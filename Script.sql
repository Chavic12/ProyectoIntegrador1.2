SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Comerciales
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Comerciales` ;

-- -----------------------------------------------------
-- Schema Comerciales
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Comerciales` DEFAULT CHARACTER SET utf8 ;
USE `Comerciales` ;

-- -----------------------------------------------------
-- Table `Comerciales`.`Paises`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Comerciales`.`Paises` ;

CREATE TABLE IF NOT EXISTS `Comerciales`.`Paises` (
  `idPais` INT NOT NULL,
  `nombrePais` VARCHAR(45) NULL,
  PRIMARY KEY (`idPais`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comerciales`.`Provincias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Comerciales`.`Provincias` ;

CREATE TABLE IF NOT EXISTS `Comerciales`.`Provincias` (
  `idProvincia` INT NOT NULL,
  `nombreProvincia` VARCHAR(45) NULL,
  `idPais` INT NOT NULL,
  PRIMARY KEY (`idProvincia`),
  INDEX `fk_Provincias_Paises1_idx` (`idPais` ASC) VISIBLE,
  CONSTRAINT `fk_Provincias_Paises1`
    FOREIGN KEY (`idPais`)
    REFERENCES `Comerciales`.`Paises` (`idPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comerciales`.`Cantones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Comerciales`.`Cantones` ;

CREATE TABLE IF NOT EXISTS `Comerciales`.`Cantones` (
  `idCanton` INT NOT NULL,
  `nombreCanton` VARCHAR(45) NULL,
  `idProvincia` INT NOT NULL,
  PRIMARY KEY (`idCanton`),
  INDEX `idProvincia_idx` (`idProvincia` ASC) VISIBLE,
  CONSTRAINT `idProvincia`
    FOREIGN KEY (`idProvincia`)
    REFERENCES `Comerciales`.`Provincias` (`idProvincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comerciales`.`Parroquias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Comerciales`.`Parroquias` ;

CREATE TABLE IF NOT EXISTS `Comerciales`.`Parroquias` (
  `idParroquia` INT NOT NULL,
  `nombreParroquia` VARCHAR(45) NULL,
  `idCanton` INT NOT NULL,
  `numPoblacion` VARCHAR(45) NULL,
  PRIMARY KEY (`idParroquia`),
  INDEX `idCanton_idx` (`idCanton` ASC) VISIBLE,
  CONSTRAINT `idCanton`
    FOREIGN KEY (`idCanton`)
    REFERENCES `Comerciales`.`Cantones` (`idCanton`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comerciales`.`Comerciales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Comerciales`.`Comerciales` ;

CREATE TABLE IF NOT EXISTS `Comerciales`.`Comerciales` (
  `idCatastro` INT NOT NULL,
  `telf1` VARCHAR(11) NULL,
  `telf2` VARCHAR(12) NULL,
  `email` VARCHAR(30) NULL,
  `web` VARCHAR(60) NULL,
  `nombreComercial` VARCHAR(30) NULL,
  `totalTrabajador` INT NULL,
  `direccion` VARCHAR(50) NULL,
  `referenciaDireccion` VARCHAR(50) NULL,
  `idParroquia` INT NOT NULL,
  PRIMARY KEY (`idCatastro`),
  INDEX `fk_Comerciales_Parroquias1_idx` (`idParroquia` ASC) VISIBLE,
  CONSTRAINT `fk_Comerciales_Parroquias1`
    FOREIGN KEY (`idParroquia`)
    REFERENCES `Comerciales`.`Parroquias` (`idParroquia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comerciales`.`Actividades`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Comerciales`.`Actividades` ;

CREATE TABLE IF NOT EXISTS `Comerciales`.`Actividades` (
  `idActividad` INT NOT NULL,
  `nombreActividad` VARCHAR(40) NULL,
  PRIMARY KEY (`idActividad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comerciales`.`Personal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Comerciales`.`Personal` ;

CREATE TABLE IF NOT EXISTS `Comerciales`.`Personal` (
  `idPersonal` INT NOT NULL,
  `nombrePersona` VARCHAR(30) NULL,
  `nacionalidad` VARCHAR(30) NULL,
  `email` VARCHAR(30) NULL,
  `emisionLicencia` DATETIME NULL,
  `Cantones_idCanton` INT NOT NULL,
  PRIMARY KEY (`idPersonal`),
  INDEX `fk_Personal_Cantones1_idx` (`Cantones_idCanton` ASC) VISIBLE,
  CONSTRAINT `fk_Personal_Cantones1`
    FOREIGN KEY (`Cantones_idCanton`)
    REFERENCES `Comerciales`.`Cantones` (`idCanton`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comerciales`.`ClasificacionPersonal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Comerciales`.`ClasificacionPersonal` ;

CREATE TABLE IF NOT EXISTS `Comerciales`.`ClasificacionPersonal` (
  `idClasificacion` INT NOT NULL,
  `nombreClasificacion` VARCHAR(45) NULL,
  PRIMARY KEY (`idClasificacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comerciales`.`Personal_Clasificaciones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Comerciales`.`Personal_Clasificaciones` ;

CREATE TABLE IF NOT EXISTS `Comerciales`.`Personal_Clasificaciones` (
  `idPersonal` INT NOT NULL,
  `idClasificacion` INT NOT NULL,
  PRIMARY KEY (`idPersonal`, `idClasificacion`),
  INDEX `fk_Personal_has_Clasificaciones_Clasificaciones1_idx` (`idClasificacion` ASC) VISIBLE,
  INDEX `fk_Personal_has_Clasificaciones_Personal1_idx` (`idPersonal` ASC) VISIBLE,
  CONSTRAINT `fk_Personal_has_Clasificaciones_Personal1`
    FOREIGN KEY (`idPersonal`)
    REFERENCES `Comerciales`.`Personal` (`idPersonal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Personal_has_Clasificaciones_Clasificaciones1`
    FOREIGN KEY (`idClasificacion`)
    REFERENCES `Comerciales`.`ClasificacionPersonal` (`idClasificacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comerciales`.`Categorias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Comerciales`.`Categorias` ;

CREATE TABLE IF NOT EXISTS `Comerciales`.`Categorias` (
  `idCategoria` INT NOT NULL,
  `nombreCategoria` VARCHAR(45) NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comerciales`.`Ventas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Comerciales`.`Ventas` ;

CREATE TABLE IF NOT EXISTS `Comerciales`.`Ventas` (
  `idVenta` INT NOT NULL,
  `ventaTotal` INT NULL,
  `tipoEmpresa` VARCHAR(45) NULL,
  `anio` VARCHAR(4) NULL,
  `idCanton` INT NOT NULL,
  PRIMARY KEY (`idVenta`),
  INDEX `fk_Ventas_Cantones1_idx` (`idCanton` ASC) VISIBLE,
  CONSTRAINT `fk_Ventas_Cantones1`
    FOREIGN KEY (`idCanton`)
    REFERENCES `Comerciales`.`Cantones` (`idCanton`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comerciales`.`Clasificaciones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Comerciales`.`Clasificaciones` ;

CREATE TABLE IF NOT EXISTS `Comerciales`.`Clasificaciones` (
  `idClasificacion` INT NOT NULL,
  `nombreClasificacion` VARCHAR(45) NULL,
  `idActividad` INT NOT NULL,
  PRIMARY KEY (`idClasificacion`),
  INDEX `fk_clasificaciones_Actididades1_idx` (`idActividad` ASC) VISIBLE,
  CONSTRAINT `fk_clasificaciones_Actididades1`
    FOREIGN KEY (`idActividad`)
    REFERENCES `Comerciales`.`Actividades` (`idActividad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comerciales`.`Turistas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Comerciales`.`Turistas` ;

CREATE TABLE IF NOT EXISTS `Comerciales`.`Turistas` (
  `idTurista` INT NOT NULL,
  `nacionalidad` VARCHAR(45) NULL,
  `edad` INT NULL,
  `idPais` INT NOT NULL,
  PRIMARY KEY (`idTurista`),
  INDEX `fk_Turistas_Paises1_idx` (`idPais` ASC) VISIBLE,
  CONSTRAINT `fk_Turistas_Paises1`
    FOREIGN KEY (`idPais`)
    REFERENCES `Comerciales`.`Paises` (`idPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comerciales`.`Viajes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Comerciales`.`Viajes` ;

CREATE TABLE IF NOT EXISTS `Comerciales`.`Viajes` (
  `idViaje` INT NOT NULL,
  `anio` VARCHAR(4) NULL,
  `mes` VARCHAR(20) NULL,
  `transporte` VARCHAR(45) NULL,
  `motivo` VARCHAR(45) NULL,
  `tipo` VARCHAR(45) NULL,
  `idTurista` INT NOT NULL,
  PRIMARY KEY (`idViaje`),
  INDEX `fk_Viajes_Turistas1_idx` (`idTurista` ASC) VISIBLE,
  CONSTRAINT `fk_Viajes_Turistas1`
    FOREIGN KEY (`idTurista`)
    REFERENCES `Comerciales`.`Turistas` (`idTurista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comerciales`.`Comerciales_Actividades`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Comerciales`.`Comerciales_Actividades` ;

CREATE TABLE IF NOT EXISTS `Comerciales`.`Comerciales_Actividades` (
  `idCatastro` INT NOT NULL,
  `idActividad` INT NOT NULL,
  PRIMARY KEY (`idCatastro`, `idActividad`),
  INDEX `fk_Comerciales_has_Actividades_Actividades1_idx` (`idActividad` ASC) VISIBLE,
  INDEX `fk_Comerciales_has_Actividades_Comerciales1_idx` (`idCatastro` ASC) VISIBLE,
  CONSTRAINT `fk_Comerciales_has_Actividades_Comerciales1`
    FOREIGN KEY (`idCatastro`)
    REFERENCES `Comerciales`.`Comerciales` (`idCatastro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comerciales_has_Actividades_Actividades1`
    FOREIGN KEY (`idActividad`)
    REFERENCES `Comerciales`.`Actividades` (`idActividad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comerciales`.`Ventas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Comerciales`.`Ventas` ;

CREATE TABLE IF NOT EXISTS `Comerciales`.`Ventas` (
  `idVenta` INT NOT NULL,
  `ventaTotal` INT NULL,
  `tipoEmpresa` VARCHAR(45) NULL,
  `anio` VARCHAR(4) NULL,
  `idCanton` INT NOT NULL,
  PRIMARY KEY (`idVenta`),
  INDEX `fk_Ventas_Cantones1_idx` (`idCanton` ASC) VISIBLE,
  CONSTRAINT `fk_Ventas_Cantones1`
    FOREIGN KEY (`idCanton`)
    REFERENCES `Comerciales`.`Cantones` (`idCanton`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comerciales`.`Categorias_Clasificaciones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Comerciales`.`Categorias_Clasificaciones` ;

CREATE TABLE IF NOT EXISTS `Comerciales`.`Categorias_Clasificaciones` (
  `idCategoria` INT NOT NULL,
  `idClasificacion` INT NOT NULL,
  PRIMARY KEY (`idCategoria`, `idClasificacion`),
  INDEX `fk_Categorias_has_Clasificaciones_Clasificaciones1_idx` (`idClasificacion` ASC) VISIBLE,
  INDEX `fk_Categorias_has_Clasificaciones_Categorias1_idx` (`idCategoria` ASC) VISIBLE,
  CONSTRAINT `fk_Categorias_has_Clasificaciones_Categorias1`
    FOREIGN KEY (`idCategoria`)
    REFERENCES `Comerciales`.`Categorias` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Categorias_has_Clasificaciones_Clasificaciones1`
    FOREIGN KEY (`idClasificacion`)
    REFERENCES `Comerciales`.`Clasificaciones` (`idClasificacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



-- INSERTS


-- CATEGORIAS
LOAD DATA LOCAL INFILE '/BDD2.csv'
INTO TABLE Categorias
FIELDS TERMINATED BY ','
ENCLOSED BY ‘”’
LINES TERMINATED BY '\n'
(idCategoria, nombreCategoria);


-- COMERCIALES
LOAD DATA LOCAL INFILE '/BDD2.csv'
INTO TABLE Comerciales
FIELDS TERMINATED BY ','
ENCLOSED BY ‘”’
LINES TERMINATED BY '\n'
(idComercial, telf1, telf2, email, web, nombreComercial, totalTrabajador, direccion, referenciaDireccion, idParroquia);

-- ACTIVIADADES
LOAD DATA LOCAL INFILE '/BDD2.csv'
INTO TABLE Actividades
FIELDS TERMINATED BY ','
ENCLOSED BY ‘”’
LINES TERMINATED BY '\n'
(idActividad, nombreActividad);

-- PARROQUIAS
LOAD DATA LOCAL INFILE '/BDD2.csv'
INTO TABLE Parroquias
FIELDS TERMINATED BY ','
ENCLOSED BY ‘”’
LINES TERMINATED BY '\n'
(idParroquia, nombreParroquia, idCanton, numPoblacion);

-- CANTONES
LOAD DATA LOCAL INFILE '/BDD2.csv'
INTO TABLE Cantones
FIELDS TERMINATED BY ','
ENCLOSED BY ‘”’
LINES TERMINATED BY '\n'
(idCanton, nombreCanton, idProvincia);

-- PROVINCIAS
LOAD DATA LOCAL INFILE '/BDD2.csv'
INTO TABLE Provincias
FIELDS TERMINATED BY ','
ENCLOSED BY ‘”’
LINES TERMINATED BY '\n'
(idProvincia, nombreProvincia, idPais);

-- PERSONAL
LOAD DATA LOCAL INFILE '/BDD2.csv'
INTO TABLE Personal
FIELDS TERMINATED BY ','
ENCLOSED BY ‘”’
LINES TERMINATED BY '\n'
(idPersonal, nombrePersona, nacionalidad, email, emisionLicencia, Cantones_idCanton);

-- CLASIFICACIONPERSONAL
LOAD DATA LOCAL INFILE '/BDD2.csv'
INTO TABLE ClasificacionPersonal
FIELDS TERMINATED BY ','
ENCLOSED BY ‘”’
LINES TERMINATED BY '\n'
(idClasificacion, nombreClasificacion, Clasificacionescol);

-- VENTAS
LOAD DATA LOCAL INFILE '/BDD2.csv'
INTO TABLE Ventas
FIELDS TERMINATED BY ','
ENCLOSED BY ‘”’
LINES TERMINATED BY '\n'
(idVenta, ventaTotal, tipoEmpresa, anio, idCanton);


-- PAISES
LOAD DATA LOCAL INFILE '/BDD2.csv'
INTO TABLE Paises
FIELDS TERMINATED BY ','
ENCLOSED BY ‘”’
LINES TERMINATED BY '\n'
(idPais, nomrbrePais);

-- TURISTAS
LOAD DATA LOCAL INFILE '/BDD2.csv'
INTO TABLE Turistas
FIELDS TERMINATED BY ','
ENCLOSED BY ‘”’
LINES TERMINATED BY '\n'
(idTurista, nacionalidad, edad, idPais);

-- VIAJES
LOAD DATA LOCAL INFILE '/BDD2.csv'
INTO TABLE Viajes
FIELDS TERMINATED BY ','
ENCLOSED BY ‘”’
LINES TERMINATED BY '\n'
(idViaje, anio, mes, transporte, motivo, tipo, idTurista);


-- CATEGORIAS_CLASIFICACIONES
LOAD DATA LOCAL INFILE '/BDD2.csv'
INTO TABLE Categorias_Clasificaciones
FIELDS TERMINATED BY ','
ENCLOSED BY ‘”’
LINES TERMINATED BY '\n'
(idCategoria, idClasificacion);


-- COMERCIALES_ACTIVIDADES
LOAD DATA LOCAL INFILE '/BDD2.csv'
INTO TABLE Comerciales_Actividades
FIELDS TERMINATED BY ','
ENCLOSED BY ‘”’
LINES TERMINATED BY '\n'
(idComercial, idActividad);


-- CLASIFICACIONES
LOAD DATA LOCAL INFILE '/BDD2.csv'
INTO TABLE Clasificaciones
FIELDS TERMINATED BY ','
ENCLOSED BY ‘”’
LINES TERMINATED BY '\n'
(idClasificacion, nombreClasificacion, idActividad);


-- CLASIFICACIONES
LOAD DATA LOCAL INFILE '/BDD2.csv'
INTO TABLE Personal_Clasificaciones
FIELDS TERMINATED BY ','
ENCLOSED BY ‘”’
LINES TERMINATED BY '\n'
(idPersonal, idClasificacion);







