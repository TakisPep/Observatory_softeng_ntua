CREATE SCHEMA `observatory`;

USE `observatory`;

CREATE TABLE `Avatar` (
	`Avatar_id` BIGINT NOT NULL AUTO_INCREMENT,
	`Avatar_path` VARCHAR(100) NOT NULL,
	PRIMARY KEY (`Avatar_id`),
	UNIQUE (`Avatar_path`)
);

CREATE TABLE `Volunteer` (
  `Volunteer_id` BIGINT NOT NULL AUTO_INCREMENT,
	`Token` VARCHAR(10),
  `Username` VARCHAR(50) NOT NULL,
  `Password` VARCHAR(255) NOT NULL,
  `FirstName` VARCHAR(50),
  `LastName` VARCHAR(50),
  `Email` VARCHAR(50),
  `Ranking` INT NOT NULL DEFAULT 0,
  `Avatar_id` BIGINT,
  PRIMARY KEY (`Volunteer_id`),
  FOREIGN KEY (`Avatar_id`) REFERENCES `Avatar` (`Avatar_id`),
	UNIQUE (`Volunteer_id`, `Email`),
	UNIQUE (`Volunteer_id`, `Username`),	
	UNIQUE (`Volunteer_id`, `Email`)
);

CREATE TABLE `Company` (
  `Company_id` BIGINT NOT NULL AUTO_INCREMENT,
	`Token` VARCHAR(10),
  `Name` VARCHAR(50) NOT NULL,
  `Password` VARCHAR(255),
  `Rewarding` INT DEFAULT 0,
  `Address` VARCHAR(100),
  `Lng` DOUBLE NOT NULL,
  `Lat` DOUBLE NOT NULL,
	`Withdrawn` VARCHAR(20) DEFAULT "false",
  `Site_link` VARCHAR(255),
  `Ranking` INT DEFAULT 0,
  `Avatar_id` BIGINT,
  PRIMARY KEY (`Company_id`),
	UNIQUE (`Name`),
	UNIQUE (`Site_link`)
);

CREATE TABLE `Observation` (
  `Observation_id` BIGINT NOT NULL AUTO_INCREMENT,
	`Volunteer_id` BIGINT,
	`Name` VARCHAR(100) NOT NULL,
	`Withdrawn` VARCHAR(13) DEFAULT "false",
  `Location` VARCHAR(255),
  `Company_name` VARCHAR(50),
  `Description` VARCHAR(255),
  `Ranking` INT DEFAULT 0,
  `Cheer_count` INT DEFAULT 0,
	`X` DOUBLE,
	`Y` DOUBLE,
	`Validation` VARCHAR(6) DEFAULT "NO",
	`Company_id` BIGINT,
	`Category` VARCHAR(20) NOT NULL,
	`Stars` INT,	 
	PRIMARY KEY (`Observation_id`),
  FOREIGN KEY (`Company_id`) REFERENCES `Company` (`Company_id`) ON DELETE CASCADE,
	FOREIGN KEY (`Volunteer_id`) REFERENCES `Volunteer` (`Volunteer_id`) ON DELETE CASCADE
);

CREATE TABLE `Amenities` (
  `Observation_id` BIGINT NOT NULL,
  `Amenity` VARCHAR(100) NOT NULL,
  FOREIGN KEY (`Observation_id`) REFERENCES `Observation` (`Observation_id`) ON DELETE CASCADE,
	UNIQUE KEY(`Observation_id`, `Amenity`)
);

CREATE TABLE `Photo` (
  `Observation_id` BIGINT NOT NULL,
  `Path` VARCHAR(255) NOT NULL,
  FOREIGN KEY (`Observation_id`) REFERENCES `Observation` (`Observation_id`) ON DELETE CASCADE,
	UNIQUE KEY(`Observation_id`, `Path`)
);

