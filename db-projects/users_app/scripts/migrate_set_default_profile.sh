#!/usr/bin/env bash
set -euo pipefail

DEFAULT_PROFILE_NAME=${DEFAULT_PROFILE_NAME:-usuario}

echo "Creating default profile if not exists (Postgres)..."
docker exec -i db_postgres psql -U postgres -d elecciones -v name="$DEFAULT_PROFILE_NAME" -c "INSERT INTO perfiles (nombre, descripcion) SELECT :'name', 'Perfil por defecto' WHERE NOT EXISTS (SELECT 1 FROM perfiles WHERE nombre = :'name');"
echo "Updating personas with NULL perfil_id in Postgres..."
PG_ID=$(docker exec -i db_postgres psql -U postgres -d elecciones -t -A -c "SELECT id FROM perfiles WHERE nombre = '$DEFAULT_PROFILE_NAME' LIMIT 1;")
docker exec -i db_postgres psql -U postgres -d elecciones -c "UPDATE personas SET perfil_id = $PG_ID WHERE perfil_id IS NULL;"
docker exec -i db_postgres psql -U postgres -d elecciones -c "ALTER TABLE personas ALTER COLUMN perfil_id SET NOT NULL;"

echo "Creating default profile if not exists (MySQL)..."
docker exec -i db_mysql sh -c "mysql -uroot -prootpass -e \"INSERT IGNORE INTO users_app.perfiles (nombre, descripcion) VALUES ('${DEFAULT_PROFILE_NAME}', 'Perfil por defecto');\""
MYSQL_ID=$(docker exec -i db_mysql sh -c "mysql -uroot -prootpass -sN -e \"SELECT id FROM users_app.perfiles WHERE nombre='${DEFAULT_PROFILE_NAME}' LIMIT 1;\"")
docker exec -i db_mysql sh -c "mysql -uroot -prootpass -e \"UPDATE users_app.personas SET perfil_id = ${MYSQL_ID} WHERE perfil_id IS NULL; ALTER TABLE users_app.personas MODIFY perfil_id INT NOT NULL;\""

echo "Creating default profile if not exists (SQL Server)..."
docker exec -i db_mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "YourStrong!Passw0rd" -Q "IF NOT EXISTS (SELECT 1 FROM users_app..perfiles WHERE nombre = '${DEFAULT_PROFILE_NAME}') INSERT INTO users_app..perfiles (nombre, descripcion) VALUES ('${DEFAULT_PROFILE_NAME}', 'Perfil por defecto');"
MSSQL_ID=$(docker exec -i db_mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "YourStrong!Passw0rd" -h -1 -W -Q "SET NOCOUNT ON; SELECT id FROM users_app..perfiles WHERE nombre='${DEFAULT_PROFILE_NAME}';" | tr -d '[:space:]')
docker exec -i db_mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "YourStrong!Passw0rd" -Q "UPDATE users_app..personas SET perfil_id = ${MSSQL_ID} WHERE perfil_id IS NULL; ALTER TABLE users_app..personas ALTER COLUMN perfil_id INT NOT NULL;"

echo "Migration complete."
