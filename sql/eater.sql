/*
Navicat MySQL Data Transfer

Source Server         : eater-dev
Source Server Version : 80026
Source Host           : localhost:3306
Source Database       : eater

Target Server Type    : MYSQL
Target Server Version : 80026
File Encoding         : 65001

Date: 2021-10-14 10:57:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_article
-- ----------------------------
DROP TABLE IF EXISTS `t_article`;
CREATE TABLE `t_article` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `lang` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'hidden',
  `user_id` int unsigned DEFAULT NULL COMMENT 'none',
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'textarea',
  `category_id` tinyint unsigned DEFAULT NULL COMMENT 'select',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'none',
  `alias` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'none',
  `status` enum('draft','public') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'draft' COMMENT 'none',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'none',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'none',
  `published_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'none',
  PRIMARY KEY (`id`,`lang`),
  UNIQUE KEY `alias` (`alias`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `category_id` (`category_id`) USING BTREE,
  FULLTEXT KEY `title_description` (`title`,`description`),
  CONSTRAINT `t_article_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `t_article_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `t_article_category` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for t_article_category
-- ----------------------------
DROP TABLE IF EXISTS `t_article_category`;
CREATE TABLE `t_article_category` (
  `id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `parent` tinyint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `t_article_category_ibfk_1` (`parent`) USING BTREE,
  CONSTRAINT `t_article_category_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `t_article_category` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for t_article_history
-- ----------------------------
DROP TABLE IF EXISTS `t_article_history`;
CREATE TABLE `t_article_history` (
  `article_id` int unsigned NOT NULL,
  `article_lang` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `article_crc32` bigint NOT NULL,
  `article_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`article_id`,`article_lang`,`article_crc32`),
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `article_id` (`article_id`,`article_lang`) USING BTREE,
  CONSTRAINT `t_article_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `t_article_history_ibfk_2` FOREIGN KEY (`article_id`, `article_lang`) REFERENCES `t_article` (`id`, `lang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for t_favorite
-- ----------------------------
DROP TABLE IF EXISTS `t_favorite`;
CREATE TABLE `t_favorite` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL COMMENT 'none',
  `item_id` int unsigned NOT NULL COMMENT 'hidden',
  `item_type` enum('user','place') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT 'user' COMMENT 'hidden',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE,
  CONSTRAINT `t_favorite_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for t_filter
-- ----------------------------
DROP TABLE IF EXISTS `t_filter`;
CREATE TABLE `t_filter` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `condition` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for t_lafourchette
-- ----------------------------
DROP TABLE IF EXISTS `t_lafourchette`;
CREATE TABLE `t_lafourchette` (
  `id` int unsigned NOT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `updated_at` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `promo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `country` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `lng` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `lat` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `city` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `tag` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `zx_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `program_id` int DEFAULT NULL,
  `place_id` int unsigned DEFAULT NULL,
  `ko` tinyint DEFAULT NULL,
  `html` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `place_id` (`place_id`) USING BTREE,
  KEY `title` (`title`) USING BTREE,
  KEY `address` (`address`) USING BTREE,
  KEY `title_2` (`title`,`address`) USING BTREE,
  CONSTRAINT `t_lafourchette_ibfk_1` FOREIGN KEY (`place_id`) REFERENCES `t_place` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for t_link
-- ----------------------------
DROP TABLE IF EXISTS `t_link`;
CREATE TABLE `t_link` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `icon` enum('website','globe','facebook','twitter','google-plus','youtube','youtube-play','vine','instagram','twitch','tumblr','android','tripadvisor','yelp','pinterest','pinterest-p','hellocoton','lafourchette','amazon','etsy','foursquare','linkedin','snapchat','viadeo','vimeo','') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tag` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `icon` (`icon`,`tag`) USING BTREE,
  KEY `tag` (`tag`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=35531 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for t_list
-- ----------------------------
DROP TABLE IF EXISTS `t_list`;
CREATE TABLE `t_list` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL COMMENT 'none',
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `type` enum('place') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'place' COMMENT 'none',
  `visibility` enum('public','private') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'public' COMMENT 'select',
  `nb_item` smallint unsigned NOT NULL DEFAULT '0' COMMENT 'none',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'none',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE,
  CONSTRAINT `t_list_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for t_list_has_item
-- ----------------------------
DROP TABLE IF EXISTS `t_list_has_item`;
CREATE TABLE `t_list_has_item` (
  `list_id` int unsigned NOT NULL,
  `item_id` int unsigned NOT NULL,
  `item_type` enum('place') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'place',
  `position` smallint unsigned NOT NULL DEFAULT '1',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`list_id`,`item_id`,`item_type`),
  CONSTRAINT `t_list_has_item_ibfk_1` FOREIGN KEY (`list_id`) REFERENCES `t_list` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

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

-- ----------------------------
-- Table structure for t_message_reply
-- ----------------------------
DROP TABLE IF EXISTS `t_message_reply`;
CREATE TABLE `t_message_reply` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `message_id` int unsigned NOT NULL,
  `message` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `message_id` (`message_id`) USING BTREE,
  CONSTRAINT `t_message_reply_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_message_reply_ibfk_2` FOREIGN KEY (`message_id`) REFERENCES `t_message_received` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=234 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for t_notification
-- ----------------------------
DROP TABLE IF EXISTS `t_notification`;
CREATE TABLE `t_notification` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `subject_id` int unsigned NOT NULL,
  `subject_type` enum('user','place') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'user',
  `verb` enum('create','update','follow','accept','refuse','cancel','react') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'create',
  `object_id` int NOT NULL,
  `object_type` enum('place','article','list','message','message-reply','conversation-reply','review','user','reservation') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` enum('new','unread','read') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'new',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`subject_id`,`subject_type`,`verb`,`object_id`,`object_type`) USING BTREE,
  CONSTRAINT `t_notification_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16977 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for t_page
-- ----------------------------
DROP TABLE IF EXISTS `t_page`;
CREATE TABLE `t_page` (
  `id` varchar(24) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `lang` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'hidden',
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'none',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'none',
  PRIMARY KEY (`id`,`lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for t_page_history
-- ----------------------------
DROP TABLE IF EXISTS `t_page_history`;
CREATE TABLE `t_page_history` (
  `page_id` varchar(24) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `page_lang` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'hidden',
  `page_crc32` bigint NOT NULL,
  `page_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`page_id`,`page_lang`,`page_crc32`),
  KEY `t_page_history_ibfk_1` (`user_id`) USING BTREE,
  CONSTRAINT `t_page_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `t_page_history_ibfk_2` FOREIGN KEY (`page_id`, `page_lang`) REFERENCES `t_page` (`id`, `lang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for t_place
-- ----------------------------
DROP TABLE IF EXISTS `t_place`;
CREATE TABLE `t_place` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `subtitle` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `address` varchar(160) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `phone` varchar(24) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `lat` double NOT NULL COMMENT 'none',
  `lng` double NOT NULL COMMENT 'none',
  `user_id` int unsigned DEFAULT NULL COMMENT 'none',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'none',
  `alias` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `status` enum('draft','public') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'draft' COMMENT 'none',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'none',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'none',
  `guide` decimal(3,2) unsigned NOT NULL DEFAULT '0.00' COMMENT 'none',
  `rate` decimal(3,2) unsigned NOT NULL DEFAULT '0.00' COMMENT 'none',
  `nb_rate` smallint unsigned NOT NULL DEFAULT '0' COMMENT 'none',
  `nb_message` smallint unsigned NOT NULL DEFAULT '0' COMMENT 'none',
  PRIMARY KEY (`id`),
  UNIQUE KEY `alias` (`alias`) USING BTREE,
  KEY `lat` (`lat`) USING BTREE,
  KEY `lng` (`lng`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `rate` (`rate`) USING BTREE,
  KEY `updated_at` (`updated_at`) USING BTREE,
  KEY `rate_nb_rate` (`rate`,`nb_rate`) USING BTREE,
  FULLTEXT KEY `title` (`title`),
  FULLTEXT KEY `title_address` (`title`,`address`),
  CONSTRAINT `t_place_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=219854 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for t_place_has_tag
-- ----------------------------
DROP TABLE IF EXISTS `t_place_has_tag`;
CREATE TABLE `t_place_has_tag` (
  `place_id` int unsigned NOT NULL,
  `tag_id` smallint unsigned NOT NULL,
  PRIMARY KEY (`place_id`,`tag_id`),
  KEY `tag_id` (`tag_id`) USING BTREE,
  KEY `place_id` (`place_id`) USING BTREE,
  CONSTRAINT `t_place_has_tag_ibfk_1` FOREIGN KEY (`place_id`) REFERENCES `t_place` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_place_has_tag_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `t_tag` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for t_place_history
-- ----------------------------
DROP TABLE IF EXISTS `t_place_history`;
CREATE TABLE `t_place_history` (
  `place_id` int unsigned NOT NULL,
  `place_crc32` bigint NOT NULL,
  `place_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`place_id`,`place_crc32`),
  KEY `user_id` (`user_id`) USING BTREE,
  CONSTRAINT `t_place_history_ibfk_1` FOREIGN KEY (`place_id`) REFERENCES `t_place` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_place_history_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for t_place_setting
-- ----------------------------
DROP TABLE IF EXISTS `t_place_setting`;
CREATE TABLE `t_place_setting` (
  `place_id` int unsigned NOT NULL,
  `category` enum('css','reservation') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'css',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `status` enum('on','off') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'on',
  PRIMARY KEY (`place_id`,`category`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for t_rate
-- ----------------------------
DROP TABLE IF EXISTS `t_rate`;
CREATE TABLE `t_rate` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `item_id` int unsigned NOT NULL,
  `item_type` enum('place') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'place',
  `rate1` decimal(2,1) unsigned DEFAULT NULL,
  `rate2` decimal(2,1) unsigned DEFAULT NULL,
  `rate3` decimal(2,1) unsigned DEFAULT NULL,
  `rate4` decimal(2,1) unsigned DEFAULT NULL,
  `rate5` decimal(2,1) unsigned DEFAULT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `visited_at` date NOT NULL,
  `ip` int unsigned DEFAULT NULL,
  `reaction1` int unsigned NOT NULL DEFAULT '0',
  `reaction2` int unsigned NOT NULL DEFAULT '0',
  `reaction3` int unsigned NOT NULL DEFAULT '0',
  `reaction4` int unsigned NOT NULL DEFAULT '0',
  `reaction5` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`item_id`,`item_type`,`visited_at`) USING BTREE,
  KEY `created_at` (`created_at`) USING BTREE,
  CONSTRAINT `t_rate_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3552 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for t_reaction
-- ----------------------------
DROP TABLE IF EXISTS `t_reaction`;
CREATE TABLE `t_reaction` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `item_id` int unsigned NOT NULL,
  `item_type` enum('review') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'review',
  `reaction` enum('1','2','3','4','5') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`item_id`,`item_type`,`reaction`) USING BTREE,
  CONSTRAINT `t_reaction_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=939 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for t_reservation
-- ----------------------------
DROP TABLE IF EXISTS `t_reservation`;
CREATE TABLE `t_reservation` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `place_id` int unsigned NOT NULL,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `email` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `phone` varchar(24) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `date` date NOT NULL,
  `time` time NOT NULL,
  `people` tinyint unsigned NOT NULL DEFAULT '0',
  `message` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `note` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `status` enum('pending','cancelled','refused','accepted') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'pending',
  `lang` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'hidden',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `date` (`date`) USING BTREE,
  KEY `place_id` (`place_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `time` (`time`) USING BTREE,
  CONSTRAINT `t_reservation_ibfk_1` FOREIGN KEY (`place_id`) REFERENCES `t_place` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_reservation_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1179 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for t_reservation_has_table
-- ----------------------------
DROP TABLE IF EXISTS `t_reservation_has_table`;
CREATE TABLE `t_reservation_has_table` (
  `reservation_id` int unsigned NOT NULL,
  `table_id` smallint unsigned NOT NULL,
  `place_id` int unsigned NOT NULL,
  PRIMARY KEY (`reservation_id`,`table_id`,`place_id`),
  KEY `table_id` (`table_id`,`place_id`) USING BTREE,
  CONSTRAINT `t_reservation_has_table_ibfk_1` FOREIGN KEY (`reservation_id`) REFERENCES `t_reservation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_reservation_has_table_ibfk_2` FOREIGN KEY (`table_id`, `place_id`) REFERENCES `t_table` (`id`, `place_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for t_restaurant_gaultmillau
-- ----------------------------
DROP TABLE IF EXISTS `t_restaurant_gaultmillau`;
CREATE TABLE `t_restaurant_gaultmillau` (
  `id` int unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `zip_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `country_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `chef` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `cuisine` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `service` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `toque` tinyint DEFAULT NULL,
  `mark` decimal(4,1) unsigned DEFAULT NULL,
  `place_id` int DEFAULT NULL,
  `status` enum('undefined','open','closed') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'undefined',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for t_restaurant_michelin
-- ----------------------------
DROP TABLE IF EXISTS `t_restaurant_michelin`;
CREATE TABLE `t_restaurant_michelin` (
  `id` int NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `zip_code` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `distinction` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `place_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for t_table
-- ----------------------------
DROP TABLE IF EXISTS `t_table`;
CREATE TABLE `t_table` (
  `id` smallint unsigned NOT NULL,
  `place_id` int unsigned NOT NULL,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `people` tinyint unsigned NOT NULL DEFAULT '2',
  `private` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`place_id`),
  KEY `place_id` (`place_id`) USING BTREE,
  CONSTRAINT `t_table_ibfk_1` FOREIGN KEY (`place_id`) REFERENCES `t_place` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for t_tag
-- ----------------------------
DROP TABLE IF EXISTS `t_tag`;
CREATE TABLE `t_tag` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for t_tripadvisor
-- ----------------------------
DROP TABLE IF EXISTS `t_tripadvisor`;
CREATE TABLE `t_tripadvisor` (
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `street` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `code` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `city` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `country` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `phone` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `website` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `lafourchette_url` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `status` enum('none','no-hour','checked','submitted','ok') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'none',
  PRIMARY KEY (`url`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `role` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT 'user',
  `firstname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `lastname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `email` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phone` varchar(24) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `language` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `algo` enum('sha1','bcrypt') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'sha1',
  `last_connection_at` datetime DEFAULT NULL,
  `status` enum('inactive','active') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'inactive',
  `ip` int unsigned DEFAULT NULL,
  `token` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`) USING BTREE,
  UNIQUE KEY `firstname` (`firstname`) USING BTREE,
  KEY `role` (`role`) USING BTREE,
  CONSTRAINT `t_user_ibfk_1` FOREIGN KEY (`role`) REFERENCES `t_user_role` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12868 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for t_user_has_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_user_has_permission`;
CREATE TABLE `t_user_has_permission` (
  `id` int unsigned NOT NULL,
  `permission` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`,`permission`),
  KEY `permission` (`permission`) USING BTREE,
  CONSTRAINT `t_user_has_permission_ibfk_1` FOREIGN KEY (`id`) REFERENCES `t_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_user_has_permission_ibfk_2` FOREIGN KEY (`permission`) REFERENCES `t_user_permission` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for t_user_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_user_permission`;
CREATE TABLE `t_user_permission` (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for t_user_role
-- ----------------------------
DROP TABLE IF EXISTS `t_user_role`;
CREATE TABLE `t_user_role` (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for t_user_role_has_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_user_role_has_permission`;
CREATE TABLE `t_user_role_has_permission` (
  `id_role` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `id_permission` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id_role`,`id_permission`),
  KEY `fk_t_user_role_has_t_user_permission_t_user_role1` (`id_role`) USING BTREE,
  KEY `fk_t_user_role_has_t_user_permission_t_user_permission1` (`id_permission`) USING BTREE,
  CONSTRAINT `t_user_role_has_permission_ibfk_1` FOREIGN KEY (`id_permission`) REFERENCES `t_user_permission` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_user_role_has_permission_ibfk_2` FOREIGN KEY (`id_role`) REFERENCES `t_user_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for t_user_setting
-- ----------------------------
DROP TABLE IF EXISTS `t_user_setting`;
CREATE TABLE `t_user_setting` (
  `user_id` int unsigned NOT NULL,
  `key` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `value` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`user_id`,`key`),
  CONSTRAINT `t_user_setting_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for t_vote
-- ----------------------------
DROP TABLE IF EXISTS `t_vote`;
CREATE TABLE `t_vote` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `type` enum('place') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'place',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE,
  CONSTRAINT `t_vote_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for t_vote_has_item
-- ----------------------------
DROP TABLE IF EXISTS `t_vote_has_item`;
CREATE TABLE `t_vote_has_item` (
  `vote_id` int unsigned NOT NULL,
  `item_id` int unsigned NOT NULL,
  `item_type` enum('place') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'place',
  `score` int NOT NULL DEFAULT '0',
  `up` mediumint NOT NULL DEFAULT '0',
  `down` mediumint NOT NULL DEFAULT '0',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`vote_id`,`item_id`,`item_type`),
  CONSTRAINT `t_vote_has_item_ibfk_1` FOREIGN KEY (`vote_id`) REFERENCES `t_vote` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- View structure for v_article
-- ----------------------------
DROP VIEW IF EXISTS `v_article`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_article` AS select `t_article`.`id` AS `id`,`t_article`.`lang` AS `lang`,`t_article`.`user_id` AS `user_id`,`t_article`.`title` AS `title`,`t_article`.`description` AS `description`,`t_article`.`category_id` AS `category_id`,`t_article`.`content` AS `content`,`t_article`.`alias` AS `alias`,`t_article`.`status` AS `status`,`t_article`.`created_at` AS `created_at`,`t_article`.`updated_at` AS `updated_at`,`t_article`.`published_at` AS `published_at`,`user`.`firstname` AS `user_firstname`,`user`.`lastname` AS `user_lastname`,`category`.`name` AS `category` from ((`t_article` left join `t_user` `user` on((`t_article`.`user_id` = `user`.`id`))) left join `t_article_category` `category` on((`t_article`.`category_id` = `category`.`id`))) ;

-- ----------------------------
-- View structure for v_guidebook_score
-- ----------------------------
DROP VIEW IF EXISTS `v_guidebook_score`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_guidebook_score` AS select `t_restaurant_michelin`.`place_id` AS `place_id`,'Michelin' AS `guide`,`t_restaurant_michelin`.`distinction` AS `score`,`t_restaurant_michelin`.`url` AS `url` from `t_restaurant_michelin` where ((`t_restaurant_michelin`.`place_id` is not null) and (`t_restaurant_michelin`.`distinction` is not null)) union select `t_restaurant_gaultmillau`.`place_id` AS `place_id`,'Gault&Millau' AS `guide`,`t_restaurant_gaultmillau`.`mark` AS `score`,concat('https://www.gaultmillau.com/restaurant/',`t_restaurant_gaultmillau`.`slug`) AS `CONCAT('https://www.gaultmillau.com/restaurant/',slug)` from `t_restaurant_gaultmillau` where ((`t_restaurant_gaultmillau`.`place_id` is not null) and (`t_restaurant_gaultmillau`.`mark` is not null)) ;

-- ----------------------------
-- View structure for v_list
-- ----------------------------
DROP VIEW IF EXISTS `v_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_list` AS select `l`.`id` AS `id`,`l`.`user_id` AS `user_id`,`l`.`title` AS `title`,`l`.`description` AS `description`,`l`.`type` AS `type`,`l`.`visibility` AS `visibility`,`l`.`updated_at` AS `updated_at`,`u`.`firstname` AS `firstname`,`u`.`lastname` AS `lastname` from (`t_list` `l` left join `t_user` `u` on((`l`.`user_id` = `u`.`id`))) ;

-- ----------------------------
-- View structure for v_message_received
-- ----------------------------
DROP VIEW IF EXISTS `v_message_received`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_message_received` AS select `t_message_received`.`id` AS `id`,`t_message_received`.`user_id` AS `user_id`,`t_user`.`firstname` AS `user_firstname`,`t_user`.`lastname` AS `user_lastname`,`t_message_received`.`item_id` AS `item_id`,`t_message_received`.`item_type` AS `item_type`,`t_message_received`.`message` AS `message`,`t_message_received`.`created_at` AS `created_at`,`t_message_received`.`updated_at` AS `updated_at`,`t_message_received`.`ip` AS `ip` from (`t_message_received` left join `t_user` on((`t_message_received`.`user_id` = `t_user`.`id`))) where ((`t_user`.`status` = 'active') and (`t_user`.`role` <> 'blacklisted')) ;

-- ----------------------------
-- View structure for v_notification
-- ----------------------------
DROP VIEW IF EXISTS `v_notification`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_notification` AS select `t_notification`.`user_id` AS `user_id`,group_concat(`t_notification`.`subject_id` separator ',') AS `subject_id`,`t_notification`.`subject_type` AS `subject_type`,`t_notification`.`verb` AS `verb`,`t_notification`.`object_id` AS `object_id`,`t_notification`.`object_type` AS `object_type`,max(`t_notification`.`created_at`) AS `created_at`,`t_notification`.`status` AS `status`,count(0) AS `count` from `t_notification` where (`t_notification`.`status` <> 'read') group by `t_notification`.`user_id`,`t_notification`.`subject_type`,`t_notification`.`verb`,`t_notification`.`object_id`,`t_notification`.`object_type`,`t_notification`.`status` ;

-- ----------------------------
-- View structure for v_place_duplicated
-- ----------------------------
DROP VIEW IF EXISTS `v_place_duplicated`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_place_duplicated` AS select `t_place`.`id` AS `id`,`t_place`.`title` AS `title`,`t_place`.`subtitle` AS `subtitle`,`t_place`.`description` AS `description`,`t_place`.`address` AS `address`,`t_place`.`phone` AS `phone`,`t_place`.`lat` AS `lat`,`t_place`.`lng` AS `lng`,`t_place`.`user_id` AS `user_id`,`t_place`.`content` AS `content`,`t_place`.`alias` AS `alias`,`t_place`.`status` AS `status`,`t_place`.`created_at` AS `created_at`,`t_place`.`updated_at` AS `updated_at`,`t_place`.`rate` AS `rate`,`t_place`.`nb_rate` AS `nb_rate` from `t_place` group by `t_place`.`title`,`t_place`.`address` having (count(0) > 1) ;

-- ----------------------------
-- View structure for v_rate
-- ----------------------------
DROP VIEW IF EXISTS `v_rate`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_rate` AS select `t_rate`.`id` AS `id`,`t_rate`.`user_id` AS `user_id`,`t_rate`.`item_id` AS `item_id`,`t_rate`.`item_type` AS `item_type`,`t_rate`.`rate1` AS `rate1`,`t_rate`.`rate2` AS `rate2`,`t_rate`.`rate3` AS `rate3`,`t_rate`.`rate4` AS `rate4`,`t_rate`.`rate5` AS `rate5`,`t_rate`.`reaction1` AS `reaction1`,`t_rate`.`reaction2` AS `reaction2`,`t_rate`.`reaction3` AS `reaction3`,`t_rate`.`reaction4` AS `reaction4`,`t_rate`.`reaction5` AS `reaction5`,`t_rate`.`message` AS `message`,`t_rate`.`created_at` AS `created_at`,`t_rate`.`visited_at` AS `visited_at`,`t_rate`.`ip` AS `ip`,`t_user`.`firstname` AS `user_firstname`,`t_user`.`lastname` AS `user_lastname`,`t_user`.`role` AS `user_role`,`t_user`.`status` AS `user_status` from (`t_rate` left join `t_user` on((`t_rate`.`user_id` = `t_user`.`id`))) ;

-- ----------------------------
-- View structure for v_reservation
-- ----------------------------
DROP VIEW IF EXISTS `v_reservation`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_reservation` AS select `t_reservation`.`id` AS `id`,`t_reservation`.`user_id` AS `user_id`,`t_reservation`.`place_id` AS `place_id`,`t_reservation`.`name` AS `name`,`t_reservation`.`email` AS `email`,`t_reservation`.`phone` AS `phone`,`t_reservation`.`date` AS `date`,`t_reservation`.`time` AS `time`,`t_reservation`.`people` AS `people`,`t_reservation`.`message` AS `message`,`t_reservation`.`note` AS `note`,`t_reservation`.`status` AS `status`,`t_reservation`.`lang` AS `lang`,`t_reservation`.`created_at` AS `created_at`,`t_user`.`firstname` AS `user_firstname`,`t_user`.`lastname` AS `user_lastname`,`t_place`.`title` AS `place_title`,`t_place`.`alias` AS `place_alias`,`t_place`.`user_id` AS `place_user_id`,count(`t_table`.`id`) AS `table_count`,group_concat(`t_table`.`id` separator ',') AS `table_id`,group_concat(`t_table`.`name` separator ' / ') AS `table_name` from ((((`t_reservation` left join `t_place` on((`t_reservation`.`place_id` = `t_place`.`id`))) left join `t_user` on((`t_reservation`.`user_id` = `t_user`.`id`))) left join `t_reservation_has_table` on((`t_reservation_has_table`.`reservation_id` = `t_reservation`.`id`))) left join `t_table` on(((`t_table`.`id` = `t_reservation_has_table`.`table_id`) and (`t_table`.`place_id` = `t_reservation_has_table`.`place_id`)))) where (`t_reservation`.`date` >= curdate()) group by `t_reservation`.`id` order by `t_reservation`.`date`,`t_reservation`.`time`,`t_reservation`.`created_at` ;
DROP TRIGGER IF EXISTS `tg_article_insert`;
DELIMITER ;;
CREATE TRIGGER `tg_article_insert` BEFORE INSERT ON `t_article` FOR EACH ROW IF (NEW.alias IS NULL) THEN
SET NEW.alias = CONCAT(NEW.lang, '-', NEW.id);
END IF
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `tg_article_delete`;
DELIMITER ;;
CREATE TRIGGER `tg_article_delete` AFTER DELETE ON `t_article` FOR EACH ROW DELETE FROM t_message_received WHERE item_id = OLD.id AND item_type = 'article'
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `tg_list_delete`;
DELIMITER ;;
CREATE TRIGGER `tg_list_delete` AFTER DELETE ON `t_list` FOR EACH ROW DELETE FROM t_message_received WHERE item_id = OLD.id AND item_type = 'review'
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `tg_message_received_delete_before`;
DELIMITER ;;
CREATE TRIGGER `tg_message_received_delete_before` BEFORE DELETE ON `t_message_received` FOR EACH ROW DELETE FROM t_message_reply WHERE message_id = OLD.id
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `tg_place_delete`;
DELIMITER ;;
CREATE TRIGGER `tg_place_delete` BEFORE DELETE ON `t_place` FOR EACH ROW BEGIN
SET @place_deleting = 1;
DELETE FROM t_link WHERE tag = CONCAT('place-', OLD.id);
DELETE FROM t_message_received WHERE item_id = OLD.id AND item_type = 'place';


INSERT INTO t_list_has_item(list_id, item_id, item_type, position)
SELECT a.list_id, a.item_id, a.item_type, a.position - 1
FROM t_list_has_item a
LEFT JOIN (
	SELECT *
	FROM t_list_has_item i
	WHERE i.item_id = OLD.id
) AS b ON a.list_id = b.list_id
WHERE a.position > b.position
ON DUPLICATE KEY UPDATE position = VALUES(position);

DELETE FROM t_list_has_item WHERE item_id = OLD.id AND item_type = 'place';
SET @place_deleting = NULL;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `tg_rate_insert`;
DELIMITER ;;
CREATE TRIGGER `tg_rate_insert` AFTER INSERT ON `t_rate` FOR EACH ROW IF (NEW.item_type = 'place') THEN
UPDATE t_place, 
	(
		SELECT
			IF(COUNT(rate.user_id) > 0, (AVG(rate1) * 15 + AVG(rate2) * 40 + AVG(rate3) * 15 + AVG(rate4) * 15 + AVG(rate5) * 15) / 100, 0) AS avg,
			COUNT(rate.user_id) AS count
		FROM t_place
		LEFT JOIN v_rate ON v_rate.item_id = t_place.id AND v_rate.user_status = 'active'
		LEFT JOIN (
				SELECT
					user_id,
					item_id,
					item_type,
					MAX(visited_at) as visited_at
				FROM t_rate
				WHERE t_rate.item_type = 'place' AND t_rate.item_id = NEW.item_id AND t_rate.visited_at > DATE_SUB(CURDATE(),INTERVAL 3 YEAR)
				GROUP BY user_id, item_id, item_type
		) AS rate ON v_rate.user_id = rate.user_id AND v_rate.item_id = rate.item_id AND v_rate.item_type = rate.item_type AND v_rate.visited_at = rate.visited_at
		WHERE t_place.id = NEW.item_id AND v_rate.item_id = rate.item_id AND v_rate.item_type = rate.item_type AND v_rate.visited_at = rate.visited_at
		GROUP BY v_rate.item_id
	) AS note
SET t_place.rate = note.avg, t_place.nb_rate = note.count
WHERE t_place.id = NEW.item_id;
END IF
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `tg_rate_update`;
DELIMITER ;;
CREATE TRIGGER `tg_rate_update` AFTER UPDATE ON `t_rate` FOR EACH ROW IF (NEW.item_type = 'place') THEN
UPDATE t_place, 
	(
		SELECT
			IF(COUNT(rate.user_id) > 0, (AVG(rate1) * 15 + AVG(rate2) * 40 + AVG(rate3) * 15 + AVG(rate4) * 15 + AVG(rate5) * 15) / 100, 0) AS avg,
			COUNT(rate.user_id) AS count
		FROM t_place
		LEFT JOIN v_rate ON v_rate.item_id = t_place.id AND v_rate.user_status = 'active'
		LEFT JOIN (
				SELECT
					user_id,
					item_id,
					item_type,
					MAX(visited_at) as visited_at
				FROM t_rate
				WHERE t_rate.item_type = 'place' AND t_rate.item_id = NEW.item_id AND t_rate.visited_at > DATE_SUB(CURDATE(),INTERVAL 3 YEAR)
				GROUP BY user_id, item_id, item_type
		) AS rate ON v_rate.user_id = rate.user_id AND v_rate.item_id = rate.item_id AND v_rate.item_type = rate.item_type AND v_rate.visited_at = rate.visited_at
		WHERE t_place.id = NEW.item_id AND v_rate.item_id = rate.item_id AND v_rate.item_type = rate.item_type AND v_rate.visited_at = rate.visited_at
		GROUP BY v_rate.item_id
	) AS note
SET t_place.rate = note.avg, t_place.nb_rate = note.count
WHERE t_place.id = NEW.item_id;
END IF
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `tg_rate_delete`;
DELIMITER ;;
CREATE TRIGGER `tg_rate_delete` AFTER DELETE ON `t_rate` FOR EACH ROW BEGIN
IF (OLD.item_type = 'place') AND @place_deleting IS NULL THEN
UPDATE t_place
SET t_place.rate = 0, t_place.nb_rate = 0
WHERE t_place.id = OLD.item_id;
UPDATE t_place, 
	(
		SELECT
			IF(COUNT(rate.user_id) > 0,(AVG(rate1) * 15 + AVG(rate2) * 40 + AVG(rate3) * 15 + AVG(rate4) * 15 + AVG(rate5) * 15) / 100, 0) AS avg,
			COUNT(rate.user_id) AS count
		FROM t_place
		LEFT JOIN v_rate ON v_rate.item_id = t_place.id AND v_rate.user_status = 'active'
		LEFT JOIN (
				SELECT
					user_id,
					item_id,
					item_type,
					MAX(visited_at) as visited_at
				FROM t_rate
				WHERE t_rate.item_type = 'place' AND t_rate.item_id = OLD.item_id AND t_rate.visited_at > DATE_SUB(CURDATE(),INTERVAL 3 YEAR)
				GROUP BY user_id, item_id, item_type
		) AS rate ON v_rate.user_id = rate.user_id AND v_rate.item_id = rate.item_id AND v_rate.item_type = rate.item_type AND v_rate.visited_at = rate.visited_at
		WHERE t_place.id = OLD.item_id AND v_rate.item_id = rate.item_id AND v_rate.item_type = rate.item_type AND v_rate.visited_at = rate.visited_at
		GROUP BY v_rate.item_id
	) AS note
SET t_place.rate = note.avg, t_place.nb_rate = note.count
WHERE t_place.id = OLD.item_id;
END IF;

DELETE FROM t_message_received WHERE item_id = OLD.id AND item_type = 'review';
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `tg_reaction_insert`;
DELIMITER ;;
CREATE TRIGGER `tg_reaction_insert` AFTER INSERT ON `t_reaction` FOR EACH ROW BEGIN
	IF (NEW.item_type = 'review') THEN
		CASE NEW.reaction
			WHEN '1' THEN UPDATE t_rate SET reaction1 = reaction1 + 1 WHERE id = NEW.item_id;
			WHEN '2' THEN UPDATE t_rate SET reaction2 = reaction2 + 1 WHERE id = NEW.item_id;
			WHEN '3' THEN UPDATE t_rate SET reaction3 = reaction3 + 1 WHERE id = NEW.item_id;
			WHEN '4' THEN UPDATE t_rate SET reaction4 = reaction4 + 1 WHERE id = NEW.item_id;
			WHEN '5' THEN UPDATE t_rate SET reaction5 = reaction5 + 1 WHERE id = NEW.item_id;
		END CASE;
	END IF;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `tg_reaction_delete`;
DELIMITER ;;
CREATE TRIGGER `tg_reaction_delete` AFTER DELETE ON `t_reaction` FOR EACH ROW BEGIN
	DELETE FROM t_notification 
	WHERE  subject_id = OLD.user_id
		AND subject_type = 'user'
		AND verb = 'react'
		AND object_id = OLD.item_id 
		AND object_type = OLD.item_type;
		
	IF (OLD.item_type = 'review') THEN
		CASE OLD.reaction
			WHEN '1' THEN UPDATE t_rate SET reaction1 = reaction1 - 1 WHERE id = OLD.item_id;
			WHEN '2' THEN UPDATE t_rate SET reaction2 = reaction2 - 1 WHERE id = OLD.item_id;
			WHEN '3' THEN UPDATE t_rate SET reaction3 = reaction3 - 1 WHERE id = OLD.item_id;
			WHEN '4' THEN UPDATE t_rate SET reaction4 = reaction4 - 1 WHERE id = OLD.item_id;
			WHEN '5' THEN UPDATE t_rate SET reaction5 = reaction5 - 1 WHERE id = OLD.item_id;
		END CASE;
	END IF;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `tg_reservation_delete`;
DELIMITER ;;
CREATE TRIGGER `tg_reservation_delete` BEFORE DELETE ON `t_reservation` FOR EACH ROW DELETE FROM t_message_received WHERE item_id = OLD.id AND item_type = 'reservation'
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `tg_user_delete`;
DELIMITER ;;
CREATE TRIGGER `tg_user_delete` BEFORE DELETE ON `t_user` FOR EACH ROW BEGIN
DELETE FROM t_favorite WHERE item_id = OLD.id AND item_type = 'user';
DELETE FROM t_notification WHERE object_id = OLD.id AND object_type = 'user';
DELETE FROM t_notification WHERE subject_id = OLD.id AND subject_type = 'user';
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `tg_user_active`;
DELIMITER ;;
CREATE TRIGGER `tg_user_active` AFTER UPDATE ON `t_user` FOR EACH ROW IF (OLD.status = 'inactive' AND NEW.status = 'active') THEN
UPDATE t_rate SET created_at = CURRENT_TIMESTAMP WHERE user_id = NEW.id;
UPDATE t_message_received SET updated_at = CURRENT_TIMESTAMP WHERE user_id = NEW.id;
END IF
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `tg_vote_has_item_update`;
DELIMITER ;;
CREATE TRIGGER `tg_vote_has_item_update` BEFORE UPDATE ON `t_vote_has_item` FOR EACH ROW SET NEW.score = NEW.up - NEW.down
;;
DELIMITER ;
SET FOREIGN_KEY_CHECKS=1;
