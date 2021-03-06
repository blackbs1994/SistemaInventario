USE [master]
GO
/****** Object:  Database [inventario]    Script Date: 01/03/2018 9:06:45 ******/
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
ALTER DATABASE [inventario] SET AUTO_CLOSE ON 
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
ALTER DATABASE [inventario] SET  ENABLE_BROKER 
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
/****** Object:  UserDefinedFunction [dbo].[fnCleanDefaultValue]    Script Date: 01/03/2018 9:06:45 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnColumnDefault]    Script Date: 01/03/2018 9:06:45 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnIsColumnPrimaryKey]    Script Date: 01/03/2018 9:06:45 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnTableHasPrimaryKey]    Script Date: 01/03/2018 9:06:45 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnTableColumnInfo]    Script Date: 01/03/2018 9:06:45 ******/
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
/****** Object:  Table [dbo].[Caracteristicas]    Script Date: 01/03/2018 9:06:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Caracteristicas](
	[idCaracteristica] [int] IDENTITY(1,1) NOT NULL,
	[idTipoCaracteristica] [int] NOT NULL,
	[Caracteristica] [nvarchar](max) NULL,
	[Descripcion] [nvarchar](max) NULL,
 CONSTRAINT [PK_caracteristicas_idCaracteristica] PRIMARY KEY CLUSTERED 
(
	[idCaracteristica] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CatalogoProductos]    Script Date: 01/03/2018 9:06:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CatalogoProductos](
	[idCatalogoProducto] [int] IDENTITY(1,1) NOT NULL,
	[CatalogoProducto] [nvarchar](max) NULL,
	[Descripcion] [nvarchar](max) NULL,
 CONSTRAINT [PK_catalogoproductos_idCatalogoProducto] PRIMARY KEY CLUSTERED 
(
	[idCatalogoProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Departamentos]    Script Date: 01/03/2018 9:06:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departamentos](
	[idDepartamento] [int] IDENTITY(1,1) NOT NULL,
	[idTipoDepartamento] [int] NOT NULL,
	[Departamento] [nvarchar](max) NULL,
	[Descripcion] [nvarchar](max) NULL,
 CONSTRAINT [PK_departamentos_idDepartamento] PRIMARY KEY CLUSTERED 
(
	[idDepartamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetalleMovimientos]    Script Date: 01/03/2018 9:06:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleMovimientos](
	[idDetalleMovimiento] [int] IDENTITY(1,1) NOT NULL,
	[idProducto] [int] NOT NULL,
	[idMovimiento] [int] NOT NULL,
 CONSTRAINT [PK_detallemovimientos_idDetalleMovimiento] PRIMARY KEY CLUSTERED 
(
	[idDetalleMovimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetalleProductos]    Script Date: 01/03/2018 9:06:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleProductos](
	[idDetalleProducto] [int] IDENTITY(1,1) NOT NULL,
	[idCaracteristica] [int] NOT NULL,
	[idProducto] [int] NOT NULL,
 CONSTRAINT [PK_detalleproductos_idDetalleProducto] PRIMARY KEY CLUSTERED 
(
	[idDetalleProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Marcas]    Script Date: 01/03/2018 9:06:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Marcas](
	[idMarca] [int] IDENTITY(1,1) NOT NULL,
	[Marca] [nvarchar](max) NULL,
	[Descripcion] [nvarchar](max) NULL,
 CONSTRAINT [PK_marcas_idMarca] PRIMARY KEY CLUSTERED 
(
	[idMarca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Modelos]    Script Date: 01/03/2018 9:06:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Modelos](
	[idModelo] [int] IDENTITY(1,1) NOT NULL,
	[idMarca] [int] NOT NULL,
	[Modelo] [nvarchar](max) NULL,
	[Descripcion] [nvarchar](max) NULL,
 CONSTRAINT [PK_modelos_idModelo] PRIMARY KEY CLUSTERED 
(
	[idModelo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movimientos]    Script Date: 01/03/2018 9:06:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movimientos](
	[idMovimiento] [int] IDENTITY(1,1) NOT NULL,
	[idTipoMovimiento] [int] NOT NULL,
	[idUsuario] [int] NOT NULL,
	[numActa] [nvarchar](max) NULL,
	[fechaMovimiento] [datetime2](0) NULL,
	[Archivo] [nvarchar](max) NULL,
 CONSTRAINT [PK_movimientos_idMovimiento] PRIMARY KEY CLUSTERED 
(
	[idMovimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Perfiles]    Script Date: 01/03/2018 9:06:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Perfiles](
	[idPerfil] [int] IDENTITY(1,1) NOT NULL,
	[Perfil] [nvarchar](max) NULL,
	[Descripcion] [nvarchar](max) NULL,
 CONSTRAINT [PK_perfiles_idPerfil] PRIMARY KEY CLUSTERED 
(
	[idPerfil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 01/03/2018 9:06:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[idProducto] [int] IDENTITY(1,1) NOT NULL,
	[idTipoOrigen] [int] NOT NULL,
	[idModelo] [int] NOT NULL,
	[idTipoProducto] [int] NOT NULL,
	[Nombre] [nvarchar](max) NULL,
	[fechaCompra] [datetime2](0) NOT NULL,
	[codigoSecob] [nvarchar](max) NULL,
	[codigoFinazas] [nvarchar](max) NULL,
	[ContratoAdquisicion] [nvarchar](max) NULL,
	[CostoAdquisicion] [nvarchar](max) NULL,
	[NumeroSerie] [nvarchar](max) NULL,
	[Estado] [smallint] NOT NULL,
	[Observacion] [nvarchar](max) NULL,
 CONSTRAINT [PK_productos_idProducto] PRIMARY KEY CLUSTERED 
(
	[idProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoCaracteristicas]    Script Date: 01/03/2018 9:06:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoCaracteristicas](
	[idTipoCaracteristica] [int] IDENTITY(1,1) NOT NULL,
	[TipoCaracteristica] [nvarchar](max) NULL,
	[Descripcion] [nvarchar](max) NULL,
 CONSTRAINT [PK_tipocaracteristicas_idTipoCaracteristica] PRIMARY KEY CLUSTERED 
(
	[idTipoCaracteristica] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoDepartamentos]    Script Date: 01/03/2018 9:06:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoDepartamentos](
	[idTipo_Departamento] [int] IDENTITY(1,1) NOT NULL,
	[TipoDepartamento] [nvarchar](max) NULL,
	[Descripcion] [nvarchar](max) NULL,
 CONSTRAINT [PK_tipodepartamentos_idTipo_Departamento] PRIMARY KEY CLUSTERED 
(
	[idTipo_Departamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoMovimientos]    Script Date: 01/03/2018 9:06:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoMovimientos](
	[idTipoMovimiento] [int] IDENTITY(1,1) NOT NULL,
	[TipoMovimimiento] [nvarchar](max) NULL,
	[Descripcion] [nvarchar](max) NULL,
 CONSTRAINT [PK_tipomovimientos_idTipoMovimiento] PRIMARY KEY CLUSTERED 
(
	[idTipoMovimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoOrigenes]    Script Date: 01/03/2018 9:06:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoOrigenes](
	[idTipoOrigen] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [nvarchar](max) NOT NULL,
	[Descripcion] [nvarchar](max) NULL,
 CONSTRAINT [PK_tipoorigenes_idTipoOrigen] PRIMARY KEY CLUSTERED 
(
	[idTipoOrigen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoProductos]    Script Date: 01/03/2018 9:06:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoProductos](
	[idTipoProducto] [int] IDENTITY(1,1) NOT NULL,
	[idCatalogoProducto] [int] NOT NULL,
	[TipoProducto] [nvarchar](max) NULL,
	[Descripcion] [nvarchar](max) NULL,
 CONSTRAINT [PK_tipoproductos_idTipoProducto] PRIMARY KEY CLUSTERED 
(
	[idTipoProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ubicaciones]    Script Date: 01/03/2018 9:06:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ubicaciones](
	[idUbicacion] [int] IDENTITY(1,1) NOT NULL,
	[Ubicacion] [nvarchar](max) NULL,
	[Descripcion] [nvarchar](max) NULL,
 CONSTRAINT [PK_ubicaciones_idUbicacion] PRIMARY KEY CLUSTERED 
(
	[idUbicacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 01/03/2018 9:06:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[idUsuario] [int] IDENTITY(1,1) NOT NULL,
	[idDepartamento] [int] NOT NULL,
	[idPerfil] [int] NOT NULL,
	[idUbicacion] [int] NOT NULL,
	[Usuario] [nvarchar](max) NOT NULL,
	[Cedula] [nvarchar](max) NULL,
	[Nombres] [nvarchar](max) NULL,
	[Apellidos] [nvarchar](max) NULL,
	[Correo] [nvarchar](max) NULL,
	[Direccion] [nvarchar](max) NULL,
	[Extension] [nvarchar](max) NULL,
	[Activar] [smallint] NULL,
	[Observacion] [nvarchar](max) NULL,
	[Contrasenia] [nvarchar](max) NULL,
	[ConfirContrasenia] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_usuarios_idUsuario] PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Index [fk_Caracteristicas_Tipo_Caracteristica1_idx]    Script Date: 01/03/2018 9:06:47 ******/
