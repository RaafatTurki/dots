#!/usr/bin/env bash
# Prints the OpenCode Go usage limits as JSON, the same data the console's usage
# page shows: go.rolling (5-hour), go.weekly and go.monthly, each with percent
# (0-100), limited and resetsAt (ms since the epoch). The data comes from the
# local opencode server, which holds the account's credentials, so no token
# handling is needed here. A response younger than 2 minutes is reused so
# reloads don't hammer the server. When a request fails, the last cached
# response is printed and the exit status is non-zero.
#
# Usage: opencode-usage.sh CACHE_FILE
set -u

cache=$1

if [ -n "$(find "$cache" -mmin -2 2>/dev/null)" ]; then
  cat "$cache"
  exit 0
fi

fetch() {
  local tmp
  mkdir -p "$(dirname "$cache")" || return 1
  tmp=$(mktemp "$cache.XXXXXX") || return 1

  # jq -e rejects responses without go usage data (an error object or an empty
  # body), so only real usage gets cached.
  if timeout 30 opencode api get /api/experimental/usage/limits 2>/dev/null \
    | jq -e '.data | select(.go != null)' > "$tmp"; then
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
