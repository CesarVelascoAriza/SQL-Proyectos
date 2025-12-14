#!/usr/bin/env bash
set -euo pipefail

echo "Ejecutando init.sql en Postgres..."
docker exec -i db_postgres psql -U postgres -d elecciones -f /docker-entrypoint-initdb.d/init.sql
echo "Hecho."
