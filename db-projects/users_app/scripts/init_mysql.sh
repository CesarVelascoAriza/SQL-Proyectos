#!/usr/bin/env bash
set -euo pipefail

echo "Aplicando DDL MySQL (users_app)..."
docker exec -i db_mysql sh -c 'mysql -uroot -prootpass' < ./schema/mysql.sql
echo "Hecho."
