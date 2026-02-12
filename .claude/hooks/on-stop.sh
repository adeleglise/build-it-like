#!/bin/bash
# Hook: Stop — Play persona-specific notification sound and show farewell
# Fires when Claude finishes responding

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

# Play sound based on persona
SOUND=$(jq -r '.verbose.completion_sound // empty' "$ENV_FILE")
NOTIF=$(jq -r '.notifications // empty' "$ENV_FILE")

# Platform-specific sound playback
play_sound() {
  local sound_name="$1"
  local sounds_dir="$PROJECT_ROOT/sounds"
  local sound_file="$sounds_dir/${sound_name}.wav"
  
  if [[ -f "$sound_file" ]]; then
    # macOS
    if command -v afplay &>/dev/null; then
      afplay "$sound_file" &
    # Linux with aplay
    elif command -v aplay &>/dev/null; then
      aplay -q "$sound_file" &
    # Linux with paplay (PulseAudio)
    elif command -v paplay &>/dev/null; then
      paplay "$sound_file" &
    # Fallback: terminal bell
    else
      printf '\a'
    fi
  else
    # No custom sound file — use terminal bell
    if [[ "$NOTIF" == *"bell"* ]]; then
      printf '\a'
    fi
  fi
}

if [[ -n "$SOUND" ]]; then
  play_sound "$SOUND"
fi

# Read farewell message
FAREWELL=$(jq -r '.verbose.farewell // empty' "$ENV_FILE")
ICON=$(yaml_val "$PERSONA_FILE" "icon")

if [[ -n "$FAREWELL" ]]; then
  jq -n --arg msg "${ICON} ${FAREWELL}" '{
    hookSpecificOutput: {
      hookEventName: "Stop",
      suppressOutput: false,
      message: $msg
    }
  }'
fi

exit 0
