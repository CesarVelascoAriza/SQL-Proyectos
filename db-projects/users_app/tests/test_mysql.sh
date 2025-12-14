#!/usr/bin/env bash
set -euo pipefail

echo "Running MySQL tests against container db_mysql..."

fail=0; pass=0

run_ok() {
  desc="$1"; sql="$2"
  if docker exec -i db_mysql sh -c "mysql -uroot -prootpass -e \"$sql\"" >/dev/null 2>&1; then
    echo "OK: $desc"; pass=$((pass+1)); else
    echo "FAIL: $desc"; fail=$((fail+1)); fi
}

run_fail() {
  desc="$1"; sql="$2"
  if docker exec -i db_mysql sh -c "mysql -uroot -prootpass -e \"$sql\"" >/dev/null 2>&1; then
    echo "FAIL (expected error): $desc"; fail=$((fail+1)); else
    echo "OK (error as expected): $desc"; pass=$((pass+1)); fi
}

run_ok "create test profile" "INSERT IGNORE INTO users_app.perfiles (nombre, descripcion) VALUES ('test_profile','test');"

run_ok "insert persona with perfil" "INSERT INTO users_app.personas (nombre, apellido, numero_documento, perfil_id) VALUES ('Test','User','TM-001',(SELECT id FROM users_app.perfiles WHERE nombre='test_profile'));"

run_ok "insert usuario" "INSERT INTO users_app.usuarios (persona_id, username, password_hash) VALUES ((SELECT id FROM users_app.personas WHERE numero_documento='TM-001'),'testuser','hash');"

run_fail "duplicate username" "INSERT INTO users_app.usuarios (persona_id, username, password_hash) VALUES ((SELECT id FROM users_app.personas WHERE numero_documento='TM-001'),'testuser','hash2');"

run_ok "insert menu and pantalla" "INSERT IGNORE INTO users_app.menus (modulo,nombre) VALUES ('mod1','Menu1'); INSERT IGNORE INTO users_app.pantallas (menu_id,nombre,ruta) VALUES ((SELECT id FROM users_app.menus WHERE modulo='mod1' AND nombre='Menu1'),'Pant1','/mod1/pant1');"

run_fail "duplicate ruta" "INSERT INTO users_app.pantallas (menu_id,nombre,ruta) VALUES ((SELECT id FROM users_app.menus WHERE modulo='mod1' AND nombre='Menu1'),'Pant2','/mod1/pant1');"

run_fail "insert persona without perfil" "INSERT INTO users_app.personas (nombre, apellido, numero_documento, perfil_id) VALUES ('No','Profile','NP-001',NULL);"

echo
echo "Tests completed: passed=$pass failed=$fail"
if [ "$fail" -ne 0 ]; then exit 1; fi
