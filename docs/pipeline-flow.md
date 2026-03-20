# Pipeline Flow

## Dev Pipeline

Automatic on push to `dev` and PRs targeting `dev`:

1. lint shell scripts and YAML
2. validate Compose and Nginx config
3. build and boot the stack
4. run smoke checks
5. cleanup

## Main Pipeline

Manual full execution by `workflow_dispatch`:

1. lint
2. validate compose and Nginx
3. build and boot the stack
4. run extended smoke checks
5. run hardening checks
6. upload a release snapshot artifact

The `main` workflow is designed to work with a protected GitHub environment named `main`.

## Prod Pipeline

Manual-only execution by `workflow_dispatch`:

1. lint
2. strict validation
3. build and boot the prod stack
4. run full smoke, TLS, header, and rate-limit checks
5. verify rollback and release documents
6. upload a final release summary artifact

The `prod` workflow is designed to work with a protected GitHub environment named `prod`.
