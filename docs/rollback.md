# Rollback

## Revert a Config Change

```bash
git log --oneline
git revert <commit>
```

## Return to a Previous Branch State

```bash
git checkout main
git log --oneline
git checkout <known-good-commit>
```

Use a temporary review branch before restoring to a long-lived branch.

## Safe Stack Restart

```bash
./scripts/cleanup.sh
docker compose -f docker-compose.yml -f docker-compose.main.yml up --build -d
```

## Notes

- regenerate certs only if the local cert files were removed
- verify `/health` after restart before promoting branch changes
