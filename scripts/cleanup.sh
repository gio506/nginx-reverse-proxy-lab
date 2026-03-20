#!/usr/bin/env bash
set -euo pipefail

# Stop the compose stack and remove local containers safely.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=scripts/lib.sh
source "${SCRIPT_DIR}/lib.sh"

compose down --remove-orphans --volumes

echo "Stack stopped."
