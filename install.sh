#!/bin/bash
#
# usedesign — global installer
# Symlinks the router skill into the agent skills directories (Claude Code + Codex),
# then refreshes the design catalog from your actually-installed skills.
# Idempotent: safe to re-run.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SRC="$SCRIPT_DIR/skills"

if [ ! -d "$SKILLS_SRC" ]; then
  echo "❌ skills/ not found at $SKILLS_SRC"
  exit 1
fi

TARGETS=("$HOME/.claude/skills" "$HOME/.codex/skills")

echo "🎛  Installing usedesign (design skill router)"
echo "   source: $SKILLS_SRC"
echo ""

for TARGET in "${TARGETS[@]}"; do
  mkdir -p "$TARGET"
  echo "→ $TARGET"
  for SKILL_PATH in "$SKILLS_SRC"/*/; do
    NAME="$(basename "$SKILL_PATH")"
    ln -sfn "$SKILLS_SRC/$NAME" "$TARGET/$NAME"
    echo "   ✅ $NAME"
  done
  echo ""
done

# Refresh the catalog from the first available skills dir so it matches this machine.
if command -v node >/dev/null 2>&1 && [ -d "$HOME/.claude/skills" ]; then
  echo "→ refreshing design catalog from ~/.claude/skills"
  node "$SCRIPT_DIR/scripts/build-catalog.mjs" "$HOME/.claude/skills" "$SKILLS_SRC/usedesign" \
    || echo "   (catalog refresh skipped — using committed baseline)"
  echo ""
fi

echo "Done. Invoke it with /usedesign <your design task> in a new session."
