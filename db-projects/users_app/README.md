# users_app schema

Esquema para gestión de usuarios y perfiles.

Tablas principales:

- `personas`: datos personales.
- `perfiles`: perfiles de la aplicación.
- `usuarios`: credenciales y enlace a `personas` y `perfiles` (un perfil por usuario).
- `menus`: estructura de menús.
- `pantallas`: pantallas relacionadas a un `menu`.
- `perfiles_menus`: permisos por perfil/menu (con columnas `puede_ver`, `puede_editar`).

Archivos:

- `diagram.mmd`: diagrama ER en Mermaid.
- `schema/postgres.sql`, `schema/mysql.sql`, `schema/mssql.sql`: DDL por motor.
- `scripts/init_*.sh`: scripts de apoyo para aplicar el DDL usando los contenedores docker definidos en `db-projects/docker-compose.yml`.

Uso rápido:

```bash
cd db-projects/users_app
chmod +x scripts/*.sh
./scripts/init_postgres.sh   # aplica a Postgres
./scripts/init_mysql.sh      # aplica a MySQL
./scripts/init_mssql.sh      # aplica a SQL Server
# Si ya existen filas en personas sin perfil, ejecutar migración para crear perfil por defecto y forzar NOT NULL
./scripts/migrate_set_default_profile.sh
```
