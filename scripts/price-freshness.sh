#!/bin/sh
# Read precios_consultados and vence from the plugin rule.
# Exit 0 when the price table is still inside its window.
# Exit 1 when today is after vence, or precios_consultados is more than one calendar month old.
# Exit 2 when those dates cannot be read.
# POSIX sh (macOS /bin/sh and Linux dash). Override the clock with PRICE_FRESHNESS_TODAY=YYYY-MM-DD.

set -eu

ROOT=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)

# If PRICE_FRESHNESS_RULE is not explicitly set, prefer local snapshot if present
if [ -z "${PRICE_FRESHNESS_RULE:-}" ]; then
  LOCAL_RULE="${HOME:-}/.cursor/scrum-dev-agents/AGENTS.md"
  if [ -n "${HOME:-}" ] && [ -f "$LOCAL_RULE" ]; then
    RULE="$LOCAL_RULE"
  else
    RULE="$ROOT/rules/cursor-agent-policy.mdc"
  fi
else
  RULE="$PRICE_FRESHNESS_RULE"
fi

if [ -n "${PRICE_FRESHNESS_TODAY:-}" ]; then
  today=$PRICE_FRESHNESS_TODAY
else
  today=$(date -u +%Y-%m-%d)
fi

extract_date() {
  key=$1
  grep -F "$key" "$RULE" 2>/dev/null | head -n 1 | sed -n 's/.*\([0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]\).*/\1/p'
}

days_in_month() {
  y=$1
  m=$2
  case $m in
    1|3|5|7|8|10|12) echo 31 ;;
    4|6|9|11) echo 30 ;;
    2)
      if [ $((y % 4)) -eq 0 ] && { [ $((y % 100)) -ne 0 ] || [ $((y % 400)) -eq 0 ]; }; then
        echo 29
      else
        echo 28
      fi
      ;;
  esac
}

add_one_calendar_month() {
  y=$(printf '%s' "$1" | cut -c1-4)
  m=$(printf '%s' "$1" | cut -c6-7 | sed 's/^0//')
  d=$(printf '%s' "$1" | cut -c9-10 | sed 's/^0//')
  m=$((m + 1))
  if [ "$m" -gt 12 ]; then
    m=1
    y=$((y + 1))
  fi
  dim=$(days_in_month "$y" "$m")
  if [ "$d" -gt "$dim" ]; then
    d=$dim
  fi
  printf '%04d-%02d-%02d' "$y" "$m" "$d"
}

if [ ! -f "$RULE" ]; then
  echo "stale"
  echo "rule-missing=$RULE"
  echo "today=$today"
  exit 2
fi

precios=$(extract_date precios_consultados)
vence=$(extract_date vence)

case $precios in
  [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]) ;;
  *) precios="" ;;
esac
case $vence in
  [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]) ;;
  *) vence="" ;;
esac

if [ -z "$precios" ] || [ -z "$vence" ]; then
  echo "stale"
  echo "precios_consultados=${precios:-missing}"
  echo "vence=${vence:-missing}"
  echo "today=$today"
  echo "Could not read precios_consultados and vence from $RULE."
  exit 2
fi

limit=$(add_one_calendar_month "$precios")
stale=0
reason=""
if [ "$today" ">" "$vence" ]; then
  stale=1
  reason="today is after vence"
fi
if [ "$today" ">" "$limit" ]; then
  stale=1
  if [ -n "$reason" ]; then
    reason="$reason; precios_consultados is more than one calendar month old"
  else
    reason="precios_consultados is more than one calendar month old"
  fi
fi

if [ "$stale" -eq 0 ]; then
  echo "fresh"
  echo "precios_consultados=$precios"
  echo "vence=$vence"
  echo "month_limit=$limit"
  echo "today=$today"
  exit 0
fi

echo "stale"
echo "precios_consultados=$precios"
echo "vence=$vence"
echo "month_limit=$limit"
echo "today=$today"
echo "reason=$reason"
exit 1
