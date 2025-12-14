#!/usr/bin/env bash
set -euo pipefail

echo "Ejecutando init.sql en MySQL..."
docker exec -i db_mysql sh -c 'mysql -uroot -prootpass mydb' < ./schema/init.sql
echo "Hecho."
