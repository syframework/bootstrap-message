/*
Navicat MySQL Data Transfer

Source Server         : eater-dev
Source Server Version : 80026
Source Host           : localhost:3306
Source Database       : eater

Target Server Type    : MYSQL
Target Server Version : 80026
File Encoding         : 65001

Date: 2021-10-14 11:06:10
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_message_received
-- ----------------------------
DROP TABLE IF EXISTS `t_message_received`;
CREATE TABLE `t_message_received` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `item_id` int unsigned NOT NULL,
  `item_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `message` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ip` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `item_id` (`item_id`,`item_type`) USING BTREE,
  CONSTRAINT `t_message_received_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8469 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
DROP TRIGGER IF EXISTS `tg_message_received_delete_before`;
DELIMITER ;;
CREATE TRIGGER `tg_message_received_delete_before` BEFORE DELETE ON `t_message_received` FOR EACH ROW DELETE FROM t_message_reply WHERE message_id = OLD.id
;;
DELIMITER ;
SET FOREIGN_KEY_CHECKS=1;
