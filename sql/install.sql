SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_message_received
-- ----------------------------
CREATE TABLE `t_message_received` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `item_id` int unsigned NOT NULL,
  `item_type` varchar(32) NOT NULL,
  `message` varchar(2048) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ip` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `item_id` (`item_id`,`item_type`) USING BTREE,
  CONSTRAINT `t_message_received_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TRIGGER IF EXISTS `tg_message_received_delete_before`;
DELIMITER ;;
CREATE TRIGGER `tg_message_received_delete_before` BEFORE DELETE ON `t_message_received` FOR EACH ROW DELETE FROM t_message_reply WHERE message_id = OLD.id
;;
DELIMITER ;

-- ----------------------------
-- Table structure for t_message_reply
-- ----------------------------
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
  CONSTRAINT `t_message_reply_ibfk_2` FOREIGN KEY (`message_id`) REFERENCES `t_message_received` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- View structure for v_message_received
-- ----------------------------
CREATE VIEW `v_message_received` AS select `t_message_received`.`id` AS `id`,`t_message_received`.`user_id` AS `user_id`,`t_user`.`email` AS `user_email`,`t_user`.`firstname` AS `user_firstname`,`t_user`.`lastname` AS `user_lastname`,`t_message_received`.`item_id` AS `item_id`,`t_message_received`.`item_type` AS `item_type`,`t_message_received`.`message` AS `message`,`t_message_received`.`created_at` AS `created_at`,`t_message_received`.`updated_at` AS `updated_at`,`t_message_received`.`ip` AS `ip` from (`t_message_received` left join `t_user` on((`t_message_received`.`user_id` = `t_user`.`id`))) where ((`t_user`.`status` = 'active') and (`t_user`.`role` <> 'blacklisted')) ;

SET FOREIGN_KEY_CHECKS=1;