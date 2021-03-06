USE [master]
GO
/****** Object:  Database [inventario]    Script Date: 2/1/2019 22:21:32 ******/
CREATE DATABASE [inventario]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'inventario', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\inventario.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'inventario_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\inventario_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
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
/****** Object:  Table [dbo].[ActasProductosUsuarios]    Script Date: 2/1/2019 22:21:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActasProductosUsuarios](
	[IdActasProductosUsuarios] [int] IDENTITY(1,1) NOT NULL,
	[idUsuario] [int] NOT NULL,
	[fechaCreacion] [datetime] NOT NULL,
 CONSTRAINT [PK_ACTASPRODUCTOSUSUARIOS] PRIMARY KEY CLUSTERED 
(
	[IdActasProductosUsuarios] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Caracteristicas]    Script Date: 2/1/2019 22:21:33 ******/
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
/****** Object:  Table [dbo].[CatalogoProductos]    Script Date: 2/1/2019 22:21:33 ******/
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
/****** Object:  Table [dbo].[Departamentos]    Script Date: 2/1/2019 22:21:33 ******/
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
/****** Object:  Table [dbo].[DetalleActaProductos]    Script Date: 2/1/2019 22:21:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleActaProductos](
	[idDetalleActaProductos] [int] IDENTITY(1,1) NOT NULL,
	[idProducto] [int] NOT NULL,
	[IdActasProductosUsuarios] [int] NOT NULL,
 CONSTRAINT [PK_DETALLEACTAPRODUCTOS] PRIMARY KEY CLUSTERED 
(
	[idDetalleActaProductos] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetalleProductos]    Script Date: 2/1/2019 22:21:33 ******/
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
/****** Object:  Table [dbo].[Marcas]    Script Date: 2/1/2019 22:21:33 ******/
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
/****** Object:  Table [dbo].[Modelos]    Script Date: 2/1/2019 22:21:33 ******/
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
/****** Object:  Table [dbo].[Perfiles]    Script Date: 2/1/2019 22:21:33 ******/
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
/****** Object:  Table [dbo].[Permiso]    Script Date: 2/1/2019 22:21:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permiso](
	[idPermiso] [int] IDENTITY(1,1) NOT NULL,
	[Modulo] [varchar](20) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Permiso] PRIMARY KEY CLUSTERED 
(
	[idPermiso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PermisoDenegadoPorRol]    Script Date: 2/1/2019 22:21:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PermisoDenegadoPorRol](
	[idPerfil] [int] NOT NULL,
	[idPermiso] [int] NOT NULL,
 CONSTRAINT [PK_PermisoDenegadoPorRol] PRIMARY KEY CLUSTERED 
(
	[idPerfil] ASC,
	[idPermiso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 2/1/2019 22:21:33 ******/
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
	[CostoAdquisicion] [money] NULL,
	[NumeroSerie] [nvarchar](max) NULL,
	[Estado] [smallint] NOT NULL,
	[Observacion] [nvarchar](max) NULL,
 CONSTRAINT [PK_productos_idProducto] PRIMARY KEY CLUSTERED 
(
	[idProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoCaracteristicas]    Script Date: 2/1/2019 22:21:33 ******/
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
/****** Object:  Table [dbo].[TipoDepartamentos]    Script Date: 2/1/2019 22:21:33 ******/
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
/****** Object:  Table [dbo].[TipoOrigenes]    Script Date: 2/1/2019 22:21:33 ******/
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
/****** Object:  Table [dbo].[TipoProductos]    Script Date: 2/1/2019 22:21:33 ******/
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
/****** Object:  Table [dbo].[Ubicaciones]    Script Date: 2/1/2019 22:21:33 ******/
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
/****** Object:  Table [dbo].[Usuarios]    Script Date: 2/1/2019 22:21:33 ******/
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
	[ConfirContrasenia] [nvarchar](max) NULL,
 CONSTRAINT [PK_usuarios_idUsuario] PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ActasProductosUsuarios] ON 

INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (1, 1, CAST(N'2018-10-17T18:43:02.903' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (2, 1, CAST(N'2018-10-20T11:01:35.780' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (3, 1, CAST(N'2018-10-20T11:02:29.867' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (4, 1, CAST(N'2018-10-20T11:19:52.630' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (5, 1, CAST(N'2018-11-06T19:28:11.047' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (6, 1, CAST(N'2018-11-06T19:37:25.837' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (7, 1, CAST(N'2018-11-06T20:19:41.500' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (8, 1, CAST(N'2018-12-03T14:32:40.630' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (9, 1, CAST(N'2018-12-03T14:32:40.880' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (10, 1, CAST(N'2018-12-03T14:33:29.760' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (11, 1, CAST(N'2018-12-03T15:31:38.750' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (12, 1, CAST(N'2018-12-03T15:32:38.680' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (13, 1, CAST(N'2018-12-03T18:37:35.253' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (14, 1, CAST(N'2018-12-16T14:06:58.670' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (15, 1, CAST(N'2018-12-24T12:23:27.007' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (16, 1, CAST(N'2018-12-24T12:29:41.180' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (17, 1, CAST(N'2018-12-24T16:55:01.047' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (18, 1, CAST(N'2018-12-24T16:59:21.483' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (19, 1, CAST(N'2018-12-24T17:04:18.037' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (20, 1, CAST(N'2018-12-24T17:12:21.277' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (21, 1, CAST(N'2018-12-24T17:17:31.650' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (22, 1, CAST(N'2018-12-24T17:22:32.117' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (23, 1, CAST(N'2018-12-30T18:01:47.373' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (24, 1, CAST(N'2018-12-30T18:11:10.593' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (25, 1, CAST(N'2018-12-30T18:18:22.577' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (26, 1, CAST(N'2018-12-30T18:20:25.917' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (27, 1, CAST(N'2018-12-30T18:20:59.777' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (28, 1, CAST(N'2018-12-30T18:26:23.620' AS DateTime))
INSERT [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios], [idUsuario], [fechaCreacion]) VALUES (29, 1, CAST(N'2018-12-30T18:31:55.820' AS DateTime))
SET IDENTITY_INSERT [dbo].[ActasProductosUsuarios] OFF
SET IDENTITY_INSERT [dbo].[Caracteristicas] ON 

INSERT [dbo].[Caracteristicas] ([idCaracteristica], [idTipoCaracteristica], [Caracteristica], [Descripcion]) VALUES (1, 1, N'500 GB', N'RIGIDO')
INSERT [dbo].[Caracteristicas] ([idCaracteristica], [idTipoCaracteristica], [Caracteristica], [Descripcion]) VALUES (2, 2, N'8 GB', N'DDR3')
INSERT [dbo].[Caracteristicas] ([idCaracteristica], [idTipoCaracteristica], [Caracteristica], [Descripcion]) VALUES (3, 3, N'I 7', N'220 GHZ')
SET IDENTITY_INSERT [dbo].[Caracteristicas] OFF
SET IDENTITY_INSERT [dbo].[CatalogoProductos] ON 

INSERT [dbo].[CatalogoProductos] ([idCatalogoProducto], [CatalogoProducto], [Descripcion]) VALUES (1, N'EQUIPO ELECTRONICO', N'840107')
SET IDENTITY_INSERT [dbo].[CatalogoProductos] OFF
SET IDENTITY_INSERT [dbo].[Departamentos] ON 

INSERT [dbo].[Departamentos] ([idDepartamento], [idTipoDepartamento], [Departamento], [Descripcion]) VALUES (1, 1, N'GERENCIA', NULL)
SET IDENTITY_INSERT [dbo].[Departamentos] OFF
SET IDENTITY_INSERT [dbo].[DetalleActaProductos] ON 

INSERT [dbo].[DetalleActaProductos] ([idDetalleActaProductos], [idProducto], [IdActasProductosUsuarios]) VALUES (20, 2, 18)
INSERT [dbo].[DetalleActaProductos] ([idDetalleActaProductos], [idProducto], [IdActasProductosUsuarios]) VALUES (32, 1, 29)
SET IDENTITY_INSERT [dbo].[DetalleActaProductos] OFF
SET IDENTITY_INSERT [dbo].[DetalleProductos] ON 

INSERT [dbo].[DetalleProductos] ([idDetalleProducto], [idCaracteristica], [idProducto]) VALUES (10, 1, 2)
INSERT [dbo].[DetalleProductos] ([idDetalleProducto], [idCaracteristica], [idProducto]) VALUES (11, 2, 2)
INSERT [dbo].[DetalleProductos] ([idDetalleProducto], [idCaracteristica], [idProducto]) VALUES (12, 3, 2)
INSERT [dbo].[DetalleProductos] ([idDetalleProducto], [idCaracteristica], [idProducto]) VALUES (16, 1, 1)
INSERT [dbo].[DetalleProductos] ([idDetalleProducto], [idCaracteristica], [idProducto]) VALUES (17, 2, 1)
INSERT [dbo].[DetalleProductos] ([idDetalleProducto], [idCaracteristica], [idProducto]) VALUES (18, 3, 1)
INSERT [dbo].[DetalleProductos] ([idDetalleProducto], [idCaracteristica], [idProducto]) VALUES (19, 1, 4)
INSERT [dbo].[DetalleProductos] ([idDetalleProducto], [idCaracteristica], [idProducto]) VALUES (20, 2, 4)
INSERT [dbo].[DetalleProductos] ([idDetalleProducto], [idCaracteristica], [idProducto]) VALUES (21, 3, 4)
SET IDENTITY_INSERT [dbo].[DetalleProductos] OFF
SET IDENTITY_INSERT [dbo].[Marcas] ON 

INSERT [dbo].[Marcas] ([idMarca], [Marca], [Descripcion]) VALUES (1, N'HP', NULL)
SET IDENTITY_INSERT [dbo].[Marcas] OFF
SET IDENTITY_INSERT [dbo].[Modelos] ON 

INSERT [dbo].[Modelos] ([idModelo], [idMarca], [Modelo], [Descripcion]) VALUES (1, 1, N'ELITBOOK', NULL)
INSERT [dbo].[Modelos] ([idModelo], [idMarca], [Modelo], [Descripcion]) VALUES (2, 1, N'PROLIANT G7', NULL)
SET IDENTITY_INSERT [dbo].[Modelos] OFF
SET IDENTITY_INSERT [dbo].[Perfiles] ON 

INSERT [dbo].[Perfiles] ([idPerfil], [Perfil], [Descripcion]) VALUES (1, N'Administrador', NULL)
INSERT [dbo].[Perfiles] ([idPerfil], [Perfil], [Descripcion]) VALUES (2, N'Analista', NULL)
INSERT [dbo].[Perfiles] ([idPerfil], [Perfil], [Descripcion]) VALUES (3, N'Monitoreo', NULL)
SET IDENTITY_INSERT [dbo].[Perfiles] OFF
SET IDENTITY_INSERT [dbo].[Permiso] ON 

INSERT [dbo].[Permiso] ([idPermiso], [Modulo], [Descripcion]) VALUES (1, N'producto', N'Puede crear nuevo registro')
INSERT [dbo].[Permiso] ([idPermiso], [Modulo], [Descripcion]) VALUES (2, N'producto', N'Puede eliminar un registro')
INSERT [dbo].[Permiso] ([idPermiso], [Modulo], [Descripcion]) VALUES (3, N'producto', N'Puede editar un registro')
INSERT [dbo].[Permiso] ([idPermiso], [Modulo], [Descripcion]) VALUES (4, N'', N'')
SET IDENTITY_INSERT [dbo].[Permiso] OFF
INSERT [dbo].[PermisoDenegadoPorRol] ([idPerfil], [idPermiso]) VALUES (3, 1)
INSERT [dbo].[PermisoDenegadoPorRol] ([idPerfil], [idPermiso]) VALUES (3, 2)
INSERT [dbo].[PermisoDenegadoPorRol] ([idPerfil], [idPermiso]) VALUES (3, 3)
SET IDENTITY_INSERT [dbo].[Productos] ON 

INSERT [dbo].[Productos] ([idProducto], [idTipoOrigen], [idModelo], [idTipoProducto], [Nombre], [fechaCompra], [codigoSecob], [codigoFinazas], [ContratoAdquisicion], [CostoAdquisicion], [NumeroSerie], [Estado], [Observacion]) VALUES (1, 1, 2, 1, N'SERVIDOR', CAST(N'2018-12-03T00:00:00.0000000' AS DateTime2), N'S/N', N'S/N', N'S/N', NULL, N'2M224000TE', 0, N'FIREWALL SERVIDOR PRINCIPAL')
INSERT [dbo].[Productos] ([idProducto], [idTipoOrigen], [idModelo], [idTipoProducto], [Nombre], [fechaCompra], [codigoSecob], [codigoFinazas], [ContratoAdquisicion], [CostoAdquisicion], [NumeroSerie], [Estado], [Observacion]) VALUES (2, 1, 1, 2, N'PORTATIL', CAST(N'2018-12-03T00:00:00.0000000' AS DateTime2), N'154931', NULL, N'S/N', NULL, N'5XNQXW1', 0, NULL)
INSERT [dbo].[Productos] ([idProducto], [idTipoOrigen], [idModelo], [idTipoProducto], [Nombre], [fechaCompra], [codigoSecob], [codigoFinazas], [ContratoAdquisicion], [CostoAdquisicion], [NumeroSerie], [Estado], [Observacion]) VALUES (4, 1, 1, 2, N'PORTATIL', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'150766', NULL, NULL, NULL, N'CNU14927SG', 0, N'SECOB
')
SET IDENTITY_INSERT [dbo].[Productos] OFF
SET IDENTITY_INSERT [dbo].[TipoCaracteristicas] ON 

INSERT [dbo].[TipoCaracteristicas] ([idTipoCaracteristica], [TipoCaracteristica], [Descripcion]) VALUES (1, N'DISCO DURO', N'')
INSERT [dbo].[TipoCaracteristicas] ([idTipoCaracteristica], [TipoCaracteristica], [Descripcion]) VALUES (2, N'MEMORIA RAM', N'')
INSERT [dbo].[TipoCaracteristicas] ([idTipoCaracteristica], [TipoCaracteristica], [Descripcion]) VALUES (3, N'PROCESADOR', N'')
SET IDENTITY_INSERT [dbo].[TipoCaracteristicas] OFF
SET IDENTITY_INSERT [dbo].[TipoDepartamentos] ON 

INSERT [dbo].[TipoDepartamentos] ([idTipo_Departamento], [TipoDepartamento], [Descripcion]) VALUES (1, N'Comercial', NULL)
SET IDENTITY_INSERT [dbo].[TipoDepartamentos] OFF
SET IDENTITY_INSERT [dbo].[TipoOrigenes] ON 

INSERT [dbo].[TipoOrigenes] ([idTipoOrigen], [Origen], [Descripcion]) VALUES (1, N'Compra', NULL)
SET IDENTITY_INSERT [dbo].[TipoOrigenes] OFF
SET IDENTITY_INSERT [dbo].[TipoProductos] ON 

INSERT [dbo].[TipoProductos] ([idTipoProducto], [idCatalogoProducto], [TipoProducto], [Descripcion]) VALUES (1, 1, N'CHASIS SERVIDORES', N'70010084001')
INSERT [dbo].[TipoProductos] ([idTipoProducto], [idCatalogoProducto], [TipoProducto], [Descripcion]) VALUES (2, 1, N'COMPUTADORA PORTATIL', N'700100070001')
SET IDENTITY_INSERT [dbo].[TipoProductos] OFF
SET IDENTITY_INSERT [dbo].[Ubicaciones] ON 

INSERT [dbo].[Ubicaciones] ([idUbicacion], [Ubicacion], [Descripcion]) VALUES (1, N'Piso 1', NULL)
SET IDENTITY_INSERT [dbo].[Ubicaciones] OFF
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([idUsuario], [idDepartamento], [idPerfil], [idUbicacion], [Usuario], [Cedula], [Nombres], [Apellidos], [Correo], [Direccion], [Extension], [Activar], [Observacion], [Contrasenia], [ConfirContrasenia]) VALUES (1, 1, 1, 1, N'aabravo', N'1722584636', N'ANDRES', N'BRAVO', N'aabravo@secob.gob.ec', N'guamani', N'4522', 1, N'ASDAS', N'25f9e794323b453885f5181f1b624d0b', N'123456789')
INSERT [dbo].[Usuarios] ([idUsuario], [idDepartamento], [idPerfil], [idUbicacion], [Usuario], [Cedula], [Nombres], [Apellidos], [Correo], [Direccion], [Extension], [Activar], [Observacion], [Contrasenia], [ConfirContrasenia]) VALUES (2, 1, 3, 1, N'rbravo', N'1722584636', N'Ricardo', N'Bravo', N'rbravo@secob.gob.ec', N'Guamani', N'4522', 1, N'asdasd', N'af597d9d019c271b3e709a667b0c96d3', N'af597d9d019c271b3e709a667b0c96d3')
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
/****** Object:  Index [fk_Caracteristicas_Tipo_Caracteristica1_idx]    Script Date: 2/1/2019 22:21:33 ******/
CREATE NONCLUSTERED INDEX [fk_Caracteristicas_Tipo_Caracteristica1_idx] ON [dbo].[Caracteristicas]
(
	[idTipoCaracteristica] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Departamentos_Tipo_Departamentos1_idx]    Script Date: 2/1/2019 22:21:33 ******/
CREATE NONCLUSTERED INDEX [fk_Departamentos_Tipo_Departamentos1_idx] ON [dbo].[Departamentos]
(
	[idTipoDepartamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Detalle_Caracteristicas_Caracteristicas1_idx]    Script Date: 2/1/2019 22:21:33 ******/
CREATE NONCLUSTERED INDEX [fk_Detalle_Caracteristicas_Caracteristicas1_idx] ON [dbo].[DetalleProductos]
(
	[idCaracteristica] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Detalle_Caracteristicas_Producto1_idx]    Script Date: 2/1/2019 22:21:33 ******/
CREATE NONCLUSTERED INDEX [fk_Detalle_Caracteristicas_Producto1_idx] ON [dbo].[DetalleProductos]
(
	[idProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Modelo_Marca1_idx]    Script Date: 2/1/2019 22:21:33 ******/
CREATE NONCLUSTERED INDEX [fk_Modelo_Marca1_idx] ON [dbo].[Modelos]
(
	[idMarca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Producto_Tipo_Origen_idx]    Script Date: 2/1/2019 22:21:33 ******/
CREATE NONCLUSTERED INDEX [fk_Producto_Tipo_Origen_idx] ON [dbo].[Productos]
(
	[idTipoOrigen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Productos_TipoProductos1_idx]    Script Date: 2/1/2019 22:21:33 ******/
CREATE NONCLUSTERED INDEX [fk_Productos_TipoProductos1_idx] ON [dbo].[Productos]
(
	[idTipoProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_tbProductos_tbModelos1_idx]    Script Date: 2/1/2019 22:21:33 ******/
CREATE NONCLUSTERED INDEX [fk_tbProductos_tbModelos1_idx] ON [dbo].[Productos]
(
	[idModelo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_TipoProductos_CatalogoProductos1_idx]    Script Date: 2/1/2019 22:21:33 ******/
CREATE NONCLUSTERED INDEX [fk_TipoProductos_CatalogoProductos1_idx] ON [dbo].[TipoProductos]
(
	[idCatalogoProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Usuario_Departamentos1_idx]    Script Date: 2/1/2019 22:21:33 ******/
CREATE NONCLUSTERED INDEX [fk_Usuario_Departamentos1_idx] ON [dbo].[Usuarios]
(
	[idDepartamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Usuario_Perfil1_idx]    Script Date: 2/1/2019 22:21:33 ******/
CREATE NONCLUSTERED INDEX [fk_Usuario_Perfil1_idx] ON [dbo].[Usuarios]
(
	[idPerfil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_Usuarios_Ubicaciones1_idx]    Script Date: 2/1/2019 22:21:33 ******/
CREATE NONCLUSTERED INDEX [fk_Usuarios_Ubicaciones1_idx] ON [dbo].[Usuarios]
(
	[idUbicacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Usuarios] ADD  DEFAULT (NULL) FOR [Activar]
GO
ALTER TABLE [dbo].[ActasProductosUsuarios]  WITH CHECK ADD  CONSTRAINT [FK_ACTASPRO_REFERENCE_USUARIOS] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[ActasProductosUsuarios] CHECK CONSTRAINT [FK_ACTASPRO_REFERENCE_USUARIOS]
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
ALTER TABLE [dbo].[DetalleActaProductos]  WITH CHECK ADD  CONSTRAINT [FK_DETALLEA_REFERENCE_ACTASPRO] FOREIGN KEY([IdActasProductosUsuarios])
REFERENCES [dbo].[ActasProductosUsuarios] ([IdActasProductosUsuarios])
GO
ALTER TABLE [dbo].[DetalleActaProductos] CHECK CONSTRAINT [FK_DETALLEA_REFERENCE_ACTASPRO]
GO
ALTER TABLE [dbo].[DetalleActaProductos]  WITH CHECK ADD  CONSTRAINT [FK_DETALLEA_REFERENCE_PRODUCTO] FOREIGN KEY([idProducto])
REFERENCES [dbo].[Productos] ([idProducto])
GO
ALTER TABLE [dbo].[DetalleActaProductos] CHECK CONSTRAINT [FK_DETALLEA_REFERENCE_PRODUCTO]
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
ALTER TABLE [dbo].[PermisoDenegadoPorRol]  WITH CHECK ADD  CONSTRAINT [FK_PermisoDenegadoPorRol_Permiso] FOREIGN KEY([idPermiso])
REFERENCES [dbo].[Permiso] ([idPermiso])
GO
ALTER TABLE [dbo].[PermisoDenegadoPorRol] CHECK CONSTRAINT [FK_PermisoDenegadoPorRol_Permiso]
GO
ALTER TABLE [dbo].[PermisoDenegadoPorRol]  WITH CHECK ADD  CONSTRAINT [FK_PermisoDenegadoPorRol_Rol] FOREIGN KEY([idPerfil])
REFERENCES [dbo].[Perfiles] ([idPerfil])
GO
ALTER TABLE [dbo].[PermisoDenegadoPorRol] CHECK CONSTRAINT [FK_PermisoDenegadoPorRol_Rol]
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
USE [master]
GO
ALTER DATABASE [inventario] SET  READ_WRITE 
GO
