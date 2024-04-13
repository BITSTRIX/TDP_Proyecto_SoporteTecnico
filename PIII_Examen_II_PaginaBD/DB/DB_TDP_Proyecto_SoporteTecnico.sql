
--TECNICAS DE PROGRAMACION

USE master
GO
DROP DATABASE DBSoporteTecnico
GO


CREATE DATABASE DBSoporteTecnico
GO

USE DBSoporteTecnico
GO

CREATE TABLE Usuarios
(
usuarioID INT IDENTITY(1,1) PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
correoElectronico VARCHAR(50),
telefono VARCHAR(15) UNIQUE,
CONSTRAINT uq_correo UNIQUE(correoElectronico)
)
GO

CREATE TABLE systemAccess
(
accessID INT IDENTITY(1,1) PRIMARY KEY,
usuarioID INT UNIQUE NOT NULL,
contrasenna VARCHAR(256) NOT NULL,
CONSTRAINT fkusuarioID FOREIGN KEY(usuarioID) REFERENCES Usuarios(usuarioID)
)
GO

CREATE TABLE Tecnicos
(
tecnicoID INT IDENTITY(1,1) PRIMARY KEY,
especialidad VARCHAR(50),
usuarioID INT UNIQUE NOT NULL,
CONSTRAINT fkIdSystemUsers FOREIGN KEY(usuarioID) REFERENCES Usuarios(usuarioID)
)
GO

CREATE TABLE Equipos
(
equipoID INT IDENTITY(1,1) PRIMARY KEY,
tipoEquipo VARCHAR(50) NOT NULL,
modelo VARCHAR(50),
usuarioID int,
CONSTRAINT fkEquiposUsuarioID FOREIGN KEY (usuarioID) REFERENCES Usuarios(usuarioID)
)
GO

CREATE TABLE Reparaciones
(
reparacionID INT IDENTITY(1,1) PRIMARY KEY,
equipoID int,
fechaSolicitud DATETIME,
estado Char(1),
CONSTRAINT fkReparacionesUsuarioID FOREIGN KEY (equipoID) REFERENCES Equipos(equipoID)
)
GO

CREATE TABLE DetallesReparacion
(
DetalleID INT IDENTITY(1,1) PRIMARY KEY,
reparacionID int,
descripcion varchar(50),
fechaInicio DATETIME,
fechaFin DATETIME,
costoReparacion DECIMAL(10, 2),
CONSTRAINT fkreparacionID FOREIGN KEY (reparacionID) REFERENCES Reparaciones(reparacionID)
)
GO

CREATE TABLE Asignaciones
(
asignacionID INT IDENTITY(1,1) PRIMARY KEY,
reparacionID int UNIQUE,
tecnicoID int,
fechaAsignacion DATETIME,
CONSTRAINT fkAsignacionesreparacionID FOREIGN KEY (reparacionID) REFERENCES Reparaciones(reparacionID),
CONSTRAINT fkAsignacionestecnicoID FOREIGN KEY (tecnicoID) REFERENCES Tecnicos(tecnicoID)
)
GO

CREATE TABLE roles
(
RolID INT IDENTITY(1,1) PRIMARY KEY,
nombreRol VARCHAR(40) CONSTRAINT uq_nombreRol UNIQUE
)
GO

CREATE TABLE usersRoles
(
idUserRol INT CONSTRAINT fk_idUser FOREIGN KEY (idUserRol) REFERENCES systemAccess (UsuarioID) NOT NULL UNIQUE,
idRolUser INT CONSTRAINT fk_idRol FOREIGN KEY (idRolUser) REFERENCES roles(RolID) NOT NULL,
)
GO

--PROCEDIMIENTOS ALMACENADOS TABLA DE EQUIPOS---

CREATE PROCEDURE PcAgregarEquipo
@TipoEquipo VARCHAR(50),
@ModeloEquipo VARCHAR(50),
@UsuarioEquipo INT
AS
	BEGIN
	INSERT INTO Equipos (tipoEquipo, modelo, usuarioID) VALUES (@TipoEquipo,@ModeloEquipo, @UsuarioEquipo)
	END
GO

CREATE PROCEDURE PcConsultarEquipo
@EquipoID INT
AS
	BEGIN
	SELECT * from  Equipos WHERE equipoID = @EquipoID
	END
GO

CREATE PROCEDURE PcModificarEquipo
@EquipoID INT,
@TipoEquipo VARCHAR(50),
@ModeloEquipo VARCHAR(50),
@UsuarioEquipo INT
AS
	BEGIN
	UPDATE Equipos SET tipoEquipo = @TipoEquipo,modelo = @ModeloEquipo, usuarioID = @UsuarioEquipo WHERE equipoID = @EquipoID
	END
GO

CREATE PROCEDURE PcEliminarEquipo
@EquipoID INT
AS
	BEGIN
	DELETE from  Equipos WHERE equipoID = @EquipoID
	END
GO

--PROCEDIMIENTOS ALMACENADOS TABLA DE USUARIOS---

CREATE PROCEDURE PcAgregarUsuario
@Nombre VARCHAR(50),
@Correo VARCHAR(50),
@Telefono VARCHAR(15)
AS
	BEGIN
	INSERT INTO Usuarios (nombre, correoElectronico, telefono)VALUES (@Nombre,@Correo, @Telefono)
	END
GO

CREATE PROCEDURE PcConsultarUsuario
@UsuarioID INT
AS
	BEGIN
	SELECT * from  Usuarios WHERE usuarioID = @UsuarioID
	END
GO

CREATE PROCEDURE PcModificarUsuario
@UsuarioID INT,
@Nombre VARCHAR(50),
@Correo VARCHAR(50),
@Telefono VARCHAR(15)
AS
	BEGIN
	UPDATE Usuarios SET nombre = @Nombre,correoElectronico = @Correo, telefono = @Telefono WHERE usuarioID = @UsuarioID
	END
GO

CREATE PROCEDURE PcEliminarUsuario
@UsuarioID INT
AS
	BEGIN
	DELETE from  Usuarios WHERE usuarioID = @UsuarioID
	END
GO

--PROCEDIMIENTOS ALMACENADOS TABLA DE TECNICOS---

