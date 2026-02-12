#!/bin/bash
# activate-persona.sh — Configure Claude Code environment for a persona
# Usage: ./scripts/activate-persona.sh napoleon

set -euo pipefail

PERSONA="${1:-}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
PERSONA_DIR="$PROJECT_ROOT/personae"
PERSONA_FILE="$PERSONA_DIR/${PERSONA}.yaml"

if [[ -z "$PERSONA" ]]; then
  echo "Usage: $0 <persona-name>"
  echo ""
  echo "Available personae:"
  for f in "$PERSONA_DIR"/*.yaml; do
    name=$(basename "$f" .yaml)
    icon=$(grep "^icon:" "$f" | head -1 | sed 's/icon: *"//' | sed 's/"//')
    tagline=$(grep "^tagline:" "$f" | head -1 | sed 's/tagline: *"//' | sed 's/"//')
    echo "  $icon $name — $tagline"
  done
  exit 1
fi

if [[ ! -f "$PERSONA_FILE" ]]; then
  echo "Persona '$PERSONA' not found at $PERSONA_FILE"
  exit 1
fi

# Validate that both .yaml and .env.json exist (Finding 14)
ENV_CHECK="$PERSONA_DIR/${PERSONA}.env.json"
if [[ ! -f "$ENV_CHECK" ]]; then
  echo "Persona '$PERSONA' is missing its .env.json file at $ENV_CHECK"
  echo "Each persona requires both a .yaml and .env.json file."
  exit 1
fi

# Read persona config
ICON=$(grep "^icon:" "$PERSONA_FILE" | head -1 | sed 's/icon: *"//' | sed 's/"//')
NAME=$(grep "^name:" "$PERSONA_FILE" | head -1 | sed 's/name: *"//' | sed 's/"//')

echo "$ICON Activating persona: $NAME"

# ─── Load persona-specific Claude Code environment ───

ENV_FILE="$PERSONA_DIR/${PERSONA}.env.json"

if [[ -f "$ENV_FILE" ]]; then
  echo "📋 Loading environment from $ENV_FILE"
  
  # Apply theme
  THEME=$(jq -r '.theme // empty' "$ENV_FILE" 2>/dev/null)
  if [[ -n "$THEME" ]]; then
    echo "🎨 Theme: $THEME"
    claude config set theme "$THEME" 2>/dev/null || true
  fi

  # Apply notification channel
  NOTIF=$(jq -r '.notifications // empty' "$ENV_FILE" 2>/dev/null)
  if [[ -n "$NOTIF" ]]; then
    echo "🔔 Notifications: $NOTIF"
    claude config set preferredNotifChannel "$NOTIF" 2>/dev/null || true
  fi
fi

# ─── Write active persona marker ───
echo "$PERSONA" > "$PROJECT_ROOT/.active-persona"
echo ""
echo "✅ Persona '$NAME' $ICON is now active"
echo "   Run /build-it-like to start a project in-character"
