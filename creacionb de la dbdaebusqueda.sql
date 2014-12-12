-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dbdaebusqueda` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci ;
USE `dbdaebusqueda` ;
-- -----------------------------------------------------
-- Table `personal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `personal` (
  `c_pers` VARCHAR(50) NOT NULL,
  `l_pass` VARCHAR(50) NOT NULL,
  `l_nomb` VARCHAR(45) NOT NULL,
  `l_apep` VARCHAR(45) NOT NULL,
  `l_apem` VARCHAR(45) NOT NULL,
  `l_dni` CHAR(8) NOT NULL,
  PRIMARY KEY (`c_pers`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa` (
  `c_ruc` VARCHAR(11) NOT NULL,
  `l_razs` VARCHAR(45) NULL,
  PRIMARY KEY (`c_ruc`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cliente` (
  `c_clie` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `l_pass` VARCHAR(50) NOT NULL,
  `l_nomb` VARCHAR(70) NOT NULL,
  `l_apem` VARCHAR(70) NOT NULL,
  `l_apep` VARCHAR(70) NOT NULL,
  `f_crea` DATETIME NOT NULL,
  `c_persc` VARCHAR(50) NOT NULL,
  `f_modi` DATETIME NULL,
  `c_persm` VARCHAR(50) NULL,
  `c_ruc` VARCHAR(11) NOT NULL,
  `l_esta` BIT NOT NULL,
  PRIMARY KEY (`c_clie`),
  INDEX `fk_Cliente_personal1_idx` (`c_persc` ASC),
  INDEX `fk_Cliente_personal2_idx` (`c_persm` ASC),
  INDEX `fk_Cliente_empresa1_idx` (`c_ruc` ASC),
  CONSTRAINT `fk_Cliente_personal1`
    FOREIGN KEY (`c_persc`)
    REFERENCES `personal` (`c_pers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_personal2`
    FOREIGN KEY (`c_persm`)
    REFERENCES `personal` (`c_pers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_empresa1`
    FOREIGN KEY (`c_ruc`)
    REFERENCES `empresa` (`c_ruc`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `producto` (
  `c_prod` INT NOT NULL,
  `l_nomb` VARCHAR(45) NOT NULL,
  `l_desc` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`c_prod`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cliente_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cliente_producto` (
  `c_clie` VARCHAR(20) NOT NULL,
  `c_prod` INT NOT NULL,
  `l_esta` BIT NOT NULL,
  `f_crea` DATETIME NOT NULL,
  `c_pers` VARCHAR(50) NOT NULL,
  INDEX `fk_tblcliente_producto_tblCliente_idx` (`c_clie` ASC),
  INDEX `fk_tblcliente_producto_tblproducto1_idx` (`c_prod` ASC),
  INDEX `fk_cliente_producto_personal1_idx` (`c_pers` ASC),
  PRIMARY KEY (`c_clie`, `c_prod`),
  CONSTRAINT `fk_tblcliente_producto_tblCliente`
    FOREIGN KEY (`c_clie`)
    REFERENCES `Cliente` (`c_clie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tblcliente_producto_tblproducto1`
    FOREIGN KEY (`c_prod`)
    REFERENCES `producto` (`c_prod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_producto_personal1`
    FOREIGN KEY (`c_pers`)
    REFERENCES `personal` (`c_pers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grupo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo` (
  `c_grup` INT NOT NULL AUTO_INCREMENT,
  `l_nomb` VARCHAR(30) NOT NULL,
  `l_desc` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`c_grup`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modulos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modulos` (
  `c_modu` INT NOT NULL AUTO_INCREMENT,
  `l_titu` VARCHAR(50) NOT NULL,
  `l_desc` VARCHAR(500) NOT NULL,
  `l_cont` VARCHAR(1500) NULL,
  `l_linkv` VARCHAR(70) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL,
  `l_linka` VARCHAR(45) NULL,
  `c_prod` INT NOT NULL,
  `c_grup` INT NOT NULL,
  PRIMARY KEY (`c_modu`),
  INDEX `fk_tbldireccion_tblproducto1_idx` (`c_prod` ASC),
  INDEX `fk_modulos_grupo1_idx` (`c_grup` ASC),
  CONSTRAINT `fk_tbldireccion_tblproducto1`
    FOREIGN KEY (`c_prod`)
    REFERENCES `producto` (`c_prod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_modulos_grupo1`
    FOREIGN KEY (`c_grup`)
    REFERENCES `grupo` (`c_grup`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `palabra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `palabra` (
  `c_pala` INT NOT NULL AUTO_INCREMENT,
  `l_pala` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`c_pala`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `palabra_modulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `palabra_modulo` (
  `id_p_m` INT NOT NULL AUTO_INCREMENT,
  `mod_id` INT NOT NULL,
  `c_pala` INT NOT NULL,
  PRIMARY KEY (`id_p_m`),
  INDEX `fk_palabra_modulo_modulos1_idx` (`mod_id` ASC),
  INDEX `fk_palabra_modulo_palabra1_idx` (`c_pala` ASC),
  CONSTRAINT `fk_palabra_modulo_modulos1`
    FOREIGN KEY (`mod_id`)
    REFERENCES `modulos` (`c_modu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_palabra_modulo_palabra1`
    FOREIGN KEY (`c_pala`)
    REFERENCES `palabra` (`c_pala`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `consultas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `consultas` (
  `c_cons` INT NOT NULL AUTO_INCREMENT,
  `c_clie` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `l_ip` VARCHAR(15) NOT NULL,
  `c_modu` INT NOT NULL,
  PRIMARY KEY (`c_cons`),
  INDEX `fk_consultas_Cliente1_idx` (`c_clie` ASC),
  INDEX `fk_consultas_modulos1_idx` (`c_modu` ASC),
  CONSTRAINT `fk_consultas_Cliente1`
    FOREIGN KEY (`c_clie`)
    REFERENCES `Cliente` (`c_clie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consultas_modulos1`
    FOREIGN KEY (`c_modu`)
    REFERENCES `modulos` (`c_modu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `accesos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `accesos` (
  `c_segu` INT NOT NULL AUTO_INCREMENT,
  `f_inis` DATETIME NOT NULL,
  `f_fins` DATETIME NOT NULL,
  `c_clie` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`c_segu`),
  INDEX `fk_seguimiento_Cliente1_idx` (`c_clie` ASC),
  CONSTRAINT `fk_seguimiento_Cliente1`
    FOREIGN KEY (`c_clie`)
    REFERENCES `Cliente` (`c_clie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