CREATE PROCEDURE PcTablaTecnicos
AS
	BEGIN
	SELECT T.tecnicoID AS 'ID TECNICO', 
	U.nombre AS 'NOMBRE DEL TECNICO',
	U.usuarioID AS 'ID USUARIO',
	T.especialidad AS 'ESPECIALIDAD'	
	FROM Tecnicos T
	INNER JOIN Usuarios U ON T.usuarioID = U.usuarioID
	INNER JOIN usersRoles UR ON U.usuarioID = UR.idUserRol
	INNER JOIN roles R ON UR.idRolUser = R.RolID 
	WHERE nombreRol = 'Tecnico'
	
	END
GO

CREATE PROCEDURE PcAgregarTecnico
@Especialidad VARCHAR(50),
@SystemUser INT
AS
	BEGIN
	INSERT INTO Tecnicos (especialidad, usuarioID)VALUES (@Especialidad, @SystemUser)
	END
GO

CREATE PROCEDURE PcConsultarTecnico
@TecnicoID INT
AS
	BEGIN
	SELECT T.tecnicoID AS 'ID TECNICO', 
	U.nombre AS 'NOMBRE DEL TECNICO',
	U.usuarioID AS 'ID USUARIO',
	T.especialidad AS 'ESPECIALIDAD'	
	FROM Tecnicos T
	INNER JOIN Usuarios U ON T.usuarioID = U.usuarioID
	INNER JOIN usersRoles UR ON U.usuarioID = UR.idUserRol
	INNER JOIN roles R ON UR.idRolUser = R.RolID 
	WHERE tecnicoID = @TecnicoID
	END
GO

EXEC PcConsultarTecnico 2
GO

CREATE PROCEDURE PcModificarTecnico
@TecnicoID INT,
@Especialidad VARCHAR(50),
@SystemUser INT
AS
	BEGIN
	UPDATE Tecnicos SET especialidad = @Especialidad, usuarioID = @SystemUser WHERE tecnicoID = @TecnicoID
	END
GO

CREATE PROCEDURE PcEliminarTecnico
@TecnicoID INT
AS
	BEGIN
	DELETE from  Tecnicos WHERE tecnicoID = @TecnicoID
	END
GO


--PROCEDIMIENTOS ALMACENADOS TABLA DE REPARACIONES---



/*SELECT
    T.nombre AS 'Nombre del tecnico',
    A.asignacionID AS 'Código de asignacion',
    A.fechaAsignacion AS 'Fecha de la asignacion',
    E.tipoEquipo AS 'Tipo de equipo',
    E.modelo AS 'Modelo de equipo',
    U.nombre AS 'Nombre de Usuario'
FROM
    Asignaciones A
INNER JOIN Tecnicos T ON A.tecnicoID = T.tecnicoID
INNER JOIN Reparaciones R ON A.reparacionID = R.reparacionID
INNER JOIN Equipos E ON R.equipoID = E.equipoID
INNER JOIN Usuarios U ON E.usuarioID = U.usuarioID;

SELECT
    T.nombre,
    A.asignacionID,
    A.fechaAsignacion,
    E.tipoEquipo,
    E.modelo,
    U.nombre
FROM
    Asignaciones A
INNER JOIN Tecnicos T ON A.tecnicoID = T.tecnicoID
INNER JOIN Reparaciones R ON A.reparacionID = R.reparacionID
INNER JOIN Equipos E ON R.equipoID = E.equipoID
INNER JOIN Usuarios U ON E.usuarioID = U.usuarioID;
GO
*/

CREATE PROCEDURE PCValidarUsuario
@correo varchar(50),
@clave varchar(50)
	AS
		BEGIN 
		DECLARE @claveHash VARCHAR(64)

		SET @claveHash = CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', @clave), 2)

			SELECT U.correoElectronico, U.nombre, SA.contrasenna, R.nombreRol 
			FROM Usuarios U 
			INNER JOIN systemAccess SA ON SA.usuarioID = U.usuarioID
			INNER JOIN usersRoles UR ON UR.idUserRol = U.usuarioID
			INNER JOIN roles R ON R.RolID = UR.idRolUser
			WHERE U.correoElectronico=@correo AND SA.contrasenna = @claveHash
		END
GO


--PROCEDIMIENTOS ALMACENADOS TABLA DE USUARIOS SISTEMA ---

CREATE PROCEDURE PcTablaAcesos
AS
BEGIN 
	SELECT
		 SA.accessID AS 'NUMERO ACCESO',
		 U.usuarioID AS 'ID USUARIO',
		 U.nombre AS 'NOMBRE USUARIO',
		 U.correoElectronico AS 'CORREO',
		 SA.contrasenna AS 'CLAVE'
	FROM systemAccess SA
	INNER JOIN Usuarios U ON SA.usuarioID = U.usuarioID
END
GO

CREATE PROCEDURE PcAgregarUsuarioSistema
@idUsuario INT,
@Password VARCHAR(50)
AS
	BEGIN
	DECLARE @HashContrasenna VARBINARY(64)
	SET @HashContrasenna = HASHBYTES('SHA2_256', @Password)
	INSERT INTO systemAccess (usuarioID, contrasenna)VALUES (@idUsuario, CONVERT(VARCHAR(64), @HashContrasenna, 2))
	END
GO

CREATE PROCEDURE PcModificarContraseñaUsuarioSistema
@AccessID INT,
@Password VARCHAR(50)
AS
	BEGIN
	DECLARE @HashContrasenna VARBINARY(64)
    SET @HashContrasenna = HASHBYTES('SHA2_256', @Password)
	UPDATE systemAccess SET contrasenna = CONVERT(VARCHAR(64), @HashContrasenna, 2) WHERE accessID = @AccessID
	END
GO

CREATE PROCEDURE PcConsultarUsuarioSistema
@AccesoID INT
AS
	BEGIN
	SELECT
		 SA.accessID AS 'NUMERO ACCESO',
		 U.usuarioID AS 'ID USUARIO',
		 U.nombre AS 'NOMBRE USUARIO',
		 U.correoElectronico AS 'CORREO',
		 SA.contrasenna AS 'CLAVE'
	FROM systemAccess SA
	INNER JOIN Usuarios U ON SA.usuarioID = U.usuarioID
	WHERE SA.accessID = @AccesoID
	END
GO

CREATE PROCEDURE PcEliminarUsuarioSistema
@AccessID INT
AS
	BEGIN
	DELETE from  systemAccess WHERE accessID = @AccessID
	END
GO

