/*==============================================================*/
/* Database name:  inventario                                   */
/* DBMS name:      Microsoft SQL Server 2005                    */
/* Created on:     23/9/2018 19:18:01                           */
/*==============================================================*/


drop database inventario
go

/*==============================================================*/
/* Database: inventario                                         */
/*==============================================================*/
create database inventario
CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'inventario', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\inventario.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'inventario_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\inventario_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
go

use inventario
go

/*==============================================================*/
/* User: dbo                                                    */
/*==============================================================*/
create schema dbo
go

/*==============================================================*/
/* Table: ActasProductosUsuarios                                */
/*==============================================================*/
create table ActasProductosUsuarios (
   IdActasProductosUsuarios int                  identity,
   idUsuario            int                  not null,
   fechaCreacion        datetime             not null,
   constraint PK_ACTASPRODUCTOSUSUARIOS primary key (IdActasProductosUsuarios)
)
go

/*==============================================================*/
/* Table: Caracteristicas                                       */
/*==============================================================*/
create table dbo.Caracteristicas (
   idCaracteristica     int                  identity,
   idTipoCaracteristica int                  not null,
   Caracteristica       nvarchar(max)        null,
   Descripcion          nvarchar(max)        null,
   constraint PK_caracteristicas_idCaracteristica primary key (idCaracteristica)
         WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
go

/*==============================================================*/
/* Index: fk_Caracteristicas_Tipo_Caracteristica1_idx           */
/*==============================================================*/
create index fk_Caracteristicas_Tipo_Caracteristica1_idx on dbo.Caracteristicas (
idTipoCaracteristica ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

/*==============================================================*/
/* Table: CatalogoProductos                                     */
/*==============================================================*/
create table dbo.CatalogoProductos (
   idCatalogoProducto   int                  identity,
   CatalogoProducto     nvarchar(max)        null,
   Descripcion          nvarchar(max)        null,
   constraint PK_catalogoproductos_idCatalogoProducto primary key (idCatalogoProducto)
         WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
go

/*==============================================================*/
/* Table: Departamentos                                         */
/*==============================================================*/
create table dbo.Departamentos (
   idDepartamento       int                  identity,
   idTipoDepartamento   int                  not null,
   Departamento         nvarchar(max)        null,
   Descripcion          nvarchar(max)        null,
   constraint PK_departamentos_idDepartamento primary key (idDepartamento)
         WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
go

/*==============================================================*/
/* Index: fk_Departamentos_Tipo_Departamentos1_idx              */
/*==============================================================*/
create index fk_Departamentos_Tipo_Departamentos1_idx on dbo.Departamentos (
idTipoDepartamento ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

/*==============================================================*/
/* Table: DetalleActaProductos                                  */
/*==============================================================*/
create table DetalleActaProductos (
   idDetalleActaProductos int                  identity,
   idProducto           int                  not null,
   IdActasProductosUsuarios int                  not null,
   constraint PK_DETALLEACTAPRODUCTOS primary key (idDetalleActaProductos)
)
go

/*==============================================================*/
/* Table: DetalleMovimientos                                    */
/*==============================================================*/
create table dbo.DetalleMovimientos (
   idDetalleMovimiento  int                  identity,
   idProducto           int                  not null,
   idMovimiento         int                  not null,
   constraint PK_detallemovimientos_idDetalleMovimiento primary key (idDetalleMovimiento)
         WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
go

/*==============================================================*/
/* Index: fk_DetalleMovimientos_Movimientos1_idx                */
/*==============================================================*/
create index fk_DetalleMovimientos_Movimientos1_idx on dbo.DetalleMovimientos (
idMovimiento ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

/*==============================================================*/
/* Index: fk_DetalleMovimientos_Productos1_idx                  */
/*==============================================================*/
create index fk_DetalleMovimientos_Productos1_idx on dbo.DetalleMovimientos (
idProducto ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

/*==============================================================*/
/* Table: DetalleProductos                                      */
/*==============================================================*/
create table dbo.DetalleProductos (
   idDetalleProducto    int                  identity,
   idCaracteristica     int                  not null,
   idProducto           int                  not null,
   constraint PK_detalleproductos_idDetalleProducto primary key (idDetalleProducto)
         WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
go

/*==============================================================*/
/* Index: fk_Detalle_Caracteristicas_Caracteristicas1_idx       */
/*==============================================================*/
create index fk_Detalle_Caracteristicas_Caracteristicas1_idx on dbo.DetalleProductos (
idCaracteristica ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

/*==============================================================*/
/* Index: fk_Detalle_Caracteristicas_Producto1_idx              */
/*==============================================================*/
create index fk_Detalle_Caracteristicas_Producto1_idx on dbo.DetalleProductos (
idProducto ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

/*==============================================================*/
/* Table: Marcas                                                */
/*==============================================================*/
create table dbo.Marcas (
   idMarca              int                  identity,
   Marca                nvarchar(max)        null,
   Descripcion          nvarchar(max)        null,
   constraint PK_marcas_idMarca primary key (idMarca)
         WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
go

/*==============================================================*/
/* Table: Modelos                                               */
/*==============================================================*/
create table dbo.Modelos (
   idModelo             int                  identity,
   idMarca              int                  not null,
   Modelo               nvarchar(max)        null,
   Descripcion          nvarchar(max)        null,
   constraint PK_modelos_idModelo primary key (idModelo)
         WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
go

/*==============================================================*/
/* Index: fk_Modelo_Marca1_idx                                  */
/*==============================================================*/
create index fk_Modelo_Marca1_idx on dbo.Modelos (
idMarca ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

/*==============================================================*/
/* Table: Movimientos                                           */
/*==============================================================*/
create table dbo.Movimientos (
   idMovimiento         int                  identity,
   idTipoMovimiento     int                  not null,
   idUsuario            int                  not null,
   numActa              nvarchar(max)        null,
   fechaMovimiento      datetime2(0)         null default null,
   Archivo              nvarchar(max)        null,
   constraint PK_movimientos_idMovimiento primary key (idMovimiento)
         WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
go

/*==============================================================*/
/* Index: fk_Movimientos_Tipo_Movimiento1_idx                   */
/*==============================================================*/
create index fk_Movimientos_Tipo_Movimiento1_idx on dbo.Movimientos (
idTipoMovimiento ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

/*==============================================================*/
/* Index: fk_Movimientos_Usuario1_idx                           */
/*==============================================================*/
create index fk_Movimientos_Usuario1_idx on dbo.Movimientos (
idUsuario ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

/*==============================================================*/
/* Table: Perfiles                                              */
/*==============================================================*/
create table dbo.Perfiles (
   idPerfil             int                  identity,
   Perfil               nvarchar(max)        null,
   Descripcion          nvarchar(max)        null,
   constraint PK_perfiles_idPerfil primary key (idPerfil)
         WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
go

/*==============================================================*/
/* Table: Productos                                             */
/*==============================================================*/
create table dbo.Productos (
   idProducto           int                  identity,
   idTipoOrigen         int                  not null,
   idModelo             int                  not null,
   idTipoProducto       int                  not null,
   Nombre               nvarchar(max)        null,
   fechaCompra          datetime2(0)         not null,
   codigoSecob          nvarchar(max)        null,
   codigoFinazas        nvarchar(max)        null,
   ContratoAdquisicion  nvarchar(max)        null,
   CostoAdquisicion     money                null,
   NumeroSerie          nvarchar(max)        null,
   Estado               smallint             not null,
   Observacion          nvarchar(max)        null,
   constraint PK_productos_idProducto primary key (idProducto)
         WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
go

/*==============================================================*/
/* Index: fk_Producto_Tipo_Origen_idx                           */
/*==============================================================*/
create index fk_Producto_Tipo_Origen_idx on dbo.Productos (
idTipoOrigen ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

/*==============================================================*/
/* Index: fk_Productos_TipoProductos1_idx                       */
/*==============================================================*/
create index fk_Productos_TipoProductos1_idx on dbo.Productos (
idTipoProducto ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

/*==============================================================*/
/* Index: fk_tbProductos_tbModelos1_idx                         */
/*==============================================================*/
create index fk_tbProductos_tbModelos1_idx on dbo.Productos (
idModelo ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

/*==============================================================*/
/* Table: TipoCaracteristicas                                   */
/*==============================================================*/
create table dbo.TipoCaracteristicas (
   idTipoCaracteristica int                  identity,
   TipoCaracteristica   nvarchar(max)        null,
   Descripcion          nvarchar(max)        null,
   constraint PK_tipocaracteristicas_idTipoCaracteristica primary key (idTipoCaracteristica)
         WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
go

/*==============================================================*/
/* Table: TipoDepartamentos                                     */
/*==============================================================*/
create table dbo.TipoDepartamentos (
   idTipo_Departamento  int                  identity,
   TipoDepartamento     nvarchar(max)        null,
   Descripcion          nvarchar(max)        null,
   constraint PK_tipodepartamentos_idTipo_Departamento primary key (idTipo_Departamento)
         WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
go

/*==============================================================*/
/* Table: TipoMovimientos                                       */
/*==============================================================*/
create table dbo.TipoMovimientos (
   idTipoMovimiento     int                  identity,
   TipoMovimimiento     nvarchar(max)        null,
   Descripcion          nvarchar(max)        null,
   constraint PK_tipomovimientos_idTipoMovimiento primary key (idTipoMovimiento)
         WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
go

/*==============================================================*/
/* Table: TipoOrigenes                                          */
/*==============================================================*/
create table dbo.TipoOrigenes (
   idTipoOrigen         int                  identity,
   Origen               nvarchar(max)        not null,
   Descripcion          nvarchar(max)        null,
   constraint PK_tipoorigenes_idTipoOrigen primary key (idTipoOrigen)
         WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
go

/*==============================================================*/
/* Table: TipoProductos                                         */
/*==============================================================*/
create table dbo.TipoProductos (
   idTipoProducto       int                  identity,
   idCatalogoProducto   int                  not null,
   TipoProducto         nvarchar(max)        null,
   Descripcion          nvarchar(max)        null,
   constraint PK_tipoproductos_idTipoProducto primary key (idTipoProducto)
         WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
go

/*==============================================================*/
/* Index: fk_TipoProductos_CatalogoProductos1_idx               */
/*==============================================================*/
create index fk_TipoProductos_CatalogoProductos1_idx on dbo.TipoProductos (
idCatalogoProducto ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

/*==============================================================*/
/* Table: Ubicaciones                                           */
/*==============================================================*/
create table dbo.Ubicaciones (
   idUbicacion          int                  identity,
   Ubicacion            nvarchar(max)        null,
   Descripcion          nvarchar(max)        null,
   constraint PK_ubicaciones_idUbicacion primary key (idUbicacion)
         WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
go

/*==============================================================*/
/* Table: Usuarios                                              */
/*==============================================================*/
create table dbo.Usuarios (
   idUsuario            int                  identity,
   idDepartamento       int                  not null,
   idPerfil             int                  not null,
   idUbicacion          int                  not null,
   Usuario              nvarchar(max)        not null,
   Cedula               nvarchar(max)        null,
   Nombres              nvarchar(max)        null,
   Apellidos            nvarchar(max)        null,
   Correo               nvarchar(max)        null,
   Direccion            nvarchar(max)        null,
   Extension            nvarchar(max)        null,
   Activar              smallint             null default null,
   Observacion          nvarchar(max)        null,
   Contrasenia          nvarchar(max)        null,
   ConfirContrasenia    nvarchar(max)        not null,
   constraint PK_usuarios_idUsuario primary key (idUsuario)
         WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
go

/*==============================================================*/
/* Index: fk_Usuario_Departamentos1_idx                         */
/*==============================================================*/
create index fk_Usuario_Departamentos1_idx on dbo.Usuarios (
idDepartamento ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

/*==============================================================*/
/* Index: fk_Usuario_Perfil1_idx                                */
/*==============================================================*/
create index fk_Usuario_Perfil1_idx on dbo.Usuarios (
idPerfil ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

/*==============================================================*/
/* Index: fk_Usuarios_Ubicaciones1_idx                          */
/*==============================================================*/
create index fk_Usuarios_Ubicaciones1_idx on dbo.Usuarios (
idUbicacion ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

alter table ActasProductosUsuarios
   add constraint FK_ACTASPRO_REFERENCE_USUARIOS foreign key (idUsuario)
      references dbo.Usuarios (idUsuario)
go

alter table dbo.Caracteristicas
   add constraint caracteristicas$fk_Caracteristicas_TipoCaracteristica1 foreign key (idTipoCaracteristica)
      references dbo.TipoCaracteristicas (idTipoCaracteristica)
go

alter table dbo.Departamentos
   add constraint departamentos$fk_Departamentos_TipoDepartamentos1 foreign key (idTipoDepartamento)
      references dbo.TipoDepartamentos (idTipo_Departamento)
go

alter table DetalleActaProductos
   add constraint FK_DETALLEA_REFERENCE_PRODUCTO foreign key (idProducto)
      references dbo.Productos (idProducto)
go

alter table DetalleActaProductos
   add constraint FK_DETALLEA_REFERENCE_ACTASPRO foreign key (IdActasProductosUsuarios)
      references ActasProductosUsuarios (IdActasProductosUsuarios)
go

alter table dbo.DetalleMovimientos
   add constraint detallemovimientos$fk_DetalleMovimientos_Movimientos1 foreign key (idMovimiento)
      references dbo.Movimientos (idMovimiento)
go

alter table dbo.DetalleMovimientos
   add constraint detallemovimientos$fk_DetalleMovimientos_Productos1 foreign key (idProducto)
      references dbo.Productos (idProducto)
go

alter table dbo.DetalleProductos
   add constraint detalleproductos$fk_Detalle_Producto_Caracteristicas1 foreign key (idCaracteristica)
      references dbo.Caracteristicas (idCaracteristica)
go

alter table dbo.DetalleProductos
   add constraint detalleproductos$fk_Detalle_Producto_Producto1 foreign key (idProducto)
      references dbo.Productos (idProducto)
go

alter table dbo.Modelos
   add constraint modelos$fk_Modelo_Marca1 foreign key (idMarca)
      references dbo.Marcas (idMarca)
go

alter table dbo.Movimientos
   add constraint movimientos$fk_Movimientos_TipoMovimiento1 foreign key (idTipoMovimiento)
      references dbo.TipoMovimientos (idTipoMovimiento)
go

alter table dbo.Movimientos
   add constraint movimientos$fk_Movimientos_Usuario1 foreign key (idUsuario)
      references dbo.Usuarios (idUsuario)
go

alter table dbo.Productos
   add constraint productos$fk_Producto_TipoOrigen foreign key (idTipoOrigen)
      references dbo.TipoOrigenes (idTipoOrigen)
go

alter table dbo.Productos
   add constraint productos$fk_Productos_Modelos1 foreign key (idModelo)
      references dbo.Modelos (idModelo)
go

alter table dbo.Productos
   add constraint productos$fk_Productos_TipoProductos1 foreign key (idTipoProducto)
      references dbo.TipoProductos (idTipoProducto)
go

alter table dbo.TipoProductos
   add constraint tipoproductos$fk_TipoProductos_CatalogoProductos1 foreign key (idCatalogoProducto)
      references dbo.CatalogoProductos (idCatalogoProducto)
go

alter table dbo.Usuarios
   add constraint usuarios$fk_Usuario_Departamentos1 foreign key (idDepartamento)
      references dbo.Departamentos (idDepartamento)
go

alter table dbo.Usuarios
   add constraint usuarios$fk_Usuario_Perfil1 foreign key (idPerfil)
      references dbo.Perfiles (idPerfil)
go

alter table dbo.Usuarios
   add constraint usuarios$fk_Usuarios_Ubicaciones1 foreign key (idUbicacion)
      references dbo.Ubicaciones (idUbicacion)
go


create function dbo.fnCleanDefaultValue (@sDefaultValue varchar(4000))
RETURNS varchar(4000)
AS
BEGIN
	RETURN SubString(@sDefaultValue, 2, DataLength(@sDefaultValue)-2)
END
go


create function dbo.fnColumnDefault (@sTableName varchar(128),@sColumnName varchar(128))
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
go


create function dbo.fnIsColumnPrimaryKey (@sTableName varchar(128),@nColumnName varchar(128))
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
		(SELECT sc.name
		FROM 	sysindexkeys sik
			INNER JOIN syscolumns sc ON sik.id = sc.id AND sik.colid = sc.colid
		WHERE 	sik.id = @nTableID
		 AND 	sik.indid = @nIndexID)
	 BEGIN
		RETURN 1
	 END


	RETURN 0
END
go


create function dbo.fnTableColumnInfo (@sTableName varchar(128))
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
go


create function dbo.fnTableHasPrimaryKey (@sTableName varchar(128))
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
go


create procedure dbo.prApp_Caracteristicas_Insert (@idTipoCaracteristica int,@Caracteristica text = NULL,@Descripcion text = NULL) as
INSERT Caracteristicas(idTipoCaracteristica, Caracteristica, Descripcion)
VALUES (@idTipoCaracteristica, @Caracteristica, @Descripcion)

RETURN SCOPE_IDENTITY()
go


create procedure dbo.prApp_Caracteristicas_Select () as
SELECT        dbo.Caracteristicas.idCaracteristica, dbo.TipoCaracteristicas.TipoCaracteristica, dbo.Caracteristicas.Caracteristica, dbo.Caracteristicas.Descripcion
FROM            dbo.Caracteristicas INNER JOIN
                         dbo.TipoCaracteristicas ON dbo.Caracteristicas.idTipoCaracteristica = dbo.TipoCaracteristicas.idTipoCaracteristica
go


create procedure dbo.prApp_CatalogoProductos_Insert (@CatalogoProducto text = NULL,@Descripcion text = NULL) as
INSERT CatalogoProductos(CatalogoProducto, Descripcion)
VALUES (@CatalogoProducto, @Descripcion)

RETURN SCOPE_IDENTITY()
go


create procedure dbo.prApp_CatalogoProductos_Select () as
SELECT	idCatalogoProducto,
	CatalogoProducto,
	Descripcion
FROM	CatalogoProductos
go


create procedure dbo.prApp_Departamentos_Select () as
SELECT	idDepartamento,
	idTipoDepartamento,
	Departamento,
	Descripcion
FROM	Departamentos
go


create procedure dbo.prApp_Perfiles_Buscar (@Perfil text) as
SELECT	idPerfil,
	Perfil,
	Descripcion
FROM	Perfiles
WHERE 	Perfil like @Perfil
go


create procedure dbo.prApp_Perfiles_Insert (@Perfil text = NULL,@Descripcion text = NULL) as
INSERT Perfiles(Perfil, Descripcion)
VALUES (@Perfil, @Descripcion)

RETURN SCOPE_IDENTITY()
go


create procedure dbo.prApp_Perfiles_Select () as
SELECT	idPerfil,
	Perfil,
	Descripcion
FROM	Perfiles
go


create procedure dbo.prApp_Productos_Select () as
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
go


create procedure dbo.prApp_TipoCaracteristicas_Insert (@TipoCaracteristica text = NULL,@Descripcion text = NULL) as
INSERT TipoCaracteristicas(TipoCaracteristica, Descripcion)
VALUES (@TipoCaracteristica, @Descripcion)

RETURN SCOPE_IDENTITY()
go


create procedure dbo.prApp_TipoCaracteristicas_Select () as
SELECT	idTipoCaracteristica,
	TipoCaracteristica,
	Descripcion
FROM	TipoCaracteristicas
go


create procedure dbo.prApp_TipoProductos_Insert (@idCatalogoProducto int,@TipoProducto text = NULL,@Descripcion text = NULL) as
INSERT TipoProductos(idCatalogoProducto, TipoProducto, Descripcion)
VALUES (@idCatalogoProducto, @TipoProducto, @Descripcion)

RETURN SCOPE_IDENTITY()
go


create procedure dbo.prApp_TipoProductos_Select () as
SELECT        dbo.CatalogoProductos.CatalogoProducto, dbo.TipoProductos.TipoProducto, dbo.TipoProductos.Descripcion, dbo.CatalogoProductos.idCatalogoProducto, dbo.TipoProductos.idTipoProducto
FROM            dbo.CatalogoProductos INNER JOIN
                         dbo.TipoProductos ON dbo.CatalogoProductos.idCatalogoProducto = dbo.TipoProductos.idCatalogoProducto
go


create procedure dbo.prApp_Ubicaciones_Select () as
SELECT	idUbicacion,
	Ubicacion,
	Descripcion
FROM	Ubicaciones
go


create procedure dbo.prApp_Usuarios_Insert (@idDepartamento int,@idPerfil int,@idUbicacion int,@Usuario text,@Cedula text = NULL,@Nombres text = NULL,@Apellidos text = NULL,@Correo text = NULL,@Direccion text = NULL,@Extension text = NULL,@Activar tinyint = NULL,@Observacion text = NULL,@Contrasenia text = NULL,@ConfirContrasenia text) as
INSERT Usuarios(idDepartamento, idPerfil, idUbicacion, Usuario, Cedula, Nombres, Apellidos, Correo, Direccion, Extension, Activar, Observacion, Contrasenia, ConfirContrasenia)
VALUES (@idDepartamento, @idPerfil, @idUbicacion, @Usuario, @Cedula, @Nombres, @Apellidos, @Correo, @Direccion, @Extension, @Activar, @Observacion, @Contrasenia, @ConfirContrasenia)

RETURN SCOPE_IDENTITY()
go


create procedure dbo.prApp_Usuarios_Select () as
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
go


create procedure dbo.prApp_tbUsuarios_acceso (@Usuario nvarchar (10),@Contrasenia nvarchar (16)) as
BEGIN
SELECT	idUsuario,
	Usuario,
	Contrasenia
FROM	tbUsuarios
WHERE 	Usuario = @Usuario and Contrasenia = @Contrasenia
END
go


create procedure dbo.pr__SYS_MakeDeleteRecordProc (@sTableName varchar(128),@bExecute bit = 0) as
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
go


create procedure dbo.pr__SYS_MakeInsertRecordProc (@sTableName varchar(128),@bExecute bit = 0) as
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
go


create procedure dbo.pr__SYS_MakeSelectRecordProc (@sTableName varchar(128),@bExecute bit = 0) as
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
go


create procedure dbo.pr__SYS_MakeUpdateRecordProc (@sTableName varchar(128),@bExecute bit = 0) as
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
go

