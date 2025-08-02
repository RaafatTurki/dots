#!/usr/bin/env bash
# Prints IQWealth's USD/IQD rates as JSON (https://iraqsm.com/developers).
# The free key allows 100 requests a day and quickshell refetches on every reload,
# so a response younger than 30 minutes is reused. When a request fails, the last
# cached response is printed and the exit status is non-zero.
# The key lives outside the dotfiles repo, in ~/secret/iqwealth.env as
# IQWEALTH_API_KEY=iqw_...
#
# Usage: fx.sh CACHE_FILE
set -u

cache=$1
env_file="$HOME/secret/iqwealth.env"

if [ -n "$(find "$cache" -mmin -30 2>/dev/null)" ]; then
  cat "$cache"
  exit 0
fi

fetch() {
  # shellcheck source=/dev/null
  . "$env_file" || return 1
  mkdir -p "$(dirname "$cache")" || return 1

  local tmp
  tmp=$(mktemp "$cache.XXXXXX") || return 1

  # The header goes through stdin so the key never shows up in the process list.
  if printf 'Authorization: Bearer %s\n' "$IQWEALTH_API_KEY" \
    | curl -fsS --max-time 20 -H @- https://iraqsm.com/api/v1/fx > "$tmp"; then
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
