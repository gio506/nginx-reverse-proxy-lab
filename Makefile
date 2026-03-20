SHELL := /usr/bin/env bash
LAB_MODE ?= main

.PHONY: up down restart logs lint validate test certs clean

up:
	docker compose -f docker-compose.yml -f docker-compose.$(LAB_MODE).yml up --build -d

down:
	docker compose -f docker-compose.yml -f docker-compose.$(LAB_MODE).yml down --remove-orphans

restart: down up

logs:
	docker compose -f docker-compose.yml -f docker-compose.$(LAB_MODE).yml logs -f

lint:
	./scripts/validate.sh

validate:
	./scripts/validate.sh

test:
	./scripts/smoke.sh && ./scripts/headers-check.sh && ./scripts/tls-check.sh && ./scripts/rate-limit-check.sh

certs:
	./scripts/generate-certs.sh

clean:
	./scripts/cleanup.sh
