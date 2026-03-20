#!/usr/bin/env bash
set -euo pipefail

# Generate a local self-signed certificate for Nginx lab use only.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=scripts/lib.sh
source "${SCRIPT_DIR}/lib.sh"

ROOT="$(repo_root)"
CERT_DIR="${ROOT}/nginx/certs"
CRT="${CERT_DIR}/localhost.crt"
KEY="${CERT_DIR}/localhost.key"

mkdir -p "${CERT_DIR}"

if [[ -f "${CRT}" && -f "${KEY}" ]]; then
  echo "TLS assets already exist in ${CERT_DIR}"
  exit 0
fi

docker run --rm \
  -v "${CERT_DIR}:/certs" \
  alpine/openssl:latest \
  req -x509 -nodes -newkey rsa:2048 \
  -keyout /certs/localhost.key \
  -out /certs/localhost.crt \
  -days 365 \
  -subj "/CN=localhost"

echo "Generated self-signed cert for local testing only."
