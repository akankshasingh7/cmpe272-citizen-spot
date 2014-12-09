/*
 Navicat Premium Data Transfer

 Source Server         : bonnie
 Source Server Type    : MySQL
 Source Server Version : 50536
 Source Host           : localhost
 Source Database       : citizenspot

 Target Server Type    : MySQL
 Target Server Version : 50536
 File Encoding         : utf-8

 Date: 12/09/2014 11:22:25 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `area`
-- ----------------------------
DROP TABLE IF EXISTS `area`;
CREATE TABLE `area` (
  `id` int(11) NOT NULL,
  `addressLine1` varchar(60) DEFAULT NULL,
  `street` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `zipcode` varchar(45) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `area`
-- ----------------------------
BEGIN;
INSERT INTO `area` VALUES ('1', 'adre1', 'str1', 'mountain view', 'ca', '95113', 'usa'), ('2', 'adr2', 'str2', 'sunnyvale', 'ca', '91101', 'usa');
COMMIT;

-- ----------------------------
--  Table structure for `problem`
-- ----------------------------
DROP TABLE IF EXISTS `problem`;
CREATE TABLE `problem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) DEFAULT NULL,
  `problem_name` varchar(45) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `image` varchar(500) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `side_of_road` varchar(45) DEFAULT NULL,
  `severity` int(11) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `latitude` float(10,6) DEFAULT NULL,
  `longitude` float(10,6) DEFAULT NULL,
  `address_line` varchar(60) DEFAULT NULL,
  `street` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `zipcode` varchar(45) NOT NULL,
  `uploaded_by` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type_id_idx` (`type_id`),
  CONSTRAINT `type_id` FOREIGN KEY (`type_id`) REFERENCES `problemtype` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `problem`
-- ----------------------------
BEGIN;
INSERT INTO `problem` VALUES ('12', '3', 'bp', 'draft', 'http://res.cloudinary.com/dtcvcuxvl/image/upload/v1418124590/2014034395e9b7f08b7f4c32a967ab3f41f78025.jpg', '2014-12-09', null, '1', '0', '0.000000', '0.000000', null, 'st1', 'ct1', 'stt1', '123', 'asd'), ('13', '2', 'pt', 'try', 'http://res.cloudinary.com/dtcvcuxvl/image/upload/v1418125118/201403432979621beb4044089c53c23ea7233875.jpg', '2014-12-01', null, '0', '0', '0.000000', '0.000000', null, 'asdasd', 'afasfsfa', 'aswer', '123', 'asd'), ('14', '2', 'pt', 'try', 'http://res.cloudinary.com/dtcvcuxvl/image/upload/v1418125161/2014034335b34c39e6314ea68d6ff06ccee0eea1.jpg', '2014-12-01', null, '0', '0', '0.000000', '0.000000', null, 'asdasd', 'afasfsfa', 'aswer', '123', 'asd'), ('15', '4', 'asd', 'try', 'http://res.cloudinary.com/dtcvcuxvl/image/upload/v1418125583/2014034307136744acbb4cc7a4817e3d9b416359.jpg', '2014-12-09', 'left', '2', '0', '0.000000', '0.000000', null, 'st1', 'ct1', 'stt1', '124', 'asd');
COMMIT;

-- ----------------------------
--  Table structure for `problemtype`
-- ----------------------------
DROP TABLE IF EXISTS `problemtype`;
CREATE TABLE `problemtype` (
  `id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `problemtype`
-- ----------------------------
BEGIN;
INSERT INTO `problemtype` VALUES ('1', 'Pothole', 'Report a Pothole problem '), ('2', 'Traffic Sign', 'Report Missing or Damaged Traffic Sign'), ('3', 'Traffic Signal', 'Report Malfunctioning Traffic Signal'), ('4', 'Streetlight', 'Report a Streetlight not working'), ('5', 'Sign pole', 'Report a Damaged Sign Pole'), ('6', 'Banner', 'Report a Damaged Banner');
COMMIT;

-- ----------------------------
--  Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_type` varchar(60) DEFAULT NULL,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `email_id` varchar(100) NOT NULL,
  `password` varchar(450) NOT NULL,
  `adressLine1` varchar(50) DEFAULT NULL,
  `street` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `zipcode` varchar(45) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_id` (`email_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `user`
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES ('1', 'user', 'Mac', 'Rull', 'mac.rull@gmail.com', 'GMsUbkVinVrd8K7ayex4eOxGOYosMi6Ijca2XuEWT6c=#$#PJlJxS2xAgNhlgY9BKhsWkwVacdpmEvd5llnEIC7+ss=', '309,Mont Apt', 'Continental Circle', 'Mountain View', 'CA', '94040', 'NULL'), ('2', 'user', 'asd', 'asd', 'a', 'GMsUbkVinVrd8K7ayex4eOxGOYosMi6Ijca2XuEWT6c=#$#PJlJxS2xAgNhlgY9BKhsWkwVacdpmEvd5llnEIC7+ss=', null, null, null, null, null, null), ('3', 'user', 'Manami', 'Bhunia', 'asd', 'GMsUbkVinVrd8K7ayex4eOxGOYosMi6Ijca2XuEWT6c=#$#PJlJxS2xAgNhlgY9BKhsWkwVacdpmEvd5llnEIC7+ss=', 'st1', 'st2', 'ct', 'stt', '12412', 'USA');
COMMIT;

-- ----------------------------
--  Table structure for `user_problem`
-- ----------------------------
DROP TABLE IF EXISTS `user_problem`;
CREATE TABLE `user_problem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `problem_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `problem_id_idx` (`problem_id`),
  KEY `user_id_idx` (`user_id`),
  CONSTRAINT `problem_id` FOREIGN KEY (`problem_id`) REFERENCES `problem` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `user_problem`
-- ----------------------------
BEGIN;
INSERT INTO `user_problem` VALUES ('1', '1', null);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
