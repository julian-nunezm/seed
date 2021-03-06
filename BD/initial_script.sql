-- MySQL Script generated by MySQL Workbench
-- Mon 04 Jun 2018 00:20:11 -05
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema seed
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `seed` ;

-- -----------------------------------------------------
-- Schema seed
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `seed` DEFAULT CHARACTER SET utf8 ;
USE `seed` ;

-- -----------------------------------------------------
-- Table `seed`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `seed`.`User` ;

CREATE TABLE IF NOT EXISTS `seed`.`User` (
  `us_id` INT NOT NULL AUTO_INCREMENT,
  `us_name` VARCHAR(45) NOT NULL,
  `us_status` ENUM('Activo', 'Desactivado') NOT NULL,
  `us_created_by` VARCHAR(45) NOT NULL DEFAULT 'admin',
  `us_modified_by` VARCHAR(45) NOT NULL DEFAULT 'admin',
  `us_creation_date` DATE NOT NULL DEFAULT CURRENT_DATE,
  `us_update_date` DATE NOT NULL DEFAULT CURRENT_DATE,
  PRIMARY KEY (`us_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `seed`.`Budget`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `seed`.`Budget` ;

CREATE TABLE IF NOT EXISTS `seed`.`Budget` (
  `bu_id` INT NOT NULL AUTO_INCREMENT,
  `User_us_id` INT NOT NULL,
  `bu_name` VARCHAR(45) NOT NULL,
  `bu_status` ENUM('Activo', 'Desactivado') NOT NULL,
  `bu_created_by` VARCHAR(45) NOT NULL DEFAULT 'admin',
  `bu_modified_by` VARCHAR(45) NOT NULL DEFAULT 'admin',
  `bu_creation_date` DATE NOT NULL DEFAULT CURRENT_DATE,
  `bu_update_date` DATE NOT NULL DEFAULT CURRENT_DATE,
  PRIMARY KEY (`bu_id`, `User_us_id`),
  CONSTRAINT `fk_Budget_User`
    FOREIGN KEY (`User_us_id`)
    REFERENCES `seed`.`User` (`us_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Budget_User_idx` ON `seed`.`Budget` (`User_us_id` ASC);


-- -----------------------------------------------------
-- Table `seed`.`Category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `seed`.`Category` ;

CREATE TABLE IF NOT EXISTS `seed`.`Category` (
  `ca_id` INT NOT NULL AUTO_INCREMENT,
  `ca_name` VARCHAR(45) NOT NULL,
  `ca_description` VARCHAR(45) NULL,
  `ca_type` ENUM('Income', 'Outcome') NOT NULL,
  `ca_created_by` VARCHAR(45) NOT NULL DEFAULT 'admin',
  `ca_modified_by` VARCHAR(45) NOT NULL DEFAULT 'admin',
  `ca_creation_date` DATE NOT NULL DEFAULT CURRENT_DATE,
  `ca_update_date` DATE NOT NULL DEFAULT CURRENT_DATE,
  PRIMARY KEY (`ca_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `seed`.`Income`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `seed`.`Income` ;

CREATE TABLE IF NOT EXISTS `seed`.`Income` (
  `in_id` INT NOT NULL AUTO_INCREMENT,
  `Budget_bu_id` INT NOT NULL,
  `Category_ca_id` INT NOT NULL,
  `in_name` VARCHAR(45) NOT NULL,
  `in_amount` FLOAT(14,2) NOT NULL,
  `in_recurrence` ENUM('Diario', 'Semanal', 'Mensual', 'Trimestral', 'Semestral', 'Anual') NULL,
  `in_date` DATE NOT NULL,
  `in_created_by` VARCHAR(45) NOT NULL,
  `in_modified_by` VARCHAR(45) NOT NULL DEFAULT 'admin',
  `in_creation_date` DATE NOT NULL DEFAULT CURRENT_DATE,
  `in_update_date` DATE NOT NULL DEFAULT CURRENT_DATE,
  PRIMARY KEY (`in_id`, `Category_ca_id`, `Budget_bu_id`),
  CONSTRAINT `fk_Income_Budget1`
    FOREIGN KEY (`Budget_bu_id`)
    REFERENCES `seed`.`Budget` (`bu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Income_Category1`
    FOREIGN KEY (`Category_ca_id`)
    REFERENCES `seed`.`Category` (`ca_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Income_Budget1_idx` ON `seed`.`Income` (`Budget_bu_id` ASC);

CREATE INDEX `fk_Income_Category1_idx` ON `seed`.`Income` (`Category_ca_id` ASC);


-- -----------------------------------------------------
-- Table `seed`.`Outcome`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `seed`.`Outcome` ;

CREATE TABLE IF NOT EXISTS `seed`.`Outcome` (
  `out_id` INT NOT NULL AUTO_INCREMENT,
  `Budget_bu_id` INT NOT NULL,
  `Category_ca_id` INT NOT NULL,
  `out_name` VARCHAR(45) NOT NULL,
  `out_amount` FLOAT(14,2) NOT NULL,
  `out_recurrence` ENUM('Diario', 'Semanal', 'Mensual', 'Trimestral', 'Semestral', 'Anual') NULL,
  `out_date` DATE NOT NULL,
  `ou_created_by` VARCHAR(45) NOT NULL DEFAULT 'admin',
  `ou_modified_by` VARCHAR(45) NOT NULL DEFAULT 'admin',
  `ou_creation_date` DATE NOT NULL DEFAULT CURRENT_DATE,
  `ou_update_date` DATE NOT NULL DEFAULT CURRENT_DATE,
  PRIMARY KEY (`out_id`, `Category_ca_id`, `Budget_bu_id`),
  CONSTRAINT `fk_Income_Budget10`
    FOREIGN KEY (`Budget_bu_id`)
    REFERENCES `seed`.`Budget` (`bu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Outcome_Category1`
    FOREIGN KEY (`Category_ca_id`)
    REFERENCES `seed`.`Category` (`ca_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Income_Budget1_idx` ON `seed`.`Outcome` (`Budget_bu_id` ASC);

CREATE INDEX `fk_Outcome_Category1_idx` ON `seed`.`Outcome` (`Category_ca_id` ASC);


-- -----------------------------------------------------
-- Table `seed`.`Summary`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `seed`.`Summary` ;

CREATE TABLE IF NOT EXISTS `seed`.`Summary` (
  `su_id` INT NOT NULL,
  `su_period` VARCHAR(45) NOT NULL,
  `su_income` DECIMAL NOT NULL,
  `su_outcome` DECIMAL NOT NULL,
  `su_created_by` VARCHAR(45) NOT NULL,
  `su_modified_by` VARCHAR(45) NOT NULL,
  `su_creation_date` DATE NOT NULL,
  `su_update_date` DATE NOT NULL,
  PRIMARY KEY (`su_id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
