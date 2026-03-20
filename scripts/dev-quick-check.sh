#!/usr/bin/env bash
set -euo pipefail

# Fast developer checks for the dev branch.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=scripts/smoke.sh
source "${SCRIPT_DIR}/lib.sh"

wait_for_url "http://localhost/health" 15 1

./scripts/smoke.sh
./scripts/headers-check.sh

echo "Dev quick checks passed."
