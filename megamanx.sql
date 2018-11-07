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
-- Table `megamanx`.`stage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `megamanx`.`stage` (
  `stage_id` INT(11) NOT NULL AUTO_INCREMENT,
  `s_name` VARCHAR(45) NOT NULL,
  `description` TEXT NOT NULL,
  `image` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`stage_id`),
  UNIQUE INDEX `stage_id_UNIQUE` (`stage_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `megamanx`.`collectible`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `megamanx`.`collectible` (
  `collectible_id` INT(11) NOT NULL AUTO_INCREMENT,
  `c_name` VARCHAR(45) NOT NULL,
  `description` TEXT NOT NULL,
  `image` VARCHAR(45) NULL DEFAULT NULL,
  `game_id` INT(11) NOT NULL,
  `stage_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`collectible_id`),
  UNIQUE INDEX `collectible_id_UNIQUE` (`collectible_id` ASC) VISIBLE,
  INDEX `FK_Collectible_Stage_idx` (`stage_id` ASC) VISIBLE,
  INDEX `FK_Collectible_Game_idx` (`game_id` ASC) VISIBLE,
  CONSTRAINT `FK_Collectible_Game`
    FOREIGN KEY (`game_id`)
    REFERENCES `megamanx`.`game` (`game_id`),
  CONSTRAINT `FK_Collectible_Stage`
    FOREIGN KEY (`stage_id`)
    REFERENCES `megamanx`.`stage` (`stage_id`))
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
  `boss_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`weapon_id`),
  UNIQUE INDEX `weapon_id_UNIQUE` (`weapon_id` ASC) VISIBLE,
  INDEX `boss_id_idx` (`boss_id` ASC) VISIBLE,
  CONSTRAINT `boss_id`
    FOREIGN KEY (`boss_id`)
    REFERENCES `megamanx`.`boss` (`boss_id`))
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
  `game_id` INT(11) NOT NULL,
  `base_damage` INT(11) NOT NULL,
  `charged_damage` INT(11) NULL DEFAULT NULL,
  `weakness` BIT(1) NOT NULL,
  PRIMARY KEY (`rel_boss_weapon_id`),
  UNIQUE INDEX `rel_boss_weapon_id_UNIQUE` (`rel_boss_weapon_id` ASC) VISIBLE,
  INDEX `weapon_id_idx` (`weapon_id` ASC) VISIBLE,
  INDEX `boss_id_idx` (`boss_id` ASC) VISIBLE,
  INDEX `FK_BW_G_idx` (`game_id` ASC) VISIBLE,
  CONSTRAINT `FK_BW_G`
    FOREIGN KEY (`game_id`)
    REFERENCES `megamanx`.`game` (`game_id`)
    ON DELETE CASCADE,
  CONSTRAINT `boss_id3`
    FOREIGN KEY (`boss_id`)
    REFERENCES `megamanx`.`boss` (`boss_id`)
    ON DELETE CASCADE,
  CONSTRAINT `weapon_id2`
    FOREIGN KEY (`weapon_id`)
    REFERENCES `megamanx`.`weapon` (`weapon_id`)
    ON DELETE CASCADE)
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
  `hp` INT(11) NOT NULL,
  `stage_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`rel_game_boss_id`),
  UNIQUE INDEX `rel_game_boss_id_UNIQUE` (`rel_game_boss_id` ASC) VISIBLE,
  INDEX `game_id_idx` (`game_id` ASC) VISIBLE,
  INDEX `boss_id_idx` (`boss_id` ASC) VISIBLE,
  INDEX `FK_RGB_Stage_idx` (`stage_id` ASC) VISIBLE,
  CONSTRAINT `FK_RGB_Stage`
    FOREIGN KEY (`stage_id`)
    REFERENCES `megamanx`.`stage` (`stage_id`)
    ON DELETE CASCADE,
  CONSTRAINT `boss_id2`
    FOREIGN KEY (`boss_id`)
    REFERENCES `megamanx`.`boss` (`boss_id`)
    ON DELETE CASCADE,
  CONSTRAINT `game_id2`
    FOREIGN KEY (`game_id`)
    REFERENCES `megamanx`.`game` (`game_id`)
    ON DELETE CASCADE)
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
    REFERENCES `megamanx`.`game` (`game_id`)
    ON DELETE CASCADE,
  CONSTRAINT `player_id2`
    FOREIGN KEY (`player_id`)
    REFERENCES `megamanx`.`player` (`player_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `megamanx`.`rel_player_weapon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `megamanx`.`rel_player_weapon` (
  `rel_player_weapon_id` INT(11) NOT NULL AUTO_INCREMENT,
  `player_id` INT(11) NOT NULL,
  `weapon_id` INT(11) NOT NULL,
  PRIMARY KEY (`rel_player_weapon_id`),
  UNIQUE INDEX `rel_player_weapon_id_UNIQUE` (`rel_player_weapon_id` ASC) VISIBLE,
  INDEX `FK_PW_P_idx` (`player_id` ASC) VISIBLE,
  INDEX `FK_PW_W_idx` (`weapon_id` ASC) VISIBLE,
  CONSTRAINT `FK_PW_P`
    FOREIGN KEY (`player_id`)
    REFERENCES `megamanx`.`player` (`player_id`)
    ON DELETE CASCADE,
  CONSTRAINT `FK_PW_W`
    FOREIGN KEY (`weapon_id`)
    REFERENCES `megamanx`.`weapon` (`weapon_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `megamanx`.`x_armor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `megamanx`.`x_armor` (
  `x_armor_id` INT(11) NOT NULL AUTO_INCREMENT,
  `x_name` VARCHAR(45) NOT NULL,
  `head_id` INT(11) NOT NULL,
  `body_id` INT(11) NOT NULL,
  `arm_id` INT(11) NOT NULL,
  `foot_id` INT(11) NOT NULL,
  `image` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`x_armor_id`),
  UNIQUE INDEX `x_armor_id_UNIQUE` (`x_armor_id` ASC) VISIBLE,
  INDEX `FK_Arm_Collectible_idx` (`arm_id` ASC) VISIBLE,
  INDEX `FK_Body_Collectible_idx` (`body_id` ASC) VISIBLE,
  INDEX `FK_Foot_Collectible_idx` (`foot_id` ASC) VISIBLE,
  INDEX `FK_Head_Collectible_idx` (`head_id` ASC) VISIBLE,
  CONSTRAINT `FK_Arm_Collectible`
    FOREIGN KEY (`arm_id`)
    REFERENCES `megamanx`.`collectible` (`collectible_id`),
  CONSTRAINT `FK_Body_Collectible`
    FOREIGN KEY (`body_id`)
    REFERENCES `megamanx`.`collectible` (`collectible_id`),
  CONSTRAINT `FK_Foot_Collectible`
    FOREIGN KEY (`foot_id`)
    REFERENCES `megamanx`.`collectible` (`collectible_id`),
  CONSTRAINT `FK_Head_Collectible`
    FOREIGN KEY (`head_id`)
    REFERENCES `megamanx`.`collectible` (`collectible_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `megamanx` ;

