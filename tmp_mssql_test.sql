USE users_app;
GO

IF NOT EXISTS (SELECT 1 FROM perfiles WHERE nombre = 'test_profile')
  INSERT INTO perfiles (nombre, descripcion) VALUES ('test_profile','test');

IF NOT EXISTS (SELECT 1 FROM personas WHERE numero_documento = 'MS-001')
  INSERT INTO personas (nombre, apellido, numero_documento, perfil_id) VALUES ('Test','User','MS-001',(SELECT id FROM perfiles WHERE nombre='test_profile'));

IF NOT EXISTS (SELECT 1 FROM usuarios WHERE username = 'testuser')
  INSERT INTO usuarios (persona_id, username, password_hash) VALUES ((SELECT id FROM personas WHERE numero_documento='MS-001'),'testuser','hash');

IF NOT EXISTS (SELECT 1 FROM menus WHERE modulo = 'mod1' AND nombre = 'Menu1')
  INSERT INTO menus (modulo,nombre) VALUES ('mod1','Menu1');

IF NOT EXISTS (SELECT 1 FROM pantallas WHERE ruta = '/mod1/pant1')
  INSERT INTO pantallas (menu_id,nombre,ruta) VALUES ((SELECT id FROM menus WHERE modulo='mod1' AND nombre='Menu1'),'Pant1','/mod1/pant1');

BEGIN TRY
  INSERT INTO personas (nombre, apellido, numero_documento, perfil_id) VALUES ('No','Profile','NP-001',NULL);
END TRY
BEGIN CATCH
  SELECT ERROR_MESSAGE() AS err;
END CATCH

SELECT 'DONE' AS result;
GO
