# Cheatsheet

## Compose

```bash
docker compose -f docker-compose.yml -f docker-compose.dev.yml up --build -d
docker compose -f docker-compose.yml -f docker-compose.dev.yml down --remove-orphans
docker compose -f docker-compose.yml -f docker-compose.dev.yml logs -f nginx
```

## Curl Route Checks

```bash
curl -i http://localhost/app1
curl -i http://localhost/app2
curl -i http://localhost/health
curl -k -i https://localhost/app1
```

## TLS Checks

```bash
curl -k -I https://localhost/app1
openssl s_client -connect localhost:443 -servername localhost
```

## Nginx Config Test

```bash
docker compose -f docker-compose.yml -f docker-compose.dev.yml exec nginx nginx -t
./scripts/validate.sh
```

## Logs

```bash
docker compose -f docker-compose.yml -f docker-compose.dev.yml logs -f app1
docker compose -f docker-compose.yml -f docker-compose.dev.yml logs -f app2
docker compose -f docker-compose.yml -f docker-compose.dev.yml logs -f nginx
```