-- -----------------------------------------------------
-- procedure Q_Get_Armor_By_ID
-- -----------------------------------------------------

DELIMITER $$
USE `megamanx`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Q_Get_Armor_By_ID`(
	IN _x_armor_id INT
)
BEGIN
	
    -- Armor details
    SELECT x_armor_id as id, x_name as 'name', image
    FROM x_armor
    WHERE x_armor_id = _x_armor_id;
    
    -- Games
	SELECT g.game_id as id, g.title, g.image
    FROM game g
    INNER JOIN collectible h
    ON g.game_id = h.game_id
    INNER JOIN collectible b
    ON g.game_id = b.game_id
    INNER JOIN collectible a
    ON g.game_id = a.game_id
    INNER JOIN collectible f
    ON g.game_id = f.game_id,
    x_armor x
    WHERE x.head_id = h.collectible_id
    AND x.body_id = b.collectible_id
    AND x.arm_id = a.collectible_id
    AND x.foot_id = f.collectible_id
    AND x.x_armor_id = _x_armor_id;
    
    -- Head
    SELECT h.collectible_id as id, h.c_name as 'name', h.description,
    s.stage_id, s.s_name as 'stage', h.image as 'image'
    FROM collectible h
    INNER JOIN stage s
    ON s.stage_id = h.stage_id
    INNER JOIN x_armor x
    ON x.head_id = h.collectible_id
    WHERE x.x_armor_id = _x_armor_id;
    
    -- Body
    SELECT b.collectible_id as id, b.c_name as 'name', b.description,
    s.stage_id, s.s_name as 'stage', b.image as 'image'
    FROM collectible b
    INNER JOIN stage s
    ON s.stage_id = b.stage_id
    INNER JOIN x_armor x
    ON x.body_id = b.collectible_id
    WHERE x.x_armor_id = _x_armor_id;
    
    -- Arm
    SELECT a.collectible_id as id, a.c_name as 'name', a.description,
    s.stage_id, s.s_name as 'stage', a.image as 'image'
    FROM collectible a
    INNER JOIN stage s
    ON s.stage_id = a.stage_id
    INNER JOIN x_armor x
    ON x.arm_id = a.collectible_id
    WHERE x.x_armor_id = _x_armor_id;
    
    -- Foot
    SELECT f.collectible_id as id, f.c_name as 'name', f.description,
    s.stage_id, s.s_name as 'stage', f.image as 'image'
    FROM collectible f
    INNER JOIN stage s
    ON s.stage_id = f.stage_id
    INNER JOIN x_armor x
    ON x.foot_id = f.collectible_id
    WHERE x.x_armor_id = _x_armor_id;
    
END$$

DELIMITER ;

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
	
    -- Boss details
    SELECT boss_id as id, b_name as 'name', 
    description, image
    FROM boss
    WHERE boss_id = _boss_id;
    
    -- Games
    SELECT g.game_id, g.title, g.image,
    gb.hp, s.stage_id, s.s_name as 'stage'
    FROM rel_game_boss gb
    INNER JOIN game g
    ON g.game_id = gb.game_id
    INNER JOIN stage s
    ON s.stage_id = gb.stage_id
    WHERE gb.boss_id = _boss_id;
    
    -- Weapons
    SELECT weapon_id, w_name as 'weapon', image
    FROM weapon
    WHERE boss_id = _boss_id;
    
    -- Weaknesses
    SELECT bw.game_id, wk.weapon_id as weakness_id, wk.w_name as weakness, wk.image
    FROM weapon wk
    INNER JOIN rel_boss_weapon bw
    ON wk.weapon_id = bw.weapon_id
    WHERE bw.boss_id = _boss_id
    AND bw.weakness = 1;
    
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Q_Get_Collectible_By_ID
-- -----------------------------------------------------

DELIMITER $$
USE `megamanx`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Q_Get_Collectible_By_ID`(
	IN _collectible_id INT
)
BEGIN

	-- Collectible details
    SELECT c.collectible_id as id, c.c_name as 'name', c.description, c.image,
    g.game_id, g.title as game, g.image as 'g_image',
    s.stage_id, s.s_name as stage, s.image as 's_image'
    FROM collectible c
    INNER JOIN game g
    ON g.game_id = c.game_id
    INNER JOIN stage s
    ON s.stage_id = c.stage_id
    WHERE c.collectible_id = _collectible_id;

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

	-- Game details
	SELECT game_id as id, title, release_date,
    story, platforms, image
    FROM game
    WHERE game_id = _game_id;
    
    -- Players
    SELECT p.player_id as id, p_name as 'name', image
    FROM player p
    INNER JOIN rel_game_player gp
    ON p.player_id = gp.player_id
    WHERE gp.game_id = _game_id;
    
    -- Stages
    SELECT s.stage_id, s.s_name as 'name', s.image
    FROM stage s
    INNER JOIN collectible c
    ON s.stage_id = c.stage_id
    WHERE c.game_id = _game_id
    GROUP BY s.stage_id;
    
    -- Armors
    SELECT x.x_armor_id, x.x_name as 'name', x.image,
    h.collectible_id as 'head_id', h.c_name as 'head', h.image as 'head_image',
    b.collectible_id as 'body_id', b.c_name as 'body', b.image as 'body_image',
    a.collectible_id as 'arm_id', a.c_name as 'arm', a.image as 'arm_image',
    f.collectible_id as 'foot_id', f.c_name as 'foot', f.image as 'foot_image'
    FROM x_armor x
    INNER JOIN collectible h
    ON x.head_id = h.collectible_id
    INNER JOIN collectible b
    ON x.body_id = b.collectible_id
    INNER JOIN collectible a
    ON x.arm_id = a.collectible_id
    INNER JOIN collectible f
    ON x.foot_id = f.collectible_id
    WHERE h.game_id = _game_id
    AND b.game_id = _game_id
    AND a.game_id = _game_id
    AND f.game_id = _game_id;
    
    -- Weakness Chart
    SELECT b.boss_id, b.b_name as 'boss',
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
    AND bw.game_id = _game_id
    AND bw.weakness = 1;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Q_Get_Player_By_ID
