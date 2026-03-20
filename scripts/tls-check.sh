#!/usr/bin/env bash
set -euo pipefail

# Verify the HTTPS endpoint works with the local self-signed certificate.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=scripts/lib.sh
source "${SCRIPT_DIR}/lib.sh"

wait_for_url "https://localhost/health" 30 2

headers="$(curl -ksSI https://localhost/app1)"

if [[ "${headers}" != *"HTTP/1.1 200 OK"* ]]; then
  echo "HTTPS endpoint did not return 200 OK" >&2
  exit 1
fi

if [[ "${headers}" != *"server: nginx"* && "${headers}" != *"Server: nginx"* ]]; then
  echo "Expected nginx server header on TLS response" >&2
  exit 1
fi

echo "TLS checks passed."
