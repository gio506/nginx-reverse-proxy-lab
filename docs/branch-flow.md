# Branch Flow

## Branch Roles

- `dev`: active development, fast feedback, auto CI, lab-friendly options
- `main`: reviewed integration branch, manual full validation, release candidate state
- `prod`: release-only branch, strict validation, manual approval-based release path

## Promotion Path

1. create feature work from `dev` using `feature/*`
2. merge `feature/*` into `dev`
3. promote `dev` into `main`
4. promote `main` into `prod`

## Notes

- daily work happens in `dev`
- `main` is cleaner than `dev`
- `prod` removes developer-only helpers and carries the strictest checks
