# Dev Notes

- use `docker-compose.dev.yml` for local development work on the `dev` branch
- `X-Environment: dev` is enabled to make branch context obvious in quick checks
- keep smoke tests fast here; deeper hardening checks are promoted to `main` and `prod`
- use `scripts/dev-quick-check.sh` after small config edits
