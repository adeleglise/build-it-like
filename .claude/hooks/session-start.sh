#!/bin/bash
# Hook: SessionStart — Load active persona environment
# Reads .active-persona and injects persona context into the session

set -euo pipefail

PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
ACTIVE_FILE="$PROJECT_ROOT/.active-persona"

# No active persona — do nothing
[[ -f "$ACTIVE_FILE" ]] || exit 0

PERSONA=$(cat "$ACTIVE_FILE")
PERSONA_FILE="$PROJECT_ROOT/personae/${PERSONA}.yaml"
ENV_FILE="$PROJECT_ROOT/personae/${PERSONA}.env.json"

[[ -f "$ENV_FILE" ]] || exit 0

# Read greeting
GREETING=$(jq -r '.verbose.greeting // empty' "$ENV_FILE")
ICON=$(grep "^icon:" "$PERSONA_FILE" 2>/dev/null | head -1 | sed 's/icon: *"//' | sed 's/"//')

if [[ -n "$GREETING" ]]; then
  # Output as JSON for Claude Code hook system
  jq -n --arg msg "${ICON} ${GREETING}" '{
    hookSpecificOutput: {
      hookEventName: "SessionStart",
      suppressOutput: false
    }
  }'
fi
