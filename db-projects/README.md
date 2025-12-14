# DB Projects

Este directorio contiene proyectos para inicializar bases de datos de ejemplo con tres motores: PostgreSQL, MySQL y SQL Server.

Instrucciones rápidas:

1. Levantar contenedores:

```bash
cd db-projects
docker compose up -d
```

2. Ejecutar inicialización (SQL Server requiere paso manual):

```bash
./init-all.sh
```

3. Ver logs:

```bash
docker compose logs -f
```

Cada proyecto tiene una estructura mínima:

- `schema/` : archivos SQL de creación
- `scripts/` : scripts útiles para ejecutar la inicialización
- `seed/` : datos de ejemplo (si aplica)

Revisa los scripts en `scripts/` antes de ejecutarlos.
