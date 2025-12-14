#!/usr/bin/env bash
set -euo pipefail

echo "Levantar contenedores..."
docker compose up -d

echo "Esperando Postgres (pg_isready)..."
for i in {1..30}; do
  if docker exec db_postgres pg_isready -U postgres >/dev/null 2>&1; then
    echo "Postgres listo"; break
  fi
  sleep 1
done

echo "Esperando MySQL..."
for i in {1..30}; do
  if docker exec db_mysql mysqladmin ping -h 127.0.0.1 -uroot -prootpass >/dev/null 2>&1; then
    echo "MySQL listo"; break
  fi
  sleep 1
done

echo "Esperando SQL Server..."
for i in {1..60}; do
  if docker exec db_mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "YourStrong!Passw0rd" -Q "SELECT 1" >/dev/null 2>&1; then
    echo "SQL Server listo"; break
  fi
  sleep 2
done

echo "Ejecutando script de SQL Server (si existe)..."
if docker exec db_mssql bash -c "test -f /var/opt/mssql/scripts/init.sql" >/dev/null 2>&1; then
  docker exec -i db_mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "YourStrong!Passw0rd" -i /var/opt/mssql/scripts/init.sql
  echo "Script de SQL Server ejecutado."
else
  echo "No hay init.sql para SQL Server en libreria/schema/." 
fi

echo "Inicialización completada."
