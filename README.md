# nginx-reverse-proxy-lab

A practical DevOps portfolio project that places Nginx in front of two small Flask services, adds local self-signed TLS, validates headers and rate limits, and models promotion from `dev` to `main` to `prod`.

## Project Overview

This lab shows a small but realistic reverse-proxy setup:
- Nginx routes `/app1` and `/app2` to separate backend services.
- `/health` is exposed through the proxy for a simple stack health check.
- Local HTTPS is supported with a self-signed certificate for testing only.
- GitHub Actions behavior changes by branch role.

## Architecture Summary

- `nginx`: public entrypoint on ports `80` and `443`
- `app1`: Flask JSON demo service
- `app2`: Flask JSON demo service
- Docker Compose orchestrates the stack
- Shell scripts validate config and run smoke checks

## Branch Purpose

- `dev`: active development, auto CI on push and PR, lab-friendly defaults
- `main`: stable integration branch, manual full pipeline, release-candidate behavior
- `prod`: release-only branch, manual pipeline with approval gate, strictest checks

## Routing Rules

- `/app1` -> backend app1
- `/app2` -> backend app2
- `/health` -> proxied health endpoint

## Run Locally

1. Generate local TLS assets:
   ```bash
   ./scripts/generate-certs.sh
   ```
2. Validate config:
   ```bash
   ./scripts/validate.sh
   ```
3. Start the stack:
   ```bash
   docker compose -f docker-compose.yml -f docker-compose.prod.yml up --build -d
   ```
4. Stop the stack:
   ```bash
   ./scripts/cleanup.sh
   ```

Windows note: use Git Bash or WSL for the shell scripts.

On the `prod` branch, debug headers are removed and rate limits are stricter than `dev` and `main`.

## Test

```bash
./scripts/smoke.sh
./scripts/headers-check.sh
./scripts/tls-check.sh
./scripts/rate-limit-check.sh
```

## CI/CD Flow

- `dev-ci.yml`: automatic on push to `dev` and PRs targeting `dev`
- `main-ci.yml`: manual full pipeline with environment-aware gate on `main`
- `prod-ci.yml`: manual-only release pipeline with strict checks on `prod`

## Promotion Flow

- `feature/*` -> `dev`
- `dev` -> `main`
- `main` -> `prod`

## Rollback Summary

- revert the last config change with `git revert <commit>`
- switch to a previous stable branch state with `git checkout <branch>` plus a known-good commit
- stop and restart safely with `./scripts/cleanup.sh` and `docker compose ... up -d`

Detailed rollback steps live in [`docs/rollback.md`](docs/rollback.md).

## Repo Map

- `.github/workflows/`: CI/CD workflows for `dev`, `main`, and `prod`
- `backends/`: two small Flask services used as upstream applications
- `docs/`: architecture, branch flow, pipeline flow, rollback, and troubleshooting docs
- `nginx/`: Nginx main config, modular includes, and local cert storage
- `scripts/`: cert generation, validation, smoke checks, and cleanup helpers
- `docker-compose.yml`: shared stack definition
- `docker-compose.main.yml`: `main` branch runtime overrides
- `docker-compose.prod.yml`: `prod` branch runtime overrides
- `Makefile`: common project commands
- `CHEATSHEET.md`: short command reference
- `FILES_EXPLAINED.md`: one-line file and folder summary
