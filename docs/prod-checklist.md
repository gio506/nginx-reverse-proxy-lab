# Prod Checklist

- confirm the workflow was started manually from the `prod` branch
- confirm the GitHub `prod` environment requires reviewer approval
- confirm `docker-compose.prod.yml` is the active override
- confirm `/app1`, `/app2`, and `/health` respond through the proxy
- confirm TLS, header, and rate-limit checks pass
- confirm rollback steps in `docs/rollback.md` were reviewed before release
- confirm release notes were refreshed for the current promotion
