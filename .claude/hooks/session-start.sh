#!/bin/bash
# Hook: SessionStart — Load active persona environment
# Reads .active-persona and injects persona context into the session

set -euo pipefail

PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
ACTIVE_FILE="$PROJECT_ROOT/.active-persona"

# No active persona — do nothing
[[ -f "$ACTIVE_FILE" ]] || exit 0

# Load shared YAML parser
source "$PROJECT_ROOT/.claude/hooks/parse-yaml.sh"

PERSONA=$(cat "$ACTIVE_FILE")
PERSONA_FILE="$PROJECT_ROOT/personae/${PERSONA}.yaml"
ENV_FILE="$PROJECT_ROOT/personae/${PERSONA}.env.json"

# Validate persona pair exists
if [[ ! -f "$PERSONA_FILE" ]] || [[ ! -f "$ENV_FILE" ]]; then
  echo "Warning: Persona '${PERSONA}' is missing files (need both .yaml and .env.json)" >&2
  exit 0
fi

# Read greeting
GREETING=$(jq -r '.verbose.greeting // empty' "$ENV_FILE")
ICON=$(yaml_val "$PERSONA_FILE" "icon")

if [[ -n "$GREETING" ]]; then
  # Output as JSON for Claude Code hook system
  jq -n --arg msg "${ICON} ${GREETING}" '{
    hookSpecificOutput: {
      hookEventName: "SessionStart",
      suppressOutput: false,
      message: $msg
    }
  }'
fi
