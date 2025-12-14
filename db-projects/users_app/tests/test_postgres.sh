#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "$0")/.." && pwd)
echo "Running Postgres tests against container db_postgres..."

fail=0
pass=0

run_ok() {
  desc="$1"; sql="$2"
  if docker exec -i db_postgres psql -U postgres -d elecciones -c "$sql" >/dev/null 2>&1; then
    echo "OK: $desc"; pass=$((pass+1)); else
    echo "FAIL: $desc"; fail=$((fail+1)); fi
}

run_fail() {
  desc="$1"; sql="$2"
  if docker exec -i db_postgres psql -U postgres -d elecciones -c "$sql" >/dev/null 2>&1; then
    echo "FAIL (expected error): $desc"; fail=$((fail+1)); else
    echo "OK (error as expected): $desc"; pass=$((pass+1)); fi
}

echo "-- Ensure test profile exists"
run_ok "create test profile" "INSERT INTO perfiles (nombre, descripcion) VALUES ('test_profile','test') ON CONFLICT DO NOTHING;"

echo "-- Insert persona linked to profile"
run_ok "insert persona with perfil" "INSERT INTO personas (nombre, apellido, numero_documento, perfil_id) VALUES ('Test','User','TP-001',(SELECT id FROM perfiles WHERE nombre='test_profile')) ;"

echo "-- Insert usuario linked to persona"
run_ok "insert usuario" "INSERT INTO usuarios (persona_id, username, password_hash) VALUES ((SELECT id FROM personas WHERE numero_documento='TP-001'),'testuser','hash');"

echo "-- Unique username enforcement (should fail)"
run_fail "duplicate username" "INSERT INTO usuarios (persona_id, username, password_hash) VALUES ((SELECT id FROM personas WHERE numero_documento='TP-001'),'testuser','hash2');"

echo "-- Ruta unique enforcement for pantallas"
run_ok "insert menu and pantalla" "INSERT INTO menus (modulo,nombre) VALUES ('mod1','Menu1') ON CONFLICT DO NOTHING; INSERT INTO pantallas (menu_id,nombre,ruta) VALUES ((SELECT id FROM menus WHERE modulo='mod1' AND nombre='Menu1'),'Pant1','/mod1/pant1');"
run_fail "duplicate ruta" "INSERT INTO pantallas (menu_id,nombre,ruta) VALUES ((SELECT id FROM menus WHERE modulo='mod1' AND nombre='Menu1'),'Pant2','/mod1/pant1');"

echo "-- persona.perfil_id NOT NULL enforcement (should fail)"
run_fail "insert persona without perfil" "INSERT INTO personas (nombre, apellido, numero_documento, perfil_id) VALUES ('No','Profile','NP-001',NULL);"

echo
echo "Tests completed: passed=$pass failed=$fail"
if [ "$fail" -ne 0 ]; then exit 1; fi
