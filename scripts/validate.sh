#!/usr/bin/env bash
set -euo pipefail

# Validate shell scripts, compose config, and nginx syntax.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=scripts/lib.sh
source "${SCRIPT_DIR}/lib.sh"

ROOT="$(repo_root)"

require_command shellcheck
require_command docker

if [[ ! -f "${ROOT}/nginx/certs/localhost.crt" || ! -f "${ROOT}/nginx/certs/localhost.key" ]]; then
  echo "TLS assets missing. Run ./scripts/generate-certs.sh first." >&2
  exit 1
fi

shellcheck "${ROOT}"/scripts/*.sh
compose config >/dev/null

docker run --rm \
  --add-host app1:127.0.0.1 \
  --add-host app2:127.0.0.1 \
  -v "${ROOT}/nginx/nginx.conf:/etc/nginx/nginx.conf:ro" \
  -v "${ROOT}/nginx/conf.d:/etc/nginx/conf.d:ro" \
  -v "${ROOT}/nginx/certs:/etc/nginx/certs:ro" \
  nginx:1.27-alpine nginx -t

echo "Validation complete."
