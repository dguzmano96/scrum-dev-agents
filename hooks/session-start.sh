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

emit "Price table is stale. Do NOT refresh silently. You must inform the USER, in the session language, that the model catalog/pricing is outdated and ask whether they want to update it on this machine. If the user says no, keep using the current table (local override if present, otherwise plugin baseline) without refreshing. When the user later agrees to a local refresh (not now): launch one subagent per model, in parallel, each using the cheapest Task-catalog slug that can WebSearch/WebFetch (not one subagent for all models). After they return, the same cheap slug applies the existing math and writes only to ~/.cursor/scrum-dev-agents/ (Windows: %USERPROFILE%\\.cursor\\scrum-dev-agents\\). GitHub stays the baseline. No GitHub Action. Do not assign any model slug until the user responds. Checker details: ${details}"
exit 0
