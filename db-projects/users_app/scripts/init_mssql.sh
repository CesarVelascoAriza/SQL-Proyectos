#!/usr/bin/env bash
set -euo pipefail

echo "Aplicando DDL SQL Server (users_app)..."
# sqlcmd puede leer desde stdin redirigiendo /dev/stdin
docker exec -i db_mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "YourStrong!Passw0rd" -i /dev/stdin < ./schema/mssql.sql
echo "Hecho."
