#!/usr/bin/env bash
set -euo pipefail

# Send a burst of requests and confirm the rate limit triggers.

url="${1:-http://localhost/app1}"
rate_limited=0

for _ in $(seq 1 25); do
  code="$(curl -ksS -o /dev/null -w '%{http_code}' "${url}")"
  if [[ "${code}" == "429" ]]; then
    rate_limited=1
    break
  fi
done

if [[ "${rate_limited}" -ne 1 ]]; then
  echo "Expected at least one 429 response from ${url}" >&2
  exit 1
fi

echo "Rate-limit checks passed."
