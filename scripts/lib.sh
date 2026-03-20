#!/usr/bin/env bash
set -euo pipefail

# Shared helpers for local runs and CI jobs.

repo_root() {
  cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd
}

compose_files() {
  local root mode override
  root="$(repo_root)"
  mode="${LAB_MODE:-main}"
  override="${root}/docker-compose.${mode}.yml"

  if [[ -f "${override}" ]]; then
    printf '%s\n' "-f" "${root}/docker-compose.yml" "-f" "${override}"
  else
    printf '%s\n' "-f" "${root}/docker-compose.yml"
  fi
}

compose() {
  local root
  root="$(repo_root)"
  # shellcheck disable=SC2207
  local args=($(compose_files))
  docker compose "${args[@]}" "$@"
}

require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Missing required command: $1" >&2
    exit 1
  fi
}

wait_for_url() {
  local url="${1:?url required}"
  local retries="${2:-30}"
  local delay="${3:-2}"
  local attempt=1

  while (( attempt <= retries )); do
    if curl -ksSf "${url}" >/dev/null; then
      return 0
    fi
    sleep "${delay}"
    ((attempt++))
  done

  echo "Timed out waiting for ${url}" >&2
  return 1
}
