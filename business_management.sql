-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema company
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema company
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `company` DEFAULT CHARACTER SET utf8 ;
USE `company` ;

-- -----------------------------------------------------
-- Table `company`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `company`.`department` (
  `DNO` INT NOT NULL AUTO_INCREMENT,
  `DName` VARCHAR(45) NOT NULL,
  `LOC` VARCHAR(45) NOT NULL,
  `Manager_SSN` INT NOT NULL,
  `ST_Date` INT NOT NULL,
  PRIMARY KEY (`DNO`),
  UNIQUE INDEX `DNO_UNIQUE` (`DNO` ASC),
  INDEX `fk_department_employee1_idx` (`Manager_SSN` ASC),
  CONSTRAINT `fk_department_employee1`
    FOREIGN KEY (`Manager_SSN`)
    REFERENCES `company`.`employee` (`SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `company`.`car`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `company`.`car` (
  `Plate NO` INT NOT NULL,
  `MOD` VARCHAR(45) NOT NULL,
  `color` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Plate NO`),
  UNIQUE INDEX `Plate NO_UNIQUE` (`Plate NO` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `company`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `company`.`employee` (
  `SSN` INT NOT NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` CHAR(30) NOT NULL,
  `DOB` DATE NOT NULL,
  `street` CHAR(100) NOT NULL,
  `zone` CHAR(100) NOT NULL,
  `department_DNO` INT NOT NULL,
  `Manager_SSN` INT NOT NULL,
  `car_Plate NO` INT NOT NULL,
  `Contract ID` INT NOT NULL,
  `Type` VARCHAR(45) NOT NULL,
  `ST Date` DATE NOT NULL,
  UNIQUE INDEX `SSN_UNIQUE` (`SSN` ASC),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  INDEX `fk_employee_department_idx` (`department_DNO` ASC) ,
  PRIMARY KEY (`SSN`),
  INDEX `fk_employee_employee1_idx` (`Manager_SSN` ASC) ,
  INDEX `fk_employee_car1_idx` (`car_Plate NO` ASC) ,
  CONSTRAINT `fk_employee_department`
    FOREIGN KEY (`department_DNO`)
    REFERENCES `company`.`department` (`DNO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_employee1`
    FOREIGN KEY (`Manager_SSN`)
    REFERENCES `company`.`employee` (`SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_car1`
    FOREIGN KEY (`car_Plate NO`)
    REFERENCES `company`.`car` (`Plate NO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `company`.`employee-phone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `company`.`employee-phone` (
  `employee_SSN` INT NOT NULL,
  `phone` INT NOT NULL,
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) ,
  INDEX `fk_employee-phone_employee1_idx` (`employee_SSN` ASC) ,
  PRIMARY KEY (`employee_SSN`, `phone`),
  CONSTRAINT `fk_employee-phone_employee1`
    FOREIGN KEY (`employee_SSN`)
    REFERENCES `company`.`employee` (`SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `company`.`project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `company`.`project` (
  `PNO` INT NOT NULL,
  `PName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`PNO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `company`.`skill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `company`.`skill` (
  `Skill_Id` INT NOT NULL AUTO_INCREMENT,
  `SName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Skill_Id`),
  UNIQUE INDEX `SID_UNIQUE` (`Skill_Id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `company`.`dependent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `company`.`dependent` (
  `name` VARCHAR(45) NOT NULL,
  `relation` VARCHAR(45) NOT NULL,
  `employee_SSN` INT NOT NULL,
  INDEX `fk_dependent_employee1_idx` (`employee_SSN` ASC) ,
  CONSTRAINT `fk_dependent_employee1`
    FOREIGN KEY (`employee_SSN`)
    REFERENCES `company`.`employee` (`SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `company`.`employee_work_on_project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `company`.`employee_work_on_project` (
  `employee_SSN` INT NOT NULL,
  `project_PNO` INT NOT NULL,
  `hours` DOUBLE NULL,
  PRIMARY KEY (`employee_SSN`, `project_PNO`),
  INDEX `fk_employee_has_project_project1_idx` (`project_PNO` ASC) ,
  INDEX `fk_employee_has_project_employee1_idx` (`employee_SSN` ASC) ,
  CONSTRAINT `fk_employee_has_project_employee1`
    FOREIGN KEY (`employee_SSN`)
    REFERENCES `company`.`employee` (`SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_has_project_project1`
    FOREIGN KEY (`project_PNO`)
    REFERENCES `company`.`project` (`PNO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `company`.`skilled_use`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `company`.`skilled_use` (
  `employee_SSN` INT NOT NULL,
  `project_PNO` INT NOT NULL,
  `skill_Skill_Id` INT NOT NULL,
  INDEX `fk_skilled_use_employee1_idx` (`employee_SSN` ASC) ,
  INDEX `fk_skilled_use_project1_idx` (`project_PNO` ASC) ,
  INDEX `fk_skilled_use_skill1_idx` (`skill_Skill_Id` ASC) ,
  CONSTRAINT `fk_skilled_use_employee1`
    FOREIGN KEY (`employee_SSN`)
    REFERENCES `company`.`employee` (`SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_skilled_use_project1`
    FOREIGN KEY (`project_PNO`)
    REFERENCES `company`.`project` (`PNO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_skilled_use_skill1`
    FOREIGN KEY (`skill_Skill_Id`)
    REFERENCES `company`.`skill` (`Skill_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
