# Architecture

The lab runs three containers on a single Docker bridge network:

- `nginx`: accepts client traffic on `80` and `443`
- `app1`: Flask backend for `/app1`
- `app2`: Flask backend for `/app2`

Request flow:

1. client connects to Nginx
2. Nginx applies security headers, rate limiting, and gzip
3. Nginx routes the request by path to the correct upstream
4. the backend returns JSON to the client through the proxy

The `/health` endpoint is exposed through Nginx and proxied to `app1` for a simple stack-level check.
