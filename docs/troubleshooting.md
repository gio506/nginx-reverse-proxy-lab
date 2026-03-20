# Troubleshooting

## Port Conflicts

If ports `80` or `443` are already in use, stop the conflicting process or remap the ports in Compose for local testing.

## Missing TLS Files

Run `./scripts/generate-certs.sh` before starting Nginx. The self-signed cert is for local testing only.

## Docker Build or Startup Errors

- confirm Docker Desktop is running
- check `docker compose ... logs`
- run `./scripts/validate.sh` before another boot attempt

## Windows Notes

Use Git Bash or WSL for the shell scripts. The scripts assume a POSIX shell with `curl`, `docker`, and `shellcheck` available.
