-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema megamanx
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema megamanx
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `megamanx` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `megamanx` ;

-- -----------------------------------------------------
-- Table `megamanx`.`boss`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `megamanx`.`boss` (
  `boss_id` INT(11) NOT NULL AUTO_INCREMENT,
  `b_name` VARCHAR(45) NOT NULL,
  `hp` INT(11) NOT NULL,
  PRIMARY KEY (`boss_id`),
  UNIQUE INDEX `boss_id_UNIQUE` (`boss_id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `megamanx`.`game`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `megamanx`.`game` (
  `game_id` INT(11) NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `release_date` DATETIME NOT NULL,
  `platforms` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`game_id`),
  UNIQUE INDEX `game_id_UNIQUE` (`game_id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `megamanx`.`player`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `megamanx`.`player` (
  `player_id` INT(11) NOT NULL AUTO_INCREMENT,
  `p_name` VARCHAR(45) NOT NULL,
  `gender` VARCHAR(2) NOT NULL,
  `main_weapon` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`player_id`),
  UNIQUE INDEX `character_id_UNIQUE` (`player_id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `megamanx`.`weapon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `megamanx`.`weapon` (
  `weapon_id` INT(11) NOT NULL AUTO_INCREMENT,
  `w_name` VARCHAR(45) NOT NULL,
  `boss_id` INT(11) NOT NULL,
  `player_id` INT(11) NOT NULL,
  PRIMARY KEY (`weapon_id`),
  UNIQUE INDEX `weapon_id_UNIQUE` (`weapon_id` ASC) VISIBLE,
  INDEX `boss_id_idx` (`boss_id` ASC) VISIBLE,
  INDEX `player_id_idx` (`player_id` ASC) VISIBLE,
  CONSTRAINT `boss_id`
    FOREIGN KEY (`boss_id`)
    REFERENCES `megamanx`.`boss` (`boss_id`),
  CONSTRAINT `player_id`
    FOREIGN KEY (`player_id`)
    REFERENCES `megamanx`.`player` (`player_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 33
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `megamanx`.`rel_boss_weapon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `megamanx`.`rel_boss_weapon` (
  `rel_boss_weapon_id` INT(11) NOT NULL AUTO_INCREMENT,
  `boss_id` INT(11) NOT NULL,
  `weapon_id` INT(11) NOT NULL,
  `base_damage` INT(11) NOT NULL,
  `charged_damage` INT(11) NULL DEFAULT NULL,
  `weakness` BIT(1) NOT NULL,
  PRIMARY KEY (`rel_boss_weapon_id`),
  UNIQUE INDEX `rel_boss_weapon_id_UNIQUE` (`rel_boss_weapon_id` ASC) VISIBLE,
  INDEX `weapon_id_idx` (`weapon_id` ASC) VISIBLE,
  INDEX `boss_id_idx` (`boss_id` ASC) VISIBLE,
  CONSTRAINT `boss_id3`
    FOREIGN KEY (`boss_id`)
    REFERENCES `megamanx`.`boss` (`boss_id`),
  CONSTRAINT `weapon_id2`
    FOREIGN KEY (`weapon_id`)
    REFERENCES `megamanx`.`weapon` (`weapon_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 65
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `megamanx`.`rel_game_boss`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `megamanx`.`rel_game_boss` (
  `rel_game_boss_id` INT(11) NOT NULL AUTO_INCREMENT,
  `game_id` INT(11) NOT NULL,
  `boss_id` INT(11) NOT NULL,
  PRIMARY KEY (`rel_game_boss_id`),
  UNIQUE INDEX `rel_game_boss_id_UNIQUE` (`rel_game_boss_id` ASC) VISIBLE,
  INDEX `game_id_idx` (`game_id` ASC) VISIBLE,
  INDEX `boss_id_idx` (`boss_id` ASC) VISIBLE,
  CONSTRAINT `boss_id2`
    FOREIGN KEY (`boss_id`)
    REFERENCES `megamanx`.`boss` (`boss_id`),
  CONSTRAINT `game_id2`
    FOREIGN KEY (`game_id`)
    REFERENCES `megamanx`.`game` (`game_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `megamanx`.`rel_game_player`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `megamanx`.`rel_game_player` (
  `rel_game_character_id` INT(11) NOT NULL AUTO_INCREMENT,
  `game_id` INT(11) NOT NULL,
  `player_id` INT(11) NOT NULL,
  PRIMARY KEY (`rel_game_character_id`),
  INDEX `game_id_idx` (`game_id` ASC) VISIBLE,
  INDEX `character_id_idx` (`player_id` ASC) VISIBLE,
  CONSTRAINT `game_id`
    FOREIGN KEY (`game_id`)
    REFERENCES `megamanx`.`game` (`game_id`),
  CONSTRAINT `player_id2`
    FOREIGN KEY (`player_id`)
    REFERENCES `megamanx`.`player` (`player_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- ALTER USER user@host IDENTIFIED WITH mysql_native_password BY password;
