-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema VIPRESERVATIONS
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema VIPRESERVATIONS
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `VIPRESERVATIONS` DEFAULT CHARACTER SET utf8 ;
USE `VIPRESERVATIONS` ;

-- -----------------------------------------------------
-- Table `VIPRESERVATIONS`.`STATETABEL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VIPRESERVATIONS`.`STATETABEL` (
  `ST_ID` INT NOT NULL AUTO_INCREMENT,
  `STCODE` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`ST_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VIPRESERVATIONS`.`ZIPCODETABLE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VIPRESERVATIONS`.`ZIPCODETABLE` (
  `ZIPCODE_ID` INT NOT NULL AUTO_INCREMENT,
  `ZIPCODE` INT(9) NOT NULL,
  PRIMARY KEY (`ZIPCODE_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VIPRESERVATIONS`.`CITYTABLE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VIPRESERVATIONS`.`CITYTABLE` (
  `CITY_ID` INT NOT NULL AUTO_INCREMENT,
  `CITYNAME` VARCHAR(45) NOT NULL,
  `STATE_ID` INT NOT NULL,
  `ZIPCODE_ID` INT NOT NULL,
  PRIMARY KEY (`CITY_ID`),
  INDEX `STATETABLE_idx` (`STATE_ID` ASC) VISIBLE,
  INDEX `ZIPCODETABLE_idx` (`ZIPCODE_ID` ASC) VISIBLE,
  CONSTRAINT `STATE_ID`
    FOREIGN KEY (`STATE_ID`)
    REFERENCES `VIPRESERVATIONS`.`STATETABEL` (`ST_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CITY_ID`
    FOREIGN KEY (`CITY_ID`)
    REFERENCES `VIPRESERVATIONS`.`CITYTABLE` (`CITY_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ZIPCODE_ID`
    FOREIGN KEY (`ZIPCODE_ID`)
    REFERENCES `VIPRESERVATIONS`.`ZIPCODETABLE` (`ZIPCODE_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VIPRESERVATIONS`.`TERRITORYTABLE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VIPRESERVATIONS`.`TERRITORYTABLE` (
  `TERRITORY_ID` INT NOT NULL AUTO_INCREMENT,
  `TERRITORY` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`TERRITORY_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VIPRESERVATIONS`.`VIPLEVELTABLE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VIPRESERVATIONS`.`VIPLEVELTABLE` (
  `VIPLEVEL_ID` INT NOT NULL AUTO_INCREMENT,
  `VIPLEVELS` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`VIPLEVEL_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VIPRESERVATIONS`.`CUSTOMERTABLE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VIPRESERVATIONS`.`CUSTOMERTABLE` (
  `CUSTOMER_ID` INT NOT NULL AUTO_INCREMENT,
  `CUSTOMERNAME` VARCHAR(50) NOT NULL,
  `PHONE` INT(10) NOT NULL,
  `ADDRESSLINE1` VARCHAR(45) NOT NULL,
  `ADDRESSLINE2` VARCHAR(45) NULL,
  `CITY_ID` INT NOT NULL,
  `TERRITORY_ID` INT NOT NULL,
  `VIPLEVEL_ID` INT NOT NULL,
  PRIMARY KEY (`CUSTOMER_ID`),
  INDEX `CITY_ID_idx` (`CITY_ID` ASC) VISIBLE,
  INDEX `TERRITORYTABLE_idx` (`TERRITORY_ID` ASC) VISIBLE,
  INDEX `VIPLEVEL_ID_idx` (`VIPLEVEL_ID` ASC) VISIBLE,
  CONSTRAINT `CITY_ID`
    FOREIGN KEY (`CITY_ID`)
    REFERENCES `VIPRESERVATIONS`.`CITYTABLE` (`CITY_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `TERRITORY_ID`
    FOREIGN KEY (`TERRITORY_ID`)
    REFERENCES `VIPRESERVATIONS`.`TERRITORYTABLE` (`TERRITORY_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `VIPLEVEL_ID`
    FOREIGN KEY (`VIPLEVEL_ID`)
    REFERENCES `VIPRESERVATIONS`.`VIPLEVELTABLE` (`VIPLEVEL_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VIPRESERVATIONS`.`BUSINESSHOURSTABLE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VIPRESERVATIONS`.`BUSINESSHOURSTABLE` (
  `BUSINESS_HRS_ID` INT NOT NULL AUTO_INCREMENT,
  `DAYSOFOPPERATION` VARCHAR(45) NOT NULL,
  `HOURSOFOPPERATION` INT NOT NULL,
  PRIMARY KEY (`BUSINESS_HRS_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VIPRESERVATIONS`.`MENUTABLE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VIPRESERVATIONS`.`MENUTABLE` (
  `MENU_ID` INT NOT NULL AUTO_INCREMENT,
  `MENUOPTIONS` VARCHAR(45) NOT NULL,
  `TAKEOUTOPTIONS` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`MENU_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VIPRESERVATIONS`.`RESERVATIONOPTTABLE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VIPRESERVATIONS`.`RESERVATIONOPTTABLE` (
  `RESERVATIONOPT_ID` INT NOT NULL AUTO_INCREMENT,
  `RESERVATIONOPTION` VARCHAR(45) NOT NULL,
  `REAERVATIONSTATUS` VARCHAR(45) NOT NULL,
  `BUSINESS_HRS_ID` INT NOT NULL,
  `MENU_ID` INT NOT NULL,
  PRIMARY KEY (`RESERVATIONOPT_ID`),
  INDEX `BUSINESS_HRS_ID_idx` (`BUSINESS_HRS_ID` ASC) VISIBLE,
  INDEX `MENU_ID_idx` (`MENU_ID` ASC) VISIBLE,
  CONSTRAINT `BUSINESS_HRS_ID`
    FOREIGN KEY (`BUSINESS_HRS_ID`)
    REFERENCES `VIPRESERVATIONS`.`BUSINESSHOURSTABLE` (`BUSINESS_HRS_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `MENU_ID`
    FOREIGN KEY (`MENU_ID`)
    REFERENCES `VIPRESERVATIONS`.`MENUTABLE` (`MENU_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VIPRESERVATIONS`.`RESTURANTTABLE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VIPRESERVATIONS`.`RESTURANTTABLE` (
  `BUSINESS_ID` INT NOT NULL AUTO_INCREMENT,
  `BUSINESSNAME` VARCHAR(75) NOT NULL,
  `PHONE` INT(10) NOT NULL,
  `ADDRESSLINE1` VARCHAR(45) NOT NULL,
  `ADDRESSLINE2` VARCHAR(45) NULL,
  `CITY_ID` INT NOT NULL,
  `RESERVATIONOPT_ID` INT NOT NULL,
  `TERRITORY_ID` INT NOT NULL,
  PRIMARY KEY (`BUSINESS_ID`),
  INDEX `CITYTABLE_idx` (`CITY_ID` ASC) VISIBLE,
  INDEX `RESERVATIONOPTTABLE_idx` (`RESERVATIONOPT_ID` ASC) VISIBLE,
  INDEX `TERRITORY_ID_idx` (`TERRITORY_ID` ASC) VISIBLE,
  CONSTRAINT `CITY_ID`
    FOREIGN KEY (`CITY_ID`)
    REFERENCES `VIPRESERVATIONS`.`CITYTABLE` (`CITY_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `RESERVATIONOPT_ID`
    FOREIGN KEY (`RESERVATIONOPT_ID`)
    REFERENCES `VIPRESERVATIONS`.`RESERVATIONOPTTABLE` (`RESERVATIONOPT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `TERRITORY_ID`
    FOREIGN KEY (`TERRITORY_ID`)
    REFERENCES `VIPRESERVATIONS`.`TERRITORYTABLE` (`TERRITORY_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