-- -----------------------------------------------------

DELIMITER $$
USE `megamanx`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Q_Get_Player_By_ID`(
	IN _player_id INT
)
BEGIN
	
    -- Player details
    SELECT player_id as id, p_name as 'name', description,
    gender, image
    FROM player
    WHERE player_id = _player_id;
    
    -- Main weapons
    SELECT w.weapon_id as id, w.w_name as weapon, w.image as image
    FROM weapon w
    INNER JOIN rel_player_weapon pw
    ON w.weapon_id = pw.weapon_id
    WHERE pw.player_id = _player_id
    AND w.boss_id IS NULL;
    
    -- Games
    SELECT g.game_id as id, g.title, g.image
    FROM game g
    INNER JOIN rel_game_player gp
    ON g.game_id = gp.game_id
    WHERE gp.player_id = _player_id;
    
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Q_Get_Stage_By_ID
-- -----------------------------------------------------

DELIMITER $$
USE `megamanx`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Q_Get_Stage_By_ID`(
	IN _stage_id INT
)
BEGIN

	-- Stage details
    SELECT stage_id as id, s_name as 'name', description, image
    FROM stage
    WHERE stage_id = _stage_id;
    
    -- Boss
    SELECT b.boss_id, b.b_name as 'name', b.image
    FROM boss b
    INNER JOIN rel_game_boss gb
    ON gb.boss_id = b.boss_id
    WHERE gb.stage_id = _stage_id;
    
    -- Games
    SELECT g.game_id, g.title, g.image
    FROM game g
    INNER JOIN rel_game_boss gb
    ON gb.game_id = g.game_id
    WHERE gb.stage_id = _stage_id;
    
    -- Collectibles
    SELECT collectible_id as id, c_name as 'name', image,
    game_id
    FROM collectible
    WHERE stage_id = _stage_id;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Q_Get_Weapon_By_ID
