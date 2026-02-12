#!/bin/bash
# Hook: UserPromptSubmit — Inject persona context into every prompt
# Adds persona prefix and thinking label to user prompts

set -euo pipefail

PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
ACTIVE_FILE="$PROJECT_ROOT/.active-persona"

[[ -f "$ACTIVE_FILE" ]] || exit 0

PERSONA=$(cat "$ACTIVE_FILE")
ENV_FILE="$PROJECT_ROOT/personae/${PERSONA}.env.json"
PERSONA_FILE="$PROJECT_ROOT/personae/${PERSONA}.yaml"

[[ -f "$ENV_FILE" ]] || exit 0

# Read the prompt from stdin
INPUT=$(cat)
PROMPT=$(echo "$INPUT" | jq -r '.prompt // empty')

# If no prompt, do nothing
[[ -n "$PROMPT" ]] || exit 0

# Get persona context
ICON=$(grep "^icon:" "$PERSONA_FILE" 2>/dev/null | head -1 | sed 's/icon: *"//' | sed 's/"//')
NAME=$(grep "^name:" "$PERSONA_FILE" 2>/dev/null | head -1 | sed 's/name: *"//' | sed 's/"//')
ARCHETYPE=$(grep "^archetype:" "$PERSONA_FILE" 2>/dev/null | head -1 | sed 's/archetype: *"//' | sed 's/"//')

# Get tool verbs for this persona
TOOL_VERBS=$(jq -r '.verbose.tool_verbs | to_entries | map("\(.key) → \(.value)") | join(", ")' "$ENV_FILE" 2>/dev/null || echo "")

# Inject persona reminder into the prompt context
# This ensures Claude stays in character even for simple prompts
PERSONA_CONTEXT="[PERSONA ACTIVE: ${ICON} ${NAME} — ${ARCHETYPE}. Stay in character. Tool verbs: ${TOOL_VERBS}]"

# Output modified prompt
jq -n --arg context "$PERSONA_CONTEXT" '{
  hookSpecificOutput: {
    hookEventName: "UserPromptSubmit",
    suppressOutput: false,
    contextInjection: $context
  }
}'
