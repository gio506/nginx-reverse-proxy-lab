#!/usr/bin/env bash
set -euo pipefail

# Check the required security headers on proxied responses.

headers="$(curl -ksSI http://localhost/app1)"

for required in \
  "X-Content-Type-Options: nosniff" \
  "X-Frame-Options: SAMEORIGIN" \
  "Referrer-Policy: strict-origin-when-cross-origin"
do
  if [[ "${headers}" != *"${required}"* ]]; then
    echo "Missing expected header: ${required}" >&2
    exit 1
  fi
done

echo "Header checks passed."