CREATE PROCEDURE PcDropListUsuarioSistemaTecnicos
AS
	BEGIN
		SELECT U.nombre, U.usuarioID FROM Usuarios U
		INNER JOIN usersRoles UR ON U.usuarioID = idUserRol
		INNER JOIN roles R ON UR.idRolUser  = RolID
		WHERE R.nombreRol = 'Tecnico'
	END
GO

CREATE PROCEDURE PcDropListUsuarioSistema
AS
	BEGIN
		SELECT nombre, usuarioID FROM Usuarios U 
		INNER JOIN usersRoles UR ON U.usuarioID = idUserRol
		INNER JOIN roles R ON UR.idRolUser  = RolID
	END
GO

CREATE PROCEDURE PcDropListUsuarios
AS
	BEGIN
		SELECT nombre, usuarioID FROM Usuarios U
	END
GO

--PROCEDIMIENTOS ALMACENADOS TABLA DE ROLES ---

CREATE PROCEDURE PcAgregarRol
@Nombre VARCHAR(40)
AS
	BEGIN
	INSERT INTO roles(nombreRol)VALUES (@Nombre)
	END
GO

CREATE PROCEDURE PcEliminarRol
@idRol INT
AS
	BEGIN
	DELETE FROM roles WHERE RolID = @idRol
	END
GO

CREATE PROCEDURE PcModificarRol
@idRol INT,
@Nombre VARCHAR(40)
AS
	BEGIN
	UPDATE roles SET nombreRol = @Nombre WHERE RolID = @idRol
	END
GO

CREATE PROCEDURE PcConsultarRol
@idRol INT
AS
	BEGIN
	SELECT RolID, nombreRol FROM roles WHERE RolID = @idRol
	END
GO

CREATE PROCEDURE PcDropListRoles
AS
	BEGIN
		SELECT RolID, nombreRol FROM roles
		END
GO

--PROCEDIMIENTOS ALMACENADOS TABLA DE ROLES USUARIOS ---

CREATE PROCEDURE PcAgregarRoleUser
@idUserSystem INT,
@idRol INT

AS
	BEGIN
		INSERT INTO usersRoles(idUserRol, idRolUser)VALUES (@idUserSystem, @idRol)
	END
GO

CREATE PROCEDURE PcModificarRoleUser
@idUserSystem INT,
@idRol INT
AS
	BEGIN
		UPDATE usersRoles SET idUserRol = @idUserSystem, idRolUser = @idRol  WHERE idUserRol = @idUserSystem
	END
GO

CREATE PROCEDURE PcEliminarRoleUser
@idUserSystem INT
AS
	BEGIN
		DELETE FROM usersRoles WHERE idUserRol = @idUserSystem
	END
GO

CREATE PROCEDURE PcConsultarRolUser
@idUser INT
AS
	BEGIN
	SELECT idUserRol, idRolUser FROM usersRoles WHERE idUserRol = @idUser
	END
GO

CREATE PROCEDURE PcTablaRolesUsuarios
AS
	BEGIN
	SELECT UR.idRolUser, R.nombreRol, UR.idUserRol, U.nombre
    FROM usersRoles UR
    INNER JOIN roles R ON UR.idRolUser = R.RolID
	INNER JOIN Usuarios U ON UR.idUserRol = U.usuarioID
	
	END
GO


CREATE PROCEDURE PcDropListUsuarioSistemaTecnico
AS
	BEGIN
		SELECT nombre, usuarioID FROM Usuarios U
		INNER JOIN usersRoles UR ON U.usuarioID = idUserRol
		INNER JOIN roles R ON UR.idRolUser  = RolID
		WHERE R.nombreRol = 'Tecnico'
	END
GO

CREATE PROCEDURE PcDropListUsuariosRoles
AS
	BEGIN
		SELECT nombre, usuarioID FROM Usuarios
	END
GO

/*
		SELECT T.nombre, 
		T.especialidad, 
		A.asignacionID,
		A.fechaAsignacion  
		FROM Tecnicos T 
		INNER JOIN Asignaciones A ON T.TecnicoID =  A.tecnicoID
		INNER JOIN Reparaciones R ON A.reparacionID = R.reparacionID

		SELECT 
			U.usuarioID, 
			U.nombre, 
			E.tipoEquipo, 
			E.modelo, 
			R.estado,
			DR.descripcion,
			A.fechaAsignacion,
			T.nombre,
			T.especialidad
		FROM 
			Usuarios U
		INNER JOIN Equipos E ON U.usuarioID = E.usuarioID
		INNER JOIN Reparaciones R ON E.equipoID = R.equipoID
		INNER JOIN DetallesReparacion DR ON  R.reparacionID = DR.reparacionID
		INNER JOIN Asignaciones A ON R.reparacionID = A.reparacionID
		INNER JOIN Tecnicos T ON A.tecnicoID = T.tecnicoID
		*/


--PROCEDIMIENTOS ALMACENADOS PARA REPARACIONES***************

CREATE PROCEDURE PcDropListEquipos
AS
BEGIN 
 SELECT E.equipoID FROM Equipos E
 END 
 GO


 CREATE PROCEDURE PcTablaReparaciones
AS
BEGIN 
 SELECT 
	 R.reparacionID AS 'ID REPARACION', 
	 R.equipoID AS 'EQUIPO ID', 
	 R.fechaSolicitud AS 'FECHA SOLICITUD', 
	 R.estado AS 'ESTADO',
	 E.tipoEquipo AS 'TIPO',
	 E.modelo AS 'MODELO',
	 E.usuarioID AS 'USUARIO ID'
 FROM Reparaciones R
	INNER JOIN Equipos E ON E.equipoID = R.equipoID
 END 
 GO

CREATE PROCEDURE PcReparacionesAgregar
@IDEquipo INT,
@Fecha DATE,
@Estado CHAR
AS
BEGIN 
 INSERT INTO Reparaciones (equipoID, fechaSolicitud, estado) VALUES (@IDEquipo, @Fecha, @Estado)
 END 
 GO

CREATE PROCEDURE PcReparacionesConsultar
@IDReparacion INT
AS
BEGIN 
 SELECT 
	 R.reparacionID AS 'ID REPARACION', 
	 R.equipoID AS 'EQUIPO ID', 
	 R.fechaSolicitud AS 'FECHA SOLICITUD', 
	 R.estado AS 'ESTADO'
 FROM Reparaciones R WHERE reparacionID = @IDReparacion
 END 
 GO

 CREATE PROCEDURE PcReparacionesActualizar
