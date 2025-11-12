#!/usr/bin/env bash
set -euo pipefail

# Used to search for a domain in AdGuard filter lists.
# Notable queries are:
# - perplexity.ai in filter 37

needle="${1:-perplexity.ai}"

for n in $(seq 1 71); do
  url="https://adguardteam.github.io/HostlistsRegistry/assets/filter_${n}.txt"
  echo "Scanning $url..."
  if curl -fsSL "$url" | rg -i --fixed-strings --context 2 "$needle"; then
    echo ">>> Match found in $url"
  fi
done
