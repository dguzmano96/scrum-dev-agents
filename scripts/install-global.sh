#!/usr/bin/env bash
# Install cursor-agent-policy globally on this machine (all Cursor windows/projects).
# Usage (from plugin repo root):
#   chmod +x ./scripts/install-global.sh
#   ./scripts/install-global.sh
#   ./scripts/install-global.sh /path/to/AGENTS.md

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE="${1:-$ROOT/AGENTS.md}"

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

{
  cat <<'EOF'
---
description: Cursor agent orchestration policy (Multitask) - low/mid/high/cursor models. Scrum = how; this rule = with what. User-facing language = first chat message.
alwaysApply: true
---

EOF
  cat "$SOURCE"
} > "$RULE_FILE"

echo "Global rule:    $RULE_FILE"
echo
echo "Installed. Cursor loads machine-local user rules from:"
echo "  $RULES"
echo
echo "Next steps:"
echo "  1. Open Customize -> Rules and confirm 'cursor-agent-policy' is listed (Always Apply)."
echo "  2. Start a NEW Multitask chat (/multitask) in any window or project."
echo "  3. The orchestrator should ask once for low / mid / high / cursor mode."
echo "  4. Every Task must pass model from the matrix (Scrum does not pick slugs)."
echo
echo "Re-run this script after pulling plugin updates that change AGENTS.md."
echo "Optional one-repo overlay: ./scripts/install-project.sh /path/to/product"
