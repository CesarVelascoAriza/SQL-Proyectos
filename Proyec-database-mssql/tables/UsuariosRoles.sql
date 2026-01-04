-- Relación muchos a muchos entre Usuarios y Roles
CREATE TABLE usuarios.UsuariosRoles (
    UsuarioID INT NOT NULL,
    RolID INT NOT NULL,
    FechaAsignacion DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (UsuarioID, RolID),
    FOREIGN KEY (UsuarioID) REFERENCES usuarios.Usuarios(UsuarioID) ON DELETE CASCADE,
    FOREIGN KEY (RolID) REFERENCES usuarios.Roles(RolID) ON DELETE CASCADE
);
GO