-- -----------------------------------------------------

DELIMITER $$
USE `megamanx`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Q_Get_Weapon_By_ID`(
	IN _weapon_id INT
)
BEGIN
    
    DECLARE cursor_id INT;
    DECLARE cursor_title VARCHAR(45);
    DECLARE cursor_image VARCHAR(45);
    DECLARE done INT DEFAULT FALSE;

	DECLARE cursor_g CURSOR FOR 
    SELECT g.game_id, g.title as 'game', g.image
    FROM game g
    INNER JOIN rel_boss_weapon bw
    ON g.game_id = bw.game_id
    WHERE bw.weapon_id = _weapon_id
    GROUP BY g.game_id;
    
    DECLARE cursor_g2 CURSOR FOR
    SELECT g.game_id, g.title as 'game', g.image
    FROM game g
    INNER JOIN rel_boss_weapon bw
    ON g.game_id = bw.game_id
    WHERE bw.weapon_id = _weapon_id
    GROUP BY g.game_id;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	-- Weapon details
    SELECT weapon_id as id, w_name as 'name', image
    FROM weapon
    WHERE weapon_id = _weapon_id;
    
    -- Games
    CREATE TEMPORARY TABLE w_games
    SELECT g.game_id, g.title as 'game', g.image
    FROM game g
    INNER JOIN rel_boss_weapon bw
    ON g.game_id = bw.game_id
    WHERE bw.weapon_id = _weapon_id
    GROUP BY g.game_id;
    
    SELECT * FROM w_games;
    DROP TEMPORARY TABLE w_games;
    
    -- Players
    CREATE TEMPORARY TABLE w_players
    (player_id INT, name VARCHAR(45), image VARCHAR(45));
    
    OPEN cursor_g;
    games_loop : LOOP
		FETCH cursor_g INTO cursor_id, cursor_title, cursor_image;
        IF done THEN
			LEAVE games_loop;
		END IF;
        INSERT INTO w_players
        SELECT p.player_id, p.p_name as 'name', p.image
        FROM player p
        INNER JOIN rel_game_player gp
        ON p.player_id = gp.player_id
        WHERE gp.game_id = cursor_id;
	END LOOP;
	CLOSE cursor_g;
    
    SELECT * FROM w_players GROUP BY player_id;
    DROP TEMPORARY TABLE w_players;
    
    -- Boss
    SELECT b.boss_id, b.b_name as 'name', b.image
    FROM boss b
    INNER JOIN weapon w
    ON b.boss_id = w.boss_id
    WHERE w.weapon_id = _weapon_id;
    
    -- Damage Chart
    CREATE TEMPORARY TABLE w_damage_chart
    (game_id INT, boss_id INT, boss VARCHAR(45), base_damage INT, charged_damage INT, weakness BIT);
    
    SET done = FALSE;
    
    OPEN cursor_g2;
    games_loop2 : LOOP
		FETCH cursor_g2 INTO cursor_id, cursor_title, cursor_image;
        IF done THEN
			LEAVE games_loop2;
		END IF;
        INSERT INTO w_damage_chart
        SELECT bw.game_id, b.boss_id, b.b_name as boss, 
        bw.base_damage, bw.charged_damage, bw.weakness
        FROM rel_boss_weapon bw
        INNER JOIN boss b
        ON b.boss_id = bw.boss_id
        WHERE bw.weapon_id = _weapon_id
        AND bw.game_id = cursor_id;
	END LOOP;
    CLOSE cursor_g2;
    
	SELECT * FROM w_damage_chart;
    DROP TEMPORARY TABLE w_damage_chart;
    
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Q_Insert_Armor
-- -----------------------------------------------------

DELIMITER $$
USE `megamanx`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Q_Insert_Armor`(
	IN _x_name VARCHAR(45),
    IN _head_id INT,
    IN _body_id INT,
    IN _arm_id INT,
    IN _foot_id INT,
    IN _image VARCHAR(45)
)
BEGIN

	DECLARE _count_head INT;
    DECLARE _count_body INT;
    DECLARE _count_arm INT;
    DECLARE _count_foot INT;
    
    
    SET _count_head = (SELECT COUNT(*) FROM collectible WHERE collectible_id = _head_id);
    SET _count_body = (SELECT COUNT(*) FROM collectible WHERE collectible_id = _body_id);
    SET _count_arm = (SELECT COUNT(*) FROM collectible WHERE collectible_id = _arm_id);
    SET _count_foot = (SELECT COUNT(*) FROM collectible WHERE collectible_id = _foot_id);
    
    IF _count_head = 0 THEN
		SELECT _count_head as id, 'There is no such head collectible.' as message;
	ELSEIF _count_body = 0 THEN
		SELECT _count_body as id, 'There is no such body collectible.' as message;
	ELSEIF _count_arm = 0 THEN
		SELECT _count_arm as id, 'There is no such arm collectible.' as message;
	ELSEIF _count_foot = 0 THEN
		SELECT _count_foot as id, 'There is no such feet collectible.' as message;
	ELSE 
		INSERT INTO x_armor
        (x_name,
		head_id,
		body_id,
		arm_id,
		foot_id,
		image
        )
        VALUES
        (_x_name,
		_head_id,
		_body_id,
		_arm_id,
		_foot_id,
		_image
        );
        
        SELECT LAST_INSERT_ID() as id, 'Success' as message;
    END IF;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Q_Insert_Boss
