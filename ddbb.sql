-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.1.26-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win32
-- HeidiSQL Versión:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para epidemic-zombiedb
CREATE DATABASE IF NOT EXISTS `epidemic-zombiedb` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `epidemic-zombiedb`;

-- Volcando estructura para tabla epidemic-zombiedb.allowed_character_creator_models
CREATE TABLE IF NOT EXISTS `allowed_character_creator_models` (
  `model_name` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`model_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla epidemic-zombiedb.buildings
CREATE TABLE IF NOT EXISTS `buildings` (
  `id` int(10) NOT NULL DEFAULT '0',
  `name` varchar(100) DEFAULT NULL,
  `use_blip` int(10) NOT NULL,
  `blip_id` int(100) DEFAULT NULL,
  `blip_x` float DEFAULT NULL,
  `blip_y` float DEFAULT NULL,
  `blip_z` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla epidemic-zombiedb.characters
CREATE TABLE IF NOT EXISTS `characters` (
  `id` int(11) NOT NULL DEFAULT '0',
  `player_id` int(11) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `faction_id` int(11) DEFAULT NULL,
  `player_model` varchar(100) DEFAULT NULL,
  `money` int(11) DEFAULT NULL,
  `job` int(11) DEFAULT NULL,
  `phone_number` varchar(11) DEFAULT NULL,
  `spawn_house_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla epidemic-zombiedb.character_tickets
CREATE TABLE IF NOT EXISTS `character_tickets` (
  `id` int(11) NOT NULL,
  `issuer_name` varchar(100) NOT NULL,
  `character_id` int(11) NOT NULL,
  `fine` int(11) NOT NULL,
  `reason` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla epidemic-zombiedb.ez_admin
CREATE TABLE IF NOT EXISTS `ez_admin` (
  `ID` int(11) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Contraseña` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Username` (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla epidemic-zombiedb.ez_general
CREATE TABLE IF NOT EXISTS `ez_general` (
  `Mantenimiento` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla epidemic-zombiedb.ez_tickets
CREATE TABLE IF NOT EXISTS `ez_tickets` (
  `id` int(11) NOT NULL,
  `user` varchar(20) DEFAULT NULL,
  `title` varchar(30) DEFAULT NULL,
  `message` varchar(250) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '1º Abierta , 2º Proceso, 3º Cerrada',
  `admin` varchar(50),
  PRIMARY KEY (`id`),
  KEY `FK_ez_tickets_ez_users` (`user`),
  KEY `FK_ez_tickets_ez_admin` (`admin`),
  CONSTRAINT `FK_ez_tickets_ez_admin` FOREIGN KEY (`admin`) REFERENCES `ez_admin` (`Username`),
  CONSTRAINT `FK_ez_tickets_ez_users` FOREIGN KEY (`user`) REFERENCES `ez_users` (`nickname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla epidemic-zombiedb.ez_users
CREATE TABLE IF NOT EXISTS `ez_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(20) NOT NULL,
  `experience` int(11) NOT NULL,
  `money` int(11) NOT NULL,
  `lenguage` int(11) NOT NULL,
  `max_round` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nickname` (`nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla epidemic-zombiedb.ez_user_survivors
CREATE TABLE IF NOT EXISTS `ez_user_survivors` (
  `user_id` int(11) NOT NULL,
  `survivor1` int(11) NOT NULL DEFAULT '0',
  `survivor2` int(11) NOT NULL DEFAULT '0',
  `survivor3` int(11) NOT NULL DEFAULT '0',
  `survivor4` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `ez_user_survivors_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `ez_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla epidemic-zombiedb.ez_voucher
CREATE TABLE IF NOT EXISTS `ez_voucher` (
  `code` varchar(10) NOT NULL,
  `money` int(11) NOT NULL,
  `experience` int(11) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla epidemic-zombiedb.faction_ranks
CREATE TABLE IF NOT EXISTS `faction_ranks` (
  `character_id` int(100) NOT NULL,
  `rank_id` int(100) NOT NULL,
  `modelHash` varchar(100) NOT NULL,
  `faction_id` int(100) NOT NULL,
  PRIMARY KEY (`character_id`,`rank_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla epidemic-zombiedb.fishing_loot
CREATE TABLE IF NOT EXISTS `fishing_loot` (
  `itemId` int(255) NOT NULL,
  `chance` int(255) DEFAULT NULL,
  `fishing_area_type` int(255) NOT NULL,
  PRIMARY KEY (`itemId`,`fishing_area_type`),
  UNIQUE KEY `itemId_fishing_area_type` (`itemId`,`fishing_area_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla epidemic-zombiedb.fishing_spots
CREATE TABLE IF NOT EXISTS `fishing_spots` (
  `id` int(255) NOT NULL,
  `type` int(255) NOT NULL,
  `posX` float NOT NULL,
  `posY` float NOT NULL,
  `posZ` float NOT NULL,
  `rotX` float NOT NULL,
  `rotY` float NOT NULL,
  `rotZ` float NOT NULL,
  `scale` float NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla epidemic-zombiedb.houses
CREATE TABLE IF NOT EXISTS `houses` (
  `id` int(11) NOT NULL DEFAULT '0',
  `owner_id` int(11) DEFAULT NULL,
  `template_id` int(11) DEFAULT NULL,
  `name` varchar(111) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla epidemic-zombiedb.house_exits
CREATE TABLE IF NOT EXISTS `house_exits` (
  `id` int(11) NOT NULL DEFAULT '0',
  `house_template_id` int(11) DEFAULT NULL,
  `exitX` float DEFAULT NULL,
  `exitY` float DEFAULT NULL,
  `exitZ` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla epidemic-zombiedb.house_teleports
CREATE TABLE IF NOT EXISTS `house_teleports` (
  `id` int(11) NOT NULL DEFAULT '0',
  `building_id` int(11) DEFAULT NULL,
  `entranceX` float DEFAULT NULL,
  `entranceY` float DEFAULT NULL,
  `entranceZ` float DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla epidemic-zombiedb.house_teleport_links
CREATE TABLE IF NOT EXISTS `house_teleport_links` (
  `entrance_id` int(100) NOT NULL DEFAULT '0',
  `exit_id` int(100) NOT NULL DEFAULT '0',
  PRIMARY KEY (`entrance_id`,`exit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla epidemic-zombiedb.house_template
CREATE TABLE IF NOT EXISTS `house_template` (
  `id` int(11) NOT NULL DEFAULT '0',
  `building_id` int(11) DEFAULT NULL,
  `ipl` varchar(100) DEFAULT NULL,
  `house_name` varchar(100) DEFAULT NULL,
  `spawn_positionX` float DEFAULT NULL,
  `spawn_positionY` float DEFAULT NULL,
  `spawn_positionZ` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla epidemic-zombiedb.items
CREATE TABLE IF NOT EXISTS `items` (
  `owner_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`owner_id`,`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla epidemic-zombiedb.item_templates
CREATE TABLE IF NOT EXISTS `item_templates` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(50) NOT NULL,
  `field1` int(11) DEFAULT NULL,
  `field2` int(11) DEFAULT NULL,
  `field3` int(11) DEFAULT NULL,
  `field4` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla epidemic-zombiedb.jailed_characters
CREATE TABLE IF NOT EXISTS `jailed_characters` (
  `id` int(100) NOT NULL,
  `time` int(100) NOT NULL,
  `reason` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla epidemic-zombiedb.model_genders
CREATE TABLE IF NOT EXISTS `model_genders` (
  `model_name` varchar(50) NOT NULL DEFAULT '',
  `gender` int(11) DEFAULT NULL,
  PRIMARY KEY (`model_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla epidemic-zombiedb.phone_contacts
CREATE TABLE IF NOT EXISTS `phone_contacts` (
  `owner` int(11) NOT NULL DEFAULT '0',
  `name` varchar(11) DEFAULT NULL,
  `number` varchar(11) NOT NULL DEFAULT '',
  PRIMARY KEY (`owner`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla epidemic-zombiedb.players
CREATE TABLE IF NOT EXISTS `players` (
  `id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `admin_level` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla epidemic-zombiedb.random_house_sell_templates
CREATE TABLE IF NOT EXISTS `random_house_sell_templates` (
  `templateId` int(11) NOT NULL,
  `minPrice` int(11) NOT NULL,
  `maxPrice` int(11) NOT NULL,
  PRIMARY KEY (`templateId`),
  UNIQUE KEY `templateId` (`templateId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla epidemic-zombiedb.text_messages
CREATE TABLE IF NOT EXISTS `text_messages` (
  `id` int(11) NOT NULL DEFAULT '0',
  `sender_number` varchar(11) NOT NULL DEFAULT '',
  `receiver_number` varchar(100) NOT NULL DEFAULT '',
  `time` varchar(11) NOT NULL DEFAULT '',
  `message` varchar(1000) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla epidemic-zombiedb.vehicles
CREATE TABLE IF NOT EXISTS `vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ownedId` int(11) DEFAULT NULL,
  `factionId` int(11) DEFAULT NULL,
  `model` int(11) DEFAULT NULL,
  `park_x` float(10,0) DEFAULT NULL,
  `park_y` float(10,0) DEFAULT NULL,
  `park_z` float(10,0) DEFAULT NULL,
  `park_rot_x` float(10,0) DEFAULT NULL,
  `park_rot_y` float(10,0) DEFAULT NULL,
  `park_rot_z` float(10,0) DEFAULT NULL,
  `license_plate_text` varchar(100) DEFAULT NULL,
  `license_plate_style` int(11) DEFAULT NULL,
  `color1` int(11) DEFAULT NULL,
  `color2` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla epidemic-zombiedb.vehicle_prices
CREATE TABLE IF NOT EXISTS `vehicle_prices` (
  `model` varchar(100) NOT NULL DEFAULT '',
  `price` int(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`model`,`price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
