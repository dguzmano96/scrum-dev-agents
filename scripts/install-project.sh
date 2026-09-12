#!/usr/bin/env bash
# Install cursor-agent-policy into one product repo (local overlay).
# Usage (from plugin repo root):
#   chmod +x ./scripts/install-project.sh
#   ./scripts/install-project.sh /path/to/your/product
#   ./scripts/install-project.sh /path/to/your/product --symlink

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE="${ROOT}/AGENTS.md"
PROJECT=""
SYMLINK=0

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 /path/to/your/product [--symlink]" >&2
  exit 1
fi

PROJECT="$1"
shift || true
if [[ "${1:-}" == "--symlink" ]]; then
  SYMLINK=1
fi

if [[ ! -f "$SOURCE" ]]; then
  echo "Source AGENTS.md not found. Run from the scrum-dev-agents plugin repo." >&2
  exit 1
fi

if [[ ! -d "$PROJECT" ]]; then
  echo "Project path does not exist: $PROJECT" >&2
  exit 1
fi

backup_if_exists() {
  local path="$1"
  if [[ ! -e "$path" && ! -L "$path" ]]; then
    return
  fi
  if [[ -L "$path" ]]; then
    rm -f "$path"
    return
  fi
  local backup="${path}.bak.$(date +%Y%m%d-%H%M%S)"
  mv "$path" "$backup"
  echo "Warning: existing file backed up to $backup" >&2
}

DEST_AGENTS="${PROJECT}/AGENTS.md"
backup_if_exists "$DEST_AGENTS"

CANONICAL="${HOME}/.cursor/AGENTS.md"
if [[ "$SYMLINK" -eq 1 ]]; then
  mkdir -p "$(dirname "$CANONICAL")"
  if [[ ! -f "$CANONICAL" ]]; then
    cp "$SOURCE" "$CANONICAL"
  fi
  if ln -s "$CANONICAL" "$DEST_AGENTS"; then
    echo "Symlinked $DEST_AGENTS -> $CANONICAL"
  else
    echo "Warning: symlink failed. Falling back to copy." >&2
    cp "$SOURCE" "$DEST_AGENTS"
    echo "Copied policy to $DEST_AGENTS"
  fi
else
  cp "$SOURCE" "$DEST_AGENTS"
  echo "Copied policy to $DEST_AGENTS"
fi

RULES_DIR="${PROJECT}/.cursor/rules"
mkdir -p "$RULES_DIR"
RULE_FILE="${RULES_DIR}/cursor-agent-policy.mdc"
backup_if_exists "$RULE_FILE"

{
  cat <<'EOF'
---
description: Cursor agent orchestration policy (Multitask) - low/mid/high/cursor models. Scrum = how; this rule = with what. User-facing language = first chat message.
alwaysApply: true
---

EOF
  cat "$SOURCE"
} > "$RULE_FILE"

echo "Project rule:   $RULE_FILE"
echo
echo "Next steps:"
echo "  1. Open this product as a workspace in Cursor (File > Open Folder)."
echo "  2. Prefer also: ./scripts/install-global.sh so nested Task lookups work in every window."
echo "  3. Start a NEW Multitask chat (type /multitask or use Multitask Mode)."
echo "  4. Confirm the agent asks for low / mid / high / cursor mode."
echo "  5. Optional: commit AGENTS.md and .cursor/rules/cursor-agent-policy.mdc in the product repo."
