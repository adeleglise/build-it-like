#!/bin/bash
# Hook: Notification — Persona-themed notifications
# Customizes notification text based on active persona

set -euo pipefail

PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
ACTIVE_FILE="$PROJECT_ROOT/.active-persona"

[[ -f "$ACTIVE_FILE" ]] || exit 0

# Load shared YAML parser
source "$PROJECT_ROOT/.claude/hooks/parse-yaml.sh"

PERSONA=$(cat "$ACTIVE_FILE")
ENV_FILE="$PROJECT_ROOT/personae/${PERSONA}.env.json"
PERSONA_FILE="$PROJECT_ROOT/personae/${PERSONA}.yaml"

# Validate persona pair exists
if [[ ! -f "$PERSONA_FILE" ]] || [[ ! -f "$ENV_FILE" ]]; then
  exit 0
fi

# Read input from stdin
INPUT=$(cat)

# Get persona icon and name using robust parser
ICON=$(yaml_val "$PERSONA_FILE" "icon")
NAME=$(yaml_val "$PERSONA_FILE" "name")

# Get notification type
NOTIF_TYPE=$(echo "$INPUT" | jq -r '.matcher_value // "unknown"')

# Customize notification title based on persona
case "$NOTIF_TYPE" in
  "idle_prompt")
    TITLE="${ICON} ${NAME} attend vos ordres"
    ;;
  "permission_prompt")
    TITLE="${ICON} ${NAME} demande une autorisation"
    ;;
  *)
    TITLE="${ICON} ${NAME}"
    ;;
esac

# Output custom notification title for Claude Code hook system
jq -n --arg title "$TITLE" '{
  hookSpecificOutput: {
    hookEventName: "Notification",
    suppressOutput: false,
    title: $title
  }
}'
