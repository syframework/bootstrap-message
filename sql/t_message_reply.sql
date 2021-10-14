/*
Navicat MySQL Data Transfer

Source Server         : eater
Source Server Version : 80020
Source Host           : localhost:3306
Source Database       : eater

Target Server Type    : MYSQL
Target Server Version : 80020
File Encoding         : 65001

Date: 2021-10-14 10:54:01
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_message_reply
-- ----------------------------
DROP TABLE IF EXISTS `t_message_reply`;
CREATE TABLE `t_message_reply` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `message_id` int unsigned NOT NULL,
  `message` varchar(2048) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `message_id` (`message_id`) USING BTREE,
  CONSTRAINT `t_message_reply_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_message_reply_ibfk_2` FOREIGN KEY (`message_id`) REFERENCES `t_message_received` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=229 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
DROP TRIGGER IF EXISTS `tg_message_reply_delete`;
DELIMITER ;;
CREATE TRIGGER `tg_message_reply_delete` AFTER DELETE ON `t_message_reply` FOR EACH ROW DELETE FROM t_notification WHERE object_type = 'message-reply' AND object_id = OLD.id
;;
DELIMITER ;
SET FOREIGN_KEY_CHECKS=1;
