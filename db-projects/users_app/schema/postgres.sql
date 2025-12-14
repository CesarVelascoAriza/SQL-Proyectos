-- Postgres DDL for users_app
CREATE TABLE IF NOT EXISTS perfiles (
  id SERIAL PRIMARY KEY,
  nombre TEXT NOT NULL UNIQUE,
  descripcion TEXT
);

-- Personas mantiene ahora el `perfil_id` (un perfil por persona)
CREATE TABLE IF NOT EXISTS personas (
  id SERIAL PRIMARY KEY,
  nombre TEXT NOT NULL,
  apellido TEXT,
  tipo_documento VARCHAR(20),
  numero_documento VARCHAR(50) UNIQUE,
  fecha_nacimiento DATE,
  correo TEXT UNIQUE,
  telefono TEXT,
  direccion TEXT,
  perfil_id INT NOT NULL REFERENCES perfiles(id) ON DELETE RESTRICT, -- relación perfil aquí (NOT NULL)
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TABLE IF NOT EXISTS usuarios (
  id SERIAL PRIMARY KEY,
  persona_id INT NOT NULL REFERENCES personas(id) ON DELETE CASCADE,
  username TEXT NOT NULL UNIQUE,
  password_hash TEXT NOT NULL,
  activo BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TABLE IF NOT EXISTS menus (
  id SERIAL PRIMARY KEY,
  modulo TEXT NOT NULL, -- nombre del módulo
  nombre TEXT NOT NULL, -- nombre de la entrada de menú
  parent_id INT REFERENCES menus(id),
  orden INT DEFAULT 0,
  UNIQUE (modulo, nombre)
);

CREATE TABLE IF NOT EXISTS pantallas (
  id SERIAL PRIMARY KEY,
  menu_id INT REFERENCES menus(id) ON DELETE CASCADE,
  nombre TEXT NOT NULL,
  ruta TEXT NOT NULL,
  UNIQUE (ruta)
);

-- Eliminada: permisos por pantalla. Ver `perfiles_menus` para permisos por menú.
-- (Permisos por pantalla se omiten para simplificar: si un perfil puede ver un menú,
-- se asume acceso a sus pantallas.)

CREATE TABLE IF NOT EXISTS perfiles_menus (
  perfil_id INT REFERENCES perfiles(id),
  menu_id INT REFERENCES menus(id),
  puede_ver BOOLEAN DEFAULT TRUE,
  puede_editar BOOLEAN DEFAULT FALSE,
  PRIMARY KEY (perfil_id, menu_id)
);

-- perfiles_menus ya definido más arriba incluyendo permisos

-- ejemplo: crear perfil por defecto
INSERT INTO perfiles (nombre, descripcion) VALUES ('usuario', 'Perfil por defecto') ON CONFLICT DO NOTHING;
