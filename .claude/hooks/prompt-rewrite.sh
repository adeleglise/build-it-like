#!/bin/bash
# Hook: UserPromptSubmit — Inject persona context into every prompt
# Adds persona prefix and thinking label to user prompts

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
  echo "Warning: Persona '${PERSONA}' is missing files (need both .yaml and .env.json)" >&2
  exit 0
fi

# Read the prompt from stdin
INPUT=$(cat)
PROMPT=$(echo "$INPUT" | jq -r '.prompt // empty')

# If no prompt, do nothing
[[ -n "$PROMPT" ]] || exit 0

# Get persona context using robust YAML parser
ICON=$(yaml_val "$PERSONA_FILE" "icon")
NAME=$(yaml_val "$PERSONA_FILE" "name")
ARCHETYPE=$(yaml_val "$PERSONA_FILE" "archetype")

# Get verbose config for this persona
TOOL_VERBS=$(jq -r '.verbose.tool_verbs | to_entries | map("\(.key) → \(.value)") | join(", ")' "$ENV_FILE" 2>/dev/null || echo "")
PREFIX=$(jq -r '.verbose.prompt_prefix // empty' "$ENV_FILE" 2>/dev/null)
ON_ERROR=$(jq -r '.verbose.on_error // empty' "$ENV_FILE" 2>/dev/null)
ON_SUCCESS=$(jq -r '.verbose.on_success // empty' "$ENV_FILE" 2>/dev/null)
THINKING=$(jq -r '.verbose.thinking_label // empty' "$ENV_FILE" 2>/dev/null)

# Inject persona reminder into the prompt context
# Tool verbs = in-character vocabulary when narrating your actions (not UI renaming)
# Example: Napoleon says "reconnaissance" when reading files, not literally renaming the Read tool
PERSONA_CONTEXT="[PERSONA ACTIVE: ${ICON} ${NAME} — ${ARCHETYPE}. Stay fully in character. Prefix your responses with: ${PREFIX}. When narrating your actions, use these in-character verbs instead of tool names: ${TOOL_VERBS}. On errors, react with: ${ON_ERROR}. On success, react with: ${ON_SUCCESS}. While working, describe your process as: ${THINKING}]"

# Output modified prompt
jq -n --arg context "$PERSONA_CONTEXT" '{
  hookSpecificOutput: {
    hookEventName: "UserPromptSubmit",
    suppressOutput: false,
    contextInjection: $context
  }
}'
