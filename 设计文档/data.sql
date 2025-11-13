/*
 Navicat Premium Dump SQL

 Source Server         : DB
 Source Server Type    : MySQL
 Source Server Version : 80042 (8.0.42)
 Source Host           : localhost:3306
 Source Schema         : xiangying-food-ordering-platform

 Target Server Type    : MySQL
 Target Server Version : 80042 (8.0.42)
 File Encoding         : 65001

 Date: 13/11/2025 16:59:37
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address_book
-- ----------------------------
DROP TABLE IF EXISTS `address_book`;
CREATE TABLE `address_book` (
                                `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
                                `user_id` bigint NOT NULL COMMENT '用户ID',
                                `consignee` varchar(20) NOT NULL COMMENT '收货人',
                                `phone` varchar(11) NOT NULL COMMENT '手机号',
                                `province` varchar(20) DEFAULT NULL COMMENT '省份',
                                `city` varchar(20) DEFAULT NULL COMMENT '城市',
                                `district` varchar(20) DEFAULT NULL COMMENT '区县',
                                `detail_address` varchar(200) NOT NULL COMMENT '详细地址',
                                `is_default` tinyint(1) DEFAULT '0' COMMENT '是否默认地址',
                                `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                PRIMARY KEY (`id`),
                                KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='地址表';

-- ----------------------------
-- Records of address_book
-- ----------------------------
BEGIN;
INSERT INTO `address_book` (`id`, `user_id`, `consignee`, `phone`, `province`, `city`, `district`, `detail_address`, `is_default`, `create_time`, `update_time`) VALUES (1, 1, '张三', '13800138001', '北京市', '北京市', '朝阳区', 'xxx街道xxx号', 1, '2024-01-15 10:00:00', '2024-01-15 10:00:00');
INSERT INTO `address_book` (`id`, `user_id`, `consignee`, `phone`, `province`, `city`, `district`, `detail_address`, `is_default`, `create_time`, `update_time`) VALUES (2, 2, '李四', '13800138002', '北京市', '北京市', '海淀区', 'xxx小区xxx栋', 1, '2024-01-15 10:00:00', '2024-01-15 10:00:00');
COMMIT;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
                            `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
                            `name` varchar(32) NOT NULL COMMENT '分类名称',
                            `type` tinyint(1) NOT NULL COMMENT '1:菜品 2:套餐',
                            `sort` int DEFAULT '0' COMMENT '排序',
                            `status` tinyint(1) DEFAULT '1' COMMENT '1:启用 0:禁用',
                            `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                            `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                            PRIMARY KEY (`id`),
                            UNIQUE KEY `uk_name_type` (`name`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='分类表';

-- ----------------------------
-- Records of category
-- ----------------------------
BEGIN;
INSERT INTO `category` (`id`, `name`, `type`, `sort`, `status`, `create_time`, `update_time`) VALUES (1, '热销菜品', 1, 1, 1, '2024-01-15 09:00:00', '2024-01-15 09:00:00');
INSERT INTO `category` (`id`, `name`, `type`, `sort`, `status`, `create_time`, `update_time`) VALUES (2, '主食', 1, 2, 1, '2024-01-15 09:00:00', '2024-01-15 09:00:00');
INSERT INTO `category` (`id`, `name`, `type`, `sort`, `status`, `create_time`, `update_time`) VALUES (3, '饮料', 1, 3, 1, '2024-01-15 09:00:00', '2024-01-15 09:00:00');
INSERT INTO `category` (`id`, `name`, `type`, `sort`, `status`, `create_time`, `update_time`) VALUES (4, '超值套餐', 2, 4, 1, '2024-01-15 09:00:00', '2024-01-15 09:00:00');
COMMIT;

-- ----------------------------
-- Table structure for coupon
-- ----------------------------
DROP TABLE IF EXISTS `coupon`;
CREATE TABLE `coupon` (
                          `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
                          `name` varchar(50) NOT NULL COMMENT '优惠券名称',
                          `type` tinyint(1) NOT NULL COMMENT '1:满减券 2:折扣券',
                          `discount_amount` decimal(10,2) DEFAULT NULL COMMENT '优惠金额',
                          `discount_rate` decimal(3,2) DEFAULT NULL COMMENT '折扣率',
                          `min_amount` decimal(10,2) DEFAULT NULL COMMENT '最低消费金额',
                          `total_count` int NOT NULL COMMENT '发放总量',
                          `used_count` int DEFAULT '0' COMMENT '已使用量',
                          `start_time` datetime NOT NULL COMMENT '开始时间',
                          `end_time` datetime NOT NULL COMMENT '结束时间',
                          `status` tinyint(1) DEFAULT '1' COMMENT '1:可用 0:禁用',
                          `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                          PRIMARY KEY (`id`),
                          KEY `idx_time` (`start_time`,`end_time`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='优惠券表';

-- ----------------------------
-- Records of coupon
-- ----------------------------
BEGIN;
INSERT INTO `coupon` (`id`, `name`, `type`, `discount_amount`, `discount_rate`, `min_amount`, `total_count`, `used_count`, `start_time`, `end_time`, `status`, `create_time`) VALUES (1, '新用户满减券', 1, 10.00, NULL, 30.00, 1000, 25, '2024-01-01 00:00:00', '2024-12-31 23:59:59', 1, '2024-01-15 09:00:00');
INSERT INTO `coupon` (`id`, `name`, `type`, `discount_amount`, `discount_rate`, `min_amount`, `total_count`, `used_count`, `start_time`, `end_time`, `status`, `create_time`) VALUES (2, '会员折扣券', 2, NULL, 0.88, 50.00, 500, 10, '2024-01-01 00:00:00', '2024-12-31 23:59:59', 1, '2024-01-15 09:00:00');
COMMIT;

-- ----------------------------
-- Table structure for dish
-- ----------------------------
DROP TABLE IF EXISTS `dish`;
CREATE TABLE `dish` (
                        `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
                        `name` varchar(50) NOT NULL COMMENT '菜品名称',
                        `category_id` bigint NOT NULL COMMENT '分类ID',
                        `dish_type` tinyint(1) DEFAULT '1' COMMENT '1:单品 2:套餐',
                        `price` decimal(10,2) NOT NULL COMMENT '价格',
                        `image` varchar(255) DEFAULT NULL COMMENT '图片URL',
                        `description` text COMMENT '描述',
                        `flavors` json DEFAULT NULL COMMENT '口味信息JSON',
                        `stock` int DEFAULT '0' COMMENT '库存',
                        `seckill_stock` int DEFAULT '0' COMMENT '秒杀库存',
                        `status` tinyint(1) DEFAULT '1' COMMENT '1:起售 0:停售',
                        `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                        `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                        PRIMARY KEY (`id`),
                        KEY `idx_category` (`category_id`),
                        KEY `idx_status` (`status`),
                        KEY `idx_dish_type` (`dish_type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='菜品表';

-- ----------------------------
-- Records of dish
-- ----------------------------
BEGIN;
INSERT INTO `dish` (`id`, `name`, `category_id`, `dish_type`, `price`, `image`, `description`, `flavors`, `stock`, `seckill_stock`, `status`, `create_time`, `update_time`) VALUES (1, '宫保鸡丁', 1, 1, 38.00, 'https://example.com/gongbao.jpg', '经典川菜，麻辣鲜香', '[\"微辣\", \"中辣\", \"特辣\"]', 100, 20, 1, '2024-01-15 09:00:00', '2024-01-15 09:00:00');
INSERT INTO `dish` (`id`, `name`, `category_id`, `dish_type`, `price`, `image`, `description`, `flavors`, `stock`, `seckill_stock`, `status`, `create_time`, `update_time`) VALUES (2, '麻婆豆腐', 1, 1, 28.00, 'https://example.com/mapo.jpg', '麻辣鲜香，口感嫩滑', '[\"微辣\", \"中辣\"]', 80, 15, 1, '2024-01-15 09:00:00', '2024-01-15 09:00:00');
INSERT INTO `dish` (`id`, `name`, `category_id`, `dish_type`, `price`, `image`, `description`, `flavors`, `stock`, `seckill_stock`, `status`, `create_time`, `update_time`) VALUES (3, '扬州炒饭', 2, 1, 25.00, 'https://example.com/chaofan.jpg', '米饭粒粒分明，配料丰富', '[]', 60, 10, 1, '2024-01-15 09:00:00', '2024-01-15 09:00:00');
INSERT INTO `dish` (`id`, `name`, `category_id`, `dish_type`, `price`, `image`, `description`, `flavors`, `stock`, `seckill_stock`, `status`, `create_time`, `update_time`) VALUES (4, '可乐', 3, 1, 5.00, 'https://example.com/cola.jpg', '冰镇可乐', '[\"冰\", \"常温\"]', 200, 50, 1, '2024-01-15 09:00:00', '2024-01-15 09:00:00');
INSERT INTO `dish` (`id`, `name`, `category_id`, `dish_type`, `price`, `image`, `description`, `flavors`, `stock`, `seckill_stock`, `status`, `create_time`, `update_time`) VALUES (5, '超值双人套餐', 4, 2, 88.00, 'https://example.com/combo.jpg', '宫保鸡丁+麻婆豆腐+扬州炒饭+2杯可乐', '[]', 50, 10, 1, '2024-01-15 09:00:00', '2024-01-15 09:00:00');
COMMIT;

-- ----------------------------
-- Table structure for order_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail` (
                                `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
                                `order_id` bigint NOT NULL COMMENT '订单ID',
                                `dish_id` bigint NOT NULL COMMENT '菜品ID',
                                `dish_name` varchar(50) NOT NULL COMMENT '菜品名称',
                                `dish_image` varchar(255) DEFAULT NULL COMMENT '菜品图片',
                                `dish_price` decimal(10,2) NOT NULL COMMENT '菜品单价',
                                `quantity` int NOT NULL COMMENT '数量',
                                `total_amount` decimal(10,2) NOT NULL COMMENT '总金额',
                                `flavors` json DEFAULT NULL COMMENT '口味信息',
                                `is_seckill` tinyint(1) DEFAULT '0' COMMENT '是否秒杀商品',
                                PRIMARY KEY (`id`),
                                KEY `idx_order_id` (`order_id`),
                                KEY `idx_dish_id` (`dish_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='订单明细表';

-- ----------------------------
-- Records of order_detail
-- ----------------------------
BEGIN;
INSERT INTO `order_detail` (`id`, `order_id`, `dish_id`, `dish_name`, `dish_image`, `dish_price`, `quantity`, `total_amount`, `flavors`, `is_seckill`) VALUES (1, 1, 5, '超值双人套餐', 'https://example.com/combo.jpg', 88.00, 1, 88.00, '[]', 0);
INSERT INTO `order_detail` (`id`, `order_id`, `dish_id`, `dish_name`, `dish_image`, `dish_price`, `quantity`, `total_amount`, `flavors`, `is_seckill`) VALUES (2, 2, 1, '宫保鸡丁', 'https://example.com/gongbao.jpg', 38.00, 1, 38.00, '[\"微辣\"]', 0);
COMMIT;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
                          `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
                          `order_no` varchar(32) NOT NULL COMMENT '订单号',
                          `user_id` bigint NOT NULL COMMENT '用户ID',
                          `total_amount` decimal(10,2) NOT NULL COMMENT '订单总金额',
                          `actual_amount` decimal(10,2) NOT NULL COMMENT '实付金额',
                          `discount_amount` decimal(10,2) DEFAULT '0.00' COMMENT '优惠金额',
                          `order_status` tinyint(1) NOT NULL COMMENT '1:待付款 2:待接单 3:制作中 4:配送中 5:已完成 6:已取消',
                          `pay_status` tinyint(1) DEFAULT '0' COMMENT '0:未支付 1:已支付 2:已退款',
                          `pay_method` tinyint(1) DEFAULT NULL COMMENT '1:微信 2:支付宝',
                          `address_info` json DEFAULT NULL COMMENT '地址信息JSON',
                          `remark` varchar(200) DEFAULT NULL COMMENT '备注',
                          `order_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '下单时间',
                          `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
                          `complete_time` datetime DEFAULT NULL COMMENT '完成时间',
                          `cancel_time` datetime DEFAULT NULL COMMENT '取消时间',
                          PRIMARY KEY (`id`),
                          UNIQUE KEY `uk_order_no` (`order_no`),
                          KEY `idx_user_id` (`user_id`),
                          KEY `idx_order_time` (`order_time`),
                          KEY `idx_order_status` (`order_status`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='订单表';

-- ----------------------------
-- Records of orders
-- ----------------------------
BEGIN;
INSERT INTO `orders` (`id`, `order_no`, `user_id`, `total_amount`, `actual_amount`, `discount_amount`, `order_status`, `pay_status`, `pay_method`, `address_info`, `remark`, `order_time`, `pay_time`, `complete_time`, `cancel_time`) VALUES (1, 'ORDER202401150001', 1, 96.00, 88.00, 8.00, 5, 1, 1, '{\"phone\": \"13800138001\", \"address\": \"北京市朝阳区xxx街道xxx号\", \"consignee\": \"张三\"}', '不要辣', '2024-01-15 12:00:00', '2024-01-15 12:01:00', '2024-01-15 12:45:00', NULL);
INSERT INTO `orders` (`id`, `order_no`, `user_id`, `total_amount`, `actual_amount`, `discount_amount`, `order_status`, `pay_status`, `pay_method`, `address_info`, `remark`, `order_time`, `pay_time`, `complete_time`, `cancel_time`) VALUES (2, 'ORDER202401150002', 2, 38.00, 38.00, 0.00, 2, 1, 1, '{\"phone\": \"13800138002\", \"address\": \"北京市海淀区xxx小区xxx栋\", \"consignee\": \"李四\"}', '尽快送达', '2024-01-15 12:30:00', '2024-01-15 12:31:00', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for seckill_activity
-- ----------------------------
DROP TABLE IF EXISTS `seckill_activity`;
CREATE TABLE `seckill_activity` (
                                    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
                                    `name` varchar(100) NOT NULL COMMENT '活动名称',
                                    `dish_id` bigint NOT NULL COMMENT '菜品ID',
                                    `seckill_price` decimal(10,2) NOT NULL COMMENT '秒杀价',
                                    `stock` int NOT NULL COMMENT '秒杀库存',
                                    `initial_stock` int NOT NULL COMMENT '初始库存',
                                    `limit_per_user` int DEFAULT '1' COMMENT '每人限购',
                                    `start_time` datetime NOT NULL COMMENT '开始时间',
                                    `end_time` datetime NOT NULL COMMENT '结束时间',
                                    `status` tinyint(1) DEFAULT '1' COMMENT '1:未开始 2:进行中 3:已结束 4:已关闭',
                                    `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                    PRIMARY KEY (`id`),
                                    KEY `idx_dish_id` (`dish_id`),
                                    KEY `idx_time` (`start_time`,`end_time`),
                                    KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='秒杀活动表';

-- ----------------------------
-- Records of seckill_activity
-- ----------------------------
BEGIN;
INSERT INTO `seckill_activity` (`id`, `name`, `dish_id`, `seckill_price`, `stock`, `initial_stock`, `limit_per_user`, `start_time`, `end_time`, `status`, `create_time`, `update_time`) VALUES (1, '宫保鸡丁限时秒杀', 1, 19.90, 20, 20, 1, '2024-01-16 12:00:00', '2024-01-16 14:00:00', 1, '2024-01-15 09:00:00', '2024-01-15 09:00:00');
INSERT INTO `seckill_activity` (`id`, `name`, `dish_id`, `seckill_price`, `stock`, `initial_stock`, `limit_per_user`, `start_time`, `end_time`, `status`, `create_time`, `update_time`) VALUES (2, '可乐特惠秒杀', 4, 2.90, 50, 50, 2, '2024-01-17 10:00:00', '2024-01-17 12:00:00', 1, '2024-01-15 09:00:00', '2024-01-15 09:00:00');
COMMIT;

-- ----------------------------
-- Table structure for shopping_cart
-- ----------------------------
DROP TABLE IF EXISTS `shopping_cart`;
CREATE TABLE `shopping_cart` (
                                 `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
                                 `user_id` bigint NOT NULL COMMENT '用户ID',
                                 `dish_id` bigint NOT NULL COMMENT '菜品ID',
                                 `quantity` int NOT NULL DEFAULT '1' COMMENT '数量',
                                 `flavors` json DEFAULT NULL COMMENT '口味选择',
                                 `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                 PRIMARY KEY (`id`),
                                 UNIQUE KEY `uk_user_dish` (`user_id`,`dish_id`),
                                 KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='购物车表';

-- ----------------------------
-- Records of shopping_cart
-- ----------------------------
BEGIN;
INSERT INTO `shopping_cart` (`id`, `user_id`, `dish_id`, `quantity`, `flavors`, `create_time`) VALUES (1, 1, 2, 1, '[\"微辣\"]', '2024-01-15 14:00:00');
INSERT INTO `shopping_cart` (`id`, `user_id`, `dish_id`, `quantity`, `flavors`, `create_time`) VALUES (2, 1, 4, 2, '[\"冰\"]', '2024-01-15 14:00:00');
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
                        `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
                        `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户账号',
                        `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
                        `user_type` tinyint(1) DEFAULT '1' COMMENT '1:普通用户 2:商家管理员',
                        `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
                        `phone` varchar(11) NOT NULL COMMENT '手机号',
                        `avatar` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '头像地址',
                        `status` tinyint(1) DEFAULT '1' COMMENT '账号状态（0正常 1停用）',
                        `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '密码',
                        `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                        `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                        PRIMARY KEY (`id`) USING BTREE,
                        UNIQUE KEY `uk_phone` (`phone`),
                        KEY `idx_phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` (`id`, `user_name`, `nick_name`, `user_type`, `sex`, `phone`, `avatar`, `status`, `password`, `create_time`, `update_time`) VALUES (1, '', '测试用户1', 1, '0', '13800138001', 'https://example.com/avatar1.jpg', 1, '', '2024-01-15 10:30:00', '2024-01-15 10:30:00');
INSERT INTO `user` (`id`, `user_name`, `nick_name`, `user_type`, `sex`, `phone`, `avatar`, `status`, `password`, `create_time`, `update_time`) VALUES (2, '', '测试用户2', 1, '0', '13800138002', 'https://example.com/avatar2.jpg', 1, '', '2024-01-15 11:20:00', '2024-01-15 11:20:00');
INSERT INTO `user` (`id`, `user_name`, `nick_name`, `user_type`, `sex`, `phone`, `avatar`, `status`, `password`, `create_time`, `update_time`) VALUES (3, '', '商家管理员', 2, '0', '13800138003', 'https://example.com/avatar3.jpg', 1, '', '2024-01-15 12:15:00', '2024-01-15 12:15:00');
COMMIT;

-- ----------------------------
-- Table structure for user_coupon
-- ----------------------------
DROP TABLE IF EXISTS `user_coupon`;
CREATE TABLE `user_coupon` (
                               `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
                               `user_id` bigint NOT NULL COMMENT '用户ID',
                               `coupon_id` bigint NOT NULL COMMENT '优惠券ID',
                               `status` tinyint(1) DEFAULT '0' COMMENT '0:未使用 1:已使用 2:已过期',
                               `get_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '领取时间',
                               `use_time` datetime DEFAULT NULL COMMENT '使用时间',
                               `order_id` bigint DEFAULT NULL COMMENT '使用的订单ID',
                               PRIMARY KEY (`id`),
                               KEY `idx_user_id` (`user_id`),
                               KEY `idx_coupon_id` (`coupon_id`),
                               KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户优惠券表';

-- ----------------------------
-- Records of user_coupon
-- ----------------------------
BEGIN;
INSERT INTO `user_coupon` (`id`, `user_id`, `coupon_id`, `status`, `get_time`, `use_time`, `order_id`) VALUES (1, 1, 1, 1, '2024-01-15 10:00:00', '2024-01-15 12:01:00', 1);
INSERT INTO `user_coupon` (`id`, `user_id`, `coupon_id`, `status`, `get_time`, `use_time`, `order_id`) VALUES (2, 1, 2, 0, '2024-01-15 10:00:00', NULL, NULL);
INSERT INTO `user_coupon` (`id`, `user_id`, `coupon_id`, `status`, `get_time`, `use_time`, `order_id`) VALUES (3, 2, 1, 1, '2024-01-15 10:00:00', '2024-01-15 12:31:00', 2);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
