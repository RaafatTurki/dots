#!/usr/bin/env bash
# Prints the Claude subscription usage limits as JSON, the same data `/usage` shows in
# Claude Code: five_hour and seven_day, each with utilization (0-100) and resets_at.
# The OAuth token is the one Claude Code keeps in ~/.claude/.credentials.json, and
# Claude Code refreshes it. A response younger than 2 minutes is reused so reloads
# don't hammer the endpoint. When a request fails, the last cached response is
# printed and the exit status is non-zero.
#
# Usage: claude-usage.sh CACHE_FILE
set -u

cache=$1
credentials="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/.credentials.json"

if [ -n "$(find "$cache" -mmin -2 2>/dev/null)" ]; then
  cat "$cache"
  exit 0
fi

fetch() {
  local token tmp
  token=$(jq -er .claudeAiOauth.accessToken "$credentials") || return 1
  mkdir -p "$(dirname "$cache")" || return 1
  tmp=$(mktemp "$cache.XXXXXX") || return 1

  # The header goes through stdin so the token never shows up in the process list.
  if printf 'Authorization: Bearer %s\n' "$token" \
    | curl -fsS --max-time 20 -H @- -H 'anthropic-beta: oauth-2025-04-20' \
      https://api.anthropic.com/api/oauth/usage > "$tmp"; then
    mv "$tmp" "$cache"
  else
    rm -f "$tmp"
    return 1
  fi
}

fetch
status=$?
cat "$cache" 2>/dev/null
exit $status
