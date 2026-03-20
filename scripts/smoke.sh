#!/usr/bin/env bash
set -euo pipefail

# Smoke-checks the core proxied routes.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=scripts/lib.sh
source "${SCRIPT_DIR}/lib.sh"

assert_contains() {
  local haystack="${1:?body required}"
  local needle="${2:?needle required}"
  if [[ "${haystack}" != *"${needle}"* ]]; then
    echo "Expected response to contain: ${needle}" >&2
    exit 1
  fi
}

wait_for_url "http://localhost/health"

app1_body="$(curl -sSf http://localhost/app1)"
app2_body="$(curl -sSf http://localhost/app2)"
health_body="$(curl -sSf http://localhost/health)"

assert_contains "${app1_body}" '"app":"app1"'
assert_contains "${app2_body}" '"app":"app2"'
assert_contains "${health_body}" '"health":"healthy"'

echo "Smoke tests passed."
