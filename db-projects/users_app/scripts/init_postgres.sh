#!/usr/bin/env bash
set -euo pipefail

echo "Aplicando DDL Postgres (users_app)..."
docker exec -i db_postgres psql -U postgres -d elecciones < ./schema/postgres.sql
echo "Hecho."