@IDReparacion INT,
@EquipoID INT,
@Fecha DATETIME,
@Estado CHAR
AS
BEGIN 
 	 UPDATE Reparaciones SET  equipoID = @EquipoID, fechaSolicitud = @Fecha, estado = @Estado WHERE reparacionID = @IDReparacion
 END 
 GO


 --PROCEDIMIENTOS ALMACENADOS PARA ASIGNACIONES***************

 CREATE PROCEDURE PcDropListReparaciones
 AS
 BEGIN
 SELECT reparacionID FROM Reparaciones WHERE NOT estado ='C'
 END
 GO

  CREATE PROCEDURE PcTablaAsignaciones
AS
BEGIN 
 SELECT 
	 A.asignacionID AS 'ID ASIGNACION', 
	 A.reparacionID AS 'REPARACION ID',
	 A.fechaAsignacion AS 'ASIGNADO',
	 A.tecnicoID AS 'COD. TECNICO',
	 U.nombre AS  'NOMBRE TECNICO'
 FROM Asignaciones A
	INNER JOIN Tecnicos	T ON A.tecnicoID = T.tecnicoID
	INNER JOIN Usuarios U ON T.usuarioID = U.usuarioID
	INNER JOIN Reparaciones R ON A.reparacionID = R.equipoID
WHERE NOT R.estado = 'C' 
 END 
 GO

 CREATE PROCEDURE PcAsignacionesAgregar
@IDReparacion INT,
@IDTecnico INT
AS
BEGIN 
 INSERT INTO Asignaciones(reparacionID, tecnicoID, fechaAsignacion) VALUES (@IDReparacion, @IDTecnico, GETDATE())
 END 
 GO

CREATE PROCEDURE PcAsignacionesConsultar
@IDAsignacion INT
AS
BEGIN 
 SELECT 
	 A.asignacionID AS 'ID REPARACION', 
	 A.reparacionID AS 'EQUIPO ID', 
	 A.tecnicoID AS 'TECNICO',
	 A.fechaAsignacion AS 'FECHA'
 FROM Asignaciones A WHERE asignacionID = @IDAsignacion
 END 
 GO

 CREATE PROCEDURE PcAsignacionModificar
 @IDAsignacion INT,
@IDReparacion INT,
@IDTecnico INT
AS
BEGIN 
 	 UPDATE Asignaciones SET  reparacionID = @IDReparacion, tecnicoID = @IDTecnico, fechaAsignacion = GETDATE() WHERE asignacionID = @IDAsignacion
 END 
 GO

 CREATE PROCEDURE PcDropListTecnicos
AS
	BEGIN
		SELECT U.nombre, T.tecnicoID FROM Tecnicos T
		INNER JOIN Usuarios U ON T.usuarioID = U.usuarioID
	END
GO

select * from Asignaciones


-- INGRESO DE DATOS PARA LA TRABAJAR LA BASE DE DATOS:

-- Insertar más datos en la tabla Usuarios
INSERT INTO Usuarios (nombre, correoElectronico, telefono) VALUES
('Laura Gómez', 'laura.gomez@example.com', '111222333'),
('Pedro Ramírez', 'pedro.ramirez@example.com', '444555666'),
('Ana Torres', 'ana.torres@example.com', '777888999'),
('Jose Antonio Valerio', 'jose.valerio@example.com', '88092323'),
('Cliente 1', 'cliente1@example.com', '999888777'),
('Cliente 2', 'cliente2@example.com', '666555444'),
('Cliente 3', 'cliente3@example.com', '333222111');