-- -----------------------------------------------------

DELIMITER $$
USE `megamanx`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Q_Insert_Boss`(
	IN _b_name VARCHAR(45),
    IN _description TEXT,
    IN _image VARCHAR(45)
)
BEGIN

	INSERT INTO boss
    (b_name,
    description,
    image
    ) 
    VALUES 
	(_b_name,
    _description,
    _image
    );
    
    SELECT LAST_INSERT_ID() as id;
    
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Q_Insert_Boss_Weapon
-- -----------------------------------------------------

DELIMITER $$
USE `megamanx`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Q_Insert_Boss_Weapon`(
	IN _boss_id INT,
    IN _weapon_id INT,
    IN _game_id INT,
    IN _base_damage INT,
    IN _charged_damage INT,
    IN _weakness INT
)
BEGIN
	
    DECLARE _count_boss INT;
    DECLARE _count_weapon INT;
	DECLARE _count_game INT;
    
    SET _count_boss = (SELECT COUNT(*) FROM boss WHERE boss_id = _boss_id);
    SET _count_weapon = (SELECT COUNT(*) FROM weapon WHERE weapon_id = _weapon_id);
	SET _count_game = (SELECT COUNT(*) FROM game WHERE game_id = _game_id);
    
	IF _count_boss = 0 THEN
		SELECT _count_boss as id, 'There is no such boss.' as message;
	ELSEIF _count_weapon = 0 THEN
		SELECT _count_weapon as id, 'There is no such weapon.' as message;
	ELSEIF _count_game = 0 THEN
		SELECT _count_game as id, 'There is no such game.' as message;
	ELSE
		IF _charged_damage = 0 THEN
			INSERT INTO rel_boss_weapon
            (boss_id,
			weapon_id,
			game_id,
			base_damage,
			weakness
            )
            VALUES
            (_boss_id,
			_weapon_id,
			_game_id,
			_base_damage,
			_weakness
            );
            
            SELECT LAST_INSERT_ID() as id, 'Success' as message;
        ELSE
			INSERT INTO rel_boss_weapon
            (boss_id,
			weapon_id,
			game_id,
			base_damage,
			charged_damage,
			weakness
            )
            VALUES
            (_boss_id,
			_weapon_id,
			_game_id,
			_base_damage,
			_charged_damage,
			_weakness
            );
            
            SELECT LAST_INSERT_ID() as id, 'Success' as message;
        END IF;
    END IF;
    
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Q_Insert_Collectible
-- -----------------------------------------------------