CREATE TABLE `Click_observation` (
  `Observation_id` BIGINT NOT NULL,
  `Click_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`Observation_id`) REFERENCES `Observation` (`Observation_id`) ON DELETE CASCADE
);

CREATE TABLE `Comment_observation` (
	`Comment_id` BIGINT NOT NULL AUTO_INCREMENT,
  `Observation_id` BIGINT NOT NULL,
	`Volunteer_id` BIGINT NOT NULL,
	`Comment` VARCHAR(150) NOT NULL,
	`Count_likes` INT NOT NULL DEFAULT 0,
	`Date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`Comment_id`),
  FOREIGN KEY (`Observation_id`) REFERENCES `Observation` (`Observation_id`) ON DELETE CASCADE,
	FOREIGN KEY (`Volunteer_id`) REFERENCES `Volunteer` (`Volunteer_id`) ON DELETE CASCADE
);

CREATE TABLE `App` (
  `Avatar` VARCHAR(255) NOT NULL,
  `Rating` DOUBLE,
	`Email` VARCHAR(50) NOT NULL
);

CREATE TABLE `Comment_app` (
	`Comment_id` BIGINT NOT NULL AUTO_INCREMENT,
	`Volunteer_id` BIGINT NOT NULL,
	`Comment` VARCHAR(255) NOT NULL,
	`Count_likes` INT NOT NULL DEFAULT 0,
	`Date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`Comment_id`),
	FOREIGN KEY (`Volunteer_id`) REFERENCES `Volunteer` (`Volunteer_id`) ON DELETE CASCADE
);

CREATE TABLE `Click_company` (
  `Company_id` BIGINT NOT NULL,
  `Click_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`Company_id`) REFERENCES `Company` (`Company_id`) ON DELETE CASCADE
);

CREATE TABLE `Email` (
  `Email` VARCHAR(50) NOT NULL,
  `Company_id` BIGINT NOT NULL,
  FOREIGN KEY (`Company_id`) REFERENCES `Company` (`Company_id`) ON DELETE CASCADE,
	UNIQUE (`Email`)
);

CREATE TABLE `Telephone_number` (
  `Number` INT NOT NULL,
  `Company_id` BIGINT NOT NULL,
  FOREIGN KEY (`Company_id`) REFERENCES `Company` (`Company_id`) ON DELETE CASCADE,
	 UNIQUE (`Number`)
);

CREATE TABLE `Offer` (
  `Offer_id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `Company_id` BIGINT NOT NULL,
  `Price` DOUBLE NOT NULL,
  `Brand` VARCHAR(30) NOT NULL,
  `Model` VARCHAR(50) NOT NULL,
  `Category` VARCHAR(50) NOT NULL,
  `Location` VARCHAR(50) NOT NULL,
  `Date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Stars` INT NOT NULL,
  `Cheer_count` INT NOT NULL,
  `X` DOUBLE NOT NULL,
  `Y` DOUBLE NOT NULL,
   FOREIGN KEY (`Company_id`) REFERENCES `Company` (`Company_id`) ON DELETE CASCADE
);

CREATE TABLE `Click_offer` (
  `Offer_id` BIGINT NOT NULL,
  `Click_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`Offer_id`) REFERENCES `Offer` (`Offer_id`) ON DELETE CASCADE
);


CREATE TABLE `Price` (
	`Price_id` BIGINT NOT NULL AUTO_INCREMENT,
	`Price` Double NOT NULL,
	`Date` Varchar(10) NOT NULL,
	`Observation_id` BIGINT NOT NULL,
	`Company_id` BIGINT NOT NULL,
	PRIMARY KEY (`Price_id`),
  FOREIGN KEY (`Observation_id`) REFERENCES `Observation` (`Observation_id`) ON DELETE CASCADE,
	FOREIGN KEY (`Company_id`) REFERENCES `Company` (`Company_id`) ON DELETE CASCADE
);


CREATE TABLE `Admin` (
	`Password` VARCHAR(255)
);

CREATE TABLE `Amenities_offer` (
  `Amenity` VARCHAR(50) NOT NULL,
  `Offer_id` BIGINT NOT NULL,
  FOREIGN KEY (`Offer_id`) REFERENCES `Offer` (`Offer_id`) ON DELETE CASCADE,
	UNIQUE (`Amenity`, `Offer_id`)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
