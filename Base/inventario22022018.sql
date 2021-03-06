USE [master]
GO
/****** Object:  Database [inventario]    Script Date: 22/02/2018 13:47:14 ******/
CREATE DATABASE [inventario]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'inventario', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\inventario.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'inventario_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\inventario_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [inventario] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [inventario].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [inventario] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [inventario] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [inventario] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [inventario] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [inventario] SET ARITHABORT OFF 
GO
ALTER DATABASE [inventario] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [inventario] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [inventario] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [inventario] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [inventario] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [inventario] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [inventario] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [inventario] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [inventario] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [inventario] SET  DISABLE_BROKER 
GO
ALTER DATABASE [inventario] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [inventario] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [inventario] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [inventario] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [inventario] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [inventario] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [inventario] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [inventario] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [inventario] SET  MULTI_USER 
GO
ALTER DATABASE [inventario] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [inventario] SET DB_CHAINING OFF 
GO
ALTER DATABASE [inventario] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [inventario] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [inventario] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [inventario] SET QUERY_STORE = OFF
GO
USE [inventario]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [inventario]
GO
/****** Object:  UserDefinedFunction [dbo].[fnCleanDefaultValue]    Script Date: 22/02/2018 13:47:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnCleanDefaultValue](@sDefaultValue varchar(4000))
RETURNS varchar(4000)
AS
BEGIN
	RETURN SubString(@sDefaultValue, 2, DataLength(@sDefaultValue)-2)
END



GO
/****** Object:  UserDefinedFunction [dbo].[fnColumnDefault]    Script Date: 22/02/2018 13:47:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnColumnDefault](@sTableName varchar(128), @sColumnName varchar(128))
RETURNS varchar(4000)
AS
BEGIN
	DECLARE @sDefaultValue varchar(4000)

	SELECT	@sDefaultValue = dbo.fnCleanDefaultValue(COLUMN_DEFAULT)
	FROM	INFORMATION_SCHEMA.COLUMNS
	WHERE	TABLE_NAME = @sTableName
	 AND 	COLUMN_NAME = @sColumnName

	RETURN 	@sDefaultValue

END

GO
/****** Object:  UserDefinedFunction [dbo].[fnIsColumnPrimaryKey]    Script Date: 22/02/2018 13:47:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE   FUNCTION [dbo].[fnIsColumnPrimaryKey](@sTableName varchar(128), @nColumnName varchar(128))
RETURNS bit
AS
BEGIN
	DECLARE @nTableID int,
		@nIndexID int,
		@i int
	
	SET 	@nTableID = OBJECT_ID(@sTableName)
	
	SELECT 	@nIndexID = indid
	FROM 	sysindexes
	WHERE 	id = @nTableID
	 AND 	indid BETWEEN 1 And 254 
	 AND 	(status & 2048) = 2048
	
	IF @nIndexID Is Null
		RETURN 0
	
	IF @nColumnName IN
		(SELECT sc.[name]
		FROM 	sysindexkeys sik
			INNER JOIN syscolumns sc ON sik.id = sc.id AND sik.colid = sc.colid
		WHERE 	sik.id = @nTableID
		 AND 	sik.indid = @nIndexID)
	 BEGIN
		RETURN 1
	 END


	RETURN 0
END







GO
/****** Object:  UserDefinedFunction [dbo].[fnTableHasPrimaryKey]    Script Date: 22/02/2018 13:47:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnTableHasPrimaryKey](@sTableName varchar(128))
RETURNS bit
AS
BEGIN
	DECLARE @nTableID int,
		@nIndexID int
	
	SET 	@nTableID = OBJECT_ID(@sTableName)
	
	SELECT 	@nIndexID = indid
	FROM 	sysindexes
	WHERE 	id = @nTableID
	 AND 	indid BETWEEN 1 And 254 
	 AND 	(status & 2048) = 2048
	
	IF @nIndexID IS NOT Null
		RETURN 1
	
	RETURN 0
END


GO
/****** Object:  UserDefinedFunction [dbo].[fnTableColumnInfo]    Script Date: 22/02/2018 13:47:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE       FUNCTION [dbo].[fnTableColumnInfo](@sTableName varchar(128))
RETURNS TABLE
AS
	RETURN
	SELECT	c.name AS sColumnName,
		c.colid AS nColumnID,
		dbo.fnIsColumnPrimaryKey(@sTableName, c.name) AS bPrimaryKeyColumn,
		CASE 	WHEN t.name IN ('char', 'varchar', 'binary', 'varbinary', 'nchar', 'nvarchar') THEN 1
			WHEN t.name IN ('decimal', 'numeric') THEN 2
			ELSE 0
		END AS nAlternateType,
		c.length AS nColumnLength,
		c.prec AS nColumnPrecision,
		c.scale AS nColumnScale, 
		c.IsNullable, 
		SIGN(c.status & 128) AS IsIdentity,
		t.name as sTypeName,
		dbo.fnColumnDefault(@sTableName, c.name) AS sDefaultValue
	FROM	syscolumns c 
		INNER JOIN systypes t ON c.xtype = t.xtype and c.usertype = t.usertype
	WHERE	c.id = OBJECT_ID(@sTableName)








GO
/****** Object:  Table [dbo].[Caracteristicas]    Script Date: 22/02/2018 13:47:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Caracteristicas](
	[idCaracteristica] [int] IDENTITY(1,1) NOT NULL,
	[idTipoCaracteristica] [int] NOT NULL,
	[Caracteristica] [text] NULL,
	[Descripcion] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CatalgoProductos]    Script Date: 22/02/2018 13:47:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CatalgoProductos](
	[idCatalgoProducto] [int] IDENTITY(1,1) NOT NULL,
	[CatalogoProducto] [text] NULL,
	[Descripcion] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Departamentos]    Script Date: 22/02/2018 13:47:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departamentos](
	[idDepartamento] [int] IDENTITY(1,1) NOT NULL,
	[idTipoDepartamento] [int] NOT NULL,
	[Departamento] [text] NULL,
	[Descripcion] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetalleMovimientos]    Script Date: 22/02/2018 13:47:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleMovimientos](
	[idDetalleMovimiento] [int] IDENTITY(1,1) NOT NULL,
	[idProducto] [int] NOT NULL,
	[idMovimiento] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetalleProductos]    Script Date: 22/02/2018 13:47:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleProductos](
	[idDetalleProducto] [int] IDENTITY(1,1) NOT NULL,
	[idCaracteristica] [int] NOT NULL,
	[idProducto] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Marcas]    Script Date: 22/02/2018 13:47:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Marcas](
	[idMarca] [int] IDENTITY(1,1) NOT NULL,
	[Marca] [text] NULL,
	[Descripcion] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Modelos]    Script Date: 22/02/2018 13:47:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Modelos](
	[idModelo] [int] IDENTITY(1,1) NOT NULL,
	[idMarca] [int] NOT NULL,
	[Modelo] [text] NULL,
	[Descripcion] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movimientos]    Script Date: 22/02/2018 13:47:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movimientos](
	[idMovimiento] [int] IDENTITY(1,1) NOT NULL,
	[idTipoMovimiento] [int] NOT NULL,
	[idUsuario] [int] NOT NULL,
	[numActa] [text] NULL,
	[fechaMovimiento] [datetime] NULL,
	[Archivo] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Perfiles]    Script Date: 22/02/2018 13:47:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Perfiles](
	[idPerfil] [int] IDENTITY(1,1) NOT NULL,
	[Perfil] [text] NULL,
	[Descripcion] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 22/02/2018 13:47:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[idProducto] [int] IDENTITY(1,1) NOT NULL,
	[idTipo_Origen] [int] NOT NULL,
	[idTipoProducto] [int] NOT NULL,
	[idModelo] [int] NOT NULL,
	[Nombre] [text] NULL,
	[fechaCompra] [datetime] NOT NULL,
	[codigoSecob] [text] NULL,
	[codigoFinazas] [text] NULL,
	[ContratoAdquisicion] [text] NULL,
	[CostoAdquisicion] [text] NULL,
	[NumeroSerie] [text] NULL,
	[Estado] [tinyint] NOT NULL,
	[Observacion] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoCaracteristicas]    Script Date: 22/02/2018 13:47:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoCaracteristicas](
	[idTipoCaracteristica] [int] IDENTITY(1,1) NOT NULL,
	[TipoCaracteristica] [text] NULL,
	[Descripcion] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoDepartamentos]    Script Date: 22/02/2018 13:47:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoDepartamentos](
	[idTipo_Departamento] [int] IDENTITY(1,1) NOT NULL,
	[TipoDepartamento] [text] NULL,
	[Descripcion] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoMovimientos]    Script Date: 22/02/2018 13:47:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoMovimientos](
	[idTipoMovimiento] [int] IDENTITY(1,1) NOT NULL,
	[TipoMovimimiento] [text] NULL,
	[Descripcion] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoOrigenes]    Script Date: 22/02/2018 13:47:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoOrigenes](
	[idTipoOrigen] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [text] NOT NULL,
	[Descripcion] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoProductos]    Script Date: 22/02/2018 13:47:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoProductos](
	[idTipoProducto] [int] IDENTITY(1,1) NOT NULL,
	[idCatalgoProducto] [int] NOT NULL,
	[TipoProducto] [text] NULL,
	[Descripcion] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ubicaciones]    Script Date: 22/02/2018 13:47:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ubicaciones](
	[idUbicacion] [int] IDENTITY(1,1) NOT NULL,
	[Ubicacion] [text] NULL,
	[Descripcion] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 22/02/2018 13:47:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[idUsuario] [int] IDENTITY(1,1) NOT NULL,
	[idDepartamento] [int] NOT NULL,
	[idPerfil] [int] NOT NULL,
	[idUbicacion] [int] NOT NULL,
	[Usuario] [text] NOT NULL,
	[Cedula] [text] NULL,
	[Nombres] [text] NULL,
	[Apellidos] [text] NULL,
	[Correo] [text] NULL,
	[Direccion] [text] NULL,
	[Extension] [text] NULL,
	[Activar] [tinyint] NULL,
	[Observacion] [text] NULL,
	[Contrasenia] [text] NULL,
	[ConfirContrasenia] [text] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Perfiles] ON 

INSERT [dbo].[Perfiles] ([idPerfil], [Perfil], [Descripcion]) VALUES (1, N'OPERADOR', N'OPERADOR')
INSERT [dbo].[Perfiles] ([idPerfil], [Perfil], [Descripcion]) VALUES (2, N'MONITOR', N'SOLO PERMISOS DE LECTURA')
SET IDENTITY_INSERT [dbo].[Perfiles] OFF
/****** Object:  Index [PK_CARACTERISTICAS]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[Caracteristicas] ADD  CONSTRAINT [PK_CARACTERISTICAS] PRIMARY KEY NONCLUSTERED 
(
	[idCaracteristica] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Caracteristicas_Tipo_Caracteristica1_idx]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[Caracteristicas] ADD  CONSTRAINT [fk_Caracteristicas_Tipo_Caracteristica1_idx] UNIQUE NONCLUSTERED 
(
	[idTipoCaracteristica] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_CATALGOPRODUCTOS]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[CatalgoProductos] ADD  CONSTRAINT [PK_CATALGOPRODUCTOS] PRIMARY KEY NONCLUSTERED 
(
	[idCatalgoProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_DEPARTAMENTOS]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[Departamentos] ADD  CONSTRAINT [PK_DEPARTAMENTOS] PRIMARY KEY NONCLUSTERED 
(
	[idDepartamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Departamentos_Tipo_Departamentos1_idx]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[Departamentos] ADD  CONSTRAINT [fk_Departamentos_Tipo_Departamentos1_idx] UNIQUE NONCLUSTERED 
(
	[idTipoDepartamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_DETALLEMOVIMIENTOS]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[DetalleMovimientos] ADD  CONSTRAINT [PK_DETALLEMOVIMIENTOS] PRIMARY KEY NONCLUSTERED 
(
	[idDetalleMovimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_DetalleMovimientos_Movimientos1_idx]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[DetalleMovimientos] ADD  CONSTRAINT [fk_DetalleMovimientos_Movimientos1_idx] UNIQUE NONCLUSTERED 
(
	[idMovimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_DetalleMovimientos_Productos1_idx]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[DetalleMovimientos] ADD  CONSTRAINT [fk_DetalleMovimientos_Productos1_idx] UNIQUE NONCLUSTERED 
(
	[idProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_DETALLEPRODUCTOS]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[DetalleProductos] ADD  CONSTRAINT [PK_DETALLEPRODUCTOS] PRIMARY KEY NONCLUSTERED 
(
	[idDetalleProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Detalle_Caracteristicas_Caracteristicas1_idx]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[DetalleProductos] ADD  CONSTRAINT [fk_Detalle_Caracteristicas_Caracteristicas1_idx] UNIQUE NONCLUSTERED 
(
	[idCaracteristica] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Detalle_Caracteristicas_Producto1_idx]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[DetalleProductos] ADD  CONSTRAINT [fk_Detalle_Caracteristicas_Producto1_idx] UNIQUE NONCLUSTERED 
(
	[idProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_MARCAS]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[Marcas] ADD  CONSTRAINT [PK_MARCAS] PRIMARY KEY NONCLUSTERED 
(
	[idMarca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_MODELOS]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[Modelos] ADD  CONSTRAINT [PK_MODELOS] PRIMARY KEY NONCLUSTERED 
(
	[idModelo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Modelo_Marca1_idx]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[Modelos] ADD  CONSTRAINT [fk_Modelo_Marca1_idx] UNIQUE NONCLUSTERED 
(
	[idMarca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_MOVIMIENTOS]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[Movimientos] ADD  CONSTRAINT [PK_MOVIMIENTOS] PRIMARY KEY NONCLUSTERED 
(
	[idMovimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Movimientos_Tipo_Movimiento1_idx]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[Movimientos] ADD  CONSTRAINT [fk_Movimientos_Tipo_Movimiento1_idx] UNIQUE NONCLUSTERED 
(
	[idTipoMovimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Movimientos_Usuario1_idx]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[Movimientos] ADD  CONSTRAINT [fk_Movimientos_Usuario1_idx] UNIQUE NONCLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_PERFILES]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[Perfiles] ADD  CONSTRAINT [PK_PERFILES] PRIMARY KEY NONCLUSTERED 
(
	[idPerfil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_PRODUCTOS]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[Productos] ADD  CONSTRAINT [PK_PRODUCTOS] PRIMARY KEY NONCLUSTERED 
(
	[idProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Producto_Tipo_Origen_idx]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[Productos] ADD  CONSTRAINT [fk_Producto_Tipo_Origen_idx] UNIQUE NONCLUSTERED 
(
	[idTipo_Origen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Producto_Tipo_Producto1_idx]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[Productos] ADD  CONSTRAINT [fk_Producto_Tipo_Producto1_idx] UNIQUE NONCLUSTERED 
(
	[idTipoProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Productos_Modelos1_idx]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[Productos] ADD  CONSTRAINT [fk_Productos_Modelos1_idx] UNIQUE NONCLUSTERED 
(
	[idModelo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_TIPOCARACTERISTICAS]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[TipoCaracteristicas] ADD  CONSTRAINT [PK_TIPOCARACTERISTICAS] PRIMARY KEY NONCLUSTERED 
(
	[idTipoCaracteristica] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_TIPODEPARTAMENTOS]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[TipoDepartamentos] ADD  CONSTRAINT [PK_TIPODEPARTAMENTOS] PRIMARY KEY NONCLUSTERED 
(
	[idTipo_Departamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_TIPOMOVIMIENTOS]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[TipoMovimientos] ADD  CONSTRAINT [PK_TIPOMOVIMIENTOS] PRIMARY KEY NONCLUSTERED 
(
	[idTipoMovimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_TIPOORIGENES]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[TipoOrigenes] ADD  CONSTRAINT [PK_TIPOORIGENES] PRIMARY KEY NONCLUSTERED 
(
	[idTipoOrigen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_TIPOPRODUCTOS]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[TipoProductos] ADD  CONSTRAINT [PK_TIPOPRODUCTOS] PRIMARY KEY NONCLUSTERED 
(
	[idTipoProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Tipo_Producto_Catalgo_Producto1_idx]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[TipoProductos] ADD  CONSTRAINT [fk_Tipo_Producto_Catalgo_Producto1_idx] UNIQUE NONCLUSTERED 
(
	[idCatalgoProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_UBICACIONES]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[Ubicaciones] ADD  CONSTRAINT [PK_UBICACIONES] PRIMARY KEY NONCLUSTERED 
(
	[idUbicacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_USUARIOS]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[Usuarios] ADD  CONSTRAINT [PK_USUARIOS] PRIMARY KEY NONCLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Usuario_Departamentos1_idx]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[Usuarios] ADD  CONSTRAINT [fk_Usuario_Departamentos1_idx] UNIQUE NONCLUSTERED 
(
	[idDepartamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Usuario_Perfil1_idx]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[Usuarios] ADD  CONSTRAINT [fk_Usuario_Perfil1_idx] UNIQUE NONCLUSTERED 
(
	[idPerfil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Usuarios_Ubicaciones1_idx]    Script Date: 22/02/2018 13:47:16 ******/
