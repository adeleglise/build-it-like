#!/bin/bash
# Hook: Notification — Persona-themed notifications
# Customizes notification text based on active persona

set -euo pipefail

PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
ACTIVE_FILE="$PROJECT_ROOT/.active-persona"

[[ -f "$ACTIVE_FILE" ]] || exit 0

PERSONA=$(cat "$ACTIVE_FILE")
ENV_FILE="$PROJECT_ROOT/personae/${PERSONA}.env.json"
PERSONA_FILE="$PROJECT_ROOT/personae/${PERSONA}.yaml"

[[ -f "$ENV_FILE" ]] || exit 0

# Read input from stdin
INPUT=$(cat)

# Get persona icon and name
ICON=$(grep "^icon:" "$PERSONA_FILE" 2>/dev/null | head -1 | sed 's/icon: *"//' | sed 's/"//')
NAME=$(grep "^name:" "$PERSONA_FILE" 2>/dev/null | head -1 | sed 's/name: *"//' | sed 's/"//')

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

# Output — let Claude Code handle the notification with our custom title
# We don't suppress, just add context
exit 0