CREATE NONCLUSTERED INDEX [fk_Caracteristicas_Tipo_Caracteristica1_idx] ON [dbo].[Caracteristicas]
(
	[idTipoCaracteristica] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Departamentos_Tipo_Departamentos1_idx]    Script Date: 01/03/2018 9:06:47 ******/
CREATE NONCLUSTERED INDEX [fk_Departamentos_Tipo_Departamentos1_idx] ON [dbo].[Departamentos]
(
	[idTipoDepartamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_DetalleMovimientos_Movimientos1_idx]    Script Date: 01/03/2018 9:06:47 ******/
CREATE NONCLUSTERED INDEX [fk_DetalleMovimientos_Movimientos1_idx] ON [dbo].[DetalleMovimientos]
(
	[idMovimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_DetalleMovimientos_Productos1_idx]    Script Date: 01/03/2018 9:06:47 ******/
CREATE NONCLUSTERED INDEX [fk_DetalleMovimientos_Productos1_idx] ON [dbo].[DetalleMovimientos]
(
	[idProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Detalle_Caracteristicas_Caracteristicas1_idx]    Script Date: 01/03/2018 9:06:47 ******/
CREATE NONCLUSTERED INDEX [fk_Detalle_Caracteristicas_Caracteristicas1_idx] ON [dbo].[DetalleProductos]
(
	[idCaracteristica] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Detalle_Caracteristicas_Producto1_idx]    Script Date: 01/03/2018 9:06:47 ******/
CREATE NONCLUSTERED INDEX [fk_Detalle_Caracteristicas_Producto1_idx] ON [dbo].[DetalleProductos]
(
	[idProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Modelo_Marca1_idx]    Script Date: 01/03/2018 9:06:47 ******/
CREATE NONCLUSTERED INDEX [fk_Modelo_Marca1_idx] ON [dbo].[Modelos]
(
	[idMarca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Movimientos_Tipo_Movimiento1_idx]    Script Date: 01/03/2018 9:06:47 ******/
CREATE NONCLUSTERED INDEX [fk_Movimientos_Tipo_Movimiento1_idx] ON [dbo].[Movimientos]
(
	[idTipoMovimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Movimientos_Usuario1_idx]    Script Date: 01/03/2018 9:06:47 ******/
CREATE NONCLUSTERED INDEX [fk_Movimientos_Usuario1_idx] ON [dbo].[Movimientos]
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Producto_Tipo_Origen_idx]    Script Date: 01/03/2018 9:06:47 ******/
CREATE NONCLUSTERED INDEX [fk_Producto_Tipo_Origen_idx] ON [dbo].[Productos]
(
	[idTipoOrigen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Productos_TipoProductos1_idx]    Script Date: 01/03/2018 9:06:47 ******/
CREATE NONCLUSTERED INDEX [fk_Productos_TipoProductos1_idx] ON [dbo].[Productos]
(
	[idTipoProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_tbProductos_tbModelos1_idx]    Script Date: 01/03/2018 9:06:47 ******/
CREATE NONCLUSTERED INDEX [fk_tbProductos_tbModelos1_idx] ON [dbo].[Productos]
(
	[idModelo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_TipoProductos_CatalogoProductos1_idx]    Script Date: 01/03/2018 9:06:47 ******/
CREATE NONCLUSTERED INDEX [fk_TipoProductos_CatalogoProductos1_idx] ON [dbo].[TipoProductos]
(
	[idCatalogoProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Usuario_Departamentos1_idx]    Script Date: 01/03/2018 9:06:47 ******/
CREATE NONCLUSTERED INDEX [fk_Usuario_Departamentos1_idx] ON [dbo].[Usuarios]
(
	[idDepartamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Usuario_Perfil1_idx]    Script Date: 01/03/2018 9:06:47 ******/
CREATE NONCLUSTERED INDEX [fk_Usuario_Perfil1_idx] ON [dbo].[Usuarios]
(
	[idPerfil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Usuarios_Ubicaciones1_idx]    Script Date: 01/03/2018 9:06:47 ******/
CREATE NONCLUSTERED INDEX [fk_Usuarios_Ubicaciones1_idx] ON [dbo].[Usuarios]
(
	[idUbicacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Movimientos] ADD  DEFAULT (NULL) FOR [fechaMovimiento]
GO
ALTER TABLE [dbo].[Usuarios] ADD  DEFAULT (NULL) FOR [Activar]
GO
ALTER TABLE [dbo].[Caracteristicas]  WITH CHECK ADD  CONSTRAINT [caracteristicas$fk_Caracteristicas_TipoCaracteristica1] FOREIGN KEY([idTipoCaracteristica])
REFERENCES [dbo].[TipoCaracteristicas] ([idTipoCaracteristica])
GO
ALTER TABLE [dbo].[Caracteristicas] CHECK CONSTRAINT [caracteristicas$fk_Caracteristicas_TipoCaracteristica1]
GO
ALTER TABLE [dbo].[Departamentos]  WITH CHECK ADD  CONSTRAINT [departamentos$fk_Departamentos_TipoDepartamentos1] FOREIGN KEY([idTipoDepartamento])
REFERENCES [dbo].[TipoDepartamentos] ([idTipo_Departamento])
GO
ALTER TABLE [dbo].[Departamentos] CHECK CONSTRAINT [departamentos$fk_Departamentos_TipoDepartamentos1]
GO
ALTER TABLE [dbo].[DetalleMovimientos]  WITH CHECK ADD  CONSTRAINT [detallemovimientos$fk_DetalleMovimientos_Movimientos1] FOREIGN KEY([idMovimiento])
REFERENCES [dbo].[Movimientos] ([idMovimiento])
GO
ALTER TABLE [dbo].[DetalleMovimientos] CHECK CONSTRAINT [detallemovimientos$fk_DetalleMovimientos_Movimientos1]
GO
ALTER TABLE [dbo].[DetalleMovimientos]  WITH CHECK ADD  CONSTRAINT [detallemovimientos$fk_DetalleMovimientos_Productos1] FOREIGN KEY([idProducto])
REFERENCES [dbo].[Productos] ([idProducto])
GO
ALTER TABLE [dbo].[DetalleMovimientos] CHECK CONSTRAINT [detallemovimientos$fk_DetalleMovimientos_Productos1]
GO
ALTER TABLE [dbo].[DetalleProductos]  WITH CHECK ADD  CONSTRAINT [detalleproductos$fk_Detalle_Producto_Caracteristicas1] FOREIGN KEY([idCaracteristica])
REFERENCES [dbo].[Caracteristicas] ([idCaracteristica])
GO
ALTER TABLE [dbo].[DetalleProductos] CHECK CONSTRAINT [detalleproductos$fk_Detalle_Producto_Caracteristicas1]
GO
ALTER TABLE [dbo].[DetalleProductos]  WITH CHECK ADD  CONSTRAINT [detalleproductos$fk_Detalle_Producto_Producto1] FOREIGN KEY([idProducto])
REFERENCES [dbo].[Productos] ([idProducto])
GO
ALTER TABLE [dbo].[DetalleProductos] CHECK CONSTRAINT [detalleproductos$fk_Detalle_Producto_Producto1]
GO
ALTER TABLE [dbo].[Modelos]  WITH CHECK ADD  CONSTRAINT [modelos$fk_Modelo_Marca1] FOREIGN KEY([idMarca])
REFERENCES [dbo].[Marcas] ([idMarca])
GO
ALTER TABLE [dbo].[Modelos] CHECK CONSTRAINT [modelos$fk_Modelo_Marca1]
GO
ALTER TABLE [dbo].[Movimientos]  WITH CHECK ADD  CONSTRAINT [movimientos$fk_Movimientos_TipoMovimiento1] FOREIGN KEY([idTipoMovimiento])
REFERENCES [dbo].[TipoMovimientos] ([idTipoMovimiento])
GO
ALTER TABLE [dbo].[Movimientos] CHECK CONSTRAINT [movimientos$fk_Movimientos_TipoMovimiento1]
GO
ALTER TABLE [dbo].[Movimientos]  WITH CHECK ADD  CONSTRAINT [movimientos$fk_Movimientos_Usuario1] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[Movimientos] CHECK CONSTRAINT [movimientos$fk_Movimientos_Usuario1]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [productos$fk_Producto_TipoOrigen] FOREIGN KEY([idTipoOrigen])
REFERENCES [dbo].[TipoOrigenes] ([idTipoOrigen])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [productos$fk_Producto_TipoOrigen]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [productos$fk_Productos_Modelos1] FOREIGN KEY([idModelo])
REFERENCES [dbo].[Modelos] ([idModelo])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [productos$fk_Productos_Modelos1]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [productos$fk_Productos_TipoProductos1] FOREIGN KEY([idTipoProducto])
REFERENCES [dbo].[TipoProductos] ([idTipoProducto])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [productos$fk_Productos_TipoProductos1]
GO
ALTER TABLE [dbo].[TipoProductos]  WITH CHECK ADD  CONSTRAINT [tipoproductos$fk_TipoProductos_CatalogoProductos1] FOREIGN KEY([idCatalogoProducto])
REFERENCES [dbo].[CatalogoProductos] ([idCatalogoProducto])
GO
ALTER TABLE [dbo].[TipoProductos] CHECK CONSTRAINT [tipoproductos$fk_TipoProductos_CatalogoProductos1]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [usuarios$fk_Usuario_Departamentos1] FOREIGN KEY([idDepartamento])
REFERENCES [dbo].[Departamentos] ([idDepartamento])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [usuarios$fk_Usuario_Departamentos1]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [usuarios$fk_Usuario_Perfil1] FOREIGN KEY([idPerfil])
REFERENCES [dbo].[Perfiles] ([idPerfil])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [usuarios$fk_Usuario_Perfil1]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [usuarios$fk_Usuarios_Ubicaciones1] FOREIGN KEY([idUbicacion])
REFERENCES [dbo].[Ubicaciones] ([idUbicacion])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [usuarios$fk_Usuarios_Ubicaciones1]
GO
/****** Object:  StoredProcedure [dbo].[pr__SYS_MakeDeleteRecordProc]    Script Date: 01/03/2018 9:06:47 ******/
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
/****** Object:  StoredProcedure [dbo].[pr__SYS_MakeInsertRecordProc]    Script Date: 01/03/2018 9:06:47 ******/
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
/****** Object:  StoredProcedure [dbo].[pr__SYS_MakeSelectRecordProc]    Script Date: 01/03/2018 9:06:47 ******/
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
/****** Object:  StoredProcedure [dbo].[pr__SYS_MakeUpdateRecordProc]    Script Date: 01/03/2018 9:06:47 ******/
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
/****** Object:  StoredProcedure [dbo].[prApp_Caracteristicas_Insert]    Script Date: 01/03/2018 9:06:47 ******/
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
/****** Object:  StoredProcedure [dbo].[prApp_Caracteristicas_Select]    Script Date: 01/03/2018 9:06:47 ******/
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
/****** Object:  StoredProcedure [dbo].[prApp_CatalogoProductos_Insert]    Script Date: 01/03/2018 9:06:47 ******/
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
/****** Object:  StoredProcedure [dbo].[prApp_CatalogoProductos_Select]    Script Date: 01/03/2018 9:06:47 ******/
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
/****** Object:  StoredProcedure [dbo].[prApp_Departamentos_Select]    Script Date: 01/03/2018 9:06:47 ******/
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
/****** Object:  StoredProcedure [dbo].[prApp_Perfiles_Buscar]    Script Date: 01/03/2018 9:06:47 ******/
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
/****** Object:  StoredProcedure [dbo].[prApp_Perfiles_Insert]    Script Date: 01/03/2018 9:06:47 ******/
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
/****** Object:  StoredProcedure [dbo].[prApp_Perfiles_Select]    Script Date: 01/03/2018 9:06:47 ******/
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
/****** Object:  StoredProcedure [dbo].[prApp_Productos_Select]    Script Date: 01/03/2018 9:06:47 ******/
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
/****** Object:  StoredProcedure [dbo].[prApp_tbUsuarios_acceso]    Script Date: 01/03/2018 9:06:47 ******/
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
/****** Object:  StoredProcedure [dbo].[prApp_TipoCaracteristicas_Insert]    Script Date: 01/03/2018 9:06:47 ******/
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
/****** Object:  StoredProcedure [dbo].[prApp_TipoCaracteristicas_Select]    Script Date: 01/03/2018 9:06:47 ******/
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
/****** Object:  StoredProcedure [dbo].[prApp_TipoProductos_Insert]    Script Date: 01/03/2018 9:06:47 ******/
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
/****** Object:  StoredProcedure [dbo].[prApp_TipoProductos_Select]    Script Date: 01/03/2018 9:06:47 ******/
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
/****** Object:  StoredProcedure [dbo].[prApp_Ubicaciones_Select]    Script Date: 01/03/2018 9:06:47 ******/
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
/****** Object:  StoredProcedure [dbo].[prApp_Usuarios_Insert]    Script Date: 01/03/2018 9:06:47 ******/
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
/****** Object:  StoredProcedure [dbo].[prApp_Usuarios_Select]    Script Date: 01/03/2018 9:06:47 ******/
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
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'inventario.caracteristicas' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Caracteristicas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'inventario.catalogoproductos' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CatalogoProductos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'inventario.departamentos' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Departamentos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'inventario.detallemovimientos' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DetalleMovimientos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'inventario.detalleproductos' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DetalleProductos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'inventario.marcas' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Marcas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'inventario.modelos' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Modelos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'inventario.movimientos' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Movimientos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'inventario.perfiles' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Perfiles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'inventario.productos' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Productos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'inventario.tipocaracteristicas' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoCaracteristicas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'inventario.tipodepartamentos' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoDepartamentos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'inventario.tipomovimientos' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoMovimientos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'inventario.tipoorigenes' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoOrigenes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'inventario.tipoproductos' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TipoProductos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'inventario.ubicaciones' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Ubicaciones'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'inventario.usuarios' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuarios'
GO
USE [master]
GO
ALTER DATABASE [inventario] SET  READ_WRITE 
GO
