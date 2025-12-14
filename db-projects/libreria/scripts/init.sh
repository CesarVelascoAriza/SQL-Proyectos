#!/usr/bin/env bash
set -euo pipefail

echo "Ejecutando init.sql en SQL Server..."
docker exec -i db_mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "YourStrong!Passw0rd" -i /var/opt/mssql/scripts/init.sql
echo "Hecho."