ALTER TABLE [dbo].[Usuarios] ADD  CONSTRAINT [fk_Usuarios_Ubicaciones1_idx] UNIQUE NONCLUSTERED 
(
	[idUbicacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Caracteristicas]  WITH CHECK ADD  CONSTRAINT [fk_Caracteristicas_Tipo_Caracteristica1] FOREIGN KEY([idTipoCaracteristica])
REFERENCES [dbo].[TipoCaracteristicas] ([idTipoCaracteristica])
GO
ALTER TABLE [dbo].[Caracteristicas] CHECK CONSTRAINT [fk_Caracteristicas_Tipo_Caracteristica1]
GO
ALTER TABLE [dbo].[Departamentos]  WITH CHECK ADD  CONSTRAINT [fk_Departamentos_Tipo_Departamentos1] FOREIGN KEY([idTipoDepartamento])
REFERENCES [dbo].[TipoDepartamentos] ([idTipo_Departamento])
GO
ALTER TABLE [dbo].[Departamentos] CHECK CONSTRAINT [fk_Departamentos_Tipo_Departamentos1]
GO
ALTER TABLE [dbo].[DetalleMovimientos]  WITH CHECK ADD  CONSTRAINT [fk_DetalleMovimientos_Movimientos1] FOREIGN KEY([idMovimiento])
REFERENCES [dbo].[Movimientos] ([idMovimiento])
GO
ALTER TABLE [dbo].[DetalleMovimientos] CHECK CONSTRAINT [fk_DetalleMovimientos_Movimientos1]
GO
ALTER TABLE [dbo].[DetalleMovimientos]  WITH CHECK ADD  CONSTRAINT [fk_DetalleMovimientos_Productos1] FOREIGN KEY([idProducto])
REFERENCES [dbo].[Productos] ([idProducto])
GO
ALTER TABLE [dbo].[DetalleMovimientos] CHECK CONSTRAINT [fk_DetalleMovimientos_Productos1]
GO
ALTER TABLE [dbo].[DetalleProductos]  WITH CHECK ADD  CONSTRAINT [fk_Detalle_Caracteristicas_Caracteristicas1] FOREIGN KEY([idCaracteristica])
REFERENCES [dbo].[Caracteristicas] ([idCaracteristica])
GO
ALTER TABLE [dbo].[DetalleProductos] CHECK CONSTRAINT [fk_Detalle_Caracteristicas_Caracteristicas1]
GO
ALTER TABLE [dbo].[DetalleProductos]  WITH CHECK ADD  CONSTRAINT [fk_Detalle_Caracteristicas_Producto1] FOREIGN KEY([idProducto])
REFERENCES [dbo].[Productos] ([idProducto])
GO
ALTER TABLE [dbo].[DetalleProductos] CHECK CONSTRAINT [fk_Detalle_Caracteristicas_Producto1]
GO
ALTER TABLE [dbo].[Modelos]  WITH CHECK ADD  CONSTRAINT [fk_Modelo_Marca1] FOREIGN KEY([idMarca])
REFERENCES [dbo].[Marcas] ([idMarca])
GO
ALTER TABLE [dbo].[Modelos] CHECK CONSTRAINT [fk_Modelo_Marca1]
GO
ALTER TABLE [dbo].[Movimientos]  WITH CHECK ADD  CONSTRAINT [fk_Movimientos_Tipo_Movimiento1] FOREIGN KEY([idTipoMovimiento])
REFERENCES [dbo].[TipoMovimientos] ([idTipoMovimiento])
GO
ALTER TABLE [dbo].[Movimientos] CHECK CONSTRAINT [fk_Movimientos_Tipo_Movimiento1]
GO
ALTER TABLE [dbo].[Movimientos]  WITH CHECK ADD  CONSTRAINT [fk_Movimientos_Usuario1] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[Movimientos] CHECK CONSTRAINT [fk_Movimientos_Usuario1]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [fk_Producto_Tipo_Origen] FOREIGN KEY([idTipo_Origen])
REFERENCES [dbo].[TipoOrigenes] ([idTipoOrigen])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [fk_Producto_Tipo_Origen]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [fk_Producto_Tipo_Producto1] FOREIGN KEY([idTipoProducto])
REFERENCES [dbo].[TipoProductos] ([idTipoProducto])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [fk_Producto_Tipo_Producto1]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [fk_Productos_Modelos1] FOREIGN KEY([idModelo])
REFERENCES [dbo].[Modelos] ([idModelo])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [fk_Productos_Modelos1]
GO
ALTER TABLE [dbo].[TipoProductos]  WITH CHECK ADD  CONSTRAINT [fk_Tipo_Producto_Catalgo_Producto1] FOREIGN KEY([idCatalgoProducto])
REFERENCES [dbo].[CatalgoProductos] ([idCatalgoProducto])
GO
ALTER TABLE [dbo].[TipoProductos] CHECK CONSTRAINT [fk_Tipo_Producto_Catalgo_Producto1]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [fk_Usuario_Departamentos1] FOREIGN KEY([idDepartamento])
REFERENCES [dbo].[Departamentos] ([idDepartamento])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [fk_Usuario_Departamentos1]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [fk_Usuario_Perfil1] FOREIGN KEY([idPerfil])
REFERENCES [dbo].[Perfiles] ([idPerfil])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [fk_Usuario_Perfil1]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [fk_Usuarios_Ubicaciones1] FOREIGN KEY([idUbicacion])
REFERENCES [dbo].[Ubicaciones] ([idUbicacion])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [fk_Usuarios_Ubicaciones1]
GO
/****** Object:  StoredProcedure [dbo].[pr__SYS_MakeDeleteRecordProc]    Script Date: 22/02/2018 13:47:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE      PROC [dbo].[pr__SYS_MakeDeleteRecordProc]
	@sTableName varchar(128),
	@bExecute bit = 0
AS

IF dbo.fnTableHasPrimaryKey(@sTableName) = 0
 BEGIN
	RAISERROR ('Procedure cannot be created on a table with no primary key.', 10, 1)
	RETURN
 END

DECLARE	@sProcText varchar(8000),
	@sKeyFields varchar(2000),
	@sWhereClause varchar(2000),
	@sColumnName varchar(128),
	@nColumnID smallint,
	@bPrimaryKeyColumn bit,
	@nAlternateType int,
	@nColumnLength int,
	@nColumnPrecision int,
	@nColumnScale int,
	@IsNullable bit, 
	@IsIdentity int,
	@sTypeName varchar(128),
	@sDefaultValue varchar(4000),
	@sCRLF char(2),
	@sTAB char(1)

SET	@sTAB = char(9)
SET 	@sCRLF = char(13) + char(10)

SET 	@sProcText = ''
SET 	@sKeyFields = ''
SET	@sWhereClause = ''

SET 	@sProcText = @sProcText + 'IF EXISTS(SELECT * FROM sysobjects WHERE name = ''prApp_' + @sTableName + '_Delete'')' + @sCRLF
SET 	@sProcText = @sProcText + @sTAB + 'DROP PROC prApp_' + @sTableName + '_Delete' + @sCRLF
IF @bExecute = 0
	SET 	@sProcText = @sProcText + 'GO' + @sCRLF

SET 	@sProcText = @sProcText + @sCRLF

PRINT @sProcText

IF @bExecute = 1 
	EXEC (@sProcText)

SET 	@sProcText = ''
SET 	@sProcText = @sProcText + '----------------------------------------------------------------------------' + @sCRLF
SET 	@sProcText = @sProcText + '-- Delete a single record from ' + @sTableName + @sCRLF
SET 	@sProcText = @sProcText + '----------------------------------------------------------------------------' + @sCRLF
SET 	@sProcText = @sProcText + 'CREATE PROC prApp_' + @sTableName + '_Delete' + @sCRLF

DECLARE crKeyFields cursor for
	SELECT	*
	FROM	dbo.fnTableColumnInfo(@sTableName)
	ORDER BY 2

OPEN crKeyFields

FETCH 	NEXT 
FROM 	crKeyFields 
INTO 	@sColumnName, @nColumnID, @bPrimaryKeyColumn, @nAlternateType, 
	@nColumnLength, @nColumnPrecision, @nColumnScale, @IsNullable, 
	@IsIdentity, @sTypeName, @sDefaultValue
				
WHILE (@@FETCH_STATUS = 0)
 BEGIN

	IF (@bPrimaryKeyColumn = 1)
	 BEGIN
		IF (@sKeyFields <> '')
			SET @sKeyFields = @sKeyFields + ',' + @sCRLF 
	
		SET @sKeyFields = @sKeyFields + @sTAB + '@' + @sColumnName + ' ' + @sTypeName

		IF (@nAlternateType = 2) --decimal, numeric
			SET @sKeyFields =  @sKeyFields + '(' + CAST(@nColumnPrecision AS varchar(3)) + ', ' 
					+ CAST(@nColumnScale AS varchar(3)) + ')'
	
		ELSE IF (@nAlternateType = 1) --character and binary
			SET @sKeyFields =  @sKeyFields + '(' + CAST(@nColumnLength AS varchar(4)) +  ')'
	
		IF (@sWhereClause = '')
			SET @sWhereClause = @sWhereClause + 'WHERE ' 
		ELSE
			SET @sWhereClause = @sWhereClause + ' AND ' 

		SET @sWhereClause = @sWhereClause + @sTAB + @sColumnName  + ' = @' + @sColumnName + @sCRLF 
	 END

	FETCH 	NEXT 
	FROM 	crKeyFields 
	INTO 	@sColumnName, @nColumnID, @bPrimaryKeyColumn, @nAlternateType, 
		@nColumnLength, @nColumnPrecision, @nColumnScale, @IsNullable, 
		@IsIdentity, @sTypeName, @sDefaultValue
 END

CLOSE crKeyFields
DEALLOCATE crKeyFields

SET 	@sProcText = @sProcText + @sKeyFields + @sCRLF
SET 	@sProcText = @sProcText + 'AS' + @sCRLF
SET 	@sProcText = @sProcText + @sCRLF
SET 	@sProcText = @sProcText + 'DELETE	' + @sTableName + @sCRLF
SET 	@sProcText = @sProcText + @sWhereClause
SET 	@sProcText = @sProcText + @sCRLF
IF @bExecute = 0
	SET 	@sProcText = @sProcText + 'GO' + @sCRLF


PRINT @sProcText

IF @bExecute = 1 
	EXEC (@sProcText)









GO
/****** Object:  StoredProcedure [dbo].[pr__SYS_MakeInsertRecordProc]    Script Date: 22/02/2018 13:47:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE       PROC [dbo].[pr__SYS_MakeInsertRecordProc]
	@sTableName varchar(128),
	@bExecute bit = 0
AS

IF dbo.fnTableHasPrimaryKey(@sTableName) = 0
 BEGIN
	RAISERROR ('Procedure cannot be created on a table with no primary key.', 10, 1)
	RETURN
 END

DECLARE	@sProcText varchar(8000),
	@sKeyFields varchar(2000),
	@sAllFields varchar(2000),
	@sAllParams varchar(2000),
	@sWhereClause varchar(2000),
	@sColumnName varchar(128),
	@nColumnID smallint,
	@bPrimaryKeyColumn bit,
	@nAlternateType int,
	@nColumnLength int,
	@nColumnPrecision int,
	@nColumnScale int,
	@IsNullable bit, 
	@IsIdentity int,
	@HasIdentity int,
	@sTypeName varchar(128),
	@sDefaultValue varchar(4000),
	@sCRLF char(2),
	@sTAB char(1)

SET 	@HasIdentity = 0
SET	@sTAB = char(9)
SET 	@sCRLF = char(13) + char(10)
SET 	@sProcText = ''
SET 	@sKeyFields = ''
SET	@sAllFields = ''
SET	@sWhereClause = ''
SET	@sAllParams  = ''

SET 	@sProcText = @sProcText + 'IF EXISTS(SELECT * FROM sysobjects WHERE name = ''prApp_' + @sTableName + '_Insert'')' + @sCRLF
SET 	@sProcText = @sProcText + @sTAB + 'DROP PROC prApp_' + @sTableName + '_Insert' + @sCRLF
IF @bExecute = 0
	SET 	@sProcText = @sProcText + 'GO' + @sCRLF

SET 	@sProcText = @sProcText + @sCRLF

PRINT @sProcText

IF @bExecute = 1 
	EXEC (@sProcText)

SET 	@sProcText = ''
SET 	@sProcText = @sProcText + '----------------------------------------------------------------------------' + @sCRLF
SET 	@sProcText = @sProcText + '-- Insert a single record into ' + @sTableName + @sCRLF
SET 	@sProcText = @sProcText + '----------------------------------------------------------------------------' + @sCRLF
SET 	@sProcText = @sProcText + 'CREATE PROC prApp_' + @sTableName + '_Insert' + @sCRLF

DECLARE crKeyFields cursor for
	SELECT	*
	FROM	dbo.fnTableColumnInfo(@sTableName)
	ORDER BY 2

OPEN crKeyFields


FETCH 	NEXT 
FROM 	crKeyFields 
INTO 	@sColumnName, @nColumnID, @bPrimaryKeyColumn, @nAlternateType, 
	@nColumnLength, @nColumnPrecision, @nColumnScale, @IsNullable, 
	@IsIdentity, @sTypeName, @sDefaultValue
				
WHILE (@@FETCH_STATUS = 0)
 BEGIN
	IF (@IsIdentity = 0)
	 BEGIN
		IF (@sKeyFields <> '')
			SET @sKeyFields = @sKeyFields + ',' + @sCRLF 

		SET @sKeyFields = @sKeyFields + @sTAB + '@' + @sColumnName + ' ' + @sTypeName

		IF (@sAllFields <> '')
		 BEGIN
			SET @sAllParams = @sAllParams + ', '
			SET @sAllFields = @sAllFields + ', '
		 END

		IF (@sTypeName = 'timestamp')
			SET @sAllParams = @sAllParams + 'NULL'
		ELSE IF (@sDefaultValue IS NOT NULL)
			SET @sAllParams = @sAllParams + 'COALESCE(@' + @sColumnName + ', ' + @sDefaultValue + ')'
		ELSE
			SET @sAllParams = @sAllParams + '@' + @sColumnName 

		SET @sAllFields = @sAllFields + @sColumnName 

	 END
	ELSE
	 BEGIN
		SET @HasIdentity = 1
	 END

	IF (@nAlternateType = 2) --decimal, numeric
		SET @sKeyFields =  @sKeyFields + '(' + CAST(@nColumnPrecision AS varchar(3)) + ', ' 
				+ CAST(@nColumnScale AS varchar(3)) + ')'

	ELSE IF (@nAlternateType = 1) --character and binary
		SET @sKeyFields =  @sKeyFields + '(' + CAST(@nColumnLength AS varchar(4)) +  ')'

	IF (@IsIdentity = 0)
	 BEGIN
		IF (@sDefaultValue IS NOT NULL) OR (@IsNullable = 1) OR (@sTypeName = 'timestamp')
			SET @sKeyFields = @sKeyFields + ' = NULL'
	 END

	FETCH 	NEXT 
	FROM 	crKeyFields 
	INTO 	@sColumnName, @nColumnID, @bPrimaryKeyColumn, @nAlternateType, 
		@nColumnLength, @nColumnPrecision, @nColumnScale, @IsNullable, 
		@IsIdentity, @sTypeName, @sDefaultValue
 END

CLOSE crKeyFields
DEALLOCATE crKeyFields

SET 	@sProcText = @sProcText + @sKeyFields + @sCRLF
SET 	@sProcText = @sProcText + 'AS' + @sCRLF
SET 	@sProcText = @sProcText + @sCRLF
SET 	@sProcText = @sProcText + 'INSERT ' + @sTableName + '(' + @sAllFields + ')' + @sCRLF
SET 	@sProcText = @sProcText + 'VALUES (' + @sAllParams + ')' + @sCRLF
SET 	@sProcText = @sProcText + @sCRLF

IF (@HasIdentity = 1)
 BEGIN
	SET 	@sProcText = @sProcText + 'RETURN SCOPE_IDENTITY()' + @sCRLF
	SET 	@sProcText = @sProcText + @sCRLF
 END

IF @bExecute = 0
	SET 	@sProcText = @sProcText + 'GO' + @sCRLF


PRINT @sProcText

IF @bExecute = 1 
	EXEC (@sProcText)







GO
/****** Object:  StoredProcedure [dbo].[pr__SYS_MakeSelectRecordProc]    Script Date: 22/02/2018 13:47:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE     PROC [dbo].[pr__SYS_MakeSelectRecordProc]
	@sTableName varchar(128),
	@bExecute bit = 0
AS

IF dbo.fnTableHasPrimaryKey(@sTableName) = 0
 BEGIN
	RAISERROR ('Procedure cannot be created on a table with no primary key.', 10, 1)
	RETURN
 END

DECLARE	@sProcText varchar(8000),
	@sKeyFields varchar(2000),
	@sSelectClause varchar(2000),
	@sWhereClause varchar(2000),
	@sColumnName varchar(128),
	@nColumnID smallint,
	@bPrimaryKeyColumn bit,
	@nAlternateType int,
	@nColumnLength int,
	@nColumnPrecision int,
	@nColumnScale int,
	@IsNullable bit, 
	@IsIdentity int,
	@sTypeName varchar(128),
	@sDefaultValue varchar(4000),
	@sCRLF char(2),
	@sTAB char(1)

SET	@sTAB = char(9)
SET 	@sCRLF = char(13) + char(10)

SET 	@sProcText = ''
SET 	@sKeyFields = ''
SET	@sSelectClause = ''
SET	@sWhereClause = ''

SET 	@sProcText = @sProcText + 'IF EXISTS(SELECT * FROM sysobjects WHERE name = ''prApp_' + @sTableName + '_Select'')' + @sCRLF
SET 	@sProcText = @sProcText + @sTAB + 'DROP PROC prApp_' + @sTableName + '_Select' + @sCRLF
IF @bExecute = 0
	SET 	@sProcText = @sProcText + 'GO' + @sCRLF

SET 	@sProcText = @sProcText + @sCRLF

PRINT @sProcText

IF @bExecute = 1 
	EXEC (@sProcText)

SET 	@sProcText = ''
SET 	@sProcText = @sProcText + '----------------------------------------------------------------------------' + @sCRLF
SET 	@sProcText = @sProcText + '-- Select a single record from ' + @sTableName + @sCRLF
SET 	@sProcText = @sProcText + '----------------------------------------------------------------------------' + @sCRLF
SET 	@sProcText = @sProcText + 'CREATE PROC prApp_' + @sTableName + '_Select' + @sCRLF

DECLARE crKeyFields cursor for
	SELECT	*
	FROM	dbo.fnTableColumnInfo(@sTableName)
	ORDER BY 2

OPEN crKeyFields

FETCH 	NEXT 
FROM 	crKeyFields 
INTO 	@sColumnName, @nColumnID, @bPrimaryKeyColumn, @nAlternateType, 
	@nColumnLength, @nColumnPrecision, @nColumnScale, @IsNullable, 
	@IsIdentity, @sTypeName, @sDefaultValue
				
WHILE (@@FETCH_STATUS = 0)
 BEGIN
	IF (@bPrimaryKeyColumn = 1)
	 BEGIN
		IF (@sKeyFields <> '')
			SET @sKeyFields = @sKeyFields + ',' + @sCRLF 
	
		SET @sKeyFields = @sKeyFields + @sTAB + '@' + @sColumnName + ' ' + @sTypeName
	
		IF (@nAlternateType = 2) --decimal, numeric
			SET @sKeyFields =  @sKeyFields + '(' + CAST(@nColumnPrecision AS varchar(3)) + ', ' 
					+ CAST(@nColumnScale AS varchar(3)) + ')'
	
		ELSE IF (@nAlternateType = 1) --character and binary
			SET @sKeyFields =  @sKeyFields + '(' + CAST(@nColumnLength AS varchar(4)) +  ')'

		IF (@sWhereClause = '')
			SET @sWhereClause = @sWhereClause + 'WHERE ' 
		ELSE
			SET @sWhereClause = @sWhereClause + ' AND ' 

		SET @sWhereClause = @sWhereClause + @sTAB + @sColumnName  + ' = @' + @sColumnName + @sCRLF 
	 END

	IF (@sSelectClause = '')
		SET @sSelectClause = @sSelectClause + 'SELECT'
	ELSE
		SET @sSelectClause = @sSelectClause + ',' + @sCRLF 

	SET @sSelectClause = @sSelectClause + @sTAB + @sColumnName 

	FETCH 	NEXT 
	FROM 	crKeyFields 
	INTO 	@sColumnName, @nColumnID, @bPrimaryKeyColumn, @nAlternateType, 
		@nColumnLength, @nColumnPrecision, @nColumnScale, @IsNullable, 
		@IsIdentity, @sTypeName, @sDefaultValue
 END

CLOSE crKeyFields
DEALLOCATE crKeyFields

SET 	@sSelectClause = @sSelectClause + @sCRLF

SET 	@sProcText = @sProcText + @sKeyFields + @sCRLF
SET 	@sProcText = @sProcText + 'AS' + @sCRLF
SET 	@sProcText = @sProcText + @sCRLF
SET 	@sProcText = @sProcText + @sSelectClause
SET 	@sProcText = @sProcText + 'FROM	' + @sTableName + @sCRLF
SET 	@sProcText = @sProcText + @sWhereClause
SET 	@sProcText = @sProcText + @sCRLF
IF @bExecute = 0
	SET 	@sProcText = @sProcText + 'GO' + @sCRLF


PRINT @sProcText

IF @bExecute = 1 
	EXEC (@sProcText)









GO
/****** Object:  StoredProcedure [dbo].[pr__SYS_MakeUpdateRecordProc]    Script Date: 22/02/2018 13:47:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE         PROC [dbo].[pr__SYS_MakeUpdateRecordProc]
	@sTableName varchar(128),
	@bExecute bit = 0
AS

IF dbo.fnTableHasPrimaryKey(@sTableName) = 0
 BEGIN
	RAISERROR ('Procedure cannot be created on a table with no primary key.', 10, 1)
	RETURN
 END

DECLARE	@sProcText varchar(8000),
	@sKeyFields varchar(2000),
	@sSetClause varchar(2000),
	@sWhereClause varchar(2000),
	@sColumnName varchar(128),
	@nColumnID smallint,
	@bPrimaryKeyColumn bit,
	@nAlternateType int,
	@nColumnLength int,
	@nColumnPrecision int,
	@nColumnScale int,
	@IsNullable bit, 
	@IsIdentity int,
	@sTypeName varchar(128),
	@sDefaultValue varchar(4000),
	@sCRLF char(2),
	@sTAB char(1)

SET	@sTAB = char(9)
SET 	@sCRLF = char(13) + char(10)

SET 	@sProcText = ''
SET 	@sKeyFields = ''
SET	@sSetClause = ''
SET	@sWhereClause = ''

SET 	@sProcText = @sProcText + 'IF EXISTS(SELECT * FROM sysobjects WHERE name = ''prApp_' + @sTableName + '_Update'')' + @sCRLF
SET 	@sProcText = @sProcText + @sTAB + 'DROP PROC prApp_' + @sTableName + '_Update' + @sCRLF
IF @bExecute = 0
	SET 	@sProcText = @sProcText + 'GO' + @sCRLF

SET 	@sProcText = @sProcText + @sCRLF

PRINT @sProcText

IF @bExecute = 1 
	EXEC (@sProcText)

SET 	@sProcText = ''
SET 	@sProcText = @sProcText + '----------------------------------------------------------------------------' + @sCRLF
SET 	@sProcText = @sProcText + '-- Update a single record in ' + @sTableName + @sCRLF
SET 	@sProcText = @sProcText + '----------------------------------------------------------------------------' + @sCRLF
SET 	@sProcText = @sProcText + 'CREATE PROC prApp_' + @sTableName + '_Update' + @sCRLF

DECLARE crKeyFields cursor for
	SELECT	*
	FROM	dbo.fnTableColumnInfo(@sTableName)
	ORDER BY 2

OPEN crKeyFields


FETCH 	NEXT 
FROM 	crKeyFields 
INTO 	@sColumnName, @nColumnID, @bPrimaryKeyColumn, @nAlternateType, 
	@nColumnLength, @nColumnPrecision, @nColumnScale, @IsNullable, 
	@IsIdentity, @sTypeName, @sDefaultValue
				
WHILE (@@FETCH_STATUS = 0)
 BEGIN
	IF (@sKeyFields <> '')
		SET @sKeyFields = @sKeyFields + ',' + @sCRLF 

	SET @sKeyFields = @sKeyFields + @sTAB + '@' + @sColumnName + ' ' + @sTypeName

	IF (@nAlternateType = 2) --decimal, numeric
		SET @sKeyFields =  @sKeyFields + '(' + CAST(@nColumnPrecision AS varchar(3)) + ', ' 
				+ CAST(@nColumnScale AS varchar(3)) + ')'

	ELSE IF (@nAlternateType = 1) --character and binary
		SET @sKeyFields =  @sKeyFields + '(' + CAST(@nColumnLength AS varchar(4)) +  ')'

	IF (@bPrimaryKeyColumn = 1)
	 BEGIN
		IF (@sWhereClause = '')
			SET @sWhereClause = @sWhereClause + 'WHERE ' 
		ELSE
			SET @sWhereClause = @sWhereClause + ' AND ' 

		SET @sWhereClause = @sWhereClause + @sTAB + @sColumnName  + ' = @' + @sColumnName + @sCRLF 
	 END
	ELSE
		IF (@IsIdentity = 0)
		 BEGIN
			IF (@sSetClause = '')
				SET @sSetClause = @sSetClause + 'SET'
			ELSE
				SET @sSetClause = @sSetClause + ',' + @sCRLF 
			SET @sSetClause = @sSetClause + @sTAB + @sColumnName  + ' = '
			IF (@sTypeName = 'timestamp')
				SET @sSetClause = @sSetClause + 'NULL'
			ELSE IF (@sDefaultValue IS NOT NULL)
				SET @sSetClause = @sSetClause + 'COALESCE(@' + @sColumnName + ', ' + @sDefaultValue + ')'
			ELSE
				SET @sSetClause = @sSetClause + '@' + @sColumnName 
		 END

	IF (@IsIdentity = 0)
	 BEGIN
		IF (@IsNullable = 1) OR (@sTypeName = 'timestamp')
			SET @sKeyFields = @sKeyFields + ' = NULL'
	 END

	FETCH 	NEXT 
	FROM 	crKeyFields 
	INTO 	@sColumnName, @nColumnID, @bPrimaryKeyColumn, @nAlternateType, 
		@nColumnLength, @nColumnPrecision, @nColumnScale, @IsNullable, 
		@IsIdentity, @sTypeName, @sDefaultValue
 END

CLOSE crKeyFields
DEALLOCATE crKeyFields

SET 	@sSetClause = @sSetClause + @sCRLF

SET 	@sProcText = @sProcText + @sKeyFields + @sCRLF
SET 	@sProcText = @sProcText + 'AS' + @sCRLF
SET 	@sProcText = @sProcText + @sCRLF
SET 	@sProcText = @sProcText + 'UPDATE	' + @sTableName + @sCRLF
SET 	@sProcText = @sProcText + @sSetClause
SET 	@sProcText = @sProcText + @sWhereClause
SET 	@sProcText = @sProcText + @sCRLF
IF @bExecute = 0
	SET 	@sProcText = @sProcText + 'GO' + @sCRLF


PRINT @sProcText

IF @bExecute = 1 
	EXEC (@sProcText)











GO
/****** Object:  StoredProcedure [dbo].[prApp_Perfiles_Buscar]    Script Date: 22/02/2018 13:47:16 ******/
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
/****** Object:  StoredProcedure [dbo].[prApp_Perfiles_Insert]    Script Date: 22/02/2018 13:47:16 ******/
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
/****** Object:  StoredProcedure [dbo].[prApp_Perfiles_Select]    Script Date: 22/02/2018 13:47:16 ******/
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
USE [master]
GO
ALTER DATABASE [inventario] SET  READ_WRITE 
GO
