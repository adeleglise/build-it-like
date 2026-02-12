#!/bin/bash
# parse-yaml.sh — Robust YAML value extraction helper
# Usage: source this file, then call yaml_val <file> <key>
# Handles: quoted values ("val"), single-quoted ('val'), unquoted values, and missing keys

yaml_val() {
  local file="$1"
  local key="$2"

  [[ -f "$file" ]] || return 0

  # Match top-level key (not indented), extract value, strip quotes
  local raw
  raw=$(grep "^${key}:" "$file" 2>/dev/null | head -1 | sed "s/^${key}: *//" || echo "")

  # Strip surrounding double quotes
  raw="${raw#\"}"
  raw="${raw%\"}"
  # Strip surrounding single quotes
  raw="${raw#\'}"
  raw="${raw%\'}"
  # Trim trailing whitespace
  raw="${raw%"${raw##*[![:space:]]}"}"

  echo "$raw"
}
