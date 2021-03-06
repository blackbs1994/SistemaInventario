USE [inventario]
GO
/****** Object:  StoredProcedure [dbo].[prApp_Caracteristicas_Insert]    Script Date: 01/03/2018 8:43:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------
-- Insert a single record into Caracteristicas
----------------------------------------------------------------------------
CREATE PROC [dbo].[prApp_Caracteristicas_Insert]
	@idTipoCaracteristica int,
	@Caracteristica text = NULL,
	@Descripcion text = NULL
AS

INSERT Caracteristicas(idTipoCaracteristica, Caracteristica, Descripcion)
VALUES (@idTipoCaracteristica, @Caracteristica, @Descripcion)

RETURN SCOPE_IDENTITY()

GO
/****** Object:  StoredProcedure [dbo].[prApp_Caracteristicas_Select]    Script Date: 01/03/2018 8:43:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------
-- Select a single record from Caracteristicas
----------------------------------------------------------------------------
CREATE PROC [dbo].[prApp_Caracteristicas_Select]

AS

SELECT        dbo.Caracteristicas.idCaracteristica, dbo.TipoCaracteristicas.TipoCaracteristica, dbo.Caracteristicas.Caracteristica, dbo.Caracteristicas.Descripcion
FROM            dbo.Caracteristicas INNER JOIN
                         dbo.TipoCaracteristicas ON dbo.Caracteristicas.idTipoCaracteristica = dbo.TipoCaracteristicas.idTipoCaracteristica

GO
/****** Object:  StoredProcedure [dbo].[prApp_CatalogoProductos_Insert]    Script Date: 01/03/2018 8:43:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------
-- Insert a single record into CatalogoProductos
----------------------------------------------------------------------------
CREATE PROC [dbo].[prApp_CatalogoProductos_Insert]
	@CatalogoProducto text = NULL,
	@Descripcion text = NULL
AS

INSERT CatalogoProductos(CatalogoProducto, Descripcion)
VALUES (@CatalogoProducto, @Descripcion)

RETURN SCOPE_IDENTITY()

GO
/****** Object:  StoredProcedure [dbo].[prApp_CatalogoProductos_Select]    Script Date: 01/03/2018 8:43:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------
-- Select a single record from CatalogoProductos
----------------------------------------------------------------------------
CREATE PROC [dbo].[prApp_CatalogoProductos_Select]
	
AS

SELECT	idCatalogoProducto,
	CatalogoProducto,
	Descripcion
FROM	CatalogoProductos


GO
/****** Object:  StoredProcedure [dbo].[prApp_Departamentos_Select]    Script Date: 01/03/2018 8:43:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------
-- Select a single record from Departamentos
----------------------------------------------------------------------------
CREATE PROC [dbo].[prApp_Departamentos_Select]
	
AS

SELECT	idDepartamento,
	idTipoDepartamento,
	Departamento,
	Descripcion
FROM	Departamentos


GO
/****** Object:  StoredProcedure [dbo].[prApp_Perfiles_Buscar]    Script Date: 01/03/2018 8:43:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------
-- Select a single record from Perfiles
----------------------------------------------------------------------------
CREATE PROC [dbo].[prApp_Perfiles_Buscar]
	@Perfil text
AS

SELECT	idPerfil,
	Perfil,
	Descripcion
FROM	Perfiles
WHERE 	Perfil like @Perfil

GO
/****** Object:  StoredProcedure [dbo].[prApp_Perfiles_Insert]    Script Date: 01/03/2018 8:43:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------
-- Insert a single record into Perfiles
----------------------------------------------------------------------------
CREATE PROC [dbo].[prApp_Perfiles_Insert]
	@Perfil text = NULL,
	@Descripcion text = NULL
AS

INSERT Perfiles(Perfil, Descripcion)
VALUES (@Perfil, @Descripcion)

RETURN SCOPE_IDENTITY()

GO
/****** Object:  StoredProcedure [dbo].[prApp_Perfiles_Select]    Script Date: 01/03/2018 8:43:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------
-- Select a single record from Perfiles
----------------------------------------------------------------------------
CREATE PROC [dbo].[prApp_Perfiles_Select]
	
AS

SELECT	idPerfil,
	Perfil,
	Descripcion
FROM	Perfiles


GO
/****** Object:  StoredProcedure [dbo].[prApp_Productos_Select]    Script Date: 01/03/2018 8:43:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------
-- Select a single record from Productos
----------------------------------------------------------------------------
CREATE PROC [dbo].[prApp_Productos_Select]
as
SELECT 
dbo.TipoProductos.TipoProducto, 
dbo.Marcas.Marca, 
dbo.Modelos.Modelo, 
dbo.Productos.fechaCompra, 
dbo.Productos.codigoFinazas, 
dbo.Productos.codigoSecob, 
dbo.Productos.NumeroSerie, 
dbo.Productos.CostoAdquisicion
FROM dbo.Productos 
INNER JOIN dbo.TipoProductos 
ON dbo.Productos.idTipoProducto = dbo.TipoProductos.idTipoProducto 
INNER JOIN dbo.Modelos 
ON dbo.Productos.idModelo = dbo.Modelos.idModelo 
INNER JOIN dbo.Marcas 
ON dbo.Modelos.idMarca = dbo.Marcas.idMarca

GO
/****** Object:  StoredProcedure [dbo].[prApp_tbUsuarios_acceso]    Script Date: 01/03/2018 8:43:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[prApp_tbUsuarios_acceso]
	@Usuario nvarchar (10),
	@Contrasenia nvarchar (16)
AS
BEGIN
SELECT	idUsuario,
	Usuario,
	Contrasenia
FROM	tbUsuarios
WHERE 	Usuario = @Usuario and Contrasenia = @Contrasenia
END
GO
/****** Object:  StoredProcedure [dbo].[prApp_TipoCaracteristicas_Insert]    Script Date: 01/03/2018 8:43:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------
-- Insert a single record into TipoCaracteristicas
----------------------------------------------------------------------------
CREATE PROC [dbo].[prApp_TipoCaracteristicas_Insert]
	@TipoCaracteristica text = NULL,
	@Descripcion text = NULL
AS

INSERT TipoCaracteristicas(TipoCaracteristica, Descripcion)
VALUES (@TipoCaracteristica, @Descripcion)

RETURN SCOPE_IDENTITY()

GO
/****** Object:  StoredProcedure [dbo].[prApp_TipoCaracteristicas_Select]    Script Date: 01/03/2018 8:43:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------
-- Select a single record from TipoCaracteristicas
----------------------------------------------------------------------------
CREATE PROC [dbo].[prApp_TipoCaracteristicas_Select]
	
AS

SELECT	idTipoCaracteristica,
	TipoCaracteristica,
	Descripcion
FROM	TipoCaracteristicas


GO
/****** Object:  StoredProcedure [dbo].[prApp_TipoProductos_Insert]    Script Date: 01/03/2018 8:43:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------
-- Insert a single record into TipoProductos
----------------------------------------------------------------------------
CREATE PROC [dbo].[prApp_TipoProductos_Insert]
	@idCatalogoProducto int,
	@TipoProducto text = NULL,
	@Descripcion text = NULL
AS

INSERT TipoProductos(idCatalogoProducto, TipoProducto, Descripcion)
VALUES (@idCatalogoProducto, @TipoProducto, @Descripcion)

RETURN SCOPE_IDENTITY()

GO
/****** Object:  StoredProcedure [dbo].[prApp_TipoProductos_Select]    Script Date: 01/03/2018 8:43:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------
-- Select a single record from TipoProductos
----------------------------------------------------------------------------
CREATE PROC [dbo].[prApp_TipoProductos_Select]
	
AS

SELECT        dbo.CatalogoProductos.CatalogoProducto, dbo.TipoProductos.TipoProducto, dbo.TipoProductos.Descripcion, dbo.CatalogoProductos.idCatalogoProducto, dbo.TipoProductos.idTipoProducto
FROM            dbo.CatalogoProductos INNER JOIN
                         dbo.TipoProductos ON dbo.CatalogoProductos.idCatalogoProducto = dbo.TipoProductos.idCatalogoProducto


GO
/****** Object:  StoredProcedure [dbo].[prApp_Ubicaciones_Select]    Script Date: 01/03/2018 8:43:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------
-- Select a single record from Ubicaciones
----------------------------------------------------------------------------
CREATE PROC [dbo].[prApp_Ubicaciones_Select]
	
AS

SELECT	idUbicacion,
	Ubicacion,
	Descripcion
FROM	Ubicaciones


GO
/****** Object:  StoredProcedure [dbo].[prApp_Usuarios_Insert]    Script Date: 01/03/2018 8:43:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------
-- Insert a single record into Usuarios
----------------------------------------------------------------------------
CREATE PROC [dbo].[prApp_Usuarios_Insert]
	@idDepartamento int,
	@idPerfil int,
	@idUbicacion int,
	@Usuario text,
	@Cedula text = NULL,
	@Nombres text = NULL,
	@Apellidos text = NULL,
	@Correo text = NULL,
	@Direccion text = NULL,
	@Extension text = NULL,
	@Activar tinyint = NULL,
	@Observacion text = NULL,
	@Contrasenia text = NULL,
	@ConfirContrasenia text
AS

INSERT Usuarios(idDepartamento, idPerfil, idUbicacion, Usuario, Cedula, Nombres, Apellidos, Correo, Direccion, Extension, Activar, Observacion, Contrasenia, ConfirContrasenia)
VALUES (@idDepartamento, @idPerfil, @idUbicacion, @Usuario, @Cedula, @Nombres, @Apellidos, @Correo, @Direccion, @Extension, @Activar, @Observacion, @Contrasenia, @ConfirContrasenia)

RETURN SCOPE_IDENTITY()

GO
/****** Object:  StoredProcedure [dbo].[prApp_Usuarios_Select]    Script Date: 01/03/2018 8:43:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------
-- Select a single record from Usuarios
----------------------------------------------------------------------------
CREATE PROC [dbo].[prApp_Usuarios_Select]
	
AS
SELECT
dbo.Usuarios.idUsuario,
dbo.Usuarios.Cedula, 
dbo.Usuarios.Usuario, 
dbo.Usuarios.Nombres, 
dbo.Usuarios.Apellidos, 
dbo.Departamentos.idDepartamento,
dbo.Departamentos.Departamento, 
dbo.Ubicaciones.idUbicacion,
dbo.Ubicaciones.Ubicacion
FROM dbo.Departamentos
INNER JOIN dbo.Usuarios 
ON dbo.Departamentos.idDepartamento = dbo.Usuarios.idDepartamento
INNER JOIN dbo.Ubicaciones 
ON dbo.Usuarios.idUbicacion = dbo.Ubicaciones.idUbicacion

GO