DELIMITER $$
USE `megamanx`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Q_Insert_Collectible`(
	IN _c_name VARCHAR(45),
    IN _description TEXT,
    IN _image VARCHAR(45),
    IN _stage_id INT,
    IN _game_id INT
)
BEGIN

	DECLARE _count_stage INT;
    DECLARE _count_game INT;
    
    SET _count_stage = (SELECT COUNT(*) FROM stage WHERE stage_id = _stage_id);
    SET _count_game = (SELECT COUNT(*) FROM game WHERE game_id = _game_id);
    
    IF _count_stage = 0 THEN
		SELECT _count_stage as id, 'There is no such stage.' as message;
	ELSEIF _count_game = 0 THEN
		IF _stage_id = 0 THEN
			INSERT INTO collectible
			(c_name,
			description,
			image,
			stage_id,
			game_id
			)
			VALUES
			(_c_name,
			_description,
			_image,
			NULL,
			_game_id
			);
        
			SELECT LAST_INSERT_ID() as id, 'Success' as message;
		ELSE
			SELECT _count_game as id, 'There is no such game.' as message;
        END IF;
	ELSE 
		INSERT INTO collectible
        (c_name,
		description,
		image,
		stage_id,
        game_id
        )
        VALUES
        (_c_name,
		_description,
		_image,
		_stage_id,
        _game_id
        );
        
        SELECT LAST_INSERT_ID() as id, 'Success' as message;
    END IF;

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
    IN _platforms VARCHAR(255),
    IN _image VARCHAR(45)
)
    READS SQL DATA
    DETERMINISTIC
BEGIN
	
    INSERT INTO game 
    (title, 
    release_date, 
    story,
    platforms, 
    image) 
    VALUES
    (_title, 
    _release_date, 
    _story,
    _platforms,
    _image);
    
    SELECT LAST_INSERT_ID() as id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Q_Insert_Game_Boss
-- -----------------------------------------------------

DELIMITER $$
USE `megamanx`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Q_Insert_Game_Boss`(
	IN _game_id INT,
    IN _boss_id INT,
    IN _hp INT,
    IN _stage_id INT
)
BEGIN

	DECLARE _count_game INT;
    DECLARE _count_boss INT;
	DECLARE _count_stage INT;
    
    SET _count_game = (SELECT COUNT(*) FROM game WHERE game_id = _game_id);
    SET _count_boss = (SELECT COUNT(*) FROM boss WHERE boss_id = _boss_id);
    SET _count_stage = (SELECT COUNT(*) FROM stage WHERE stage_id = _stage_id);

	IF _count_game = 0 THEN
		SELECT _count_game as id, 'There is no such game.' as message;
	ELSEIF _count_boss = 0 THEN
		SELECT _count_boss as id, 'There is no such boss.' as message;
	ELSEIF _count_stage = 0 THEN
		SELECT _count_stage as id, 'There is no such stage.' as message;
	ELSE 
		INSERT INTO rel_game_boss
		(game_id,
		boss_id,
		hp,
		stage_id
		) 
		VALUES 
		(_game_id,
		_boss_id,
		_hp,
		_stage_id
		);

		SELECT LAST_INSERT_ID() as id, 'Success' as message;
	END IF;
    
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Q_Insert_Game_Player
-- -----------------------------------------------------

