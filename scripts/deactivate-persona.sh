#!/bin/bash
# deactivate-persona.sh — Remove active persona and restore Claude Code defaults
# Usage: ./scripts/deactivate-persona.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
ACTIVE_FILE="$PROJECT_ROOT/.active-persona"

if [[ ! -f "$ACTIVE_FILE" ]]; then
  echo "No active persona to deactivate."
  exit 0
fi

PERSONA=$(cat "$ACTIVE_FILE")
PERSONA_DIR="$PROJECT_ROOT/personae"
PERSONA_FILE="$PERSONA_DIR/${PERSONA}.yaml"

# Read persona info for display
ICON=$(grep "^icon:" "$PERSONA_FILE" 2>/dev/null | head -1 | sed 's/icon: *"*//' | sed 's/"*$//')
NAME=$(grep "^name:" "$PERSONA_FILE" 2>/dev/null | head -1 | sed 's/name: *"*//' | sed 's/"*$//')

# Remove active persona marker
rm -f "$ACTIVE_FILE"

# Restore Claude Code defaults
claude config set theme "dark" 2>/dev/null || true
claude config set preferredNotifChannel "iterm2" 2>/dev/null || true

echo "${ICON} Persona '${NAME}' deactivated"
echo "   Claude Code theme and notifications restored to defaults"
