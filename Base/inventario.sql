-- MySQL Script generated by MySQL Workbench
-- Wed Feb 21 17:33:28 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema inventario
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema inventario
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `inventario` ;
USE `inventario` ;

-- -----------------------------------------------------
-- Table `inventario`.`TipoOrigenes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`TipoOrigenes` (
  `idTipoOrigen` INT NOT NULL AUTO_INCREMENT,
  `Origen` TEXT NOT NULL,
  `Descripcion` TEXT NULL,
  PRIMARY KEY (`idTipoOrigen`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario`.`CatalgoProductos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`CatalgoProductos` (
  `idCatalgoProducto` INT NOT NULL AUTO_INCREMENT,
  `CatalogoProducto` TEXT NULL,
  `Descripcion` TEXT NULL,
  PRIMARY KEY (`idCatalgoProducto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario`.`TipoProductos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`TipoProductos` (
  `idTipoProducto` INT NOT NULL AUTO_INCREMENT,
  `idCatalgoProducto` INT NOT NULL,
  `TipoProducto` TEXT NULL,
  `Descripcion` TEXT NULL,
  PRIMARY KEY (`idTipoProducto`),
  INDEX `fk_Tipo_Producto_Catalgo_Producto1_idx` (`idCatalgoProducto` ASC),
  CONSTRAINT `fk_Tipo_Producto_Catalgo_Producto1`
    FOREIGN KEY (`idCatalgoProducto`)
    REFERENCES `inventario`.`CatalgoProductos` (`idCatalgoProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario`.`Marcas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`Marcas` (
  `idMarca` INT NOT NULL AUTO_INCREMENT,
  `Marca` TEXT NULL,
  `Descripcion` TEXT NULL,
  PRIMARY KEY (`idMarca`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario`.`Modelos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`Modelos` (
  `idModelo` INT NOT NULL AUTO_INCREMENT,
  `idMarca` INT NOT NULL,
  `Modelo` TEXT NULL,
  `Descripcion` TEXT NULL,
  PRIMARY KEY (`idModelo`),
  INDEX `fk_Modelo_Marca1_idx` (`idMarca` ASC),
  CONSTRAINT `fk_Modelo_Marca1`
    FOREIGN KEY (`idMarca`)
    REFERENCES `inventario`.`Marcas` (`idMarca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario`.`Productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`Productos` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `idTipo_Origen` INT NOT NULL,
  `idTipoProducto` INT NOT NULL,
  `idModelo` INT NOT NULL,
  `Nombre` TEXT NULL,
  `fechaCompra` DATETIME NOT NULL,
  `codigoSecob` TEXT NULL,
  `codigoFinazas` TEXT NULL,
  `ContratoAdquisicion` TEXT NULL,
  `CostoAdquisicion` TEXT NULL,
  `NumeroSerie` TEXT NULL,
  `Estado` TINYINT NOT NULL,
  `Observacion` TEXT NULL,
  PRIMARY KEY (`idProducto`),
  INDEX `fk_Producto_Tipo_Origen_idx` (`idTipo_Origen` ASC),
  INDEX `fk_Producto_Tipo_Producto1_idx` (`idTipoProducto` ASC),
  INDEX `fk_Productos_Modelos1_idx` (`idModelo` ASC),
  CONSTRAINT `fk_Producto_Tipo_Origen`
    FOREIGN KEY (`idTipo_Origen`)
    REFERENCES `inventario`.`TipoOrigenes` (`idTipoOrigen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_Tipo_Producto1`
    FOREIGN KEY (`idTipoProducto`)
    REFERENCES `inventario`.`TipoProductos` (`idTipoProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Productos_Modelos1`
    FOREIGN KEY (`idModelo`)
    REFERENCES `inventario`.`Modelos` (`idModelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario`.`Ubicaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`Ubicaciones` (
  `idUbicacion` INT NOT NULL AUTO_INCREMENT,
  `Ubicacion` TEXT NULL,
  `Descripcion` TEXT NULL,
  PRIMARY KEY (`idUbicacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario`.`TipoCaracteristicas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`TipoCaracteristicas` (
  `idTipoCaracteristica` INT NOT NULL AUTO_INCREMENT,
  `TipoCaracteristica` TEXT NULL,
  `Descripcion` TEXT NULL,
  PRIMARY KEY (`idTipoCaracteristica`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario`.`Caracteristicas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`Caracteristicas` (
  `idCaracteristica` INT NOT NULL AUTO_INCREMENT,
  `idTipoCaracteristica` INT NOT NULL,
  `Caracteristica` TEXT NULL,
  `Descripcion` TEXT NULL,
  PRIMARY KEY (`idCaracteristica`),
  INDEX `fk_Caracteristicas_Tipo_Caracteristica1_idx` (`idTipoCaracteristica` ASC),
  CONSTRAINT `fk_Caracteristicas_Tipo_Caracteristica1`
    FOREIGN KEY (`idTipoCaracteristica`)
    REFERENCES `inventario`.`TipoCaracteristicas` (`idTipoCaracteristica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario`.`DetalleProductos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`DetalleProductos` (
  `idDetalleProducto` INT NOT NULL AUTO_INCREMENT,
  `idCaracteristica` INT NOT NULL,
  `idProducto` INT NOT NULL,
  INDEX `fk_Detalle_Caracteristicas_Caracteristicas1_idx` (`idCaracteristica` ASC),
  INDEX `fk_Detalle_Caracteristicas_Producto1_idx` (`idProducto` ASC),
  PRIMARY KEY (`idDetalleProducto`),
  CONSTRAINT `fk_Detalle_Caracteristicas_Caracteristicas1`
    FOREIGN KEY (`idCaracteristica`)
    REFERENCES `inventario`.`Caracteristicas` (`idCaracteristica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Detalle_Caracteristicas_Producto1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `inventario`.`Productos` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario`.`TipoDepartamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`TipoDepartamentos` (
  `idTipo_Departamento` INT NOT NULL AUTO_INCREMENT,
  `TipoDepartamento` TEXT NULL,
  `Descripcion` TEXT NULL,
  PRIMARY KEY (`idTipo_Departamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario`.`Departamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`Departamentos` (
  `idDepartamento` INT NOT NULL AUTO_INCREMENT,
  `idTipoDepartamento` INT NOT NULL,
  `Departamento` TEXT NULL,
  `Descripcion` TEXT NULL,
  PRIMARY KEY (`idDepartamento`),
  INDEX `fk_Departamentos_Tipo_Departamentos1_idx` (`idTipoDepartamento` ASC),
  CONSTRAINT `fk_Departamentos_Tipo_Departamentos1`
    FOREIGN KEY (`idTipoDepartamento`)
    REFERENCES `inventario`.`TipoDepartamentos` (`idTipo_Departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario`.`Perfiles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`Perfiles` (
  `idPerfil` INT NOT NULL AUTO_INCREMENT,
  `Perfil` TEXT NULL,
  `Descripcion` TEXT NULL,
  PRIMARY KEY (`idPerfil`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`Usuarios` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `idDepartamento` INT NOT NULL,
  `idPerfil` INT NOT NULL,
  `idUbicacion` INT NOT NULL,
  `Usuario` TEXT NOT NULL,
  `Cedula` TEXT NULL,
  `Nombres` TEXT NULL,
  `Apellidos` TEXT NULL,
  `Correo` TEXT NULL,
  `Direccion` TEXT NULL,
  `Extension` TEXT NULL,
  `Activar` TINYINT NULL,
  `Observacion` TEXT NULL,
  `Contrasenia` TEXT NULL,
  `ConfirContrasenia` TEXT NOT NULL,
  PRIMARY KEY (`idUsuario`),
  INDEX `fk_Usuario_Departamentos1_idx` (`idDepartamento` ASC),
  INDEX `fk_Usuario_Perfil1_idx` (`idPerfil` ASC),
  INDEX `fk_Usuarios_Ubicaciones1_idx` (`idUbicacion` ASC),
  CONSTRAINT `fk_Usuario_Departamentos1`
    FOREIGN KEY (`idDepartamento`)
    REFERENCES `inventario`.`Departamentos` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_Perfil1`
    FOREIGN KEY (`idPerfil`)
    REFERENCES `inventario`.`Perfiles` (`idPerfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuarios_Ubicaciones1`
    FOREIGN KEY (`idUbicacion`)
    REFERENCES `inventario`.`Ubicaciones` (`idUbicacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario`.`TipoMovimientos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`TipoMovimientos` (
  `idTipoMovimiento` INT NOT NULL AUTO_INCREMENT,
  `TipoMovimimiento` TEXT NULL,
  `Descripcion` TEXT NULL,
  PRIMARY KEY (`idTipoMovimiento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario`.`Movimientos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`Movimientos` (
  `idMovimiento` INT NOT NULL AUTO_INCREMENT,
  `idTipoMovimiento` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  `numActa` TEXT GENERATED ALWAYS AS () VIRTUAL,
  `fechaMovimiento` DATETIME NULL,
  `Archivo` TEXT NULL,
  PRIMARY KEY (`idMovimiento`),
  INDEX `fk_Movimientos_Tipo_Movimiento1_idx` (`idTipoMovimiento` ASC),
  INDEX `fk_Movimientos_Usuario1_idx` (`idUsuario` ASC),
  CONSTRAINT `fk_Movimientos_Tipo_Movimiento1`
    FOREIGN KEY (`idTipoMovimiento`)
    REFERENCES `inventario`.`TipoMovimientos` (`idTipoMovimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Movimientos_Usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `inventario`.`Usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario`.`DetalleMovimientos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`DetalleMovimientos` (
  `idDetalleMovimiento` INT NOT NULL AUTO_INCREMENT,
  `idProducto` INT NOT NULL,
  `idMovimiento` INT NOT NULL,
  PRIMARY KEY (`idDetalleMovimiento`),
  INDEX `fk_DetalleMovimientos_Productos1_idx` (`idProducto` ASC),
  INDEX `fk_DetalleMovimientos_Movimientos1_idx` (`idMovimiento` ASC),
  CONSTRAINT `fk_DetalleMovimientos_Productos1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `inventario`.`Productos` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DetalleMovimientos_Movimientos1`
    FOREIGN KEY (`idMovimiento`)
    REFERENCES `inventario`.`Movimientos` (`idMovimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;