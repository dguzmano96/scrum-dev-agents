#!/usr/bin/env bash
# Optional. Copies the model policy into the user Cursor directory.
# The GitHub plugin already loads rules/cursor-agent-policy.mdc. Running this
# script as well duplicates that Always Apply rule. Use it only when Plugins
# are unavailable.
# Usage (from plugin repo root):
#   chmod +x ./scripts/install-global.sh
#   ./scripts/install-global.sh
#   ./scripts/install-global.sh /path/to/AGENTS.md

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
RULE_SOURCE="${ROOT}/rules/cursor-agent-policy.mdc"
SOURCE="${1:-$ROOT/AGENTS.md}"

if [[ ! -f "$RULE_SOURCE" ]]; then
  echo "Source rule not found: $RULE_SOURCE" >&2
  exit 1
fi

if [[ ! -f "$SOURCE" ]]; then
  echo "Source AGENTS.md not found: $SOURCE" >&2
  exit 1
fi

CURSOR="${HOME}/.cursor"
RULES="${CURSOR}/rules"
CANONICAL="${CURSOR}/AGENTS.md"
RULE_FILE="${RULES}/cursor-agent-policy.mdc"

mkdir -p "$RULES"
cp "$SOURCE" "$CANONICAL"
echo "Canonical copy: $CANONICAL"

if [[ -f "$RULE_FILE" ]]; then
  BACKUP="${RULE_FILE}.bak.$(date +%Y%m%d-%H%M%S)"
  cp "$RULE_FILE" "$BACKUP"
  echo "Warning: existing rule backed up to $BACKUP" >&2
fi

cp "$RULE_SOURCE" "$RULE_FILE"
echo "Global rule:    $RULE_FILE"
echo
echo "Installed. Cursor loads machine-local user rules from:"
echo "  $RULES"
echo
echo "Next steps:"
echo "  1. Open Customize -> Rules and confirm exactly one 'cursor-agent-policy' (Always Apply)."
echo "  2. Start a NEW Multitask chat (/multitask) in any window or project."
echo "  3. The orchestrator should ask once for budget / low / mid / high / cursor / emergencia mode."
echo "  4. Every Task must pass model from the matrix (Scrum does not pick slugs)."
echo
echo "Warning: the GitHub plugin already registers this rule. Disable one copy in Customize -> Rules."
echo "Re-run after git pull when rules/cursor-agent-policy.mdc or AGENTS.md change."
echo "Optional one-repo overlay: ./scripts/install-project.sh /path/to/product"
