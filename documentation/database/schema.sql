-- MySQL Script generated by MySQL Workbench
-- Tue Oct 30 21:21:27 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`category` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`category` (
  `id` BIGINT NOT NULL COMMENT 'ИД Категории',
  `name` VARCHAR(45) NULL COMMENT 'Наименование категории',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = 'Категория';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`category_spec`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`category_spec` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`category_spec` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `categoryid` BIGINT NOT NULL COMMENT 'ИД категории',
  `serviceid` BIGINT NOT NULL COMMENT 'ИД услуги',
  `datefrom` DATE NOT NULL COMMENT 'Действует с',
  `dateto` DATE NULL COMMENT 'Действует по',
  PRIMARY KEY (`id`),
  INDEX `category_spec_service_idx` (`serviceid` ASC) VISIBLE,
  INDEX `category_spec_category_idx` (`categoryid` ASC) VISIBLE,
  CONSTRAINT `category_spec_category`
    FOREIGN KEY (`categoryid`)
    REFERENCES `mydb`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `category_spec_service`
    FOREIGN KEY (`serviceid`)
    REFERENCES `mydb`.`services` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`department` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`department` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT 'Ид',
  `pid` BIGINT NULL COMMENT 'Ссылка на родителя',
  `sname` VARCHAR(45) NOT NULL COMMENT 'Краткое наименование',
  `name` VARCHAR(240) NOT NULL COMMENT 'Полное наименование',
  `datefrom` DATE NULL COMMENT 'Действует с',
  `dateto` DATE NULL COMMENT 'Действует по',
  `hier_level` INT NULL,
  `organizationid` BIGINT NULL,
  `position` VARCHAR(10) NULL COMMENT 'Позиция(для сортировки)',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `sname_UNIQUE` (`sname` ASC) INVISIBLE,
  INDEX `i_department_pid` (`pid` ASC) VISIBLE,
  INDEX `department_organization_idx` (`organizationid` ASC) VISIBLE,
  CONSTRAINT `department_pid`
    FOREIGN KEY (`id`)
    REFERENCES `mydb`.`department` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `department_organization`
    FOREIGN KEY (`organizationid`)
    REFERENCES `mydb`.`oraganization` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Подразделения';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`discount`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`discount` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`discount` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT 'ИД',
  `name` VARCHAR(100) NOT NULL COMMENT 'Наименование',
  `percent` FLOAT NOT NULL DEFAULT 0 COMMENT 'Процент',
  `datefrom` DATE NOT NULL COMMENT 'Дата с',
  `dateto` DATE NULL COMMENT 'Дата по',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = 'Дискоунт';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`employee` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`employee` (
  `id` BIGINT NOT NULL,
  `firstname` VARCHAR(100) NOT NULL COMMENT 'Имя',
  `lastname` VARCHAR(100) NOT NULL COMMENT 'Отчество',
  `familyname` VARCHAR(100) NOT NULL COMMENT 'Фамилия',
  `birthdate` DATE NOT NULL COMMENT 'Дата рождения',
  `departmentid` BIGINT NULL COMMENT 'ИД подразделения',
  `jobbegindate` DATE NOT NULL COMMENT 'Дата приема',
  `dismissdate` DATE NULL COMMENT 'Дата увольнения',
  `postid` BIGINT NULL COMMENT 'Должность',
  `email` VARCHAR(100) NULL COMMENT 'email',
  `internalnumber` VARCHAR(50) NULL COMMENT 'Внутрений номер',
  `phone1` VARCHAR(50) NULL COMMENT 'Телефон 1',
  `phone2` VARCHAR(50) NULL COMMENT 'Телефон 2',
  `categoryid` BIGINT NOT NULL COMMENT 'Категория',
  `photo` BLOB NULL COMMENT 'Фото',
  `cardid` VARCHAR(45) NULL COMMENT 'Уникальній идетнификатор карты',
  `dbuser` BIGINT NULL COMMENT 'Пользователь БД',
  `gender` INT(1) NOT NULL DEFAULT 0 COMMENT 'Пол:  0 - женский, 1 - мужской',
  `employeecol` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `employee_department_idx` (`departmentid` ASC) VISIBLE,
  INDEX `employee_category_idx` (`categoryid` ASC) VISIBLE,
  INDEX `employee_post_idx` (`postid` ASC) VISIBLE,
  INDEX `employee_dbuse_idx` (`dbuser` ASC) INVISIBLE,
  CONSTRAINT `employee_department`
    FOREIGN KEY (`departmentid`)
    REFERENCES `mydb`.`department` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `employee_category`
    FOREIGN KEY (`categoryid`)
    REFERENCES `mydb`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `employee_post`
    FOREIGN KEY (`postid`)
    REFERENCES `mydb`.`post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `employee_dbuse`
    FOREIGN KEY (`dbuser`)
    REFERENCES `mydb`.`userlist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Персонал';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`employeediscount`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`employeediscount` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`employeediscount` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `discountid` BIGINT NOT NULL,
  `validfrom` DATE NOT NULL,
  `employeeid` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `employee_discount_unq` (`id` ASC, `employeeid` ASC, `validfrom` ASC, `discountid` ASC) VISIBLE,
  INDEX `employee_discount_employee_idx` (`employeeid` ASC) VISIBLE,
  CONSTRAINT `employeediscount_discount`
    FOREIGN KEY (`discountid`)
    REFERENCES `mydb`.`discount` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `employee_discount_employee`
    FOREIGN KEY (`employeeid`)
    REFERENCES `mydb`.`employee` (`departmentid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`grouptraining`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`grouptraining` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`grouptraining` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `employeeid` BIGINT NOT NULL COMMENT 'ид сотрудника',
  `gymid` BIGINT NOT NULL COMMENT 'ид помещения',
  `serviceid` BIGINT NOT NULL COMMENT 'ид услуги',
  `amount` INT NOT NULL DEFAULT 0 COMMENT 'кол-во человек',
  `state` CHAR(1) NOT NULL DEFAULT 0 COMMENT '0 - открыта , 1 - закрыта',
  `description` VARCHAR(250) NULL,
  `grouptrainintypeid` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `grouptraining_employee_idx` (`employeeid` ASC) VISIBLE,
  INDEX `grouptraining_service_idx` (`serviceid` ASC) VISIBLE,
  INDEX `grouptraining_gym_idx` (`gymid` ASC) VISIBLE,
  INDEX `grouptraining_type_idx` (`grouptrainintypeid` ASC) VISIBLE,
  CONSTRAINT `grouptraining_employee`
    FOREIGN KEY (`employeeid`)
    REFERENCES `mydb`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `grouptraining_service`
    FOREIGN KEY (`serviceid`)
    REFERENCES `mydb`.`services` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `grouptraining_gym`
    FOREIGN KEY (`gymid`)
    REFERENCES `mydb`.`gym` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `grouptraining_type`
    FOREIGN KEY (`grouptrainintypeid`)
    REFERENCES `mydb`.`trainigtype` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Групповые тренировки';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`gym`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`gym` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`gym` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(250) NULL,
  `capacity` INT NOT NULL DEFAULT 0,
  `company` BIGINT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`oraganization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`oraganization` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`oraganization` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `sname` VARCHAR(45) NULL,
  `name` VARCHAR(250) NULL,
  `phone` VARCHAR(45) NULL,
  `phone2` VARCHAR(45) NULL,
  `email` VARCHAR(100) NULL,
  `address` VARCHAR(250) NULL,
  `orgcode` VARCHAR(10) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`post` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`post` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(250) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`roles` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`roles` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `rolename` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `rolename_UNIQUE` (`rolename` ASC) VISIBLE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`rolesprivs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`rolesprivs` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`rolesprivs` (
  `roleid` BIGINT NOT NULL,
  `unitcode` VARCHAR(100) NULL,
  `unitaction` VARCHAR(100) NULL,
  PRIMARY KEY (`roleid`),
  UNIQUE INDEX `rolesprivs_unq` (`roleid` ASC, `unitcode` ASC, `unitaction` ASC) VISIBLE,
  INDEX `rolesprivs_unitcode_idx` (`unitcode` ASC) VISIBLE,
  INDEX `rolesprivs_unitaction_idx` (`unitaction` ASC) VISIBLE,
  CONSTRAINT `rolesprivs_unitcode`
    FOREIGN KEY (`unitcode`)
    REFERENCES `mydb`.`unitlist` (`unitcode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `rolesprivs_unitaction`
    FOREIGN KEY (`unitaction`)
    REFERENCES `mydb`.`unitactions` (`unitaction`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `rolesprivs_role`
    FOREIGN KEY (`roleid`)
    REFERENCES `mydb`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`services`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`services` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`services` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT 'ид',
  `name` VARCHAR(100) NOT NULL COMMENT 'Наименование',
  `description` VARCHAR(250) NULL COMMENT 'Описание',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = 'Услуги';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`trainigtype`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`trainigtype` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`trainigtype` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `description` VARCHAR(250) NULL,
  `avaliable4group` INT(1) NULL COMMENT 'Доступна для групповой',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`unitactions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`unitactions` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`unitactions` (
  `unitcode` VARCHAR(100) NOT NULL,
  `unitaction` VARCHAR(100) NOT NULL,
  `unitactionname` VARCHAR(250) NULL,
  PRIMARY KEY (`unitcode`, `unitaction`),
  UNIQUE INDEX `unitactions_unq` (`unitcode` ASC, `unitaction` ASC) VISIBLE,
  CONSTRAINT `unitactions_unitlist`
    FOREIGN KEY (`unitcode`)
    REFERENCES `mydb`.`unitlist` (`unitcode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`unitlist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`unitlist` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`unitlist` (
  `unitcode` VARCHAR(100) NOT NULL,
  `unitname` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`unitcode`),
  UNIQUE INDEX `unitcode_UNIQUE` (`unitcode` ASC) VISIBLE,
  UNIQUE INDEX `unitname_UNIQUE` (`unitname` ASC) VISIBLE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`userlist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`userlist` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`userlist` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT 'Ид пользователя',
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(100) NULL,
  `user_fullname` VARCHAR(100) NULL,
  `user_img` VARCHAR(500) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = 'Пользователи\n';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`userroles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`userroles` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`userroles` (
  `id` BIGINT NOT NULL,
  `roleid` BIGINT NULL,
  `userid` BIGINT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `userroles_unq` (`roleid` ASC, `userid` ASC) VISIBLE,
  INDEX `userroles_user_idx` (`userid` ASC) VISIBLE,
  CONSTRAINT `userroles_user`
    FOREIGN KEY (`userid`)
    REFERENCES `mydb`.`userlist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `userroles_role`
    FOREIGN KEY (`roleid`)
    REFERENCES `mydb`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