-- Insertar más datos en la tabla systemAccess (Contraseñas solo para usuarios que necesitan acceso)
INSERT INTO systemAccess (usuarioID, contrasenna) VALUES
(1, CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', '123'), 2)), -- Laura Gómez
(2, CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', 'contrasennaPedro'), 2)), -- Pedro Ramírez
(3, CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', 'contrasennaAna'), 2)), -- Ana Torres
(4, CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', '123'), 2)); -- Jose Antonio Valerio

-- Insertar más datos en la tabla Tecnicos (Solo para usuarios con rol 'Tecnico')
INSERT INTO Tecnicos (especialidad, usuarioID) VALUES
('Software', 2),
('Redes', 4);

-- Insertar más datos en la tabla Equipos
INSERT INTO Equipos (tipoEquipo, modelo, usuarioID) VALUES
('Impresora', 'HP LaserJet', 4),
('Smartphone', 'iPhone 13', 5),
('Servidor', 'Dell PowerEdge', 6);

-- Insertar más datos en la tabla Reparaciones
INSERT INTO Reparaciones (equipoID, fechaSolicitud, estado) VALUES
(1, GETDATE(), 'P'),
(2, GETDATE(), 'P'),
(3, GETDATE(), 'P');

-- Insertar más datos en la tabla DetallesReparacion
INSERT INTO DetallesReparacion (reparacionID, descripcion, fechaInicio, fechaFin) VALUES
(1, 'Reparación de cartuchos', GETDATE(), GETDATE()),
(2, 'Reparación de pantalla rota', GETDATE(), GETDATE()),
(3, 'Configuración de red', GETDATE(), GETDATE());

-- Insertar más datos en la tabla Asignaciones
INSERT INTO Asignaciones (reparacionID, tecnicoID, fechaAsignacion) VALUES
(1, 1, GETDATE()),
(2, 1, GETDATE()),
(3, 2, GETDATE());

-- Insertar más datos en la tabla roles
INSERT INTO roles (nombreRol) VALUES
('Tecnico'),
('Admin'),
('Lector');
GO

-- Insertar más datos en la tabla usersRoles (Roles solo para usuarios que necesitan acceso)
INSERT INTO usersRoles (idUserRol, idRolUser) VALUES
(1, 2), -- Laura Gómez es Admin
(2, 1), -- Pedro Ramírez es Tecnico
(3, 3), -- Ana Torres es Lector
(4, 1); -- Jose es Tecnico
GO


--PROCEDIMIENTOS ALMACENADOS DE REPORTES*****************************

CREATE PROCEDURE STPCReporteUsuarioNombre
@Filtro VARCHAR(50)
AS
	BEGIN
		SELECT 
		usuarioID AS 'ID USUARIO',
		nombre AS 'NOMBRE',
		correoElectronico AS 'CORREO',
		telefono AS 'TELEFONO'
		FROM Usuarios WHERE nombre LIKE '%' + @Filtro + '%'
	END
	GO

CREATE PROCEDURE STPCReporteUsuarioID
@Filtro INT
AS
	BEGIN
		SELECT 
		usuarioID AS 'ID USUARIO',
		nombre AS 'NOMBRE',
		correoElectronico AS 'CORREO',
		telefono AS 'TELEFONO'
		FROM Usuarios WHERE usuarioID = @Filtro
	END
	GO

CREATE PROCEDURE STPCReporteUsuarioCorreo
@Filtro VARCHAR(50)
AS
	BEGIN
		SELECT 
		usuarioID AS 'ID USUARIO',
		nombre AS 'NOMBRE',
		correoElectronico AS 'CORREO',
		telefono AS 'TELEFONO'
		FROM Usuarios WHERE correoElectronico LIKE '%' + @Filtro + '%'
	END
	GO

CREATE PROCEDURE STPCReporteUsuarioTelefono
@Filtro VARCHAR(50)
AS
	BEGIN
		SELECT 
		usuarioID AS 'ID USUARIO',
		nombre AS 'NOMBRE',
		correoElectronico AS 'CORREO',
		telefono AS 'TELEFONO'
		FROM Usuarios WHERE telefono LIKE '%' + @Filtro + '%'
	END
	GO

	--------------------------------REPORTE EQUIPOS ------------------------------------

	CREATE PROCEDURE STPCReporteEquipos
AS
	BEGIN
		SELECT 
		E.equipoID AS 'ID EQUIPO',
		E.tipoEquipo AS 'TIPO DE EQUIPO',
		E.modelo AS 'MODELO',
		R.estado AS 'ESTADO',
		U.usuarioID AS 'ID USUARIO',
		U.nombre AS 'NOMBRE DEL USUARIO'
		FROM Equipos E
		INNER JOIN Usuarios U ON E.usuarioID = U.usuarioID
		INNER JOIN Reparaciones R ON E.equipoID = R.equipoID
	END
	GO

	CREATE PROCEDURE STPCReporteEquiposIDEquipo
	@Filtro INT
AS
	BEGIN
		SELECT 
		E.equipoID AS 'ID EQUIPO',
		E.tipoEquipo AS 'TIPO DE EQUIPO',
		E.modelo AS 'MODELO',
		R.estado AS 'ESTADO',
		U.usuarioID AS 'ID USUARIO',
		U.nombre AS 'NOMBRE DEL USUARIO'
		FROM Equipos E
		INNER JOIN Usuarios U ON E.usuarioID = U.usuarioID
		INNER JOIN Reparaciones R ON E.equipoID = R.equipoID 
		WHERE E.equipoID = @Filtro
	END
	GO

CREATE PROCEDURE STPCReporteEquiposTipoEquipo
	@Filtro VARCHAR(50)
AS
	BEGIN
		SELECT 
		E.equipoID AS 'ID EQUIPO',
		E.tipoEquipo AS 'TIPO DE EQUIPO',
		E.modelo AS 'MODELO',
		R.estado AS 'ESTADO',
		U.usuarioID AS 'ID USUARIO',
		U.nombre AS 'NOMBRE DEL USUARIO'
		FROM Equipos E
		INNER JOIN Usuarios U ON E.usuarioID = U.usuarioID
		INNER JOIN Reparaciones R ON E.equipoID = R.equipoID 
		WHERE E.tipoEquipo LIKE '%' + @Filtro + '%'
	END
	GO

CREATE PROCEDURE STPCReporteEquiposModelo
	@Filtro VARCHAR(50)
AS
	BEGIN
		SELECT 
		E.equipoID AS 'ID EQUIPO',
		E.tipoEquipo AS 'TIPO DE EQUIPO',
		E.modelo AS 'MODELO',
		R.estado AS 'ESTADO',
		U.usuarioID AS 'ID USUARIO',
		U.nombre AS 'NOMBRE DEL USUARIO'
		FROM Equipos E
		INNER JOIN Usuarios U ON E.usuarioID = U.usuarioID
		INNER JOIN Reparaciones R ON E.equipoID = R.equipoID 
		WHERE E.modelo LIKE '%' + @Filtro + '%'
	END
	GO

CREATE PROCEDURE STPCReporteEquiposEstado
	@Filtro CHAR
AS
	BEGIN
		SELECT 
		E.equipoID AS 'ID EQUIPO',
		E.tipoEquipo AS 'TIPO DE EQUIPO',
		E.modelo AS 'MODELO',
		R.estado AS 'ESTADO',
		U.usuarioID AS 'ID USUARIO',
		U.nombre AS 'NOMBRE DEL USUARIO'
		FROM Equipos E
		INNER JOIN Usuarios U ON E.usuarioID = U.usuarioID
		INNER JOIN Reparaciones R ON E.equipoID = R.equipoID 
		WHERE R.estado = @Filtro
	END
	GO

CREATE PROCEDURE STPCReporteEquiposUsuarioID
	@Filtro INT
AS
	BEGIN
		SELECT 
		E.equipoID AS 'ID EQUIPO',
		E.tipoEquipo AS 'TIPO DE EQUIPO',
		E.modelo AS 'MODELO',
		R.estado AS 'ESTADO',
		U.usuarioID AS 'ID USUARIO',
		U.nombre AS 'NOMBRE DEL USUARIO'
		FROM Equipos E
		INNER JOIN Usuarios U ON E.usuarioID = U.usuarioID
		INNER JOIN Reparaciones R ON E.equipoID = R.equipoID 
		WHERE E.usuarioID = @Filtro
	END
	GO

CREATE PROCEDURE STPCReporteEquiposNombreUsuario
	@Filtro VARCHAR(50)
AS
	BEGIN
		SELECT 
		E.equipoID AS 'ID EQUIPO',
		E.tipoEquipo AS 'TIPO DE EQUIPO',
		E.modelo AS 'MODELO',
		R.estado AS 'ESTADO',
		U.usuarioID AS 'ID USUARIO',
		U.nombre AS 'NOMBRE DEL USUARIO'
		FROM Equipos E
		INNER JOIN Usuarios U ON E.usuarioID = U.usuarioID
		INNER JOIN Reparaciones R ON E.equipoID = R.equipoID 
		WHERE U.nombre LIKE '%' + @Filtro + '%'
	END
	GO

		--------------------------------REPORTE EQUIPOS ------------------------------------

	CREATE PROCEDURE STPCReporteAccesosUsuarios
AS
	BEGIN
		SELECT 
			SA.accessID AS 'NUMERO ACCESO',
			U.usuarioID AS 'ID USUARIO',
			U.nombre AS 'NOMBRE USUARIO',
			U.correoElectronico AS 'CORREO',
			SA.contrasenna AS 'CLAVE',
			R.nombreRol AS 'ROL'
		FROM systemAccess SA
		INNER JOIN Usuarios U ON SA.usuarioID = U.usuarioID
		INNER JOIN usersRoles UR ON UR.idUserRol = U.usuarioID
		INNER JOIN roles R ON R.RolID = UR.idRolUser
	END
	GO

CREATE PROCEDURE STPCReporteAccesosNumeroAcceso
@Filtro INT	
AS
	BEGIN
		SELECT 
			SA.accessID AS 'NUMERO ACCESO',
			U.usuarioID AS 'ID USUARIO',
			U.nombre AS 'NOMBRE USUARIO',
			U.correoElectronico AS 'CORREO',
			SA.contrasenna AS 'CLAVE',
			R.nombreRol AS 'ROL'
		FROM systemAccess SA
		INNER JOIN Usuarios U ON SA.usuarioID = U.usuarioID
		INNER JOIN usersRoles UR ON UR.idUserRol = U.usuarioID
		INNER JOIN roles R ON R.RolID = UR.idRolUser
		WHERE SA.accessID = @Filtro
	END
	GO

CREATE PROCEDURE STPCReporteAccesosIDUsuario
@Filtro INT	
AS
	BEGIN
		SELECT 
			SA.accessID AS 'NUMERO ACCESO',
			U.usuarioID AS 'ID USUARIO',
			U.nombre AS 'NOMBRE USUARIO',
			U.correoElectronico AS 'CORREO',
			SA.contrasenna AS 'CLAVE',
			R.nombreRol AS 'ROL'
		FROM systemAccess SA
		INNER JOIN Usuarios U ON SA.usuarioID = U.usuarioID
		INNER JOIN usersRoles UR ON UR.idUserRol = U.usuarioID
		INNER JOIN roles R ON R.RolID = UR.idRolUser
		WHERE U.usuarioID = @Filtro
	END
	GO

CREATE PROCEDURE STPCReporteAccesosNombre
@Filtro VARCHAR(50)	
AS
	BEGIN
		SELECT 
			SA.accessID AS 'NUMERO ACCESO',
			U.usuarioID AS 'ID USUARIO',
			U.nombre AS 'NOMBRE USUARIO',
			U.correoElectronico AS 'CORREO',
			SA.contrasenna AS 'CLAVE',
			R.nombreRol AS 'ROL'
		FROM systemAccess SA
		INNER JOIN Usuarios U ON SA.usuarioID = U.usuarioID
		INNER JOIN usersRoles UR ON UR.idUserRol = U.usuarioID
		INNER JOIN roles R ON R.RolID = UR.idRolUser
		WHERE U.nombre LIKE '%' + @Filtro + '%'
	END
	GO

CREATE PROCEDURE STPCReporteAccesosCorreo
@Filtro VARCHAR(50)	
AS
	BEGIN
		SELECT 
			SA.accessID AS 'NUMERO ACCESO',
			U.usuarioID AS 'ID USUARIO',
			U.nombre AS 'NOMBRE USUARIO',
			U.correoElectronico AS 'CORREO',
			SA.contrasenna AS 'CLAVE',
			R.nombreRol AS 'ROL'
		FROM systemAccess SA
		INNER JOIN Usuarios U ON SA.usuarioID = U.usuarioID
		INNER JOIN usersRoles UR ON UR.idUserRol = U.usuarioID
		INNER JOIN roles R ON R.RolID = UR.idRolUser
		WHERE U.correoElectronico LIKE '%' + @Filtro + '%'
	END
	GO

CREATE PROCEDURE STPCReporteAccesosRol
@Filtro VARCHAR(50)	
AS
	BEGIN
		SELECT 
			SA.accessID AS 'NUMERO ACCESO',
			U.usuarioID AS 'ID USUARIO',
			U.nombre AS 'NOMBRE USUARIO',
			U.correoElectronico AS 'CORREO',
			SA.contrasenna AS 'CLAVE',
			R.nombreRol AS 'ROL'
		FROM systemAccess SA
		INNER JOIN Usuarios U ON SA.usuarioID = U.usuarioID
		INNER JOIN usersRoles UR ON UR.idUserRol = U.usuarioID
		INNER JOIN roles R ON R.RolID = UR.idRolUser
		WHERE R.nombreRol LIKE '%' + @Filtro + '%'
	END
	GO

CREATE PROCEDURE STPCReporteDetalladoReparaciones
AS
BEGIN
    SELECT 
        U.nombre AS 'DUEÑO DEL EQUIPO',
        E.equipoID AS 'ID EQUIPO',
        E.tipoEquipo AS 'TIPO',
        E.modelo AS 'MODELO',
        R.reparacionID AS 'ID REPARACIÓN',
        R.fechaSolicitud AS 'SOLICITUD DE REPARACIÓN',
        R.estado AS 'ESTADO',
        A.asignacionID AS 'ID ASIGNACIÓN',
        T.tecnicoID AS 'TÉCNICO ASIGNADO',
        DR.descripcion AS 'DESCRIPCIÓN DE REPARACIÓN',
        DR.fechaInicio AS 'INICIO DE REPARACIÓN',
        DR.fechaFin AS 'FIN DE REPARACIÓN'
    FROM Usuarios U
    INNER JOIN Equipos E ON U.usuarioID = E.usuarioID
    INNER JOIN Reparaciones R ON E.equipoID = R.equipoID
    LEFT JOIN Asignaciones A ON R.reparacionID = A.reparacionID
    LEFT JOIN Tecnicos T ON A.tecnicoID = T.tecnicoID
    LEFT JOIN DetallesReparacion DR ON R.reparacionID = DR.reparacionID
END
GO

CREATE PROCEDURE STPCReporteReparacionesNombre
@Filtro VARCHAR(50)
AS
BEGIN
    SELECT 
        U.nombre AS 'DUEÑO DEL EQUIPO',
        E.equipoID AS 'ID EQUIPO',
        E.tipoEquipo AS 'TIPO',
        E.modelo AS 'MODELO',
        R.reparacionID AS 'ID REPARACIÓN',
        R.fechaSolicitud AS 'SOLICITUD DE REPARACIÓN',
        R.estado AS 'ESTADO',
        A.asignacionID AS 'ID ASIGNACIÓN',
        T.tecnicoID AS 'TÉCNICO ASIGNADO',
        DR.descripcion AS 'DESCRIPCIÓN DE REPARACIÓN',
        DR.fechaInicio AS 'INICIO DE REPARACIÓN',
        DR.fechaFin AS 'FIN DE REPARACIÓN'
    FROM Usuarios U
    INNER JOIN Equipos E ON U.usuarioID = E.usuarioID
    INNER JOIN Reparaciones R ON E.equipoID = R.equipoID
    LEFT JOIN Asignaciones A ON R.reparacionID = A.reparacionID
    LEFT JOIN Tecnicos T ON A.tecnicoID = T.tecnicoID
    LEFT JOIN DetallesReparacion DR ON R.reparacionID = DR.reparacionID
	WHERE U.nombre LIKE '%' + @Filtro + '%'
END
GO

CREATE PROCEDURE STPCReporteReparacionesIDEquipo
@Filtro INT
AS
BEGIN
    SELECT 
        U.nombre AS 'DUEÑO DEL EQUIPO',
        E.equipoID AS 'ID EQUIPO',
        E.tipoEquipo AS 'TIPO',
        E.modelo AS 'MODELO',
        R.reparacionID AS 'ID REPARACIÓN',
        R.fechaSolicitud AS 'SOLICITUD DE REPARACIÓN',
        R.estado AS 'ESTADO',
        A.asignacionID AS 'ID ASIGNACIÓN',
        T.tecnicoID AS 'TÉCNICO ASIGNADO',
        DR.descripcion AS 'DESCRIPCIÓN DE REPARACIÓN',
        DR.fechaInicio AS 'INICIO DE REPARACIÓN',
        DR.fechaFin AS 'FIN DE REPARACIÓN'
    FROM Usuarios U
    INNER JOIN Equipos E ON U.usuarioID = E.usuarioID
    INNER JOIN Reparaciones R ON E.equipoID = R.equipoID
    LEFT JOIN Asignaciones A ON R.reparacionID = A.reparacionID
    LEFT JOIN Tecnicos T ON A.tecnicoID = T.tecnicoID
    LEFT JOIN DetallesReparacion DR ON R.reparacionID = DR.reparacionID
	WHERE E.equipoID = @Filtro
END
GO

CREATE PROCEDURE STPCReporteReparacionesTipoEquipo
@Filtro VARCHAR(50)
AS
BEGIN
    SELECT 
        U.nombre AS 'DUEÑO DEL EQUIPO',
        E.equipoID AS 'ID EQUIPO',
        E.tipoEquipo AS 'TIPO',
        E.modelo AS 'MODELO',
        R.reparacionID AS 'ID REPARACIÓN',
        R.fechaSolicitud AS 'SOLICITUD DE REPARACIÓN',
        R.estado AS 'ESTADO',
        A.asignacionID AS 'ID ASIGNACIÓN',
        T.tecnicoID AS 'TÉCNICO ASIGNADO',
        DR.descripcion AS 'DESCRIPCIÓN DE REPARACIÓN',
        DR.fechaInicio AS 'INICIO DE REPARACIÓN',
        DR.fechaFin AS 'FIN DE REPARACIÓN'
    FROM Usuarios U
    INNER JOIN Equipos E ON U.usuarioID = E.usuarioID
    INNER JOIN Reparaciones R ON E.equipoID = R.equipoID
    LEFT JOIN Asignaciones A ON R.reparacionID = A.reparacionID
    LEFT JOIN Tecnicos T ON A.tecnicoID = T.tecnicoID
    LEFT JOIN DetallesReparacion DR ON R.reparacionID = DR.reparacionID
	WHERE E.tipoEquipo LIKE '%' + @Filtro + '%'
END
GO

CREATE PROCEDURE STPCReporteReparacionesModeloEquipo
@Filtro VARCHAR(50)
AS
BEGIN
    SELECT 
        U.nombre AS 'DUEÑO DEL EQUIPO',
        E.equipoID AS 'ID EQUIPO',
        E.tipoEquipo AS 'TIPO',
        E.modelo AS 'MODELO',
        R.reparacionID AS 'ID REPARACIÓN',
        R.fechaSolicitud AS 'SOLICITUD DE REPARACIÓN',
        R.estado AS 'ESTADO',
        A.asignacionID AS 'ID ASIGNACIÓN',
        T.tecnicoID AS 'TÉCNICO ASIGNADO',
        DR.descripcion AS 'DESCRIPCIÓN DE REPARACIÓN',
        DR.fechaInicio AS 'INICIO DE REPARACIÓN',
        DR.fechaFin AS 'FIN DE REPARACIÓN'
    FROM Usuarios U
    INNER JOIN Equipos E ON U.usuarioID = E.usuarioID
    INNER JOIN Reparaciones R ON E.equipoID = R.equipoID
    LEFT JOIN Asignaciones A ON R.reparacionID = A.reparacionID
    LEFT JOIN Tecnicos T ON A.tecnicoID = T.tecnicoID
    LEFT JOIN DetallesReparacion DR ON R.reparacionID = DR.reparacionID
	WHERE E.modelo LIKE '%' + @Filtro + '%'
END
GO

CREATE PROCEDURE STPCReporteReparacionesIDReparacion
@Filtro INT
AS
BEGIN
    SELECT 
        U.nombre AS 'DUEÑO DEL EQUIPO',
        E.equipoID AS 'ID EQUIPO',
        E.tipoEquipo AS 'TIPO',
        E.modelo AS 'MODELO',
        R.reparacionID AS 'ID REPARACIÓN',
        R.fechaSolicitud AS 'SOLICITUD DE REPARACIÓN',
        R.estado AS 'ESTADO',
        A.asignacionID AS 'ID ASIGNACIÓN',
        T.tecnicoID AS 'TÉCNICO ASIGNADO',
        DR.descripcion AS 'DESCRIPCIÓN DE REPARACIÓN',
        DR.fechaInicio AS 'INICIO DE REPARACIÓN',
        DR.fechaFin AS 'FIN DE REPARACIÓN'
    FROM Usuarios U
    INNER JOIN Equipos E ON U.usuarioID = E.usuarioID
    INNER JOIN Reparaciones R ON E.equipoID = R.equipoID
    LEFT JOIN Asignaciones A ON R.reparacionID = A.reparacionID
    LEFT JOIN Tecnicos T ON A.tecnicoID = T.tecnicoID
    LEFT JOIN DetallesReparacion DR ON R.reparacionID = DR.reparacionID
	WHERE R.reparacionID = @Filtro
END
GO

CREATE PROCEDURE STPCReporteReparacionesEstado
@Filtro VARCHAR(50)
AS
BEGIN
    SELECT 
        U.nombre AS 'DUEÑO DEL EQUIPO',
        E.equipoID AS 'ID EQUIPO',
        E.tipoEquipo AS 'TIPO',
        E.modelo AS 'MODELO',
        R.reparacionID AS 'ID REPARACIÓN',
        R.fechaSolicitud AS 'SOLICITUD DE REPARACIÓN',
        R.estado AS 'ESTADO',
        A.asignacionID AS 'ID ASIGNACIÓN',
        T.tecnicoID AS 'TÉCNICO ASIGNADO',
        DR.descripcion AS 'DESCRIPCIÓN DE REPARACIÓN',
        DR.fechaInicio AS 'INICIO DE REPARACIÓN',
        DR.fechaFin AS 'FIN DE REPARACIÓN'
    FROM Usuarios U
    INNER JOIN Equipos E ON U.usuarioID = E.usuarioID
    INNER JOIN Reparaciones R ON E.equipoID = R.equipoID
    LEFT JOIN Asignaciones A ON R.reparacionID = A.reparacionID
    LEFT JOIN Tecnicos T ON A.tecnicoID = T.tecnicoID
    LEFT JOIN DetallesReparacion DR ON R.reparacionID = DR.reparacionID
	WHERE R.estado LIKE '%' + @Filtro + '%'
END
GO

CREATE PROCEDURE STPCReporteReparacionesIDAsignacion
@Filtro INT
AS
BEGIN
    SELECT 
        U.nombre AS 'DUEÑO DEL EQUIPO',
        E.equipoID AS 'ID EQUIPO',
        E.tipoEquipo AS 'TIPO',
        E.modelo AS 'MODELO',
        R.reparacionID AS 'ID REPARACIÓN',
        R.fechaSolicitud AS 'SOLICITUD DE REPARACIÓN',
        R.estado AS 'ESTADO',
        A.asignacionID AS 'ID ASIGNACIÓN',
        T.tecnicoID AS 'TÉCNICO ASIGNADO',
        DR.descripcion AS 'DESCRIPCIÓN DE REPARACIÓN',
        DR.fechaInicio AS 'INICIO DE REPARACIÓN',
        DR.fechaFin AS 'FIN DE REPARACIÓN'
    FROM Usuarios U
    INNER JOIN Equipos E ON U.usuarioID = E.usuarioID
    INNER JOIN Reparaciones R ON E.equipoID = R.equipoID
    LEFT JOIN Asignaciones A ON R.reparacionID = A.reparacionID
    LEFT JOIN Tecnicos T ON A.tecnicoID = T.tecnicoID
    LEFT JOIN DetallesReparacion DR ON R.reparacionID = DR.reparacionID
	WHERE A.asignacionID = @Filtro
END
GO

CREATE PROCEDURE STPCReporteReparacionesIDTecnico
@Filtro INT
AS
BEGIN
    SELECT 
        U.nombre AS 'DUEÑO DEL EQUIPO',
        E.equipoID AS 'ID EQUIPO',
        E.tipoEquipo AS 'TIPO',
        E.modelo AS 'MODELO',
        R.reparacionID AS 'ID REPARACIÓN',
        R.fechaSolicitud AS 'SOLICITUD DE REPARACIÓN',
        R.estado AS 'ESTADO',
        A.asignacionID AS 'ID ASIGNACIÓN',
        T.tecnicoID AS 'TÉCNICO ASIGNADO',
        DR.descripcion AS 'DESCRIPCIÓN DE REPARACIÓN',
        DR.fechaInicio AS 'INICIO DE REPARACIÓN',
        DR.fechaFin AS 'FIN DE REPARACIÓN'
    FROM Usuarios U
    INNER JOIN Equipos E ON U.usuarioID = E.usuarioID
    INNER JOIN Reparaciones R ON E.equipoID = R.equipoID
    LEFT JOIN Asignaciones A ON R.reparacionID = A.reparacionID
    LEFT JOIN Tecnicos T ON A.tecnicoID = T.tecnicoID
    LEFT JOIN DetallesReparacion DR ON R.reparacionID = DR.reparacionID
	WHERE T.tecnicoID = @Filtro
END
GO

CREATE PROCEDURE STPCReporteReparacionesDescripcion
@Filtro VARCHAR(50)
AS
BEGIN
    SELECT 
        U.nombre AS 'DUEÑO DEL EQUIPO',
        E.equipoID AS 'ID EQUIPO',
        E.tipoEquipo AS 'TIPO',
        E.modelo AS 'MODELO',
        R.reparacionID AS 'ID REPARACIÓN',
        R.fechaSolicitud AS 'SOLICITUD DE REPARACIÓN',
        R.estado AS 'ESTADO',
        A.asignacionID AS 'ID ASIGNACIÓN',
        T.tecnicoID AS 'TÉCNICO ASIGNADO',
        DR.descripcion AS 'DESCRIPCIÓN DE REPARACIÓN',
        DR.fechaInicio AS 'INICIO DE REPARACIÓN',
        DR.fechaFin AS 'FIN DE REPARACIÓN'
    FROM Usuarios U
    INNER JOIN Equipos E ON U.usuarioID = E.usuarioID
    INNER JOIN Reparaciones R ON E.equipoID = R.equipoID
    LEFT JOIN Asignaciones A ON R.reparacionID = A.reparacionID
    LEFT JOIN Tecnicos T ON A.tecnicoID = T.tecnicoID
    LEFT JOIN DetallesReparacion DR ON R.reparacionID = DR.reparacionID
	WHERE DR.descripcion LIKE '%' + @Filtro + '%'
END
GO