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
  emit "Price freshness check is missing at scripts/price-freshness.sh. Before assigning a model slug, run the price refresh in AGENTS.md section 2.1."
  exit 0
fi

status=0
details=$("$CHECK" 2>&1) || status=$?

if [ "$status" -eq 0 ]; then
  printf '%s\n' '{"additional_context":""}'
  exit 0
fi

emit "Price table is stale. Before assigning or suggesting any model slug, run the model-policy price refresh (AGENTS.md section 2.1 / docs/fuentes.md): open https://cursor.com/docs/models-and-pricing and the Spanish variant of that page, update input, output, cache write, and cache read, recompute cost and bar_drain, and re-check budget, low, mid, high, and cursor. Do not assign a slug from the stale matrix. Checker output: ${details}"
exit 0