DELIMITER $$
USE `megamanx`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Q_Insert_Game_Player`(
	IN _game_id INT,
    IN _player_id INT
)
BEGIN

	DECLARE _count_game INT;
    DECLARE _count_player INT;
	SET _count_game = (SELECT COUNT(*) FROM game WHERE game_id = _game_id);
    SET _count_player = (SELECT COUNT(*) FROM player WHERE player_id = _player_id);

	IF _count_game = 0 THEN
		SELECT _count_game as id, 'There is no such game.' as message;
	ELSEIF _count_player = 0 THEN
		SELECT _count_player as id, 'There is no such player.' as message;
	ELSE
		INSERT INTO rel_game_player
        (game_id,
		player_id
        )
        VALUES
        (_game_id,
		_player_id
        );
        
        SELECT LAST_INSERT_ID() as id, 'Success' as message;
    END IF;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Q_Insert_Player
-- -----------------------------------------------------

DELIMITER $$
USE `megamanx`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Q_Insert_Player`(
	IN _p_name VARCHAR(45),
    IN _description TEXT,
    IN _gender VARCHAR(2),
    IN _image VARCHAR(45)
)
BEGIN
	INSERT INTO player
	(p_name,
    description,
    gender,
    image
	)
	VALUES
	(_p_name,
    _description,
    _gender,
    _image
	);
	
	SELECT LAST_INSERT_ID() as id, 'Success' as message;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Q_Insert_Player_Weapon
-- -----------------------------------------------------

DELIMITER $$
USE `megamanx`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Q_Insert_Player_Weapon`(
	IN _player_id INT,
    IN _weapon_id INT
)
BEGIN
	
    DECLARE _count_player INT;
    DECLARE _count_weapon INT;
    
    SET _count_player = (SELECT COUNT(*) FROM player WHERE player_id = _player_id);
	SET _count_weapon = (SELECT COUNT(*) FROM weapon WHERE weapon_id = _weapon_id);
    
    IF _count_player = 0 THEN
		SELECT _count_player as id, 'There is no such player.' as message;
	ELSEIF _count_weapon = 0 THEN
		SELECT _count_weapon as id, 'There is no such weapon.' as message;
	ELSE
		INSERT INTO rel_player_weapon
        (player_id,
		weapon_id
        )
        VALUES
        (_player_id,
		_weapon_id
        );
        
        SELECT LAST_INSERT_ID() as id, 'Success' as message;
    END IF;
        
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Q_Insert_Stage
-- -----------------------------------------------------

DELIMITER $$
USE `megamanx`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Q_Insert_Stage`(
	IN _s_name VARCHAR(45),
    IN _description TEXT,
    IN _image VARCHAR(45)
)
BEGIN

	INSERT INTO stage
	(s_name,
	description,
	image
	)
	VALUES
	(_s_name,
	_description,
	_image
	);
	
	SELECT LAST_INSERT_ID() as id, 'Success' as message;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Q_Insert_Weapon
-- -----------------------------------------------------

DELIMITER $$
USE `megamanx`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Q_Insert_Weapon`(
	IN _w_name VARCHAR(45),
    IN _image VARCHAR(45),
    IN _boss_id INT
)
BEGIN
	
    DECLARE _count_boss INT;
	SET _count_boss = (SELECT COUNT(*) FROM boss WHERE boss_id = _boss_id);
    
    IF _boss_id = 0 THEN
        INSERT INTO weapon
        (w_name,
        image,
        boss_id
        )
        VALUES
        (_w_name,
        _image,
        NULL
        );
        
        SELECT LAST_INSERT_ID() as id, 'Success' as message;
    ELSE
		IF _count_boss = 0 THEN
			SELECT _count_boss as id, 'There is no such boss.' as message;
		ELSE
			INSERT INTO weapon
			(w_name,
			image,
            boss_id
			)
			VALUES
			(_w_name,
			_image,
            _boss_id
			);
        
			SELECT LAST_INSERT_ID() as id, 'Success' as message;
        END IF;
    END IF;
    
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
