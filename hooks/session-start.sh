#!/bin/sh
# sessionStart for macOS and Linux (POSIX sh). Prints one JSON object on stdout.
# A fresh price table sends an empty additional_context. Exit 0 either way.

set -u

ROOT=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
CHECK="$ROOT/scripts/price-freshness.sh"

json_escape() {
  printf '%s' "$1" | awk '
    BEGIN { ORS = "" }
    {
      gsub(/\\/, "\\\\")
      gsub(/"/, "\\\"")
      if (NR > 1) printf "\\n"
      printf "%s", $0
    }
  '
}

emit() {
  printf '{"additional_context":"%s"}\n' "$(json_escape "$1")"
}

if [ ! -f "$CHECK" ]; then
  emit "Price freshness check is missing at scripts/price-freshness.sh. Do not assign or refresh models silently."
  exit 0
fi

status=0
details=$("$CHECK" 2>&1) || status=$?

if [ "$status" -eq 0 ]; then
  printf '%s\n' '{"additional_context":""}'
  exit 0
fi

emit "Price table is stale. Do NOT refresh silently. You must inform the USER, in the session language, that the model catalog/pricing is outdated and ask whether they want to update it on this machine. If the user says no, keep using the current table (local override if present, otherwise plugin baseline) without refreshing. If the user says yes, perform the local refresh using the cheapest Task-catalog model that can WebSearch/WebFetch (AGENTS.md §2.0) and save the results in ~/.cursor/scrum-dev-agents/. Do not assign any model slug until the user responds. Checker details: ${details}"
exit 0
