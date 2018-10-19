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
  `description` TEXT NOT NULL,
  `hp` INT(11) NOT NULL,
  `stage` VARCHAR(45) NOT NULL,
  `image` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`boss_id`),
  UNIQUE INDEX `boss_id_UNIQUE` (`boss_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `megamanx`.`game`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `megamanx`.`game` (
  `game_id` INT(11) NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `release_date` DATETIME NOT NULL,
  `story` TEXT NOT NULL,
  `platforms` VARCHAR(255) NOT NULL,
  `image` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`game_id`),
  UNIQUE INDEX `game_id_UNIQUE` (`game_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `megamanx`.`player`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `megamanx`.`player` (
  `player_id` INT(11) NOT NULL AUTO_INCREMENT,
  `p_name` VARCHAR(45) NOT NULL,
  `description` TEXT NOT NULL,
  `gender` VARCHAR(2) NOT NULL,
  `main_weapon` VARCHAR(45) NOT NULL,
  `image` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`player_id`),
  UNIQUE INDEX `character_id_UNIQUE` (`player_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `megamanx`.`weapon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `megamanx`.`weapon` (
  `weapon_id` INT(11) NOT NULL AUTO_INCREMENT,
  `w_name` VARCHAR(45) NOT NULL,
  `image` VARCHAR(45) NULL DEFAULT NULL,
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
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `megamanx`.`rel_game_player`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `megamanx`.`rel_game_player` (
  `rel_game_player_id` INT(11) NOT NULL AUTO_INCREMENT,
  `game_id` INT(11) NOT NULL,
  `player_id` INT(11) NOT NULL,
  PRIMARY KEY (`rel_game_player_id`),
  INDEX `game_id_idx` (`game_id` ASC) VISIBLE,
  INDEX `character_id_idx` (`player_id` ASC) VISIBLE,
  CONSTRAINT `game_id`
    FOREIGN KEY (`game_id`)
    REFERENCES `megamanx`.`game` (`game_id`),
  CONSTRAINT `player_id2`
    FOREIGN KEY (`player_id`)
    REFERENCES `megamanx`.`player` (`player_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `megamanx`.`x_armor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `megamanx`.`x_armor` (
  `x_armor_id` INT(11) NOT NULL AUTO_INCREMENT,
  `x_name` VARCHAR(45) NOT NULL,
  `head_effect` TEXT NOT NULL,
  `head_stage` VARCHAR(45) NOT NULL,
  `body_effect` TEXT NOT NULL,
  `body_stage` VARCHAR(45) NOT NULL,
  `arm_effect` TEXT NOT NULL,
  `arm_stage` VARCHAR(45) NOT NULL,
  `foot_effect` TEXT NOT NULL,
  `foot_stage` VARCHAR(45) NOT NULL,
  `image` VARCHAR(45) NULL DEFAULT NULL,
  `game_id` INT(11) NOT NULL,
  PRIMARY KEY (`x_armor_id`),
  UNIQUE INDEX `x_armor_id_UNIQUE` (`x_armor_id` ASC) VISIBLE,
  INDEX `FK_Game_ID_idx` (`game_id` ASC) VISIBLE,
  CONSTRAINT `FK_Game_ID`
    FOREIGN KEY (`game_id`)
    REFERENCES `megamanx`.`game` (`game_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `megamanx` ;

-- -----------------------------------------------------
-- procedure Q_Get_Boss_By_ID
-- -----------------------------------------------------

DELIMITER $$
USE `megamanx`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Q_Get_Boss_By_ID`(
	IN _boss_id INT
)
    READS SQL DATA
    DETERMINISTIC
BEGIN
	
    SELECT boss_id as id, b_name as 'name', 
    description, hp, stage, image
    FROM boss
    WHERE boss_id = _boss_id;
    
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Q_Get_Game_By_ID
-- -----------------------------------------------------

DELIMITER $$
USE `megamanx`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Q_Get_Game_By_ID`(
	IN _game_id INT
)
    READS SQL DATA
    DETERMINISTIC
BEGIN

	-- Game
	SELECT game_id as id, title, release_date,
    story, platforms, image
    FROM game
    WHERE game_id = _game_id;
    
    -- Characters
    SELECT p.player_id as id, p_name as 'name',
    image
    FROM player p
    INNER JOIN rel_game_player gp
    ON p.player_id = gp.player_id
    WHERE gp.game_id = _game_id;
    
    -- Armor sets
    SELECT x_armor_id as id, x_name as 'name',
    head_effect as head,
	body_effect as body, arm_effect as arm,
    foot_effect as foot, image
    FROM x_armor
    WHERE game_id = _game_id;
    
    -- Weakness Chart
    SELECT b.boss_id as id, b.b_name as 'name', b.stage,
    w.weapon_id as weapon_id, w.w_name as weapon_name,
    wk.weapon_id as weakness_id, wk.w_name as weakness_name
    FROM boss b
    INNER JOIN weapon w
    ON b.boss_id = w.boss_id
    INNER JOIN rel_boss_weapon bw
    ON b.boss_id = bw.boss_id
    INNER JOIN weapon wk
    ON bw.weapon_id = wk.weapon_id
    INNER JOIN rel_game_boss gb
    ON b.boss_id = gb.boss_id
    WHERE gb.game_id = _game_id
    AND bw.weakness = 1;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Q_Insert_Boss_By_Game
-- -----------------------------------------------------

DELIMITER $$
USE `megamanx`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Q_Insert_Boss_By_Game`(
	IN _b_name VARCHAR(45),
    IN _description TEXT,
    IN _hp INT,
    IN _stage VARCHAR(45),
    IN _image VARCHAR(45),
    IN _game_id INT
)
BEGIN

	DECLARE _inserted_boss_id INT;

	INSERT INTO boss
    (b_name,
    description,
    hp,
    stage,
    image
    ) 
    VALUES 
	(_b_name,
    _description,
    _hp,
    _stage,
    _image
    );
    
    SET _inserted_boss_id = LAST_INSERT_ID();
    
    INSERT INTO rel_game_boss
    (
	game_id,
    boss_id
    ) VALUES
    (
    _game_id,
    _inserted_boss_id
    );
    
    SELECT _inserted_boss_id as id;
    
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Q_Insert_Game
-- -----------------------------------------------------

DELIMITER $$
USE `megamanx`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Q_Insert_Game`(
	IN _title VARCHAR(45),
    IN _release_date DATETIME,
    IN _story TEXT,
    IN _platforms VARCHAR(255)
)
    READS SQL DATA
    DETERMINISTIC
BEGIN
	
    INSERT INTO game 
    (title, 
    release_date, 
    story,
    platforms) 
    VALUES
    (_title, 
    _release_date, 
    _story,
    _platforms);
    
    SELECT LAST_INSERT_ID() as id;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
