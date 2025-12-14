-- PostgreSQL schema for elecciones_territoriales
CREATE TABLE IF NOT EXISTS region (
  id SERIAL PRIMARY KEY,
  nombre TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS election (
  id SERIAL PRIMARY KEY,
  nombre TEXT NOT NULL,
  fecha DATE
);

CREATE TABLE IF NOT EXISTS position (
  id SERIAL PRIMARY KEY,
  nombre TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS candidate (
  id SERIAL PRIMARY KEY,
  nombre TEXT NOT NULL,
  region_id INT REFERENCES region(id)
);

CREATE TABLE IF NOT EXISTS votes (
  id SERIAL PRIMARY KEY,
  election_id INT REFERENCES election(id),
  candidate_id INT REFERENCES candidate(id),
  votos INT DEFAULT 0
);

-- Seed example
INSERT INTO region (nombre) VALUES ('Región Central') ON CONFLICT DO NOTHING;
INSERT INTO election (nombre, fecha) VALUES ('Elecciones 2026', '2026-10-12') ON CONFLICT DO NOTHING;
