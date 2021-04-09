/*
Navicat MySQL Data Transfer

Source Server         : 127.0.01
Source Server Version : 50724
Source Host           : localhost:3306
Source Database       : newkey

Target Server Type    : MYSQL
Target Server Version : 50724
File Encoding         : 65001

Date: 2021-04-09 19:27:36
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for ea_customer_contract
-- ----------------------------
DROP TABLE IF EXISTS `ea_customer_contract`;
CREATE TABLE `ea_customer_contract` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL COMMENT '主题公司id',
  `customer_id` int(11) unsigned NOT NULL COMMENT '客户公司id',
  `writer_id` bigint(11) unsigned NOT NULL COMMENT '写入id',
  `sales_id` int(11) NOT NULL COMMENT '销售id',
  `contract_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '合同编号',
  `contract_signer` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '合同签订人',
  `service` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '服务 {checkbox}',
  `language` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '语种{checkbox}',
  `currency` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '币种',
  `unit_price` decimal(10,2) NOT NULL COMMENT '单价',
  `unit` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '单位',
  `estimated_sales` decimal(10,2) NOT NULL COMMENT '预计销售额',
  `tax_rate` int(10) NOT NULL COMMENT '税率',
  `customer_tax_number` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '客户税号',
  `bank_information` tinytext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '银行信息',
  `invoicing_rules` int(10) NOT NULL DEFAULT '0' COMMENT '开票规则 {radio} (1:专票, 2:普票, 0:N/A)',
  `account_period` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '结算方式',
  `confidentiality_agreement` tinyint(10) NOT NULL DEFAULT '0' COMMENT '有无保密协议 {radio} (1:yes, 2:no, 0:N/A)',
  `effective_date` int(11) NOT NULL COMMENT '生效日期',
  `expiration_date` int(11) NOT NULL COMMENT '失效日期',
  `recipient` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '合同收件人',
  `recipient_address` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '合同收件地址',
  `remarks` tinytext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '备注',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `writer_id` (`writer_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `ea_customer_contract_ibfk_1` FOREIGN KEY (`writer_id`) REFERENCES `ea_system_admin` (`id`),
  CONSTRAINT `ea_customer_contract_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `ea_customer_information` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of ea_customer_contract
-- ----------------------------
INSERT INTO `ea_customer_contract` VALUES ('7', '2', '2', '1', '4', 'C-das213213khj20210406', '签订人1', '3', '8', '7', '50.00', '2', '1000.00', '5', 'fdsfdas62631123', '312313', '0', '20天后结算', '0', '1617292800', '1617811200', '合同一收件人', '合同一收货地址', '13', '1617706654', '1617706654');

-- ----------------------------
-- Table structure for ea_customer_demand
-- ----------------------------
DROP TABLE IF EXISTS `ea_customer_demand`;
CREATE TABLE `ea_customer_demand` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contract_id` int(11) unsigned NOT NULL COMMENT '合同id',
  `company_id` int(11) NOT NULL COMMENT '主体公司id',
  `customer_id` int(11) NOT NULL,
  `mid` int(11) NOT NULL COMMENT '项目经理id',
  `writer_id` int(11) DEFAULT NULL,
  `cooperation_first` int(11) NOT NULL DEFAULT '0' COMMENT '是否首次合作 {radio} (1:yes, 2:no, 0:N/A)',
  `quotation_amount` decimal(10,2) NOT NULL COMMENT '报价金额',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ea_customer_demand_ibfk_1` (`contract_id`),
  CONSTRAINT `ea_customer_demand_ibfk_1` FOREIGN KEY (`contract_id`) REFERENCES `ea_customer_contract` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of ea_customer_demand
-- ----------------------------
INSERT INTO `ea_customer_demand` VALUES ('4', '7', '2', '2', '6', '1', '2', '5040.00', '1617707866', '1617707866');
INSERT INTO `ea_customer_demand` VALUES ('5', '7', '2', '2', '6', '1', '2', '50000.00', '1617761306', '1617877575');

-- ----------------------------
-- Table structure for ea_customer_file
-- ----------------------------
DROP TABLE IF EXISTS `ea_customer_file`;
CREATE TABLE `ea_customer_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `demand_id` int(11) NOT NULL COMMENT '来稿需求id',
  `file_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '文件名称',
  `page` tinyint(10) NOT NULL COMMENT '文件页数',
  `number_of_words` int(11) NOT NULL COMMENT '源语数量',
  `file_type` int(11) NOT NULL COMMENT '文件类型{select}',
  `service` int(11) NOT NULL COMMENT '服务{checkbox}',
  `language` int(11) NOT NULL COMMENT '语种{select}',
  `unit_price` decimal(10,2) NOT NULL COMMENT '单价{select}',
  `unit` int(11) NOT NULL COMMENT '单位{select}',
  `quotation_number` int(11) NOT NULL COMMENT '报价数量',
  `tax_rate` int(11) NOT NULL COMMENT '税率{select}',
  `vat` decimal(10,2) NOT NULL COMMENT '增值税',
  `quotation_price` decimal(10,2) NOT NULL COMMENT '报价金额',
  `customer_submit_date` int(11) NOT NULL COMMENT '客户期望提交日期',
  `customer_file_request` tinytext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户要求',
  `customer_file_reference` tinytext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户参考文件',
  `customer_file_remark` tinytext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户参考文件备注',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of ea_customer_file
-- ----------------------------
INSERT INTO `ea_customer_file` VALUES ('1', '5', '文件名称1', '6', '2', '10', '1', '8', '50.00', '1', '2', '12', '0.00', '100.00', '1617878040', '                    3                ', '                    3                ', '                    3                ', '1617878212', '1617964994');
INSERT INTO `ea_customer_file` VALUES ('2', '5', '文件名称2', '6', '3', '10', '1', '8', '50.00', '2', '111', '12', '666.00', '6216.00', '1617878312', '                    1                ', '                    1                ', '                                    ', '1617878321', '1617964983');
INSERT INTO `ea_customer_file` VALUES ('3', '5', '文件名称3', '6', '1', '10', '1', '8', '5.00', '2', '2', '12', '20.00', '30.00', '1618545135', '                                        1                                ', '                                        1                                ', '                                                        35                ', '1617878392', '1617965046');

-- ----------------------------
-- Table structure for ea_customer_information
-- ----------------------------
DROP TABLE IF EXISTS `ea_customer_information`;
CREATE TABLE `ea_customer_information` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `writer_id` int(11) NOT NULL COMMENT '写入人',
  `customer_contact` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '客户联系人',
  `department` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '所在部门',
  `company_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '公司全称',
  `company_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '公司地址',
  `country` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '国家',
  `position` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '职位',
  `mobile_phone_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '移动电话号码',
  `landline_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '固定电话号码',
  `mailbox` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `company_code` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '公司编码',
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `update_time` int(11) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of ea_customer_information
-- ----------------------------
INSERT INTO `ea_customer_information` VALUES ('1', '5', '客户1', '部门1', '客户公司名称1', '公司地址1', '国家1', '职位1', '13257245375', '8512456', 'zhuchenchen@zhuchenchen.cn', 'das21321321gdgd', '                    1312                ', '1617688716', '1617334402');
INSERT INTO `ea_customer_information` VALUES ('2', '1', '客户2', '客户2公司名称', '客户二公司名称', '客户2公司地址', '客户2v', '客户2职位', '13257245375', '8512456', 'zhuchenchen@zhuchenchen.cn', 'das213213khj', '                                                            阿斯顿                                                ', '1617688957', '1617334702');
INSERT INTO `ea_customer_information` VALUES ('3', '2', '客户三客户联系人', '客户三', '客户三公司名称', '客户三', '客户三', '客户三', '13257245375', '8512456', 'zhuchenchen@zhuchenchen.cn', 'das2132', '                                                                                                            ', '1617688918', '1617335104');

-- ----------------------------
-- Table structure for ea_database_content
-- ----------------------------
DROP TABLE IF EXISTS `ea_database_content`;
CREATE TABLE `ea_database_content` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `list_id` int(11) unsigned NOT NULL COMMENT '词条类型',
  `content` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '词条内容',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `list_id` (`list_id`),
  CONSTRAINT `ea_database_content_ibfk_1` FOREIGN KEY (`list_id`) REFERENCES `ea_database_directory` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of ea_database_content
-- ----------------------------
INSERT INTO `ea_database_content` VALUES ('1', '1', '页', '1617347473', '1617347473');
INSERT INTO `ea_database_content` VALUES ('2', '1', '条', '1617347587', '1617347587');
INSERT INTO `ea_database_content` VALUES ('3', '2', '翻译', '1617348761', '1617348761');
INSERT INTO `ea_database_content` VALUES ('4', '2', '排版', '1617348776', '1617348776');
INSERT INTO `ea_database_content` VALUES ('5', '2', '校对', '1617348794', '1617348794');
INSERT INTO `ea_database_content` VALUES ('6', '10', '人民币/CNY', '1617350223', '1617350223');
INSERT INTO `ea_database_content` VALUES ('7', '10', '欧元/EUR', '1617350246', '1617350246');
INSERT INTO `ea_database_content` VALUES ('8', '3', '中文-英文/CN-EN', '1617350452', '1617350452');
INSERT INTO `ea_database_content` VALUES ('9', '3', '英文-中文/EN-CN', '1617350474', '1617687482');
INSERT INTO `ea_database_content` VALUES ('10', '4', 'PDF', '1617762948', '1617762948');
INSERT INTO `ea_database_content` VALUES ('11', '4', 'Word', '1617762972', '1617762972');
INSERT INTO `ea_database_content` VALUES ('12', '9', '6', '1617766962', '1617766962');
INSERT INTO `ea_database_content` VALUES ('13', '9', '9', '1617766971', '1617766971');

-- ----------------------------
-- Table structure for ea_database_directory
-- ----------------------------
DROP TABLE IF EXISTS `ea_database_directory`;
CREATE TABLE `ea_database_directory` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '词库名称',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of ea_database_directory
-- ----------------------------
INSERT INTO `ea_database_directory` VALUES ('1', '单位', '2021-04-02 14:57:41', '2021-04-02 14:57:41');
INSERT INTO `ea_database_directory` VALUES ('2', '服务', '2021-04-02 14:58:12', '2021-04-02 14:58:12');
INSERT INTO `ea_database_directory` VALUES ('3', '语种', '2021-04-02 14:58:47', '2021-04-02 14:58:47');
INSERT INTO `ea_database_directory` VALUES ('4', '文件类型', '2021-04-02 14:58:57', '2021-04-02 14:58:57');
INSERT INTO `ea_database_directory` VALUES ('6', '文件分类', '2021-04-02 14:59:40', '2021-04-02 14:59:40');
INSERT INTO `ea_database_directory` VALUES ('7', '翻译校对工作内容', '2021-04-02 15:00:16', '2021-04-02 15:00:16');
INSERT INTO `ea_database_directory` VALUES ('8', '排版工作内容', '2021-04-02 15:00:25', '2021-04-02 15:00:25');
INSERT INTO `ea_database_directory` VALUES ('9', '税率', '2021-04-02 15:00:34', '2021-04-02 15:00:34');
INSERT INTO `ea_database_directory` VALUES ('10', '币种', '2021-04-02 15:56:21', '2021-04-02 15:56:21');

-- ----------------------------
-- Table structure for ea_main_company
-- ----------------------------
DROP TABLE IF EXISTS `ea_main_company`;
CREATE TABLE `ea_main_company` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `chinese_company_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '中文公司名称',
  `english_company_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `chinese_company_address` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '公司地址',
  `english_company_address` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '公司地址',
  `main_company_tax_number` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '税号',
  `chinese_bank_information` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '银行信息',
  `english_bank_information` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of ea_main_company
-- ----------------------------
INSERT INTO `ea_main_company` VALUES ('1', '中文公司名称1', '英文公司名称1', '公司地址', '英文公司地址', '212121dasddasasasasas213213123213', '     银行信息                                                                                                ', '                           das                                                                                ');
INSERT INTO `ea_main_company` VALUES ('2', '中文公司名称2', '英文公司名称2', '中文公司名称2', '英文公司名称2', 's9dsad4a4', '中文公司名称2', '中文公司名称2');

-- ----------------------------
-- Table structure for ea_mall_cate
-- ----------------------------
DROP TABLE IF EXISTS `ea_mall_cate`;
CREATE TABLE `ea_mall_cate` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL COMMENT '分类名',
  `image` varchar(500) DEFAULT NULL COMMENT '分类图片',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态(1:禁用,2:启用)',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注说明',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品分类';

-- ----------------------------
-- Records of ea_mall_cate
-- ----------------------------
INSERT INTO `ea_mall_cate` VALUES ('9', '手机', 'http://admin.host/upload/20200514/98fc09b0c4ad4d793a6f04bef79a0edc.jpg', '0', '1', '', '1589440437', '1589440437', null);
INSERT INTO `ea_mall_cate` VALUES ('10', '计算机内存', 'http://easyadmin.test/upload/20210401/0afd939a10d07cdb0a2f0e798768768e.png', '0', '1', '', '1617277501', '1617277501', null);

-- ----------------------------
-- Table structure for ea_mall_goods
-- ----------------------------
DROP TABLE IF EXISTS `ea_mall_goods`;
CREATE TABLE `ea_mall_goods` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cate_id` int(11) DEFAULT NULL COMMENT '分类ID',
  `title` varchar(20) NOT NULL COMMENT '商品名称',
  `logo` varchar(500) DEFAULT NULL COMMENT '商品logo',
  `images` text COMMENT '商品图片 以 | 做分割符号',
  `describe` text COMMENT '商品描述',
  `market_price` decimal(10,2) DEFAULT '0.00' COMMENT '市场价',
  `discount_price` decimal(10,2) DEFAULT '0.00' COMMENT '折扣价',
  `sales` int(11) DEFAULT '0' COMMENT '销量',
  `virtual_sales` int(11) DEFAULT '0' COMMENT '虚拟销量',
  `stock` int(11) DEFAULT '0' COMMENT '库存',
  `total_stock` int(11) DEFAULT '0' COMMENT '总库存',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态(1:禁用,2:启用)',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注说明',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `cate_id` (`cate_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品列表';

-- ----------------------------
-- Records of ea_mall_goods
-- ----------------------------
INSERT INTO `ea_mall_goods` VALUES ('8', '10', '落地-风扇', 'http://admin.host/upload/20200514/a0f7fe9637abd219f7e93ceb2820df9b.jpg', 'http://admin.host/upload/20200514/95496713918290f6315ea3f87efa6bf2.jpg|http://admin.host/upload/20200514/ae29fa9cba4fc02defb7daed41cb2b13.jpg|http://admin.host/upload/20200514/f0a104d88ec7dc6fb42d2f87cbc71b76.jpg|http://admin.host/upload/20200514/3b88be4b1934690e5c1bd6b54b9ab5c8.jpg', '<p>76654757</p>\n\n<p><img alt=\"\" src=\"http://admin.host/upload/20200515/198070421110fa01f2c2ac2f52481647.jpg\" style=\"height:689px; width:790px\" /></p>\n\n<p><img alt=\"\" src=\"http://admin.host/upload/20200515/a07a742c15a78781e79f8a3317006c1d.jpg\" style=\"height:877px; width:790px\" /></p>\n', '599.00', '368.00', '0', '594', '0', '0', '675', '1', '', '1589454309', '1589567016', null);
INSERT INTO `ea_mall_goods` VALUES ('9', '9', '电脑', 'http://admin.host/upload/20200514/bbf858d469dec2e12a89460110068d3d.jpg', 'http://admin.host/upload/20200514/f0a104d88ec7dc6fb42d2f87cbc71b76.jpg', '<p>477</p>\n', '0.00', '0.00', '0', '0', '115', '320', '0', '1', '', '1589465215', '1589476345', null);

-- ----------------------------
-- Table structure for ea_system_admin
-- ----------------------------
DROP TABLE IF EXISTS `ea_system_admin`;
CREATE TABLE `ea_system_admin` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `auth_ids` varchar(255) DEFAULT NULL COMMENT '角色权限ID',
  `head_img` varchar(255) DEFAULT NULL COMMENT '头像',
  `username` varchar(50) NOT NULL DEFAULT '' COMMENT '用户登录名',
  `password` char(40) NOT NULL DEFAULT '' COMMENT '用户登录密码',
  `phone` varchar(16) DEFAULT NULL COMMENT '联系手机号',
  `remark` varchar(255) DEFAULT '' COMMENT '备注说明',
  `login_num` bigint(20) unsigned DEFAULT '0' COMMENT '登录次数',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态(0:禁用,1:启用,)',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE,
  KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统用户表';

-- ----------------------------
-- Records of ea_system_admin
-- ----------------------------
INSERT INTO `ea_system_admin` VALUES ('1', '1,7', '/static/admin/images/head.jpg', 'admin', '3e128eeae279e37c50fcd0a1cf3a5e6ab00df413', 'admin', 'admin', '31', '0', '1', '1617274397', '1617962332', null);
INSERT INTO `ea_system_admin` VALUES ('2', '1', 'https://lxn-99php.oss-cn-shenzhen.aliyuncs.com/upload/20191111/28cefa547f573a951bcdbbeb1396b06f.jpg', 'zcc', 'ed696eb5bba1f7460585cc6975e6cf9bf24903dd', '朱晨晨', '朱晨晨', '1', '0', '1', '1617274467', '1617275572', null);
INSERT INTO `ea_system_admin` VALUES ('3', '9', 'http://easyadmin.test/upload/20210401/0afd939a10d07cdb0a2f0e798768768e.png', '销售1', '', '', '', '0', '0', '1', '1617344766', '1617344766', null);
INSERT INTO `ea_system_admin` VALUES ('4', '9', 'http://easyadmin.test/upload/20210401/0afd939a10d07cdb0a2f0e798768768e.png', '销售2', '', '', '', '0', '0', '1', '1617344787', '1617344787', null);
INSERT INTO `ea_system_admin` VALUES ('5', '1,11', 'http://easyadmin.test/upload/20210401/0afd939a10d07cdb0a2f0e798768768e.png', 'test1', 'ed696eb5bba1f7460585cc6975e6cf9bf24903dd', 'test1', 'test1', '8', '0', '1', '1617361321', '1617878743', null);
INSERT INTO `ea_system_admin` VALUES ('6', '12', 'http://admin.host/upload/20200514/e1c6c9ef6a4b98b8f7d95a1a0191a2df.jpg', '项目经理1', '', '', '', '0', '0', '1', '1617688009', '1617688009', null);
INSERT INTO `ea_system_admin` VALUES ('7', '12', 'http://admin.host/upload/20200514/98fc09b0c4ad4d793a6f04bef79a0edc.jpg', '项目经理2', '', '', '', '0', '0', '1', '1617688035', '1617688035', null);

-- ----------------------------
-- Table structure for ea_system_auth
-- ----------------------------
DROP TABLE IF EXISTS `ea_system_auth`;
CREATE TABLE `ea_system_auth` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL COMMENT '权限名称',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态(1:禁用,2:启用)',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注说明',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统权限表';

-- ----------------------------
-- Records of ea_system_auth
-- ----------------------------
INSERT INTO `ea_system_auth` VALUES ('1', '管理员', '1', '1', '测试管理员', '1588921753', '1589614331', null);
INSERT INTO `ea_system_auth` VALUES ('6', '游客权限', '0', '1', '', '1588227513', '1589591751', '1589591751');
INSERT INTO `ea_system_auth` VALUES ('7', '市场', '0', '1', '', '1617274631', '1617274631', null);
INSERT INTO `ea_system_auth` VALUES ('8', '项目', '0', '1', '', '1617277117', '1617277117', null);
INSERT INTO `ea_system_auth` VALUES ('9', '销售', '0', '1', '', '1617327386', '1617327386', null);
INSERT INTO `ea_system_auth` VALUES ('11', '管理', '0', '1', '', '1617338875', '1617338875', null);
INSERT INTO `ea_system_auth` VALUES ('12', '项目经理', '0', '1', '项目经理', '1617687965', '1617687965', null);

-- ----------------------------
-- Table structure for ea_system_auth_node
-- ----------------------------
DROP TABLE IF EXISTS `ea_system_auth_node`;
CREATE TABLE `ea_system_auth_node` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `auth_id` bigint(20) unsigned DEFAULT NULL COMMENT '角色ID',
  `node_id` bigint(20) DEFAULT NULL COMMENT '节点ID',
  PRIMARY KEY (`id`),
  KEY `index_system_auth_auth` (`auth_id`) USING BTREE,
  KEY `index_system_auth_node` (`node_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='角色与节点关系表';

-- ----------------------------
-- Records of ea_system_auth_node
-- ----------------------------
INSERT INTO `ea_system_auth_node` VALUES ('1', '6', '1');
INSERT INTO `ea_system_auth_node` VALUES ('2', '6', '2');
INSERT INTO `ea_system_auth_node` VALUES ('3', '6', '9');
INSERT INTO `ea_system_auth_node` VALUES ('4', '6', '12');
INSERT INTO `ea_system_auth_node` VALUES ('5', '6', '18');
INSERT INTO `ea_system_auth_node` VALUES ('6', '6', '19');
INSERT INTO `ea_system_auth_node` VALUES ('7', '6', '21');
INSERT INTO `ea_system_auth_node` VALUES ('8', '6', '22');
INSERT INTO `ea_system_auth_node` VALUES ('9', '6', '29');
INSERT INTO `ea_system_auth_node` VALUES ('10', '6', '30');
INSERT INTO `ea_system_auth_node` VALUES ('11', '6', '38');
INSERT INTO `ea_system_auth_node` VALUES ('12', '6', '39');
INSERT INTO `ea_system_auth_node` VALUES ('13', '6', '45');
INSERT INTO `ea_system_auth_node` VALUES ('14', '6', '46');
INSERT INTO `ea_system_auth_node` VALUES ('15', '6', '52');
INSERT INTO `ea_system_auth_node` VALUES ('16', '6', '53');
INSERT INTO `ea_system_auth_node` VALUES ('73', '11', '1');
INSERT INTO `ea_system_auth_node` VALUES ('74', '11', '2');
INSERT INTO `ea_system_auth_node` VALUES ('75', '11', '3');
INSERT INTO `ea_system_auth_node` VALUES ('76', '11', '4');
INSERT INTO `ea_system_auth_node` VALUES ('77', '11', '5');
INSERT INTO `ea_system_auth_node` VALUES ('78', '11', '6');
INSERT INTO `ea_system_auth_node` VALUES ('79', '11', '7');
INSERT INTO `ea_system_auth_node` VALUES ('80', '11', '8');
INSERT INTO `ea_system_auth_node` VALUES ('81', '11', '9');
INSERT INTO `ea_system_auth_node` VALUES ('82', '11', '10');
INSERT INTO `ea_system_auth_node` VALUES ('83', '11', '11');
INSERT INTO `ea_system_auth_node` VALUES ('84', '11', '12');
INSERT INTO `ea_system_auth_node` VALUES ('85', '11', '13');
INSERT INTO `ea_system_auth_node` VALUES ('86', '11', '14');
INSERT INTO `ea_system_auth_node` VALUES ('87', '11', '15');
INSERT INTO `ea_system_auth_node` VALUES ('88', '11', '16');
INSERT INTO `ea_system_auth_node` VALUES ('89', '11', '17');
INSERT INTO `ea_system_auth_node` VALUES ('90', '11', '21');
INSERT INTO `ea_system_auth_node` VALUES ('91', '11', '22');
INSERT INTO `ea_system_auth_node` VALUES ('92', '11', '23');
INSERT INTO `ea_system_auth_node` VALUES ('93', '11', '24');
INSERT INTO `ea_system_auth_node` VALUES ('94', '11', '25');
INSERT INTO `ea_system_auth_node` VALUES ('95', '11', '26');
INSERT INTO `ea_system_auth_node` VALUES ('96', '11', '27');
INSERT INTO `ea_system_auth_node` VALUES ('97', '11', '28');
INSERT INTO `ea_system_auth_node` VALUES ('98', '11', '67');
INSERT INTO `ea_system_auth_node` VALUES ('99', '11', '68');
INSERT INTO `ea_system_auth_node` VALUES ('100', '11', '76');
INSERT INTO `ea_system_auth_node` VALUES ('101', '11', '77');
INSERT INTO `ea_system_auth_node` VALUES ('102', '11', '78');
INSERT INTO `ea_system_auth_node` VALUES ('103', '11', '79');
INSERT INTO `ea_system_auth_node` VALUES ('104', '11', '80');
INSERT INTO `ea_system_auth_node` VALUES ('105', '11', '81');
INSERT INTO `ea_system_auth_node` VALUES ('106', '11', '82');
INSERT INTO `ea_system_auth_node` VALUES ('107', '11', '83');
INSERT INTO `ea_system_auth_node` VALUES ('108', '11', '84');
INSERT INTO `ea_system_auth_node` VALUES ('109', '11', '85');
INSERT INTO `ea_system_auth_node` VALUES ('110', '11', '86');
INSERT INTO `ea_system_auth_node` VALUES ('111', '11', '87');
INSERT INTO `ea_system_auth_node` VALUES ('112', '11', '88');
INSERT INTO `ea_system_auth_node` VALUES ('113', '11', '89');
INSERT INTO `ea_system_auth_node` VALUES ('114', '11', '90');
INSERT INTO `ea_system_auth_node` VALUES ('115', '11', '91');
INSERT INTO `ea_system_auth_node` VALUES ('116', '11', '92');
INSERT INTO `ea_system_auth_node` VALUES ('117', '11', '93');
INSERT INTO `ea_system_auth_node` VALUES ('118', '11', '94');
INSERT INTO `ea_system_auth_node` VALUES ('119', '11', '95');
INSERT INTO `ea_system_auth_node` VALUES ('120', '11', '96');
INSERT INTO `ea_system_auth_node` VALUES ('121', '11', '97');
INSERT INTO `ea_system_auth_node` VALUES ('122', '11', '98');
INSERT INTO `ea_system_auth_node` VALUES ('123', '11', '99');
INSERT INTO `ea_system_auth_node` VALUES ('124', '11', '100');
INSERT INTO `ea_system_auth_node` VALUES ('125', '11', '101');
INSERT INTO `ea_system_auth_node` VALUES ('126', '11', '102');
INSERT INTO `ea_system_auth_node` VALUES ('127', '11', '103');
INSERT INTO `ea_system_auth_node` VALUES ('128', '11', '111');
INSERT INTO `ea_system_auth_node` VALUES ('129', '11', '112');
INSERT INTO `ea_system_auth_node` VALUES ('130', '11', '113');
INSERT INTO `ea_system_auth_node` VALUES ('131', '11', '114');
INSERT INTO `ea_system_auth_node` VALUES ('132', '11', '115');
INSERT INTO `ea_system_auth_node` VALUES ('133', '11', '116');
INSERT INTO `ea_system_auth_node` VALUES ('134', '11', '117');
INSERT INTO `ea_system_auth_node` VALUES ('135', '1', '1');
INSERT INTO `ea_system_auth_node` VALUES ('136', '1', '2');
INSERT INTO `ea_system_auth_node` VALUES ('137', '1', '3');
INSERT INTO `ea_system_auth_node` VALUES ('138', '1', '4');
INSERT INTO `ea_system_auth_node` VALUES ('139', '1', '5');
INSERT INTO `ea_system_auth_node` VALUES ('140', '1', '6');
INSERT INTO `ea_system_auth_node` VALUES ('141', '1', '7');
INSERT INTO `ea_system_auth_node` VALUES ('142', '1', '8');
INSERT INTO `ea_system_auth_node` VALUES ('143', '1', '9');
INSERT INTO `ea_system_auth_node` VALUES ('144', '1', '10');
INSERT INTO `ea_system_auth_node` VALUES ('145', '1', '11');
INSERT INTO `ea_system_auth_node` VALUES ('146', '1', '12');
INSERT INTO `ea_system_auth_node` VALUES ('147', '1', '13');
INSERT INTO `ea_system_auth_node` VALUES ('148', '1', '14');
INSERT INTO `ea_system_auth_node` VALUES ('149', '1', '15');
INSERT INTO `ea_system_auth_node` VALUES ('150', '1', '16');
INSERT INTO `ea_system_auth_node` VALUES ('151', '1', '17');
INSERT INTO `ea_system_auth_node` VALUES ('152', '1', '21');
INSERT INTO `ea_system_auth_node` VALUES ('153', '1', '22');
INSERT INTO `ea_system_auth_node` VALUES ('154', '1', '23');
INSERT INTO `ea_system_auth_node` VALUES ('155', '1', '24');
INSERT INTO `ea_system_auth_node` VALUES ('156', '1', '25');
INSERT INTO `ea_system_auth_node` VALUES ('157', '1', '26');
INSERT INTO `ea_system_auth_node` VALUES ('158', '1', '27');
INSERT INTO `ea_system_auth_node` VALUES ('159', '1', '28');
INSERT INTO `ea_system_auth_node` VALUES ('160', '1', '67');
INSERT INTO `ea_system_auth_node` VALUES ('161', '1', '68');
INSERT INTO `ea_system_auth_node` VALUES ('162', '1', '76');
INSERT INTO `ea_system_auth_node` VALUES ('163', '1', '77');
INSERT INTO `ea_system_auth_node` VALUES ('164', '1', '78');
INSERT INTO `ea_system_auth_node` VALUES ('165', '1', '79');
INSERT INTO `ea_system_auth_node` VALUES ('166', '1', '80');
INSERT INTO `ea_system_auth_node` VALUES ('167', '1', '81');
INSERT INTO `ea_system_auth_node` VALUES ('168', '1', '82');
INSERT INTO `ea_system_auth_node` VALUES ('169', '1', '83');
INSERT INTO `ea_system_auth_node` VALUES ('170', '1', '84');
INSERT INTO `ea_system_auth_node` VALUES ('171', '1', '85');
INSERT INTO `ea_system_auth_node` VALUES ('172', '1', '86');
INSERT INTO `ea_system_auth_node` VALUES ('173', '1', '87');
INSERT INTO `ea_system_auth_node` VALUES ('174', '1', '88');
INSERT INTO `ea_system_auth_node` VALUES ('175', '1', '89');
INSERT INTO `ea_system_auth_node` VALUES ('176', '1', '90');
INSERT INTO `ea_system_auth_node` VALUES ('177', '1', '91');
INSERT INTO `ea_system_auth_node` VALUES ('178', '1', '92');
INSERT INTO `ea_system_auth_node` VALUES ('179', '1', '93');
INSERT INTO `ea_system_auth_node` VALUES ('180', '1', '94');
INSERT INTO `ea_system_auth_node` VALUES ('181', '1', '95');
INSERT INTO `ea_system_auth_node` VALUES ('182', '1', '96');
INSERT INTO `ea_system_auth_node` VALUES ('183', '1', '97');
INSERT INTO `ea_system_auth_node` VALUES ('184', '1', '98');
INSERT INTO `ea_system_auth_node` VALUES ('185', '1', '99');
INSERT INTO `ea_system_auth_node` VALUES ('186', '1', '100');
INSERT INTO `ea_system_auth_node` VALUES ('187', '1', '101');
INSERT INTO `ea_system_auth_node` VALUES ('188', '1', '102');
INSERT INTO `ea_system_auth_node` VALUES ('189', '1', '103');
INSERT INTO `ea_system_auth_node` VALUES ('190', '1', '111');
INSERT INTO `ea_system_auth_node` VALUES ('191', '1', '112');
INSERT INTO `ea_system_auth_node` VALUES ('192', '1', '113');
INSERT INTO `ea_system_auth_node` VALUES ('193', '1', '114');
INSERT INTO `ea_system_auth_node` VALUES ('194', '1', '115');
INSERT INTO `ea_system_auth_node` VALUES ('195', '1', '116');
INSERT INTO `ea_system_auth_node` VALUES ('196', '1', '117');
INSERT INTO `ea_system_auth_node` VALUES ('197', '1', '118');
INSERT INTO `ea_system_auth_node` VALUES ('198', '1', '119');
INSERT INTO `ea_system_auth_node` VALUES ('199', '1', '120');
INSERT INTO `ea_system_auth_node` VALUES ('200', '1', '121');
INSERT INTO `ea_system_auth_node` VALUES ('201', '1', '122');
INSERT INTO `ea_system_auth_node` VALUES ('202', '1', '123');
INSERT INTO `ea_system_auth_node` VALUES ('203', '1', '124');
INSERT INTO `ea_system_auth_node` VALUES ('204', '1', '125');
INSERT INTO `ea_system_auth_node` VALUES ('205', '1', '126');
INSERT INTO `ea_system_auth_node` VALUES ('206', '1', '127');
INSERT INTO `ea_system_auth_node` VALUES ('207', '1', '128');
INSERT INTO `ea_system_auth_node` VALUES ('208', '1', '129');
INSERT INTO `ea_system_auth_node` VALUES ('209', '1', '130');
INSERT INTO `ea_system_auth_node` VALUES ('210', '1', '131');

-- ----------------------------
-- Table structure for ea_system_config
-- ----------------------------
DROP TABLE IF EXISTS `ea_system_config`;
CREATE TABLE `ea_system_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '变量名',
  `group` varchar(30) NOT NULL DEFAULT '' COMMENT '分组',
  `value` text COMMENT '变量值',
  `remark` varchar(100) DEFAULT '' COMMENT '备注信息',
  `sort` int(10) DEFAULT '0',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `group` (`group`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统配置表';

-- ----------------------------
-- Records of ea_system_config
-- ----------------------------
INSERT INTO `ea_system_config` VALUES ('41', 'alisms_access_key_id', 'sms', '填你的', '阿里大于公钥', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('42', 'alisms_access_key_secret', 'sms', '填你的', '阿里大鱼私钥', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('55', 'upload_type', 'upload', 'local', '当前上传方式 （local,alioss,qnoss,txoss）', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('56', 'upload_allow_ext', 'upload', 'doc,gif,ico,icon,jpg,mp3,mp4,p12,pem,png,rar,jpeg', '允许上传的文件类型', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('57', 'upload_allow_size', 'upload', '1024000', '允许上传的大小', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('58', 'upload_allow_mime', 'upload', 'image/gif,image/jpeg,video/x-msvideo,text/plain,image/png', '允许上传的文件mime', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('59', 'upload_allow_type', 'upload', 'local,alioss,qnoss,txcos', '可用的上传文件方式', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('60', 'alioss_access_key_id', 'upload', '填你的', '阿里云oss公钥', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('61', 'alioss_access_key_secret', 'upload', '填你的', '阿里云oss私钥', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('62', 'alioss_endpoint', 'upload', '填你的', '阿里云oss数据中心', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('63', 'alioss_bucket', 'upload', '填你的', '阿里云oss空间名称', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('64', 'alioss_domain', 'upload', '填你的', '阿里云oss访问域名', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('65', 'logo_title', 'site', 'EasyAdmin', 'LOGO标题', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('66', 'logo_image', 'site', '/favicon.ico', 'logo图片', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('68', 'site_name', 'site', 'codex系统', '站点名称', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('69', 'site_ico', 'site', 'https://lxn-99php.oss-cn-shenzhen.aliyuncs.com/upload/20191111/7d32671f4c1d1b01b0b28f45205763f9.ico', '浏览器图标', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('70', 'site_copyright', 'site', '无', '版权信息', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('71', 'site_beian', 'site', '无', '备案信息', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('72', 'site_version', 'site', '2.0.0', '版本信息', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('75', 'sms_type', 'sms', 'alisms', '短信类型', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('76', 'miniapp_appid', 'wechat', '填你的', '小程序公钥', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('77', 'miniapp_appsecret', 'wechat', '填你的', '小程序私钥', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('78', 'web_appid', 'wechat', '填你的', '公众号公钥', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('79', 'web_appsecret', 'wechat', '填你的', '公众号私钥', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('80', 'txcos_secret_id', 'upload', '填你的', '腾讯云cos密钥', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('81', 'txcos_secret_key', 'upload', '填你的', '腾讯云cos私钥', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('82', 'txcos_region', 'upload', '填你的', '存储桶地域', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('83', 'tecos_bucket', 'upload', '填你的', '存储桶名称', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('84', 'qnoss_access_key', 'upload', '填你的', '访问密钥', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('85', 'qnoss_secret_key', 'upload', '填你的', '安全密钥', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('86', 'qnoss_bucket', 'upload', '填你的', '存储空间', '0', null, null);
INSERT INTO `ea_system_config` VALUES ('87', 'qnoss_domain', 'upload', '填你的', '访问域名', '0', null, null);

-- ----------------------------
-- Table structure for ea_system_log_202104
-- ----------------------------
DROP TABLE IF EXISTS `ea_system_log_202104`;
CREATE TABLE `ea_system_log_202104` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) unsigned DEFAULT '0' COMMENT '管理员ID',
  `url` varchar(1500) NOT NULL DEFAULT '' COMMENT '操作页面',
  `method` varchar(50) NOT NULL COMMENT '请求方法',
  `title` varchar(100) DEFAULT '' COMMENT '日志标题',
  `content` text NOT NULL COMMENT '内容',
  `ip` varchar(50) NOT NULL DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) DEFAULT '' COMMENT 'User-Agent',
  `create_time` int(10) DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=951 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='后台操作日志表 - 202104';

-- ----------------------------
-- Records of ea_system_log_202104
-- ----------------------------
INSERT INTO `ea_system_log_202104` VALUES ('630', null, '/admin/login/index.html', 'post', '', '{\"\\/admin\\/login\\/index_html\":\"\",\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"captcha\":\"cdvg\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617274413');
INSERT INTO `ea_system_log_202104` VALUES ('631', '1', '/admin/system.admin/add', 'post', '', '{\"\\/admin\\/system_admin\\/add\":\"\",\"head_img\":\"https:\\/\\/lxn-99php.oss-cn-shenzhen.aliyuncs.com\\/upload\\/20191111\\/28cefa547f573a951bcdbbeb1396b06f.jpg\",\"file\":\"\",\"username\":\"朱晨晨\",\"phone\":\"13257275375\",\"auth_ids\":{\"1\":\"on\"},\"remark\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617274467');
INSERT INTO `ea_system_log_202104` VALUES ('632', '1', '/admin/system.node/refreshNode?force=1', 'post', '', '{\"\\/admin\\/system_node\\/refreshNode\":\"\",\"force\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617274550');
INSERT INTO `ea_system_log_202104` VALUES ('633', '1', '/admin/system.auth/add', 'post', '', '{\"\\/admin\\/system_auth\\/add\":\"\",\"title\":\"市场\",\"remark\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617274630');
INSERT INTO `ea_system_log_202104` VALUES ('634', '1', '/admin/system.node/modify', 'post', '', '{\"\\/admin\\/system_node\\/modify\":\"\",\"id\":\"52\",\"field\":\"is_auth\",\"value\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617274894');
INSERT INTO `ea_system_log_202104` VALUES ('635', '1', '/admin/system.node/clearNode', 'post', '', '{\"\\/admin\\/system_node\\/clearNode\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617274899');
INSERT INTO `ea_system_log_202104` VALUES ('636', '1', '/admin/system.menu/modify', 'post', '', '{\"\\/admin\\/system_menu\\/modify\":\"\",\"id\":\"249\",\"field\":\"status\",\"value\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617274935');
INSERT INTO `ea_system_log_202104` VALUES ('637', null, '/admin/login/index', 'post', '', '{\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"captcha\":\"yfry\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617275013');
INSERT INTO `ea_system_log_202104` VALUES ('638', '1', '/admin/system.auth/saveAuthorize', 'post', '', '{\"\\/admin\\/system_auth\\/saveAuthorize\":\"\",\"title\":\"管理员\",\"node\":\"[1,2,3,4,5,6,7,8]\",\"id\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617275052');
INSERT INTO `ea_system_log_202104` VALUES ('639', '1', '/admin/system.admin/edit?id=2', 'post', '', '{\"\\/admin\\/system_admin\\/edit\":\"\",\"id\":\"2\",\"head_img\":\"https:\\/\\/lxn-99php.oss-cn-shenzhen.aliyuncs.com\\/upload\\/20191111\\/28cefa547f573a951bcdbbeb1396b06f.jpg\",\"file\":\"\",\"username\":\"朱晨晨\",\"phone\":\"朱晨晨\",\"auth_ids\":{\"1\":\"on\"},\"remark\":\"朱晨晨\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617275066');
INSERT INTO `ea_system_log_202104` VALUES ('640', null, '/admin/login/index', 'post', '', '{\"username\":\"朱晨晨\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"captcha\":\"pnt3\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617275086');
INSERT INTO `ea_system_log_202104` VALUES ('641', null, '/admin/login/index', 'post', '', '{\"username\":\"朱晨晨\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"captcha\":\"yrjj\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617275100');
INSERT INTO `ea_system_log_202104` VALUES ('642', null, '/admin/login/index', 'post', '', '{\"username\":\"朱晨晨\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"captcha\":\"khyn\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617275111');
INSERT INTO `ea_system_log_202104` VALUES ('643', null, '/admin/login/index', 'post', '', '{\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"captcha\":\"mrww\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617275122');
INSERT INTO `ea_system_log_202104` VALUES ('644', '1', '/admin/system.admin/password?id=2', 'post', '', '{\"\\/admin\\/system_admin\\/password\":\"\",\"id\":\"2\",\"username\":\"朱晨晨\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"password_again\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617275496');
INSERT INTO `ea_system_log_202104` VALUES ('645', '1', '/admin/system.admin/password?id=2', 'post', '', '{\"\\/admin\\/system_admin\\/password\":\"\",\"id\":\"2\",\"username\":\"朱晨晨\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"password_again\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617275499');
INSERT INTO `ea_system_log_202104` VALUES ('646', '1', '/admin/system.admin/password?id=2', 'post', '', '{\"\\/admin\\/system_admin\\/password\":\"\",\"id\":\"2\",\"username\":\"朱晨晨\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"password_again\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617275501');
INSERT INTO `ea_system_log_202104` VALUES ('647', '1', '/admin/system.admin/password?id=2', 'post', '', '{\"\\/admin\\/system_admin\\/password\":\"\",\"id\":\"2\",\"username\":\"朱晨晨\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"password_again\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617275511');
INSERT INTO `ea_system_log_202104` VALUES ('648', null, '/admin/login/index', 'post', '', '{\"username\":\"zcc\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617275572');
INSERT INTO `ea_system_log_202104` VALUES ('649', null, '/admin/login/index', 'post', '', '{\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617275592');
INSERT INTO `ea_system_log_202104` VALUES ('650', '1', '/admin/system.config/save', 'post', '', '{\"\\/admin\\/system_config\\/save\":\"\",\"site_name\":\"codex系统\",\"site_ico\":\"https:\\/\\/lxn-99php.oss-cn-shenzhen.aliyuncs.com\\/upload\\/20191111\\/7d32671f4c1d1b01b0b28f45205763f9.ico\",\"file\":\"\",\"site_version\":\"2.0.0\",\"site_beian\":\"无\",\"site_copyright\":\"无\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617275840');
INSERT INTO `ea_system_log_202104` VALUES ('651', '1', '/admin/system.config/save', 'post', '', '{\"\\/admin\\/system_config\\/save\":\"\",\"site_name\":\"codex系统\",\"site_ico\":\"https:\\/\\/lxn-99php.oss-cn-shenzhen.aliyuncs.com\\/upload\\/20191111\\/7d32671f4c1d1b01b0b28f45205763f9.ico\",\"file\":\"\",\"site_version\":\"2.0.0\",\"site_beian\":\"无\",\"site_copyright\":\"无\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617275846');
INSERT INTO `ea_system_log_202104` VALUES ('652', null, '/admin/login/index', 'post', '', '{\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617275890');
INSERT INTO `ea_system_log_202104` VALUES ('653', '1', '/admin/system.node/refreshNode?force=1', 'post', '', '{\"\\/admin\\/system_node\\/refreshNode\":\"\",\"force\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617276694');
INSERT INTO `ea_system_log_202104` VALUES ('654', '1', '/admin/system.menu/add', 'post', '', '{\"\\/admin\\/system_menu\\/add\":\"\",\"pid\":\"0\",\"title\":\"客户管理\",\"href\":\"\",\"icon\":\"fa fa-list\",\"target\":\"_parent\",\"sort\":\"0\",\"remark\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617276791');
INSERT INTO `ea_system_log_202104` VALUES ('655', '1', '/admin/system.node/refreshNode?force=1', 'post', '', '{\"\\/admin\\/system_node\\/refreshNode\":\"\",\"force\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617276810');
INSERT INTO `ea_system_log_202104` VALUES ('656', '1', '/admin/system.node/modify', 'post', '', '{\"\\/admin\\/system_node\\/modify\":\"\",\"id\":\"69\",\"field\":\"title\",\"value\":\"客户管理\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617276832');
INSERT INTO `ea_system_log_202104` VALUES ('657', null, '/admin/login/index', 'post', '', '{\"username\":\"admin\",\"password\":\"a33b679d5581a8692988ec9f92ad2d6a2259eaa7\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617276851');
INSERT INTO `ea_system_log_202104` VALUES ('658', null, '/admin/login/index', 'post', '', '{\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617276855');
INSERT INTO `ea_system_log_202104` VALUES ('659', '1', '/admin/system.menu/add?id=254', 'post', '', '{\"\\/admin\\/system_menu\\/add\":\"\",\"id\":\"254\",\"pid\":\"254\",\"title\":\"合同管理\",\"href\":\"\",\"icon\":\"fa fa-list\",\"target\":\"_blank\",\"sort\":\"0\",\"remark\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617276893');
INSERT INTO `ea_system_log_202104` VALUES ('660', '1', '/admin/system.admin/edit?id=1', 'post', '', '{\"\\/admin\\/system_admin\\/edit\":\"\",\"id\":\"1\",\"head_img\":\"\\/static\\/admin\\/images\\/head.jpg\",\"file\":\"\",\"username\":\"admin\",\"phone\":\"admin\",\"auth_ids\":{\"1\":\"on\",\"7\":\"on\"},\"remark\":\"admin\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617276945');
INSERT INTO `ea_system_log_202104` VALUES ('661', '1', '/admin/system.menu/edit?id=255', 'post', '', '{\"\\/admin\\/system_menu\\/edit\":\"\",\"id\":\"255\",\"pid\":\"254\",\"title\":\"合同管理\",\"href\":\"client.contract\\/index\",\"icon\":\"fa fa-list\",\"target\":\"_blank\",\"sort\":\"0\",\"remark\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617276970');
INSERT INTO `ea_system_log_202104` VALUES ('662', '1', '/admin/system.node/clearNode', 'post', '', '{\"\\/admin\\/system_node\\/clearNode\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617276981');
INSERT INTO `ea_system_log_202104` VALUES ('663', '1', '/admin/system.node/refreshNode?force=0', 'post', '', '{\"\\/admin\\/system_node\\/refreshNode\":\"\",\"force\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617276984');
INSERT INTO `ea_system_log_202104` VALUES ('664', null, '/admin/login/index', 'post', '', '{\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617276995');
INSERT INTO `ea_system_log_202104` VALUES ('665', '1', '/admin/system.menu/edit?id=255', 'post', '', '{\"\\/admin\\/system_menu\\/edit\":\"\",\"id\":\"255\",\"pid\":\"254\",\"title\":\"合同管理\",\"href\":\"client.contract\\/index\",\"icon\":\"fa fa-list\",\"target\":\"_self\",\"sort\":\"0\",\"remark\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617277020');
INSERT INTO `ea_system_log_202104` VALUES ('666', '1', '/admin/system.auth/add', 'post', '', '{\"\\/admin\\/system_auth\\/add\":\"\",\"title\":\"项目\",\"remark\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617277117');
INSERT INTO `ea_system_log_202104` VALUES ('667', '1', '/admin/client.contract/add', 'post', '', '{\"\\/admin\\/client_contract\\/add\":\"\",\"Register_Date\":\"1\",\"Update_Date\":\"11\",\"Sales\":\"123123\",\"Attention\":\"\",\"Department\":\"\",\"Company_Full_Name\":\"\",\"Company_Name\":\"\",\"Contract_Signer\":\"\",\"Signer_is_Department\":\"\",\"Company_Address\":\"\",\"Country\":\"\",\"Mobile\":\"\",\"Telephone_Number\":\"\",\"Email\":\"\",\"Company_Code\":\"\",\"Contract_Number\":\"\",\"Service\":\"\",\"Language\":\"\",\"Currency\":\"\",\"Unit_Price\":\"\",\"Units\":\"\",\"Sales_Forecasted\":\"\",\"VAT_Rate\":\"\",\"Customer_VAT_No\":\"\",\"Customer_Address\":\"\",\"Customer_Phone\":\"\",\"Customer_Bank\":\"\",\"Customer_Bank_Account\":\"\",\"Invoicing_Policy\":\"\",\"Account_Period\":\"\",\"NDA\":\"\",\"Effective_Date\":\"\",\"Expired_Date\":\"\",\"Remaining_Validity\":\"\",\"Contract_Status\":\"\",\"Contract_Recipient\":\"\",\"Contract_Recipient_Address\":\"\",\"Remarks\":\"\",\"Subject_Company\":\"\",\"Subject_Company_VAT_ID\":\"\",\"Subject_Company_Address\":\"\",\"Subject_Company_Bank_Info\":\"\",\"Filled_by\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617277185');
INSERT INTO `ea_system_log_202104` VALUES ('668', null, '/admin/login/index', 'post', '', '{\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617277427');
INSERT INTO `ea_system_log_202104` VALUES ('669', '1', '/admin/system.menu/modify', 'post', '', '{\"\\/admin\\/system_menu\\/modify\":\"\",\"id\":\"249\",\"field\":\"status\",\"value\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617277481');
INSERT INTO `ea_system_log_202104` VALUES ('670', '1', '/admin/ajax/upload', 'post', '', '[]', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617277499');
INSERT INTO `ea_system_log_202104` VALUES ('671', '1', '/admin/mall.cate/add', 'post', '', '{\"\\/admin\\/mall_cate\\/add\":\"\",\"title\":\"计算机内存\",\"image\":\"http:\\/\\/easyadmin.test\\/upload\\/20210401\\/0afd939a10d07cdb0a2f0e798768768e.png\",\"file\":\"\",\"sort\":\"0\",\"remark\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617277501');
INSERT INTO `ea_system_log_202104` VALUES ('672', '1', '/admin/client.contract/add', 'post', '', '{\"\\/admin\\/client_contract\\/add\":\"\",\"Register_Date\":\"111\",\"Update_Date\":\"\",\"Sales\":\"\",\"Attention\":\"\",\"Department\":\"\",\"Company_Full_Name\":\"\",\"Company_Name\":\"\",\"Contract_Signer\":\"\",\"Signer_is_Department\":\"\",\"Company_Address\":\"\",\"Country\":\"\",\"Mobile\":\"\",\"Telephone_Number\":\"\",\"Email\":\"\",\"Company_Code\":\"\",\"Contract_Number\":\"\",\"Service\":\"\",\"Language\":\"\",\"Currency\":\"\",\"Unit_Price\":\"\",\"Units\":\"\",\"Sales_Forecasted\":\"\",\"VAT_Rate\":\"\",\"Customer_VAT_No\":\"\",\"Customer_Address\":\"\",\"Customer_Phone\":\"\",\"Customer_Bank\":\"\",\"Customer_Bank_Account\":\"\",\"Invoicing_Policy\":\"\",\"Account_Period\":\"\",\"NDA\":\"\",\"Effective_Date\":\"\",\"Expired_Date\":\"\",\"Remaining_Validity\":\"\",\"Contract_Status\":\"\",\"Contract_Recipient\":\"\",\"Contract_Recipient_Address\":\"\",\"Remarks\":\"\",\"Subject_Company\":\"\",\"Subject_Company_VAT_ID\":\"\",\"Subject_Company_Address\":\"\",\"Subject_Company_Bank_Info\":\"\",\"Filled_by\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617277738');
INSERT INTO `ea_system_log_202104` VALUES ('673', '1', '/admin/system.menu/modify', 'post', '', '{\"\\/admin\\/system_menu\\/modify\":\"\",\"id\":\"249\",\"field\":\"status\",\"value\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617279196');
INSERT INTO `ea_system_log_202104` VALUES ('674', '1', '/admin/system.quick/modify', 'post', '', '{\"\\/admin\\/system_quick\\/modify\":\"\",\"id\":\"11\",\"field\":\"status\",\"value\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617280625');
INSERT INTO `ea_system_log_202104` VALUES ('675', '1', '/admin/system.quick/modify', 'post', '', '{\"\\/admin\\/system_quick\\/modify\":\"\",\"id\":\"11\",\"field\":\"status\",\"value\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617280626');
INSERT INTO `ea_system_log_202104` VALUES ('676', '1', '/admin/system.quick/modify', 'post', '', '{\"\\/admin\\/system_quick\\/modify\":\"\",\"id\":\"11\",\"field\":\"status\",\"value\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617280627');
INSERT INTO `ea_system_log_202104` VALUES ('677', null, '/admin/login/index.html', 'post', '', '{\"\\/admin\\/login\\/index_html\":\"\",\"username\":\"codex\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617324876');
INSERT INTO `ea_system_log_202104` VALUES ('678', null, '/admin/login/index.html', 'post', '', '{\"\\/admin\\/login\\/index_html\":\"\",\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617324881');
INSERT INTO `ea_system_log_202104` VALUES ('679', '1', '/admin/client.contract/delete', 'post', '', '{\"\\/admin\\/client_contract\\/delete\":\"\",\"id\":[\"18\",\"17\",\"16\",\"15\",\"14\",\"13\",\"12\",\"11\",\"10\",\"9\",\"8\",\"7\",\"6\",\"5\",\"4\"]}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617324892');
INSERT INTO `ea_system_log_202104` VALUES ('680', '1', '/admin/system.menu/modify', 'post', '', '{\"\\/admin\\/system_menu\\/modify\":\"\",\"id\":\"249\",\"field\":\"status\",\"value\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617325215');
INSERT INTO `ea_system_log_202104` VALUES ('681', '1', '/admin/system.auth/add', 'post', '', '{\"\\/admin\\/system_auth\\/add\":\"\",\"title\":\"销售\",\"remark\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617327386');
INSERT INTO `ea_system_log_202104` VALUES ('682', null, '/admin/login/index.html', 'post', '', '{\"\\/admin\\/login\\/index_html\":\"\",\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617332173');
INSERT INTO `ea_system_log_202104` VALUES ('683', '1', '/admin/system.node/refreshNode?force=0', 'post', '', '{\"\\/admin\\/system_node\\/refreshNode\":\"\",\"force\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617332182');
INSERT INTO `ea_system_log_202104` VALUES ('684', '1', '/admin/system.node/modify', 'post', '', '{\"\\/admin\\/system_node\\/modify\":\"\",\"id\":\"76\",\"field\":\"title\",\"value\":\"主体公司\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617332208');
INSERT INTO `ea_system_log_202104` VALUES ('685', '1', '/admin/system.menu/add', 'post', '', '{\"\\/admin\\/system_menu\\/add\":\"\",\"pid\":\"228\",\"title\":\"主体公司\",\"href\":\"main.company\\/index\",\"icon\":\"fa fa-list\",\"target\":\"_self\",\"sort\":\"0\",\"remark\":\"主体公司信息\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617332307');
INSERT INTO `ea_system_log_202104` VALUES ('686', '1', '/admin/main.company/add', 'post', '', '{\"\\/admin\\/main_company\\/add\":\"\",\"chinese_company_name\":\"中文公司名称1\",\"english_company_name\":\"英文公司名称1\",\"chinese_company_address\":\"公司地址\",\"english_company_address\":\"英文公司地址\",\"main_company_tax_number\":\"税号\",\"chinese_bank_information\":\"银行信息\",\"english_bank_information\":\"银行信息\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617332540');
INSERT INTO `ea_system_log_202104` VALUES ('687', '1', '/admin/main.company/add', 'post', '', '{\"\\/admin\\/main_company\\/add\":\"\",\"chinese_company_name\":\"中文公司名称1\",\"english_company_name\":\"英文公司名称1\",\"chinese_company_address\":\"公司地址\",\"english_company_address\":\"英文公司地址\",\"main_company_tax_number\":\"2121212121212121212121\",\"chinese_bank_information\":\"银行信息\",\"english_bank_information\":\"银行信息\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617332547');
INSERT INTO `ea_system_log_202104` VALUES ('688', '1', '/admin/main.company/add', 'post', '', '{\"\\/admin\\/main_company\\/add\":\"\",\"chinese_company_name\":\"中文公司名称1\",\"english_company_name\":\"英文公司名称1\",\"chinese_company_address\":\"公司地址\",\"english_company_address\":\"英文公司地址\",\"main_company_tax_number\":\"2121212121212121212121\",\"chinese_bank_information\":\"银行信息\",\"english_bank_information\":\"银行信息\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617332568');
INSERT INTO `ea_system_log_202104` VALUES ('689', '1', '/admin/main.company/add', 'post', '', '{\"\\/admin\\/main_company\\/add\":\"\",\"chinese_company_name\":\"中文公司名称1\",\"english_company_name\":\"英文公司名称1\",\"chinese_company_address\":\"公司地址\",\"english_company_address\":\"英文公司地址\",\"main_company_tax_number\":\"2121212121212121212121\",\"chinese_bank_information\":\"银行信息\",\"english_bank_information\":\"银行信息\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617332594');
INSERT INTO `ea_system_log_202104` VALUES ('690', '1', '/admin/main.company/add', 'post', '', '{\"\\/admin\\/main_company\\/add\":\"\",\"chinese_company_name\":\"中文公司名称1\",\"english_company_name\":\"英文公司名称1\",\"chinese_company_address\":\"公司地址\",\"english_company_address\":\"英文公司地址\",\"main_company_tax_number\":\"21212121212\",\"chinese_bank_information\":\"银行信息\",\"english_bank_information\":\"银行信息\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617332602');
INSERT INTO `ea_system_log_202104` VALUES ('691', '1', '/admin/main.company/add', 'post', '', '{\"\\/admin\\/main_company\\/add\":\"\",\"chinese_company_name\":\"中文公司名称1\",\"english_company_name\":\"英文公司名称1\",\"chinese_company_address\":\"公司地址\",\"english_company_address\":\"英文公司地址\",\"main_company_tax_number\":\"2121212\",\"chinese_bank_information\":\"银行信息\",\"english_bank_information\":\"银行信息\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617332607');
INSERT INTO `ea_system_log_202104` VALUES ('692', '1', '/admin/main.company/add', 'post', '', '{\"\\/admin\\/main_company\\/add\":\"\",\"chinese_company_name\":\"中文公司名称1\",\"english_company_name\":\"英文公司名称1\",\"chinese_company_address\":\"公司地址\",\"english_company_address\":\"英文公司地址\",\"main_company_tax_number\":\"2121212\",\"chinese_bank_information\":\"银行信息\",\"english_bank_information\":\"银行信息\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617332616');
INSERT INTO `ea_system_log_202104` VALUES ('693', '1', '/admin/main.company/edit?id=1', 'post', '', '{\"\\/admin\\/main_company\\/edit\":\"\",\"id\":\"1\",\"chinese_company_name\":\"中文公司名称1\",\"english_company_name\":\"英文公司名称1\",\"chinese_company_address\":\"公司地址\",\"english_company_address\":\"英文公司地址\",\"main_company_tax_number\":\"2121212\",\"chinese_bank_information\":\"              银行信息                \",\"english_bank_information\":\"                                    das\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617333456');
INSERT INTO `ea_system_log_202104` VALUES ('694', '1', '/admin/main.company/edit?id=1', 'post', '', '{\"\\/admin\\/main_company\\/edit\":\"\",\"id\":\"1\",\"chinese_company_name\":\"中文公司名称1\",\"english_company_name\":\"英文公司名称1\",\"chinese_company_address\":\"公司地址\",\"english_company_address\":\"英文公司地址\",\"main_company_tax_number\":\"21212122133213\",\"chinese_bank_information\":\"                            银行信息                                \",\"english_bank_information\":\"                                                        das                \"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617333480');
INSERT INTO `ea_system_log_202104` VALUES ('695', '1', '/admin/main.company/edit?id=1', 'post', '', '{\"\\/admin\\/main_company\\/edit\":\"\",\"id\":\"1\",\"chinese_company_name\":\"中文公司名称1\",\"english_company_name\":\"英文公司名称1\",\"chinese_company_address\":\"公司地址\",\"english_company_address\":\"英文公司地址\",\"main_company_tax_number\":\"21212122133213\",\"chinese_bank_information\":\"                            银行信息                                \",\"english_bank_information\":\"                                                        das                \"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617333489');
INSERT INTO `ea_system_log_202104` VALUES ('696', '1', '/admin/main.company/edit?id=1', 'post', '', '{\"\\/admin\\/main_company\\/edit\":\"\",\"id\":\"1\",\"chinese_company_name\":\"中文公司名称1\",\"english_company_name\":\"英文公司名称1\",\"chinese_company_address\":\"公司地址\",\"english_company_address\":\"英文公司地址\",\"main_company_tax_number\":\"21212122133213\",\"chinese_bank_information\":\"                            银行信息                                \",\"english_bank_information\":\"                                                        das                \"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617333494');
INSERT INTO `ea_system_log_202104` VALUES ('697', '1', '/admin/main.company/edit?id=1', 'post', '', '{\"\\/admin\\/main_company\\/edit\":\"\",\"id\":\"1\",\"chinese_company_name\":\"中文公司名称1\",\"english_company_name\":\"英文公司名称1\",\"chinese_company_address\":\"公司地址\",\"english_company_address\":\"英文公司地址\",\"main_company_tax_number\":\"212121\",\"chinese_bank_information\":\"                            银行信息                                \",\"english_bank_information\":\"                                                        das                \"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617333501');
INSERT INTO `ea_system_log_202104` VALUES ('698', '1', '/admin/main.company/edit?id=1', 'post', '', '{\"\\/admin\\/main_company\\/edit\":\"\",\"id\":\"1\",\"chinese_company_name\":\"中文公司名称1\",\"english_company_name\":\"英文公司名称1\",\"chinese_company_address\":\"公司地址\",\"english_company_address\":\"英文公司地址\",\"main_company_tax_number\":\"212121dasd\",\"chinese_bank_information\":\"                                          银行信息                                                \",\"english_bank_information\":\"                                                                            das                                \"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617333525');
INSERT INTO `ea_system_log_202104` VALUES ('699', '1', '/admin/main.company/edit?id=1', 'post', '', '{\"\\/admin\\/main_company\\/edit\":\"\",\"id\":\"1\",\"chinese_company_name\":\"中文公司名称1\",\"english_company_name\":\"英文公司名称1\",\"chinese_company_address\":\"公司地址\",\"english_company_address\":\"英文公司地址\",\"main_company_tax_number\":\"212121dasddasasasasas213213123213\",\"chinese_bank_information\":\"                                                        银行信息                                                                \",\"english_bank_information\":\"                                                                                                das                                                \"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617333532');
INSERT INTO `ea_system_log_202104` VALUES ('700', '1', '/admin/main.company/edit?id=1', 'post', '', '{\"\\/admin\\/main_company\\/edit\":\"\",\"id\":\"1\",\"chinese_company_name\":\"中文公司名称1\",\"english_company_name\":\"英文公司名称1\",\"chinese_company_address\":\"公司地址\",\"english_company_address\":\"英文公司地址\",\"main_company_tax_number\":\"212121dasddasasasasas213213123213\",\"chinese_bank_information\":\"                                                                      银行信息                                                                                \",\"english_bank_information\":\"       das                                                                \"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617333560');
INSERT INTO `ea_system_log_202104` VALUES ('701', '1', '/admin/main.company/edit?id=1', 'post', '', '{\"\\/admin\\/main_company\\/edit\":\"\",\"id\":\"1\",\"chinese_company_name\":\"中文公司名称1\",\"english_company_name\":\"英文公司名称1\",\"chinese_company_address\":\"公司地址\",\"english_company_address\":\"英文公司地址\",\"main_company_tax_number\":\"212121dasddasasasasas213213123213\",\"chinese_bank_information\":\"     银行信息                                                                                                \",\"english_bank_information\":\"                           das                                                                                \"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617333862');
INSERT INTO `ea_system_log_202104` VALUES ('702', '1', '/admin/system.node/refreshNode?force=0', 'post', '', '{\"\\/admin\\/system_node\\/refreshNode\":\"\",\"force\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617334155');
INSERT INTO `ea_system_log_202104` VALUES ('703', '1', '/admin/system.node/modify', 'post', '', '{\"\\/admin\\/system_node\\/modify\":\"\",\"id\":\"83\",\"field\":\"title\",\"value\":\"客户信息\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617334169');
INSERT INTO `ea_system_log_202104` VALUES ('704', '1', '/admin/system.menu/add?id=254', 'post', '', '{\"\\/admin\\/system_menu\\/add\":\"\",\"id\":\"254\",\"pid\":\"254\",\"title\":\"客户信息\",\"href\":\"customer.information\\/index\",\"icon\":\"fa fa-list\",\"target\":\"_self\",\"sort\":\"0\",\"remark\":\"客户信息\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617334246');
INSERT INTO `ea_system_log_202104` VALUES ('705', '1', '/admin/customer.information/add', 'post', '', '{\"\\/admin\\/customer_information\\/add\":\"\",\"customer_contact\":\"客户1\",\"department\":\"部门1\",\"company_name\":\"客户公司名称1\",\"company_address\":\"公司地址1\",\"country\":\"国家1\",\"position\":\"职位1\",\"mobile_phone_number\":\"13257245375\",\"landline_number\":\"8512456\",\"mailbox\":\"zhuchenchen@zhuchenchen.cn\",\"company_code\":\"das21321321\",\"contract_code\":\"131dsda\",\"remarks\":\"1312\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617334355');
INSERT INTO `ea_system_log_202104` VALUES ('706', '1', '/admin/customer.information/add', 'post', '', '{\"\\/admin\\/customer_information\\/add\":\"\",\"customer_contact\":\"客户1\",\"department\":\"部门1\",\"company_name\":\"客户公司名称1\",\"company_address\":\"公司地址1\",\"country\":\"国家1\",\"position\":\"职位1\",\"mobile_phone_number\":\"13257245375\",\"landline_number\":\"8512456\",\"mailbox\":\"zhuchenchen@zhuchenchen.cn\",\"company_code\":\"das21321321\",\"contract_code\":\"131dsda\",\"remarks\":\"1312\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617334402');
INSERT INTO `ea_system_log_202104` VALUES ('707', '1', '/admin/customer.information/add', 'post', '', '{\"\\/admin\\/customer_information\\/add\":\"\",\"customer_contact\":\"客户2\",\"department\":\"客户2所在部门\",\"company_name\":\"客户2公司全称\",\"company_address\":\"客户2公司地址\",\"country\":\"客户2v\",\"position\":\"客户2职位\",\"mobile_phone_number\":\"13257245375\",\"landline_number\":\"8512456\",\"mailbox\":\"zhuchenchen@zhuchenchen.cn\",\"company_code\":\"das213213212313\",\"contract_code\":\"212\",\"remarks\":\"阿斯顿\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617334702');
INSERT INTO `ea_system_log_202104` VALUES ('708', '1', '/admin/customer.information/add', 'post', '', '{\"\\/admin\\/customer_information\\/add\":\"\",\"customer_contact\":\"客户三客户联系人\",\"department\":\"客户三\",\"company_name\":\"客户三\",\"company_address\":\"客户三\",\"country\":\"客户三\",\"position\":\"客户三\",\"mobile_phone_number\":\"13257245375\",\"landline_number\":\"8512456\",\"mailbox\":\"zhuchenchen@zhuchenchen.cn\",\"company_code\":\"das21321321\",\"contract_code\":\"131dsda\",\"remarks\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617335104');
INSERT INTO `ea_system_log_202104` VALUES ('709', null, '/admin/login/index', 'post', '', '{\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Mobile Safari/537.36', '1617338778');
INSERT INTO `ea_system_log_202104` VALUES ('710', '1', '/admin/system.auth/add', 'post', '', '{\"\\/admin\\/system_auth\\/add\":\"\",\"title\":\"管理员\",\"remark\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617338860');
INSERT INTO `ea_system_log_202104` VALUES ('711', '1', '/admin/system.auth/add', 'post', '', '{\"\\/admin\\/system_auth\\/add\":\"\",\"title\":\"管理\",\"remark\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617338875');
INSERT INTO `ea_system_log_202104` VALUES ('712', '1', '/admin/system.auth/saveAuthorize', 'post', '', '{\"\\/admin\\/system_auth\\/saveAuthorize\":\"\",\"title\":\"管理\",\"node\":\"[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,21,22,23,24,25,26,27,28,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89]\",\"id\":\"11\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617338923');
INSERT INTO `ea_system_log_202104` VALUES ('713', '1', '/admin/system.node/refreshNode?force=1', 'post', '', '{\"\\/admin\\/system_node\\/refreshNode\":\"\",\"force\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617341723');
INSERT INTO `ea_system_log_202104` VALUES ('714', '1', '/admin/system.node/clearNode', 'post', '', '{\"\\/admin\\/system_node\\/clearNode\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617341727');
INSERT INTO `ea_system_log_202104` VALUES ('715', '1', '/admin/system.node/modify', 'post', '', '{\"\\/admin\\/system_node\\/modify\":\"\",\"id\":\"76\",\"field\":\"title\",\"value\":\"主体公司\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617341766');
INSERT INTO `ea_system_log_202104` VALUES ('716', '1', '/admin/system.node/modify', 'post', '', '{\"\\/admin\\/system_node\\/modify\":\"\",\"id\":\"83\",\"field\":\"title\",\"value\":\"客户信息\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617341786');
INSERT INTO `ea_system_log_202104` VALUES ('717', '1', '/admin/system.node/modify', 'post', '', '{\"\\/admin\\/system_node\\/modify\":\"\",\"id\":\"90\",\"field\":\"title\",\"value\":\"客户合同\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617341797');
INSERT INTO `ea_system_log_202104` VALUES ('718', '1', '/admin/system.menu/add?id=254', 'post', '', '{\"\\/admin\\/system_menu\\/add\":\"\",\"id\":\"254\",\"pid\":\"254\",\"title\":\"合同管理\",\"href\":\"customer.contract\\/index\",\"icon\":\"fa fa-list\",\"target\":\"_self\",\"sort\":\"1\",\"remark\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617341849');
INSERT INTO `ea_system_log_202104` VALUES ('719', '1', '/admin/system.menu/delete?id=255', 'post', '', '{\"\\/admin\\/system_menu\\/delete\":\"\",\"id\":\"255\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617341982');
INSERT INTO `ea_system_log_202104` VALUES ('720', '1', '/admin/main.company/add', 'post', '', '{\"\\/admin\\/main_company\\/add\":\"\",\"chinese_company_name\":\"中文公司名称2\",\"english_company_name\":\"英文公司名称2\",\"chinese_company_address\":\"中文公司名称2\",\"english_company_address\":\"英文公司名称2\",\"main_company_tax_number\":\"s9dsad4a4\",\"chinese_bank_information\":\"中文公司名称2\",\"english_bank_information\":\"中文公司名称2\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617343557');
INSERT INTO `ea_system_log_202104` VALUES ('721', '1', '/admin/system.admin/add', 'post', '', '{\"\\/admin\\/system_admin\\/add\":\"\",\"head_img\":\"http:\\/\\/easyadmin.test\\/upload\\/20210401\\/0afd939a10d07cdb0a2f0e798768768e.png\",\"file\":\"\",\"username\":\"销售1\",\"phone\":\"\",\"auth_ids\":{\"9\":\"on\"},\"remark\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617344766');
INSERT INTO `ea_system_log_202104` VALUES ('722', '1', '/admin/system.admin/add', 'post', '', '{\"\\/admin\\/system_admin\\/add\":\"\",\"head_img\":\"http:\\/\\/easyadmin.test\\/upload\\/20210401\\/0afd939a10d07cdb0a2f0e798768768e.png\",\"file\":\"\",\"username\":\"销售2\",\"phone\":\"\",\"auth_ids\":{\"9\":\"on\"},\"remark\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617344787');
INSERT INTO `ea_system_log_202104` VALUES ('723', '1', '/admin/system.node/refreshNode?force=0', 'post', '', '{\"\\/admin\\/system_node\\/refreshNode\":\"\",\"force\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617345568');
INSERT INTO `ea_system_log_202104` VALUES ('724', '1', '/admin/system.node/refreshNode?force=0', 'post', '', '{\"\\/admin\\/system_node\\/refreshNode\":\"\",\"force\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617345580');
INSERT INTO `ea_system_log_202104` VALUES ('725', '1', '/admin/system.node/refreshNode?force=0', 'post', '', '{\"\\/admin\\/system_node\\/refreshNode\":\"\",\"force\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617345602');
INSERT INTO `ea_system_log_202104` VALUES ('726', '1', '/admin/system.node/refreshNode?force=0', 'post', '', '{\"\\/admin\\/system_node\\/refreshNode\":\"\",\"force\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617345607');
INSERT INTO `ea_system_log_202104` VALUES ('727', '1', '/admin/system.node/refreshNode?force=0', 'post', '', '{\"\\/admin\\/system_node\\/refreshNode\":\"\",\"force\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617345686');
INSERT INTO `ea_system_log_202104` VALUES ('728', '1', '/admin/system.node/modify', 'post', '', '{\"\\/admin\\/system_node\\/modify\":\"\",\"id\":\"97\",\"field\":\"title\",\"value\":\"词库内容\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617345701');
INSERT INTO `ea_system_log_202104` VALUES ('729', '1', '/admin/system.node/modify', 'post', '', '{\"\\/admin\\/system_node\\/modify\":\"\",\"id\":\"104\",\"field\":\"title\",\"value\":\"词库列表\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617345710');
INSERT INTO `ea_system_log_202104` VALUES ('730', '1', '/admin/system.menu/add', 'post', '', '{\"\\/admin\\/system_menu\\/add\":\"\",\"pid\":\"0\",\"title\":\"词库管理\",\"href\":\"\",\"icon\":\"fa fa-list\",\"target\":\"_self\",\"sort\":\"0\",\"remark\":\"词库管理菜单\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617345748');
INSERT INTO `ea_system_log_202104` VALUES ('731', '1', '/admin/system.menu/add?id=259', 'post', '', '{\"\\/admin\\/system_menu\\/add\":\"\",\"id\":\"259\",\"pid\":\"259\",\"title\":\"词库列表\",\"href\":\"database.databaselist\",\"icon\":\"fa fa-list\",\"target\":\"_self\",\"sort\":\"0\",\"remark\":\"词库列表\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617345775');
INSERT INTO `ea_system_log_202104` VALUES ('732', '1', '/admin/system.menu/add?id=259', 'post', '', '{\"\\/admin\\/system_menu\\/add\":\"\",\"id\":\"259\",\"pid\":\"259\",\"title\":\"词库内容\",\"href\":\"database.content\\/index\",\"icon\":\"fa fa-list\",\"target\":\"_self\",\"sort\":\"0\",\"remark\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617345836');
INSERT INTO `ea_system_log_202104` VALUES ('733', '1', '/admin/system.menu/edit?id=259', 'post', '', '{\"\\/admin\\/system_menu\\/edit\":\"\",\"id\":\"259\",\"pid\":\"228\",\"title\":\"词库管理\",\"href\":\"\",\"icon\":\"fa fa-list\",\"target\":\"_self\",\"sort\":\"0\",\"remark\":\"词库管理菜单\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617345865');
INSERT INTO `ea_system_log_202104` VALUES ('734', null, '/admin/login/index.html', 'post', '', '{\"\\/admin\\/login\\/index_html\":\"\",\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617346018');
INSERT INTO `ea_system_log_202104` VALUES ('735', '1', '/admin/system.node/refreshNode?force=0', 'post', '', '{\"\\/admin\\/system_node\\/refreshNode\":\"\",\"force\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617346557');
INSERT INTO `ea_system_log_202104` VALUES ('736', '1', '/admin/system.node/clearNode', 'post', '', '{\"\\/admin\\/system_node\\/clearNode\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617346560');
INSERT INTO `ea_system_log_202104` VALUES ('737', '1', '/admin/system.node/modify', 'post', '', '{\"\\/admin\\/system_node\\/modify\":\"\",\"id\":\"111\",\"field\":\"title\",\"value\":\"词库目录\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617346574');
INSERT INTO `ea_system_log_202104` VALUES ('738', '1', '/admin/system.menu/edit?id=260', 'post', '', '{\"\\/admin\\/system_menu\\/edit\":\"\",\"id\":\"260\",\"pid\":\"259\",\"title\":\"词库列表\",\"href\":\"database.directory\\/index\",\"icon\":\"fa fa-list\",\"target\":\"_self\",\"sort\":\"0\",\"remark\":\"词库列表\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617346596');
INSERT INTO `ea_system_log_202104` VALUES ('739', '1', '/admin/database.directory/add', 'post', '', '{\"\\/admin\\/database_directory\\/add\":\"\",\"title\":\"单位\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617346660');
INSERT INTO `ea_system_log_202104` VALUES ('740', '1', '/admin/database.directory/add', 'post', '', '{\"\\/admin\\/database_directory\\/add\":\"\",\"title\":\"服务\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617346691');
INSERT INTO `ea_system_log_202104` VALUES ('741', '1', '/admin/database.directory/add', 'post', '', '{\"\\/admin\\/database_directory\\/add\":\"\",\"title\":\"语种\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617346727');
INSERT INTO `ea_system_log_202104` VALUES ('742', '1', '/admin/database.directory/add', 'post', '', '{\"\\/admin\\/database_directory\\/add\":\"\",\"title\":\"文件类型\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617346736');
INSERT INTO `ea_system_log_202104` VALUES ('743', '1', '/admin/database.directory/add', 'post', '', '{\"\\/admin\\/database_directory\\/add\":\"\",\"title\":\"服务类型\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617346746');
INSERT INTO `ea_system_log_202104` VALUES ('744', '1', '/admin/database.directory/add', 'post', '', '{\"\\/admin\\/database_directory\\/add\":\"\",\"title\":\"文件分类\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617346780');
INSERT INTO `ea_system_log_202104` VALUES ('745', '1', '/admin/database.directory/add', 'post', '', '{\"\\/admin\\/database_directory\\/add\":\"\",\"title\":\"翻译校对工作内容\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617346816');
INSERT INTO `ea_system_log_202104` VALUES ('746', '1', '/admin/database.directory/add', 'post', '', '{\"\\/admin\\/database_directory\\/add\":\"\",\"title\":\"排版工作内容\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617346825');
INSERT INTO `ea_system_log_202104` VALUES ('747', '1', '/admin/database.directory/add', 'post', '', '{\"\\/admin\\/database_directory\\/add\":\"\",\"title\":\"税率\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617346833');
INSERT INTO `ea_system_log_202104` VALUES ('748', '1', '/admin/database.content/add', 'post', '', '{\"\\/admin\\/database_content\\/add\":\"\",\"list_id\":\"1\",\"content\":\"页\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617347369');
INSERT INTO `ea_system_log_202104` VALUES ('749', '1', '/admin/database.content/add', 'post', '', '{\"\\/admin\\/database_content\\/add\":\"\",\"list_id\":\"1\",\"content\":\"页\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617347473');
INSERT INTO `ea_system_log_202104` VALUES ('750', '1', '/admin/database.content/add', 'post', '', '{\"\\/admin\\/database_content\\/add\":\"\",\"list_id\":\"1\",\"content\":\"条\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617347587');
INSERT INTO `ea_system_log_202104` VALUES ('751', '1', '/admin/database.content/add', 'post', '', '{\"\\/admin\\/database_content\\/add\":\"\",\"list_id\":\"2\",\"content\":\"翻译\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617348761');
INSERT INTO `ea_system_log_202104` VALUES ('752', '1', '/admin/database.content/add', 'post', '', '{\"\\/admin\\/database_content\\/add\":\"\",\"list_id\":\"2\",\"content\":\"排版\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617348776');
INSERT INTO `ea_system_log_202104` VALUES ('753', '1', '/admin/database.content/add', 'post', '', '{\"\\/admin\\/database_content\\/add\":\"\",\"list_id\":\"2\",\"content\":\"校对\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617348794');
INSERT INTO `ea_system_log_202104` VALUES ('754', '1', '/admin/database.directory/add', 'post', '', '{\"\\/admin\\/database_directory\\/add\":\"\",\"title\":\"币种\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617350180');
INSERT INTO `ea_system_log_202104` VALUES ('755', '1', '/admin/database.content/add', 'post', '', '{\"\\/admin\\/database_content\\/add\":\"\",\"list_id\":\"10\",\"content\":\"人民币\\/CNY\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617350223');
INSERT INTO `ea_system_log_202104` VALUES ('756', '1', '/admin/database.content/add', 'post', '', '{\"\\/admin\\/database_content\\/add\":\"\",\"list_id\":\"10\",\"content\":\"欧元\\/EUR\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617350246');
INSERT INTO `ea_system_log_202104` VALUES ('757', '1', '/admin/database.content/add', 'post', '', '{\"\\/admin\\/database_content\\/add\":\"\",\"list_id\":\"3\",\"content\":\"中文-英文\\/CN-EN\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617350452');
INSERT INTO `ea_system_log_202104` VALUES ('758', '1', '/admin/database.content/add', 'post', '', '{\"\\/admin\\/database_content\\/add\":\"\",\"list_id\":\"3\",\"content\":\"英文-中文\\/EN-CN\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617350474');
INSERT INTO `ea_system_log_202104` VALUES ('759', '1', '/admin/database.directory/delete?id=5', 'post', '', '{\"\\/admin\\/database_directory\\/delete\":\"\",\"id\":\"5\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617351775');
INSERT INTO `ea_system_log_202104` VALUES ('760', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"3\",\"sales_id\":\"1\",\"contract_signer\":\"签订人1\",\"service\":\"3\",\"language\":\"8\",\"currency\":\"6\",\"unit_price\":\"50\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"客户银行信\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-02\",\"expiration_date\":\"2021-04-02\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"阿达\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617351939');
INSERT INTO `ea_system_log_202104` VALUES ('761', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"3\",\"sales_id\":\"1\",\"contract_signer\":\"签订人1\",\"service\":\"3\",\"language\":\"8\",\"currency\":\"6\",\"unit_price\":\"50\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"客户银行信\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-02\",\"expiration_date\":\"2021-04-02\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"阿达\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617351943');
INSERT INTO `ea_system_log_202104` VALUES ('762', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"3\",\"sales_id\":\"1\",\"contract_signer\":\"签订人1\",\"service\":\"3\",\"language\":\"8\",\"currency\":\"6\",\"unit_price\":\"50\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"客户银行信\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-02\",\"expiration_date\":\"2021-04-02\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"阿达\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617351995');
INSERT INTO `ea_system_log_202104` VALUES ('763', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"3\",\"sales_id\":\"1\",\"contract_signer\":\"签订人1\",\"service\":\"3\",\"language\":\"8\",\"currency\":\"6\",\"unit_price\":\"50\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"客户银行信\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-02\",\"expiration_date\":\"2021-04-02\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"阿达\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617352176');
INSERT INTO `ea_system_log_202104` VALUES ('764', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"3\",\"sales_id\":\"1\",\"contract_signer\":\"签订人1\",\"service\":\"3\",\"language\":\"8\",\"currency\":\"6\",\"unit_price\":\"50\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"客户银行信\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-02\",\"expiration_date\":\"2021-04-02\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"阿达\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617352194');
INSERT INTO `ea_system_log_202104` VALUES ('765', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"3\",\"sales_id\":\"1\",\"contract_signer\":\"签订人1\",\"service\":\"3\",\"language\":\"8\",\"currency\":\"6\",\"unit_price\":\"50\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"客户银行信\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-02\",\"expiration_date\":\"2021-04-02\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"阿达\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617352295');
INSERT INTO `ea_system_log_202104` VALUES ('766', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"3\",\"sales_id\":\"1\",\"contract_signer\":\"签订人1\",\"service\":\"3\",\"language\":\"8\",\"currency\":\"6\",\"unit_price\":\"50\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"客户银行信\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-02\",\"expiration_date\":\"2021-04-02\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"阿达\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617352308');
INSERT INTO `ea_system_log_202104` VALUES ('767', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"3\",\"sales_id\":\"1\",\"contract_signer\":\"签订人1\",\"service\":\"3\",\"language\":\"8\",\"currency\":\"6\",\"unit_price\":\"50\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"客户银行信\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-02\",\"expiration_date\":\"2021-04-02\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"阿达\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617352330');
INSERT INTO `ea_system_log_202104` VALUES ('768', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"2\",\"sales_id\":\"2\",\"contract_signer\":\"签订人2\",\"service\":\"3\",\"language\":\"9\",\"currency\":\"6\",\"unit_price\":\"50\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"123\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"2\",\"effective_date\":\"2021-04-02\",\"expiration_date\":\"2021-04-10\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"123\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617352951');
INSERT INTO `ea_system_log_202104` VALUES ('769', null, '/admin/login/index.html', 'post', '', '{\"\\/admin\\/login\\/index_html\":\"\",\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617353380');
INSERT INTO `ea_system_log_202104` VALUES ('770', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"2\",\"customer_id\":\"1\",\"sales_id\":\"1\",\"contract_signer\":\"签订人2\",\"service\":\"5\",\"language\":\"9\",\"currency\":\"7\",\"unit_price\":\"50\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626321\",\"bank_information\":\"1312\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-02\",\"expiration_date\":\"2021-04-17\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617354816');
INSERT INTO `ea_system_log_202104` VALUES ('771', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"2\",\"customer_id\":\"1\",\"sales_id\":\"1\",\"contract_signer\":\"签订人1\",\"service\":\"4\",\"language\":\"8\",\"currency\":\"6\",\"unit_price\":\"50\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"和\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-02\",\"expiration_date\":\"2021-04-16\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617355042');
INSERT INTO `ea_system_log_202104` VALUES ('772', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"2\",\"customer_id\":\"1\",\"sales_id\":\"1\",\"contract_signer\":\"签订人1\",\"service\":\"4\",\"language\":\"8\",\"currency\":\"6\",\"unit_price\":\"50\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"和\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-02\",\"expiration_date\":\"2021-04-16\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617355047');
INSERT INTO `ea_system_log_202104` VALUES ('773', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"2\",\"customer_id\":\"1\",\"sales_id\":\"1\",\"contract_signer\":\"签订人1\",\"service\":\"4\",\"language\":\"8\",\"currency\":\"6\",\"unit_price\":\"50\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"和\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-02\",\"expiration_date\":\"2021-04-16\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617355071');
INSERT INTO `ea_system_log_202104` VALUES ('774', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"2\",\"customer_id\":\"1\",\"sales_id\":\"1\",\"contract_signer\":\"签订人1\",\"service\":\"4\",\"language\":\"8\",\"currency\":\"6\",\"unit_price\":\"50\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"和\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-02\",\"expiration_date\":\"2021-04-16\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617355082');
INSERT INTO `ea_system_log_202104` VALUES ('775', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"2\",\"customer_id\":\"1\",\"sales_id\":\"1\",\"contract_signer\":\"签订人1\",\"service\":\"4\",\"language\":\"8\",\"currency\":\"6\",\"unit_price\":\"50\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"和\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-02\",\"expiration_date\":\"2021-04-16\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617355288');
INSERT INTO `ea_system_log_202104` VALUES ('776', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"1\",\"sales_id\":\"2\",\"contract_signer\":\"签订人1\",\"service\":\"5\",\"language\":\"9\",\"currency\":\"6\",\"unit_price\":\"50\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-02\",\"expiration_date\":\"2021-04-10\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617355327');
INSERT INTO `ea_system_log_202104` VALUES ('777', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"1\",\"sales_id\":\"2\",\"contract_signer\":\"签订人1\",\"service\":\"5\",\"language\":\"9\",\"currency\":\"6\",\"unit_price\":\"50\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-02\",\"expiration_date\":\"2021-04-10\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617355339');
INSERT INTO `ea_system_log_202104` VALUES ('778', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"1\",\"sales_id\":\"1\",\"contract_signer\":\"签订人1\",\"service\":\"5\",\"language\":\"9\",\"currency\":\"6\",\"unit_price\":\"50\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-17\",\"expiration_date\":\"2021-04-02\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617355455');
INSERT INTO `ea_system_log_202104` VALUES ('779', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"1\",\"sales_id\":\"1\",\"contract_signer\":\"签订人1\",\"service\":\"5\",\"language\":\"9\",\"currency\":\"6\",\"unit_price\":\"50\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-17\",\"expiration_date\":\"2021-04-02\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617355474');
INSERT INTO `ea_system_log_202104` VALUES ('780', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"2\",\"customer_id\":\"3\",\"sales_id\":\"1\",\"contract_signer\":\"签订人1\",\"service\":\"5\",\"language\":\"9\",\"currency\":\"6\",\"unit_price\":\"50\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-17\",\"expiration_date\":\"2021-04-02\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617355526');
INSERT INTO `ea_system_log_202104` VALUES ('781', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"2\",\"customer_id\":\"3\",\"sales_id\":\"1\",\"contract_signer\":\"签订人1\",\"service\":\"5\",\"language\":\"9\",\"currency\":\"6\",\"unit_price\":\"50\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-17\",\"expiration_date\":\"2021-04-02\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617355536');
INSERT INTO `ea_system_log_202104` VALUES ('782', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"2\",\"customer_id\":\"3\",\"sales_id\":\"1\",\"contract_signer\":\"签订人1\",\"service\":\"5\",\"language\":\"9\",\"currency\":\"6\",\"unit_price\":\"50\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-17\",\"expiration_date\":\"2021-04-02\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617355619');
INSERT INTO `ea_system_log_202104` VALUES ('783', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"2\",\"customer_id\":\"3\",\"sales_id\":\"2\",\"contract_signer\":\"签订人1\",\"service\":\"5\",\"language\":\"9\",\"currency\":\"7\",\"unit_price\":\"50\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-02\",\"expiration_date\":\"2021-04-24\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617355665');
INSERT INTO `ea_system_log_202104` VALUES ('784', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"2\",\"customer_id\":\"3\",\"sales_id\":\"2\",\"contract_signer\":\"签订人1\",\"service\":\"5\",\"language\":\"9\",\"currency\":\"7\",\"unit_price\":\"50\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-02\",\"expiration_date\":\"2021-04-24\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617355702');
INSERT INTO `ea_system_log_202104` VALUES ('785', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"3\",\"sales_id\":\"4\",\"contract_signer\":\"签订人1\",\"service\":\"5\",\"language\":\"9\",\"currency\":\"6\",\"unit_price\":\"50\",\"unit\":\"2\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"3\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-16\",\"expiration_date\":\"2021-04-23\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617355739');
INSERT INTO `ea_system_log_202104` VALUES ('786', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"3\",\"sales_id\":\"4\",\"contract_signer\":\"签订人1\",\"service\":\"5\",\"language\":\"9\",\"currency\":\"6\",\"unit_price\":\"50\",\"unit\":\"2\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"3\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-16\",\"expiration_date\":\"2021-04-23\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617355765');
INSERT INTO `ea_system_log_202104` VALUES ('787', '1', '/admin/customer.contract/edit?id=4', 'post', '', '{\"\\/admin\\/customer_contract\\/edit\":\"\",\"id\":\"4\",\"company_id\":\"1\",\"customer_id\":\"3\",\"sales_id\":\"4\",\"contract_signer\":\"签订人1\",\"service\":\"5\",\"language\":\"9\",\"currency\":\"6\",\"unit_price\":\"50.00\",\"unit\":\"2\",\"estimated_sales\":\"1000.00\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"                    3                \",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-16 00:00:00\",\"expiration_date\":\"2021-04-23 00:00:00\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"                                    13123\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617356801');
INSERT INTO `ea_system_log_202104` VALUES ('788', '1', '/admin/customer.contract/edit?id=1', 'post', '', '{\"\\/admin\\/customer_contract\\/edit\":\"\",\"id\":\"1\",\"company_id\":\"1\",\"customer_id\":\"3\",\"sales_id\":\"3\",\"contract_signer\":\"签订人1\",\"service\":\"3\",\"language\":\"8\",\"currency\":\"6\",\"unit_price\":\"50.00\",\"unit\":\"1\",\"estimated_sales\":\"1000.00\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"                    客户银行信                \",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-02 00:00:00\",\"expiration_date\":\"2021-04-12 00:00:00\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"                    阿达                \"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617357623');
INSERT INTO `ea_system_log_202104` VALUES ('789', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"1\",\"sales_id\":\"3\",\"contract_signer\":\"签订人2\",\"service\":\"5\",\"language\":\"8\",\"currency\":\"6\",\"unit_price\":\"50\",\"unit\":\"2\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626321\",\"bank_information\":\"的\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-08\",\"expiration_date\":\"2021-04-15\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617359489');
INSERT INTO `ea_system_log_202104` VALUES ('790', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"1\",\"sales_id\":\"3\",\"contract_signer\":\"签订人2\",\"service\":\"5\",\"language\":\"8\",\"currency\":\"6\",\"unit_price\":\"50\",\"unit\":\"2\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626321\",\"bank_information\":\"的\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-08\",\"expiration_date\":\"2021-04-15\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617359580');
INSERT INTO `ea_system_log_202104` VALUES ('791', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"1\",\"sales_id\":\"3\",\"contract_signer\":\"签订人2\",\"service\":\"5\",\"language\":\"8\",\"currency\":\"6\",\"unit_price\":\"50\",\"unit\":\"2\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626321\",\"bank_information\":\"的\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-08\",\"expiration_date\":\"2021-04-15\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617359596');
INSERT INTO `ea_system_log_202104` VALUES ('792', '1', '/admin/system.auth/saveAuthorize', 'post', '', '{\"\\/admin\\/system_auth\\/saveAuthorize\":\"\",\"title\":\"管理\",\"node\":\"[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,21,22,23,24,25,26,27,28,67,68,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,111,112,113,114,115,116,117]\",\"id\":\"11\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617361298');
INSERT INTO `ea_system_log_202104` VALUES ('793', '1', '/admin/system.admin/add', 'post', '', '{\"\\/admin\\/system_admin\\/add\":\"\",\"head_img\":\"http:\\/\\/easyadmin.test\\/upload\\/20210401\\/0afd939a10d07cdb0a2f0e798768768e.png\",\"file\":\"\",\"username\":\"test1\",\"phone\":\"\",\"auth_ids\":{\"11\":\"on\"},\"remark\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617361321');
INSERT INTO `ea_system_log_202104` VALUES ('794', '1', '/admin/system.admin/password?id=5', 'post', '', '{\"\\/admin\\/system_admin\\/password\":\"\",\"id\":\"5\",\"username\":\"test1\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"password_again\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617361335');
INSERT INTO `ea_system_log_202104` VALUES ('795', null, '/admin/login/index', 'post', '', '{\"username\":\"test1\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617361348');
INSERT INTO `ea_system_log_202104` VALUES ('796', null, '/admin/login/index.html', 'post', '', '{\"\\/admin\\/login\\/index_html\":\"\",\"username\":\"admin\",\"password\":\"9dc7ebef2d81728609120a209641e88e902dd3d9\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617668905');
INSERT INTO `ea_system_log_202104` VALUES ('797', null, '/admin/login/index.html', 'post', '', '{\"\\/admin\\/login\\/index_html\":\"\",\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617668911');
INSERT INTO `ea_system_log_202104` VALUES ('798', null, '/admin/login/index', 'post', '', '{\"username\":\"test1\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617673277');
INSERT INTO `ea_system_log_202104` VALUES ('799', '5', '/admin/customer.information/edit?id=3', 'post', '', '{\"\\/admin\\/customer_information\\/edit\":\"\",\"id\":\"3\",\"customer_contact\":\"客户三客户联系人\",\"department\":\"客户三\",\"company_name\":\"客户三\",\"company_address\":\"客户三\",\"country\":\"客户三\",\"position\":\"客户三\",\"mobile_phone_number\":\"13257245375\",\"landline_number\":\"8512456\",\"mailbox\":\"zhuchenchen@zhuchenchen.cn\",\"company_code\":\"das21321321\",\"remarks\":\"                                    \"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617673362');
INSERT INTO `ea_system_log_202104` VALUES ('800', '5', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"1\",\"sales_id\":\"3\",\"contract_signer\":\"签订人2\",\"service\":\"3\",\"language\":\"8\",\"currency\":\"6\",\"unit_price\":\"50\",\"unit\":\"1\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626213213\",\"bank_information\":\"客户银行信息\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-06\",\"expiration_date\":\"2021-04-09\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"大萨达12\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617674392');
INSERT INTO `ea_system_log_202104` VALUES ('801', '5', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"1\",\"sales_id\":\"3\",\"contract_signer\":\"签订人2\",\"service\":\"3\",\"language\":\"8\",\"currency\":\"6\",\"unit_price\":\"50\",\"unit\":\"1\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626213213\",\"bank_information\":\"客户银行信息\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-06\",\"expiration_date\":\"2021-04-09\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"大萨达12\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617674399');
INSERT INTO `ea_system_log_202104` VALUES ('802', '5', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"1\",\"sales_id\":\"3\",\"contract_signer\":\"签订人2\",\"service\":\"3\",\"language\":\"8\",\"currency\":\"6\",\"unit_price\":\"50\",\"unit\":\"1\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626213213\",\"bank_information\":\"客户银行信息\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-06\",\"expiration_date\":\"2021-04-09\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"大萨达12\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617674417');
INSERT INTO `ea_system_log_202104` VALUES ('803', '5', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"1\",\"sales_id\":\"3\",\"contract_signer\":\"签订人2\",\"service\":\"3\",\"language\":\"8\",\"currency\":\"6\",\"unit_price\":\"50\",\"unit\":\"1\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626213213\",\"bank_information\":\"客户银行信息\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-06\",\"expiration_date\":\"2021-04-09\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"大萨达12\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617674422');
INSERT INTO `ea_system_log_202104` VALUES ('804', '5', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"1\",\"sales_id\":\"3\",\"contract_signer\":\"签订人2\",\"service\":\"3\",\"language\":\"8\",\"currency\":\"6\",\"unit_price\":\"50\",\"unit\":\"1\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626213213\",\"bank_information\":\"客户银行信息\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-06\",\"expiration_date\":\"2021-04-09\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"大萨达12\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617674430');
INSERT INTO `ea_system_log_202104` VALUES ('805', '5', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"1\",\"sales_id\":\"3\",\"contract_signer\":\"签订人2\",\"service\":\"3\",\"language\":\"8\",\"currency\":\"6\",\"unit_price\":\"50\",\"unit\":\"1\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626213213\",\"bank_information\":\"客户银行信息\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-06\",\"expiration_date\":\"2021-04-09\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"大萨达12\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617674445');
INSERT INTO `ea_system_log_202104` VALUES ('806', '5', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"1\",\"sales_id\":\"3\",\"contract_signer\":\"签订人2\",\"service\":\"3\",\"language\":\"8\",\"currency\":\"6\",\"unit_price\":\"50\",\"unit\":\"1\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626213213\",\"bank_information\":\"客户银行信息\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-06\",\"expiration_date\":\"2021-04-09\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"大萨达12\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617674476');
INSERT INTO `ea_system_log_202104` VALUES ('807', '5', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"1\",\"sales_id\":\"3\",\"contract_signer\":\"签订人2\",\"service\":\"3\",\"language\":\"8\",\"currency\":\"6\",\"unit_price\":\"50\",\"unit\":\"1\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626213213\",\"bank_information\":\"客户银行信息\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-06\",\"expiration_date\":\"2021-04-09\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"大萨达12\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617674496');
INSERT INTO `ea_system_log_202104` VALUES ('808', '5', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"1\",\"sales_id\":\"3\",\"contract_signer\":\"签订人2\",\"service\":\"3\",\"language\":\"8\",\"currency\":\"6\",\"unit_price\":\"50\",\"unit\":\"1\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626213213\",\"bank_information\":\"客户银行信息\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-06\",\"expiration_date\":\"2021-04-09\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"大萨达12\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617674553');
INSERT INTO `ea_system_log_202104` VALUES ('809', '5', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"1\",\"customer_id\":\"1\",\"sales_id\":\"3\",\"contract_signer\":\"签订人2\",\"service\":\"3\",\"language\":\"8\",\"currency\":\"6\",\"unit_price\":\"50\",\"unit\":\"1\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626213213\",\"bank_information\":\"客户银行信息\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-06\",\"expiration_date\":\"2021-04-09\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"大萨达12\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617674566');
INSERT INTO `ea_system_log_202104` VALUES ('810', null, '/admin/login/index', 'post', '', '{\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617675419');
INSERT INTO `ea_system_log_202104` VALUES ('811', null, '/admin/login/index', 'post', '', '{\"username\":\"test1\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617675914');
INSERT INTO `ea_system_log_202104` VALUES ('812', null, '/admin/login/index', 'post', '', '{\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617676975');
INSERT INTO `ea_system_log_202104` VALUES ('813', null, '/admin/login/index', 'post', '', '{\"username\":\"test\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617677432');
INSERT INTO `ea_system_log_202104` VALUES ('814', null, '/admin/login/index', 'post', '', '{\"username\":\"test1\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617677436');
INSERT INTO `ea_system_log_202104` VALUES ('815', null, '/admin/login/index', 'post', '', '{\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617677554');
INSERT INTO `ea_system_log_202104` VALUES ('816', null, '/admin/login/index', 'post', '', '{\"username\":\"test1\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617677743');
INSERT INTO `ea_system_log_202104` VALUES ('817', null, '/admin/login/index', 'post', '', '{\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617679935');
INSERT INTO `ea_system_log_202104` VALUES ('818', '1', '/admin/system.menu/modify', 'post', '', '{\"\\/admin\\/system_menu\\/modify\":\"\",\"id\":\"249\",\"field\":\"status\",\"value\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617680008');
INSERT INTO `ea_system_log_202104` VALUES ('819', '1', '/admin/customer.contract/delete?id=1', 'post', '', '{\"\\/admin\\/customer_contract\\/delete\":\"\",\"id\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617681672');
INSERT INTO `ea_system_log_202104` VALUES ('820', '1', '/admin/system.admin/delete?id=5', 'post', '', '{\"\\/admin\\/system_admin\\/delete\":\"\",\"id\":\"5\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617681687');
INSERT INTO `ea_system_log_202104` VALUES ('821', '1', '/admin/system.menu/edit?id=254', 'post', '', '{\"\\/admin\\/system_menu\\/edit\":\"\",\"id\":\"254\",\"pid\":\"228\",\"title\":\"客户管理\",\"href\":\"\",\"icon\":\"fa fa-list\",\"target\":\"_parent\",\"sort\":\"0\",\"remark\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617684723');
INSERT INTO `ea_system_log_202104` VALUES ('822', '1', '/admin/system.menu/edit?id=254', 'post', '', '{\"\\/admin\\/system_menu\\/edit\":\"\",\"id\":\"254\",\"pid\":\"0\",\"title\":\"客户管理\",\"href\":\"\",\"icon\":\"fa fa-list\",\"target\":\"_parent\",\"sort\":\"0\",\"remark\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617684742');
INSERT INTO `ea_system_log_202104` VALUES ('823', '1', '/admin/system.menu/modify', 'post', '', '{\"\\/admin\\/system_menu\\/modify\":\"\",\"id\":\"257\",\"field\":\"sort\",\"value\":\"2\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617684765');
INSERT INTO `ea_system_log_202104` VALUES ('824', '1', '/admin/system.admin/modify', 'post', '', '{\"\\/admin\\/system_admin\\/modify\":\"\",\"id\":\"5\",\"field\":\"status\",\"value\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617685016');
INSERT INTO `ea_system_log_202104` VALUES ('825', '1', '/admin/system.admin/modify', 'post', '', '{\"\\/admin\\/system_admin\\/modify\":\"\",\"id\":\"5\",\"field\":\"status\",\"value\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617685017');
INSERT INTO `ea_system_log_202104` VALUES ('826', '1', '/admin/system.admin/modify', 'post', '', '{\"\\/admin\\/system_admin\\/modify\":\"\",\"id\":\"5\",\"field\":\"status\",\"value\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617685018');
INSERT INTO `ea_system_log_202104` VALUES ('827', '1', '/admin/system.admin/modify', 'post', '', '{\"\\/admin\\/system_admin\\/modify\":\"\",\"id\":\"5\",\"field\":\"status\",\"value\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617685019');
INSERT INTO `ea_system_log_202104` VALUES ('828', '1', '/admin/system.admin/modify', 'post', '', '{\"\\/admin\\/system_admin\\/modify\":\"\",\"id\":\"5\",\"field\":\"status\",\"value\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617685020');
INSERT INTO `ea_system_log_202104` VALUES ('829', '1', '/admin/system.admin/modify', 'post', '', '{\"\\/admin\\/system_admin\\/modify\":\"\",\"id\":\"5\",\"field\":\"status\",\"value\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617685021');
INSERT INTO `ea_system_log_202104` VALUES ('830', '1', '/admin/system.node/refreshNode?force=0', 'post', '', '{\"\\/admin\\/system_node\\/refreshNode\":\"\",\"force\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617685555');
INSERT INTO `ea_system_log_202104` VALUES ('831', '1', '/admin/system.node/modify', 'post', '', '{\"\\/admin\\/system_node\\/modify\":\"\",\"id\":\"118\",\"field\":\"title\",\"value\":\"来稿需求\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617685569');
INSERT INTO `ea_system_log_202104` VALUES ('832', '1', '/admin/system.menu/add?id=254', 'post', '', '{\"\\/admin\\/system_menu\\/add\":\"\",\"id\":\"254\",\"pid\":\"254\",\"title\":\"来稿需求\",\"href\":\"customer.demand\\/index\",\"icon\":\"fa fa-list\",\"target\":\"_self\",\"sort\":\"3\",\"remark\":\"来稿需求\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617685609');
INSERT INTO `ea_system_log_202104` VALUES ('833', '1', '/admin/system.menu/modify', 'post', '', '{\"\\/admin\\/system_menu\\/modify\":\"\",\"id\":\"262\",\"field\":\"sort\",\"value\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617685638');
INSERT INTO `ea_system_log_202104` VALUES ('834', '1', '/admin/customer.contract/edit?id=3', 'post', '', '{\"\\/admin\\/customer_contract\\/edit\":\"\",\"id\":\"3\",\"company_id\":\"2\",\"customer_id\":\"1\",\"sales_id\":\"3\",\"contract_signer\":\"签订人2\",\"service\":\"5\",\"language\":\"9\",\"currency\":\"7\",\"unit_price\":\"50.00\",\"unit\":\"1\",\"estimated_sales\":\"1000.00\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626321\",\"bank_information\":\"                    1312                \",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-02\",\"expiration_date\":\"2021-04-17\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"                                    \"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617686765');
INSERT INTO `ea_system_log_202104` VALUES ('835', '1', '/admin/customer.contract/edit?id=2', 'post', '', '{\"\\/admin\\/customer_contract\\/edit\":\"\",\"id\":\"2\",\"company_id\":\"1\",\"customer_id\":\"2\",\"sales_id\":\"3\",\"contract_signer\":\"签订人2\",\"service\":\"3\",\"language\":\"9\",\"currency\":\"6\",\"unit_price\":\"50.00\",\"unit\":\"2\",\"estimated_sales\":\"1000.00\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"                    123                \",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"2\",\"effective_date\":\"2021-04-02\",\"expiration_date\":\"2021-04-10\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"                    123                \"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617686777');
INSERT INTO `ea_system_log_202104` VALUES ('836', '1', '/admin/customer.contract/edit?id=4', 'post', '', '{\"\\/admin\\/customer_contract\\/edit\":\"\",\"id\":\"4\",\"company_id\":\"1\",\"customer_id\":\"3\",\"sales_id\":\"4\",\"contract_signer\":\"签订人1\",\"service\":\"5\",\"language\":\"9\",\"currency\":\"6\",\"unit_price\":\"50.00\",\"unit\":\"2\",\"estimated_sales\":\"1000.00\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"                                        3                                \",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-16\",\"expiration_date\":\"2021-04-23\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"                                                        13123                \"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617686786');
INSERT INTO `ea_system_log_202104` VALUES ('837', null, '/admin/login/index.html', 'post', '', '{\"\\/admin\\/login\\/index_html\":\"\",\"username\":\"test1\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617687192');
INSERT INTO `ea_system_log_202104` VALUES ('838', '5', '/admin/customer.contract/edit?id=2', 'post', '', '{\"\\/admin\\/customer_contract\\/edit\":\"\",\"id\":\"2\",\"company_id\":\"1\",\"customer_id\":\"2\",\"sales_id\":\"3\",\"contract_signer\":\"签订人2\",\"service\":\"3\",\"language\":\"9\",\"currency\":\"6\",\"unit_price\":\"50.00\",\"unit\":\"2\",\"estimated_sales\":\"1000.00\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"                                        123                                \",\"invoicing_rules\":\"2\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-02\",\"expiration_date\":\"2021-04-10\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"                                        123                                \"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617687272');
INSERT INTO `ea_system_log_202104` VALUES ('839', null, '/admin/login/index', 'post', '', '{\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617687333');
INSERT INTO `ea_system_log_202104` VALUES ('840', null, '/admin/login/index', 'post', '', '{\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617687364');
INSERT INTO `ea_system_log_202104` VALUES ('841', '1', '/admin/database.content/edit?id=9', 'post', '', '{\"\\/admin\\/database_content\\/edit\":\"\",\"id\":\"9\",\"list_id\":\"3\",\"content\":\"英文-中文\\/EN-CN2\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617687455');
INSERT INTO `ea_system_log_202104` VALUES ('842', '1', '/admin/database.content/edit?id=9', 'post', '', '{\"\\/admin\\/database_content\\/edit\":\"\",\"id\":\"9\",\"list_id\":\"3\",\"content\":\"英文-中文\\/EN-CN\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617687482');
INSERT INTO `ea_system_log_202104` VALUES ('843', '1', '/admin/system.auth/add', 'post', '', '{\"\\/admin\\/system_auth\\/add\":\"\",\"title\":\"项目经理\",\"remark\":\"项目经理\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617687964');
INSERT INTO `ea_system_log_202104` VALUES ('844', '1', '/admin/system.admin/add', 'post', '', '{\"\\/admin\\/system_admin\\/add\":\"\",\"head_img\":\"http:\\/\\/admin.host\\/upload\\/20200514\\/e1c6c9ef6a4b98b8f7d95a1a0191a2df.jpg\",\"file\":\"\",\"username\":\"项目经理1\",\"phone\":\"\",\"auth_ids\":{\"12\":\"on\"},\"remark\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617688009');
INSERT INTO `ea_system_log_202104` VALUES ('845', '1', '/admin/system.admin/add', 'post', '', '{\"\\/admin\\/system_admin\\/add\":\"\",\"head_img\":\"http:\\/\\/admin.host\\/upload\\/20200514\\/98fc09b0c4ad4d793a6f04bef79a0edc.jpg\",\"file\":\"\",\"username\":\"项目经理2\",\"phone\":\"\",\"auth_ids\":{\"12\":\"on\"},\"remark\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617688035');
INSERT INTO `ea_system_log_202104` VALUES ('846', '1', '/admin/customer.information/edit?id=3', 'post', '', '{\"\\/admin\\/customer_information\\/edit\":\"\",\"id\":\"3\",\"customer_contact\":\"客户三客户联系人\",\"department\":\"客户三\",\"company_name\":\"客户三\",\"company_address\":\"客户三\",\"country\":\"客户三\",\"position\":\"客户三\",\"mobile_phone_number\":\"13257245375\",\"landline_number\":\"8512456\",\"mailbox\":\"zhuchenchen@zhuchenchen.cn\",\"company_code\":\"das2132\",\"remarks\":\"                                                                        \"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617688700');
INSERT INTO `ea_system_log_202104` VALUES ('847', '1', '/admin/customer.information/edit?id=2', 'post', '', '{\"\\/admin\\/customer_information\\/edit\":\"\",\"id\":\"2\",\"customer_contact\":\"客户2\",\"department\":\"客户2所在部门\",\"company_name\":\"客户2公司全称\",\"company_address\":\"客户2公司地址\",\"country\":\"客户2v\",\"position\":\"客户2职位\",\"mobile_phone_number\":\"13257245375\",\"landline_number\":\"8512456\",\"mailbox\":\"zhuchenchen@zhuchenchen.cn\",\"company_code\":\"das213213khj\",\"remarks\":\"                    阿斯顿                \"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617688709');
INSERT INTO `ea_system_log_202104` VALUES ('848', '1', '/admin/customer.information/edit?id=1', 'post', '', '{\"\\/admin\\/customer_information\\/edit\":\"\",\"id\":\"1\",\"customer_contact\":\"客户1\",\"department\":\"部门1\",\"company_name\":\"客户公司名称1\",\"company_address\":\"公司地址1\",\"country\":\"国家1\",\"position\":\"职位1\",\"mobile_phone_number\":\"13257245375\",\"landline_number\":\"8512456\",\"mailbox\":\"zhuchenchen@zhuchenchen.cn\",\"company_code\":\"das21321321gdgd\",\"remarks\":\"                    1312                \"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617688716');
INSERT INTO `ea_system_log_202104` VALUES ('849', '1', '/admin/customer.contract/edit?id=3', 'post', '', '{\"\\/admin\\/customer_contract\\/edit\":\"\",\"id\":\"3\",\"company_id\":\"2\",\"customer_id\":\"1\",\"sales_id\":\"3\",\"contract_signer\":\"签订人2\",\"service\":\"5\",\"language\":\"9\",\"currency\":\"7\",\"unit_price\":\"50.00\",\"unit\":\"1\",\"estimated_sales\":\"1000.00\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626321\",\"bank_information\":\"                                        1312                                \",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-02\",\"expiration_date\":\"2021-04-17\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"                                                                        \"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617688739');
INSERT INTO `ea_system_log_202104` VALUES ('850', '1', '/admin/customer.information/edit?id=2', 'post', '', '{\"\\/admin\\/customer_information\\/edit\":\"\",\"id\":\"2\",\"customer_contact\":\"客户2\",\"department\":\"客户2公司名称\",\"company_name\":\"客户2公司全称\",\"company_address\":\"客户2公司地址\",\"country\":\"客户2v\",\"position\":\"客户2职位\",\"mobile_phone_number\":\"13257245375\",\"landline_number\":\"8512456\",\"mailbox\":\"zhuchenchen@zhuchenchen.cn\",\"company_code\":\"das213213khj\",\"remarks\":\"                                        阿斯顿                                \"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617688898');
INSERT INTO `ea_system_log_202104` VALUES ('851', '1', '/admin/customer.information/edit?id=3', 'post', '', '{\"\\/admin\\/customer_information\\/edit\":\"\",\"id\":\"3\",\"customer_contact\":\"客户三客户联系人\",\"department\":\"客户三\",\"company_name\":\"客户三公司名称\",\"company_address\":\"客户三\",\"country\":\"客户三\",\"position\":\"客户三\",\"mobile_phone_number\":\"13257245375\",\"landline_number\":\"8512456\",\"mailbox\":\"zhuchenchen@zhuchenchen.cn\",\"company_code\":\"das2132\",\"remarks\":\"                                                                                                            \"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617688918');
INSERT INTO `ea_system_log_202104` VALUES ('852', '1', '/admin/customer.information/edit?id=2', 'post', '', '{\"\\/admin\\/customer_information\\/edit\":\"\",\"id\":\"2\",\"customer_contact\":\"客户2\",\"department\":\"客户2公司名称\",\"company_name\":\"客户二公司名称\",\"company_address\":\"客户2公司地址\",\"country\":\"客户2v\",\"position\":\"客户2职位\",\"mobile_phone_number\":\"13257245375\",\"landline_number\":\"8512456\",\"mailbox\":\"zhuchenchen@zhuchenchen.cn\",\"company_code\":\"das213213khj\",\"remarks\":\"                                                            阿斯顿                                                \"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617688957');
INSERT INTO `ea_system_log_202104` VALUES ('853', '1', '/admin/customer.contract/edit?id=2', 'post', '', '{\"\\/admin\\/customer_contract\\/edit\":\"\",\"id\":\"2\",\"company_id\":\"1\",\"customer_id\":\"2\",\"sales_id\":\"3\",\"contract_signer\":\"签订人2\",\"service\":\"3\",\"language\":\"9\",\"currency\":\"6\",\"unit_price\":\"50.00\",\"unit\":\"2\",\"estimated_sales\":\"1000.00\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas626\",\"bank_information\":\"                                                            123                                                \",\"invoicing_rules\":\"2\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-02\",\"expiration_date\":\"2021-04-10\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"                                                            123                                                \"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617688993');
INSERT INTO `ea_system_log_202104` VALUES ('854', '1', '/admin/customer.demand/add', 'post', '', '{\"\\/admin\\/customer_demand\\/add\":\"\",\"cid\":\"5\",\"mid\":\"6\",\"cooperation_first\":\"0\",\"quotation_amount\":\"50000\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617689094');
INSERT INTO `ea_system_log_202104` VALUES ('855', null, '/admin/login/index.html', 'post', '', '{\"\\/admin\\/login\\/index_html\":\"\",\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617694587');
INSERT INTO `ea_system_log_202104` VALUES ('856', '1', '/admin/system.menu/modify', 'post', '', '{\"\\/admin\\/system_menu\\/modify\":\"\",\"id\":\"249\",\"field\":\"status\",\"value\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617697154');
INSERT INTO `ea_system_log_202104` VALUES ('857', '1', '/admin/customer.demand/add', 'post', '', '{\"\\/admin\\/customer_demand\\/add\":\"\",\"cid\":\"4\",\"mid\":\"6\",\"cooperation_first\":\"2\",\"quotation_amount\":\"5040\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617699780');
INSERT INTO `ea_system_log_202104` VALUES ('858', '1', '/admin/customer.contract/delete?id=6', 'post', '', '{\"\\/admin\\/customer_contract\\/delete\":\"\",\"id\":\"6\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617706011');
INSERT INTO `ea_system_log_202104` VALUES ('859', '1', '/admin/customer.contract/delete', 'post', '', '{\"\\/admin\\/customer_contract\\/delete\":\"\",\"id\":[\"4\",\"3\",\"2\"]}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617706078');
INSERT INTO `ea_system_log_202104` VALUES ('860', '1', '/admin/customer.contract/add', 'post', '', '{\"\\/admin\\/customer_contract\\/add\":\"\",\"company_id\":\"2\",\"customer_id\":\"2\",\"sales_id\":\"4\",\"contract_signer\":\"签订人1\",\"service\":\"3\",\"language\":\"8\",\"currency\":\"7\",\"unit_price\":\"50\",\"unit\":\"2\",\"estimated_sales\":\"1000\",\"tax_rate\":\"5\",\"customer_tax_number\":\"fdsfdas62631123\",\"bank_information\":\"312313\",\"invoicing_rules\":\"0\",\"account_period\":\"20天后结算\",\"confidentiality_agreement\":\"0\",\"effective_date\":\"2021-04-02\",\"expiration_date\":\"2021-04-08\",\"recipient\":\"合同一收件人\",\"recipient_address\":\"合同一收货地址\",\"remarks\":\"13\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617706654');
INSERT INTO `ea_system_log_202104` VALUES ('861', '1', '/admin/customer.demand/delete?id=2', 'post', '', '{\"\\/admin\\/customer_demand\\/delete\":\"\",\"id\":\"2\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617707667');
INSERT INTO `ea_system_log_202104` VALUES ('862', '1', '/admin/customer.demand/add', 'post', '', '{\"\\/admin\\/customer_demand\\/add\":\"\",\"cid\":\"5\",\"mid\":\"6\",\"cooperation_first\":\"0\",\"quotation_amount\":\"50000\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617707823');
INSERT INTO `ea_system_log_202104` VALUES ('863', '1', '/admin/customer.contract/delete?id=5', 'post', '', '{\"\\/admin\\/customer_contract\\/delete\":\"\",\"id\":\"5\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617707845');
INSERT INTO `ea_system_log_202104` VALUES ('864', '1', '/admin/customer.demand/add', 'post', '', '{\"\\/admin\\/customer_demand\\/add\":\"\",\"cid\":\"7\",\"mid\":\"6\",\"cooperation_first\":\"2\",\"quotation_amount\":\"5040\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617707866');
INSERT INTO `ea_system_log_202104` VALUES ('865', null, '/admin/login/index.html', 'post', '', '{\"\\/admin\\/login\\/index_html\":\"\",\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617712304');
INSERT INTO `ea_system_log_202104` VALUES ('866', '1', '/admin/system.menu/modify', 'post', '', '{\"\\/admin\\/system_menu\\/modify\":\"\",\"id\":\"249\",\"field\":\"status\",\"value\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617712319');
INSERT INTO `ea_system_log_202104` VALUES ('867', null, '/admin/login/index.html', 'post', '', '{\"\\/admin\\/login\\/index_html\":\"\",\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617756691');
INSERT INTO `ea_system_log_202104` VALUES ('868', '1', '/admin/customer.demand/add', 'post', '', '{\"\\/admin\\/customer_demand\\/add\":\"\",\"cid\":\"7\",\"mid\":\"6\",\"cooperation_first\":\"0\",\"quotation_amount\":\"50000\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617760898');
INSERT INTO `ea_system_log_202104` VALUES ('869', '1', '/admin/customer.demand/add', 'post', '', '{\"\\/admin\\/customer_demand\\/add\":\"\",\"cid\":\"7\",\"mid\":\"6\",\"cooperation_first\":\"0\",\"quotation_amount\":\"50000\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617761012');
INSERT INTO `ea_system_log_202104` VALUES ('870', '1', '/admin/customer.demand/add', 'post', '', '{\"\\/admin\\/customer_demand\\/add\":\"\",\"cid\":\"7\",\"mid\":\"6\",\"cooperation_first\":\"0\",\"quotation_amount\":\"50000\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617761054');
INSERT INTO `ea_system_log_202104` VALUES ('871', '1', '/admin/customer.demand/add', 'post', '', '{\"\\/admin\\/customer_demand\\/add\":\"\",\"cid\":\"7\",\"mid\":\"6\",\"cooperation_first\":\"0\",\"quotation_amount\":\"50000\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617761199');
INSERT INTO `ea_system_log_202104` VALUES ('872', '1', '/admin/customer.demand/add', 'post', '', '{\"\\/admin\\/customer_demand\\/add\":\"\",\"cid\":\"7\",\"mid\":\"6\",\"cooperation_first\":\"0\",\"quotation_amount\":\"50000\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617761208');
INSERT INTO `ea_system_log_202104` VALUES ('873', '1', '/admin/customer.demand/add', 'post', '', '{\"\\/admin\\/customer_demand\\/add\":\"\",\"cid\":\"7\",\"mid\":\"6\",\"cooperation_first\":\"0\",\"quotation_amount\":\"50000\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617761227');
INSERT INTO `ea_system_log_202104` VALUES ('874', '1', '/admin/customer.demand/add', 'post', '', '{\"\\/admin\\/customer_demand\\/add\":\"\",\"cid\":\"7\",\"mid\":\"6\",\"cooperation_first\":\"0\",\"quotation_amount\":\"50000\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617761262');
INSERT INTO `ea_system_log_202104` VALUES ('875', '1', '/admin/customer.demand/add', 'post', '', '{\"\\/admin\\/customer_demand\\/add\":\"\",\"cid\":\"7\",\"mid\":\"6\",\"cooperation_first\":\"0\",\"quotation_amount\":\"50000\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617761306');
INSERT INTO `ea_system_log_202104` VALUES ('876', '1', '/admin/database.content/add', 'post', '', '{\"\\/admin\\/database_content\\/add\":\"\",\"list_id\":\"4\",\"content\":\"PDF\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617762948');
INSERT INTO `ea_system_log_202104` VALUES ('877', '1', '/admin/database.content/add', 'post', '', '{\"\\/admin\\/database_content\\/add\":\"\",\"list_id\":\"4\",\"content\":\"Word\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617762972');
INSERT INTO `ea_system_log_202104` VALUES ('878', null, '/admin/login/index.html', 'post', '', '{\"\\/admin\\/login\\/index_html\":\"\",\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617764750');
INSERT INTO `ea_system_log_202104` VALUES ('879', '1', '/admin/system.node/refreshNode?force=0', 'post', '', '{\"\\/admin\\/system_node\\/refreshNode\":\"\",\"force\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617765322');
INSERT INTO `ea_system_log_202104` VALUES ('880', '1', '/admin/system.node/modify', 'post', '', '{\"\\/admin\\/system_node\\/modify\":\"\",\"id\":\"125\",\"field\":\"title\",\"value\":\"文件信息\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617765335');
INSERT INTO `ea_system_log_202104` VALUES ('881', '1', '/admin/customer.file/index?id=5', 'post', '', '{\"\\/admin\\/customer_file\\/index\":\"\",\"id\":\"5\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617765405');
INSERT INTO `ea_system_log_202104` VALUES ('882', '1', '/admin/customer.file/index?id=5', 'post', '', '{\"\\/admin\\/customer_file\\/index\":\"\",\"id\":\"5\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617765414');
INSERT INTO `ea_system_log_202104` VALUES ('883', '1', '/admin/customer.file/index?id=5', 'post', '', '{\"\\/admin\\/customer_file\\/index\":\"\",\"id\":\"5\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617765441');
INSERT INTO `ea_system_log_202104` VALUES ('884', '1', '/admin/customer.file/index?id=5', 'post', '', '{\"\\/admin\\/customer_file\\/index\":\"\",\"id\":\"5\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617765453');
INSERT INTO `ea_system_log_202104` VALUES ('885', '1', '/admin/customer.file/index?id=5', 'post', '', '{\"\\/admin\\/customer_file\\/index\":\"\",\"id\":\"5\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617765480');
INSERT INTO `ea_system_log_202104` VALUES ('886', '1', '/admin/customer.file/index?id=5', 'post', '', '{\"\\/admin\\/customer_file\\/index\":\"\",\"id\":\"5\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617765568');
INSERT INTO `ea_system_log_202104` VALUES ('887', '1', '/admin/database.content/add', 'post', '', '{\"\\/admin\\/database_content\\/add\":\"\",\"list_id\":\"9\",\"content\":\"6\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617766962');
INSERT INTO `ea_system_log_202104` VALUES ('888', '1', '/admin/database.content/add', 'post', '', '{\"\\/admin\\/database_content\\/add\":\"\",\"list_id\":\"9\",\"content\":\"9\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617766971');
INSERT INTO `ea_system_log_202104` VALUES ('889', null, '/admin/login/index.html', 'post', '', '{\"\\/admin\\/login\\/index_html\":\"\",\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617776254');
INSERT INTO `ea_system_log_202104` VALUES ('890', null, '/admin/login/index.html', 'post', '', '{\"\\/admin\\/login\\/index_html\":\"\",\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617792331');
INSERT INTO `ea_system_log_202104` VALUES ('891', null, '/admin/login/index', 'post', '', '{\"username\":\"admin\",\"password\":\"c706430c861b372f86085ec964e448d0df5ce3c0\",\"keep_login\":\"0\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617871765');
INSERT INTO `ea_system_log_202104` VALUES ('892', null, '/admin/login/index', 'post', '', '{\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617871769');
INSERT INTO `ea_system_log_202104` VALUES ('893', '1', '/admin/index/editPassword.html', 'post', '', '{\"\\/admin\\/index\\/editPassword_html\":\"\",\"username\":\"admin\",\"password\":\"3e128eeae279e37c50fcd0a1cf3a5e6ab00df413\",\"password_again\":\"3e128eeae279e37c50fcd0a1cf3a5e6ab00df413\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617871794');
INSERT INTO `ea_system_log_202104` VALUES ('894', '1', '/admin/index/editPassword.html', 'post', '', '{\"\\/admin\\/index\\/editPassword_html\":\"\",\"username\":\"admin\",\"password\":\"3e128eeae279e37c50fcd0a1cf3a5e6ab00df413\",\"password_again\":\"3e128eeae279e37c50fcd0a1cf3a5e6ab00df413\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617871797');
INSERT INTO `ea_system_log_202104` VALUES ('895', '1', '/admin/index/editPassword.html', 'post', '', '{\"\\/admin\\/index\\/editPassword_html\":\"\",\"username\":\"admin\",\"password\":\"3e128eeae279e37c50fcd0a1cf3a5e6ab00df413\",\"password_again\":\"3e128eeae279e37c50fcd0a1cf3a5e6ab00df413\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617871801');
INSERT INTO `ea_system_log_202104` VALUES ('896', '1', '/admin/index/editPassword.html', 'post', '', '{\"\\/admin\\/index\\/editPassword_html\":\"\",\"username\":\"admin\",\"password\":\"3e128eeae279e37c50fcd0a1cf3a5e6ab00df413\",\"password_again\":\"3e128eeae279e37c50fcd0a1cf3a5e6ab00df413\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617871882');
INSERT INTO `ea_system_log_202104` VALUES ('897', null, '/admin/login/index', 'post', '', '{\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617871894');
INSERT INTO `ea_system_log_202104` VALUES ('898', null, '/admin/login/index', 'post', '', '{\"username\":\"admin\",\"password\":\"3e128eeae279e37c50fcd0a1cf3a5e6ab00df413\",\"keep_login\":\"0\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617871900');
INSERT INTO `ea_system_log_202104` VALUES ('899', '1', '/admin/system.auth/saveAuthorize', 'post', '', '{\"\\/admin\\/system_auth\\/saveAuthorize\":\"\",\"title\":\"管理员\",\"node\":\"[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,21,22,23,24,25,26,27,28,67,68,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131]\",\"id\":\"1\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617872010');
INSERT INTO `ea_system_log_202104` VALUES ('900', '1', '/admin/system.admin/edit?id=5', 'post', '', '{\"\\/admin\\/system_admin\\/edit\":\"\",\"id\":\"5\",\"head_img\":\"http:\\/\\/easyadmin.test\\/upload\\/20210401\\/0afd939a10d07cdb0a2f0e798768768e.png\",\"file\":\"\",\"username\":\"test1\",\"phone\":\"test1\",\"auth_ids\":{\"1\":\"on\",\"11\":\"on\"},\"remark\":\"test1\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617872055');
INSERT INTO `ea_system_log_202104` VALUES ('901', null, '/admin/login/index', 'post', '', '{\"username\":\"test1\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617872067');
INSERT INTO `ea_system_log_202104` VALUES ('902', null, '/admin/login/index', 'post', '', '{\"username\":\"admin\",\"password\":\"c706430c861b372f86085ec964e448d0df5ce3c0\",\"keep_login\":\"0\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617872149');
INSERT INTO `ea_system_log_202104` VALUES ('903', null, '/admin/login/index', 'post', '', '{\"username\":\"admin\",\"password\":\"3e128eeae279e37c50fcd0a1cf3a5e6ab00df413\",\"keep_login\":\"0\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617872153');
INSERT INTO `ea_system_log_202104` VALUES ('904', null, '/admin/login/index.html', 'post', '', '{\"\\/admin\\/login\\/index_html\":\"\",\"username\":\"admin\",\"password\":\"3e128eeae279e37c50fcd0a1cf3a5e6ab00df413\",\"keep_login\":\"0\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617872583');
INSERT INTO `ea_system_log_202104` VALUES ('905', '1', '/admin/customer.file/add', 'post', '', '{\"\\/admin\\/customer_file\\/add\":\"\",\"file_name\":\"文件名称1\",\"page\":\"6\",\"number_of_words\":\"66\",\"file_type\":\"10\",\"service\":\"1\",\"language\":\"8\",\"unit_price\":\"50\",\"unit\":\"2\",\"quotation_number\":\"2\",\"tax_rate\":\"12\",\"customer_submit_date\":\"2021-04-08 18:15:52\",\"customer_file_request\":\"23\",\"customer_file_reference\":\"12\",\"customer_file_remark\":\"21\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617876956');
INSERT INTO `ea_system_log_202104` VALUES ('906', '1', '/admin/customer.file/add', 'post', '', '{\"\\/admin\\/customer_file\\/add\":\"\",\"file_name\":\"文件名称1\",\"page\":\"6\",\"number_of_words\":\"66\",\"file_type\":\"10\",\"service\":\"1\",\"language\":\"8\",\"unit_price\":\"50\",\"unit\":\"2\",\"quotation_number\":\"2\",\"tax_rate\":\"12\",\"customer_submit_date\":\"2021-04-08 18:15:52\",\"customer_file_request\":\"23\",\"customer_file_reference\":\"12\",\"customer_file_remark\":\"21\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617876960');
INSERT INTO `ea_system_log_202104` VALUES ('907', '1', '/admin/customer.file/add', 'post', '', '{\"\\/admin\\/customer_file\\/add\":\"\",\"file_name\":\"文件名称1\",\"page\":\"6\",\"number_of_words\":\"66\",\"file_type\":\"10\",\"service\":\"1\",\"language\":\"8\",\"unit_price\":\"50\",\"unit\":\"2\",\"quotation_number\":\"2\",\"tax_rate\":\"12\",\"customer_submit_date\":\"2021-04-08 18:15:52\",\"customer_file_request\":\"23\",\"customer_file_reference\":\"12\",\"customer_file_remark\":\"21\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617877028');
INSERT INTO `ea_system_log_202104` VALUES ('908', '1', '/admin/customer.file/add', 'post', '', '{\"\\/admin\\/customer_file\\/add\":\"\",\"file_name\":\"文件名称1\",\"page\":\"6\",\"number_of_words\":\"66\",\"file_type\":\"10\",\"service\":\"1\",\"language\":\"8\",\"unit_price\":\"50\",\"unit\":\"2\",\"quotation_number\":\"2\",\"tax_rate\":\"12\",\"customer_submit_date\":\"2021-04-08 18:15:52\",\"customer_file_request\":\"23\",\"customer_file_reference\":\"12\",\"customer_file_remark\":\"21\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617877036');
INSERT INTO `ea_system_log_202104` VALUES ('909', '1', '/admin/customer.file/add', 'post', '', '{\"\\/admin\\/customer_file\\/add\":\"\",\"file_name\":\"文件名称1\",\"page\":\"6\",\"number_of_words\":\"66\",\"file_type\":\"10\",\"service\":\"1\",\"language\":\"8\",\"unit_price\":\"50\",\"unit\":\"2\",\"quotation_number\":\"2\",\"tax_rate\":\"12\",\"customer_submit_date\":\"2021-04-08 18:15:52\",\"customer_file_request\":\"23\",\"customer_file_reference\":\"12\",\"customer_file_remark\":\"21\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617877116');
INSERT INTO `ea_system_log_202104` VALUES ('910', '1', '/admin/customer.file/add', 'post', '', '{\"\\/admin\\/customer_file\\/add\":\"\",\"file_name\":\"文件名称1\",\"page\":\"6\",\"number_of_words\":\"66\",\"file_type\":\"10\",\"service\":\"1\",\"language\":\"8\",\"unit_price\":\"50\",\"unit\":\"2\",\"quotation_number\":\"2\",\"tax_rate\":\"12\",\"customer_submit_date\":\"2021-04-08 18:15:52\",\"customer_file_request\":\"23\",\"customer_file_reference\":\"12\",\"customer_file_remark\":\"21\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617877142');
INSERT INTO `ea_system_log_202104` VALUES ('911', '1', '/admin/customer.file/add', 'post', '', '{\"\\/admin\\/customer_file\\/add\":\"\",\"file_name\":\"文件名称1\",\"page\":\"6\",\"number_of_words\":\"66\",\"file_type\":\"10\",\"service\":\"1\",\"language\":\"8\",\"unit_price\":\"50\",\"unit\":\"2\",\"quotation_number\":\"2\",\"tax_rate\":\"12\",\"customer_submit_date\":\"2021-04-08 18:15:52\",\"customer_file_request\":\"23\",\"customer_file_reference\":\"12\",\"customer_file_remark\":\"21\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617877144');
INSERT INTO `ea_system_log_202104` VALUES ('912', '1', '/admin/customer.file/add', 'post', '', '{\"\\/admin\\/customer_file\\/add\":\"\",\"file_name\":\"文件名称1\",\"page\":\"6\",\"number_of_words\":\"66\",\"file_type\":\"10\",\"service\":\"1\",\"language\":\"8\",\"unit_price\":\"50\",\"unit\":\"2\",\"quotation_number\":\"2\",\"tax_rate\":\"12\",\"customer_submit_date\":\"2021-04-08 18:15:52\",\"customer_file_request\":\"23\",\"customer_file_reference\":\"12\",\"customer_file_remark\":\"21\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617877149');
INSERT INTO `ea_system_log_202104` VALUES ('913', '1', '/admin/customer.file/add', 'post', '', '{\"\\/admin\\/customer_file\\/add\":\"\",\"file_name\":\"文件名称1\",\"page\":\"6\",\"number_of_words\":\"66\",\"file_type\":\"10\",\"service\":\"1\",\"language\":\"8\",\"unit_price\":\"50\",\"unit\":\"2\",\"quotation_number\":\"2\",\"tax_rate\":\"12\",\"customer_submit_date\":\"2021-04-08 18:15:52\",\"customer_file_request\":\"23\",\"customer_file_reference\":\"12\",\"customer_file_remark\":\"21\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617877160');
INSERT INTO `ea_system_log_202104` VALUES ('914', '1', '/admin/customer.file/add', 'post', '', '{\"\\/admin\\/customer_file\\/add\":\"\",\"file_name\":\"文件名称1\",\"page\":\"6\",\"number_of_words\":\"2\",\"file_type\":\"10\",\"service\":\"1\",\"language\":\"8\",\"unit_price\":\"50\",\"unit\":\"1\",\"quotation_number\":\"2\",\"tax_rate\":\"13\",\"customer_submit_date\":\"2021-04-08 18:21:50\",\"customer_file_request\":\"2\",\"customer_file_reference\":\"2\",\"customer_file_remark\":\"2\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617877312');
INSERT INTO `ea_system_log_202104` VALUES ('915', '1', '/admin/customer.demand/edit?id=5', 'post', '', '{\"\\/admin\\/customer_demand\\/edit\":\"\",\"id\":\"5\",\"cid\":\"7\",\"mid\":\"6\",\"cooperation_first\":\"2\",\"quotation_amount\":\"50000.00\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617877575');
INSERT INTO `ea_system_log_202104` VALUES ('916', '1', '/admin/customer.file/add', 'post', '', '{\"\\/admin\\/customer_file\\/add\":\"\",\"file_name\":\"文件名称1\",\"page\":\"6\",\"number_of_words\":\"2\",\"file_type\":\"10\",\"service\":\"1\",\"language\":\"8\",\"unit_price\":\"50\",\"unit\":\"1\",\"quotation_number\":\"2\",\"tax_rate\":\"12\",\"customer_submit_date\":\"2021-04-08 18:27:27\",\"customer_file_request\":\"2\",\"customer_file_reference\":\"2\",\"customer_file_remark\":\"2\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617877649');
INSERT INTO `ea_system_log_202104` VALUES ('917', '1', '/admin/customer.file/add', 'post', '', '{\"\\/admin\\/customer_file\\/add\":\"\",\"file_name\":\"文件名称1\",\"page\":\"6\",\"number_of_words\":\"2\",\"file_type\":\"10\",\"service\":\"1\",\"language\":\"8\",\"unit_price\":\"50\",\"unit\":\"1\",\"quotation_number\":\"2\",\"tax_rate\":\"12\",\"customer_submit_date\":\"2021-04-08 18:27:27\",\"customer_file_request\":\"2\",\"customer_file_reference\":\"2\",\"customer_file_remark\":\"2\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617877654');
INSERT INTO `ea_system_log_202104` VALUES ('918', '1', '/admin/customer.file/add', 'post', '', '{\"\\/admin\\/customer_file\\/add\":\"\",\"file_name\":\"文件名称1\",\"page\":\"6\",\"number_of_words\":\"2\",\"file_type\":\"10\",\"service\":\"1\",\"language\":\"8\",\"unit_price\":\"50\",\"unit\":\"1\",\"quotation_number\":\"2\",\"tax_rate\":\"12\",\"customer_submit_date\":\"2021-04-08 18:27:27\",\"customer_file_request\":\"2\",\"customer_file_reference\":\"2\",\"customer_file_remark\":\"2\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617877847');
INSERT INTO `ea_system_log_202104` VALUES ('919', '1', '/admin/customer.file/add', 'post', '', '{\"\\/admin\\/customer_file\\/add\":\"\",\"file_name\":\"文件名称1\",\"page\":\"6\",\"number_of_words\":\"2\",\"file_type\":\"10\",\"service\":\"1\",\"language\":\"8\",\"unit_price\":\"50\",\"unit\":\"1\",\"quotation_number\":\"2\",\"tax_rate\":\"12\",\"customer_submit_date\":\"2021-04-08 18:27:27\",\"customer_file_request\":\"2\",\"customer_file_reference\":\"2\",\"customer_file_remark\":\"2\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617877854');
INSERT INTO `ea_system_log_202104` VALUES ('920', '1', '/admin/customer.file/add', 'post', '', '{\"\\/admin\\/customer_file\\/add\":\"\",\"demand_id\":\"\",\"file_name\":\"文件名称1\",\"page\":\"6\",\"number_of_words\":\"2\",\"file_type\":\"10\",\"service\":\"1\",\"language\":\"8\",\"unit_price\":\"50\",\"unit\":\"1\",\"quotation_number\":\"2\",\"tax_rate\":\"12\",\"customer_submit_date\":\"2021-04-08 18:34:00\",\"customer_file_request\":\"3\",\"customer_file_reference\":\"3\",\"customer_file_remark\":\"3\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617878043');
INSERT INTO `ea_system_log_202104` VALUES ('921', '1', '/admin/customer.file/add', 'post', '', '{\"\\/admin\\/customer_file\\/add\":\"\",\"demand_id\":\"\",\"file_name\":\"文件名称1\",\"page\":\"6\",\"number_of_words\":\"2\",\"file_type\":\"10\",\"service\":\"1\",\"language\":\"8\",\"unit_price\":\"50\",\"unit\":\"1\",\"quotation_number\":\"2\",\"tax_rate\":\"12\",\"customer_submit_date\":\"2021-04-08 18:34:00\",\"customer_file_request\":\"3\",\"customer_file_reference\":\"3\",\"customer_file_remark\":\"3\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617878212');
INSERT INTO `ea_system_log_202104` VALUES ('922', '1', '/admin/customer.file/add', 'post', '', '{\"\\/admin\\/customer_file\\/add\":\"\",\"demand_id\":\"\",\"file_name\":\"文件名称2\",\"page\":\"6\",\"number_of_words\":\"3\",\"file_type\":\"10\",\"language\":\"8\",\"unit_price\":\"50\",\"unit\":\"2\",\"quotation_number\":\"111\",\"tax_rate\":\"12\",\"customer_submit_date\":\"2021-04-08 18:38:32\",\"customer_file_request\":\"1\",\"customer_file_reference\":\"1\",\"customer_file_remark\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617878314');
INSERT INTO `ea_system_log_202104` VALUES ('923', '1', '/admin/customer.file/add', 'post', '', '{\"\\/admin\\/customer_file\\/add\":\"\",\"demand_id\":\"\",\"file_name\":\"文件名称2\",\"page\":\"6\",\"number_of_words\":\"3\",\"file_type\":\"10\",\"service\":\"1\",\"language\":\"8\",\"unit_price\":\"50\",\"unit\":\"2\",\"quotation_number\":\"111\",\"tax_rate\":\"12\",\"customer_submit_date\":\"2021-04-08 18:38:32\",\"customer_file_request\":\"1\",\"customer_file_reference\":\"1\",\"customer_file_remark\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617878321');
INSERT INTO `ea_system_log_202104` VALUES ('924', '1', '/admin/customer.file/add', 'post', '', '{\"\\/admin\\/customer_file\\/add\":\"\",\"demand_id\":\"\",\"file_name\":\"文件名称3\",\"page\":\"6\",\"number_of_words\":\"1\",\"file_type\":\"10\",\"service\":\"1\",\"language\":\"8\",\"unit_price\":\"5\",\"unit\":\"2\",\"quotation_number\":\"2\",\"tax_rate\":\"12\",\"customer_submit_date\":\"2021-04-16 11:52:15\",\"customer_file_request\":\"1\",\"customer_file_reference\":\"1\",\"customer_file_remark\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617878392');
INSERT INTO `ea_system_log_202104` VALUES ('925', '1', '/admin/system.menu/modify', 'post', '', '{\"\\/admin\\/system_menu\\/modify\":\"\",\"id\":\"249\",\"field\":\"status\",\"value\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617878482');
INSERT INTO `ea_system_log_202104` VALUES ('926', '1', '/admin/system.menu/edit?id=249', 'post', '', '{\"\\/admin\\/system_menu\\/edit\":\"\",\"id\":\"249\",\"pid\":\"0\",\"title\":\"测试模块\",\"href\":\"\",\"icon\":\"fa fa-list\",\"target\":\"_self\",\"sort\":\"0\",\"remark\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617878504');
INSERT INTO `ea_system_log_202104` VALUES ('927', '1', '/admin/system.menu/edit?id=250', 'post', '', '{\"\\/admin\\/system_menu\\/edit\":\"\",\"id\":\"250\",\"pid\":\"249\",\"title\":\"测试分类\",\"href\":\"mall.cate\\/index\",\"icon\":\"fa fa-calendar-check-o\",\"target\":\"_self\",\"sort\":\"0\",\"remark\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617878526');
INSERT INTO `ea_system_log_202104` VALUES ('928', '1', '/admin/system.menu/edit?id=251', 'post', '', '{\"\\/admin\\/system_menu\\/edit\":\"\",\"id\":\"251\",\"pid\":\"249\",\"title\":\"测试属性\",\"href\":\"mall.goods\\/index\",\"icon\":\"fa fa-list\",\"target\":\"_self\",\"sort\":\"0\",\"remark\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617878541');
INSERT INTO `ea_system_log_202104` VALUES ('929', null, '/admin/login/index', 'post', '', '{\"username\":\"test\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '192.168.2.41', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617878737');
INSERT INTO `ea_system_log_202104` VALUES ('930', null, '/admin/login/index', 'post', '', '{\"username\":\"test1\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"keep_login\":\"0\"}', '192.168.2.41', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617878743');
INSERT INTO `ea_system_log_202104` VALUES ('931', null, '/admin/login/index', 'post', '', '{\"username\":\"admin\",\"password\":\"c706430c861b372f86085ec964e448d0df5ce3c0\",\"keep_login\":\"0\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617962326');
INSERT INTO `ea_system_log_202104` VALUES ('932', null, '/admin/login/index', 'post', '', '{\"username\":\"admin\",\"password\":\"3e128eeae279e37c50fcd0a1cf3a5e6ab00df413\",\"keep_login\":\"0\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617962332');
INSERT INTO `ea_system_log_202104` VALUES ('933', '1', '/admin/customer.file/edit?id=3', 'post', '', '{\"\\/admin\\/customer_file\\/edit\":\"\",\"id\":\"3\",\"demand_id\":\"3\",\"file_name\":\"文件名称3\",\"page\":\"6\",\"number_of_words\":\"1\",\"file_type\":\"10\",\"language\":\"8\",\"unit_price\":\"5.00\",\"unit\":\"2\",\"quotation_number\":\"2\",\"tax_rate\":\"12\",\"quotation_price\":\"30.00\",\"customer_submit_date\":\"2021-04-16 11:52:15\",\"customer_file_request\":\"                    1                \",\"customer_file_reference\":\"                    1                \",\"customer_file_remark\":\"                                    35\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617964798');
INSERT INTO `ea_system_log_202104` VALUES ('934', '1', '/admin/customer.file/edit?id=2', 'post', '', '{\"\\/admin\\/customer_file\\/edit\":\"\",\"id\":\"2\",\"demand_id\":\"2\",\"file_name\":\"文件名称2\",\"page\":\"6\",\"number_of_words\":\"3\",\"file_type\":\"10\",\"language\":\"8\",\"unit_price\":\"50.00\",\"unit\":\"2\",\"quotation_number\":\"111\",\"tax_rate\":\"12\",\"quotation_price\":\"6216.00\",\"customer_submit_date\":\"2021-04-08 18:38:32\",\"customer_file_request\":\"                    1                \",\"customer_file_reference\":\"                    1                \",\"customer_file_remark\":\"                                    \"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617964983');
INSERT INTO `ea_system_log_202104` VALUES ('935', '1', '/admin/customer.file/edit?id=1', 'post', '', '{\"\\/admin\\/customer_file\\/edit\":\"\",\"id\":\"1\",\"demand_id\":\"1\",\"file_name\":\"文件名称1\",\"page\":\"6\",\"number_of_words\":\"2\",\"file_type\":\"10\",\"language\":\"8\",\"unit_price\":\"50.00\",\"unit\":\"1\",\"quotation_number\":\"2\",\"tax_rate\":\"12\",\"quotation_price\":\"100.00\",\"customer_submit_date\":\"2021-04-08 18:34:00\",\"customer_file_request\":\"                    3                \",\"customer_file_reference\":\"                    3                \",\"customer_file_remark\":\"                    3                \"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617964994');
INSERT INTO `ea_system_log_202104` VALUES ('936', '1', '/admin/customer.file/edit?id=3', 'post', '', '{\"\\/admin\\/customer_file\\/edit\":\"\",\"id\":\"3\",\"demand_id\":\"3\",\"file_name\":\"文件名称3\",\"page\":\"6\",\"number_of_words\":\"1\",\"file_type\":\"10\",\"language\":\"8\",\"unit_price\":\"5.00\",\"unit\":\"2\",\"quotation_number\":\"2\",\"tax_rate\":\"12\",\"quotation_price\":\"30.00\",\"customer_submit_date\":\"2021-04-16 11:52:15\",\"customer_file_request\":\"                                        1                                \",\"customer_file_reference\":\"                                        1                                \",\"customer_file_remark\":\"                                                        35                \"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617965046');
INSERT INTO `ea_system_log_202104` VALUES ('937', '1', '/admin/customer.file/index?id=5', 'post', '', '{\"\\/admin\\/customer_file\\/index\":\"\",\"id\":\"5\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617966173');
INSERT INTO `ea_system_log_202104` VALUES ('938', '1', '/admin/customer.file/index?id=5', 'post', '', '{\"\\/admin\\/customer_file\\/index\":\"\",\"id\":\"5\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617966206');
INSERT INTO `ea_system_log_202104` VALUES ('939', '1', '/admin/customer.file/index?id=4', 'post', '', '{\"\\/admin\\/customer_file\\/index\":\"\",\"id\":\"4\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617966216');
INSERT INTO `ea_system_log_202104` VALUES ('940', '1', '/admin/customer.file/index?id=4', 'post', '', '{\"\\/admin\\/customer_file\\/index\":\"\",\"id\":\"4\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617966232');
INSERT INTO `ea_system_log_202104` VALUES ('941', '1', '/admin/customer.file/index?id=4', 'post', '', '{\"\\/admin\\/customer_file\\/index\":\"\",\"id\":\"4\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617966247');
INSERT INTO `ea_system_log_202104` VALUES ('942', '1', '/admin/customer.file/index?id=4', 'post', '', '{\"\\/admin\\/customer_file\\/index\":\"\",\"id\":\"4\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617966258');
INSERT INTO `ea_system_log_202104` VALUES ('943', '1', '/admin/customer.file/index?id=4', 'post', '', '{\"\\/admin\\/customer_file\\/index\":\"\",\"id\":\"4\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617966269');
INSERT INTO `ea_system_log_202104` VALUES ('944', '1', '/admin/customer.file/index?id=4', 'post', '', '{\"\\/admin\\/customer_file\\/index\":\"\",\"id\":\"4\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617966285');
INSERT INTO `ea_system_log_202104` VALUES ('945', '1', '/admin/customer.file/index?id=4', 'post', '', '{\"\\/admin\\/customer_file\\/index\":\"\",\"id\":\"4\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617966296');
INSERT INTO `ea_system_log_202104` VALUES ('946', '1', '/admin/customer.file/index?id=5', 'post', '', '{\"\\/admin\\/customer_file\\/index\":\"\",\"id\":\"5\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617966303');
INSERT INTO `ea_system_log_202104` VALUES ('947', '1', '/admin/customer.file/index?id=5', 'post', '', '{\"\\/admin\\/customer_file\\/index\":\"\",\"id\":\"5\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617966313');
INSERT INTO `ea_system_log_202104` VALUES ('948', '1', '/admin/customer.file/index?id=4', 'post', '', '{\"\\/admin\\/customer_file\\/index\":\"\",\"id\":\"4\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617966330');
INSERT INTO `ea_system_log_202104` VALUES ('949', '1', '/admin/customer.file/index?id=5', 'post', '', '{\"\\/admin\\/customer_file\\/index\":\"\",\"id\":\"5\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617966337');
INSERT INTO `ea_system_log_202104` VALUES ('950', '1', '/admin/customer.file/index?id=5', 'post', '', '{\"\\/admin\\/customer_file\\/index\":\"\",\"id\":\"5\"}', '192.168.2.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '1617966340');

-- ----------------------------
-- Table structure for ea_system_menu
-- ----------------------------
DROP TABLE IF EXISTS `ea_system_menu`;
CREATE TABLE `ea_system_menu` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '父id',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '名称',
  `icon` varchar(100) NOT NULL DEFAULT '' COMMENT '菜单图标',
  `href` varchar(100) NOT NULL DEFAULT '' COMMENT '链接',
  `params` varchar(500) DEFAULT '' COMMENT '链接参数',
  `target` varchar(20) NOT NULL DEFAULT '_self' COMMENT '链接打开方式',
  `sort` int(11) DEFAULT '0' COMMENT '菜单排序',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态(0:禁用,1:启用)',
  `remark` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `title` (`title`),
  KEY `href` (`href`)
) ENGINE=InnoDB AUTO_INCREMENT=263 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统菜单表';

-- ----------------------------
-- Records of ea_system_menu
-- ----------------------------
INSERT INTO `ea_system_menu` VALUES ('227', '99999999', '后台首页', 'fa fa-home', 'index/welcome', '', '_self', '0', '1', null, null, '1573120497', null);
INSERT INTO `ea_system_menu` VALUES ('228', '0', '系统管理', 'fa fa-cog', '', '', '_self', '0', '1', '', null, '1588999529', null);
INSERT INTO `ea_system_menu` VALUES ('234', '228', '菜单管理', 'fa fa-tree', 'system.menu/index', '', '_self', '10', '1', '', null, '1588228555', null);
INSERT INTO `ea_system_menu` VALUES ('244', '228', '管理员管理', 'fa fa-user', 'system.admin/index', '', '_self', '12', '1', '', '1573185011', '1588228573', null);
INSERT INTO `ea_system_menu` VALUES ('245', '228', '角色管理', 'fa fa-bitbucket-square', 'system.auth/index', '', '_self', '11', '1', '', '1573435877', '1588228634', null);
INSERT INTO `ea_system_menu` VALUES ('246', '228', '节点管理', 'fa fa-list', 'system.node/index', '', '_self', '9', '1', '', '1573435919', '1588228648', null);
INSERT INTO `ea_system_menu` VALUES ('247', '228', '配置管理', 'fa fa-asterisk', 'system.config/index', '', '_self', '8', '1', '', '1573457448', '1588228566', null);
INSERT INTO `ea_system_menu` VALUES ('248', '228', '上传管理', 'fa fa-arrow-up', 'system.uploadfile/index', '', '_self', '0', '1', '', '1573542953', '1588228043', null);
INSERT INTO `ea_system_menu` VALUES ('249', '0', '测试模块', 'fa fa-list', '', '', '_self', '0', '1', '', '1589439884', '1617878504', null);
INSERT INTO `ea_system_menu` VALUES ('250', '249', '测试分类', 'fa fa-calendar-check-o', 'mall.cate/index', '', '_self', '0', '1', '', '1589439910', '1617878526', null);
INSERT INTO `ea_system_menu` VALUES ('251', '249', '测试属性', 'fa fa-list', 'mall.goods/index', '', '_self', '0', '1', '', '1589439931', '1617878541', null);
INSERT INTO `ea_system_menu` VALUES ('252', '228', '快捷入口', 'fa fa-list', 'system.quick/index', '', '_self', '0', '1', '', '1589623683', '1589623683', null);
INSERT INTO `ea_system_menu` VALUES ('253', '228', '日志管理', 'fa fa-connectdevelop', 'system.log/index', '', '_self', '0', '1', '', '1589623684', '1589623684', null);
INSERT INTO `ea_system_menu` VALUES ('254', '0', '客户管理', 'fa fa-list', '', '', '_parent', '0', '1', '', '1617276791', '1617684742', null);
INSERT INTO `ea_system_menu` VALUES ('255', '254', '合同管理', 'fa fa-list', 'client.contract/index', '', '_self', '0', '1', '', '1617276893', '1617341982', '1617341982');
INSERT INTO `ea_system_menu` VALUES ('256', '228', '主体公司', 'fa fa-list', 'main.company/index', '', '_self', '0', '1', '主体公司信息', '1617332307', '1617332307', null);
INSERT INTO `ea_system_menu` VALUES ('257', '254', '客户信息', 'fa fa-list', 'customer.information/index', '', '_self', '2', '1', '客户信息', '1617334246', '1617684765', null);
INSERT INTO `ea_system_menu` VALUES ('258', '254', '合同管理', 'fa fa-list', 'customer.contract/index', '', '_self', '1', '1', '', '1617341849', '1617341849', null);
INSERT INTO `ea_system_menu` VALUES ('259', '228', '词库管理', 'fa fa-list', '', '', '_self', '0', '1', '词库管理菜单', '1617345748', '1617345865', null);
INSERT INTO `ea_system_menu` VALUES ('260', '259', '词库列表', 'fa fa-list', 'database.directory/index', '', '_self', '0', '1', '词库列表', '1617345775', '1617346596', null);
INSERT INTO `ea_system_menu` VALUES ('261', '259', '词库内容', 'fa fa-list', 'database.content/index', '', '_self', '0', '1', '', '1617345836', '1617345836', null);
INSERT INTO `ea_system_menu` VALUES ('262', '254', '来稿需求', 'fa fa-list', 'customer.demand/index', '', '_self', '0', '1', '来稿需求', '1617685609', '1617685638', null);

-- ----------------------------
-- Table structure for ea_system_node
-- ----------------------------
DROP TABLE IF EXISTS `ea_system_node`;
CREATE TABLE `ea_system_node` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `node` varchar(100) DEFAULT NULL COMMENT '节点代码',
  `title` varchar(500) DEFAULT NULL COMMENT '节点标题',
  `type` tinyint(1) DEFAULT '3' COMMENT '节点类型（1：控制器，2：节点）',
  `is_auth` tinyint(1) unsigned DEFAULT '1' COMMENT '是否启动RBAC权限控制',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `node` (`node`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统节点表';

-- ----------------------------
-- Records of ea_system_node
-- ----------------------------
INSERT INTO `ea_system_node` VALUES ('1', 'system.admin', '管理员管理', '1', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('2', 'system.admin/index', '列表', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('3', 'system.admin/add', '添加', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('4', 'system.admin/edit', '编辑', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('5', 'system.admin/password', '编辑', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('6', 'system.admin/delete', '删除', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('7', 'system.admin/modify', '属性修改', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('8', 'system.admin/export', '导出', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('9', 'system.auth', '角色权限管理', '1', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('10', 'system.auth/authorize', '授权', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('11', 'system.auth/saveAuthorize', '授权保存', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('12', 'system.auth/index', '列表', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('13', 'system.auth/add', '添加', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('14', 'system.auth/edit', '编辑', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('15', 'system.auth/delete', '删除', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('16', 'system.auth/export', '导出', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('17', 'system.auth/modify', '属性修改', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('18', 'system.config', '系统配置管理', '1', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('19', 'system.config/index', '列表', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('20', 'system.config/save', '保存', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('21', 'system.menu', '菜单管理', '1', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('22', 'system.menu/index', '列表', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('23', 'system.menu/add', '添加', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('24', 'system.menu/edit', '编辑', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('25', 'system.menu/delete', '删除', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('26', 'system.menu/modify', '属性修改', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('27', 'system.menu/getMenuTips', '添加菜单提示', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('28', 'system.menu/export', '导出', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('29', 'system.node', '系统节点管理', '1', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('30', 'system.node/index', '列表', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('31', 'system.node/refreshNode', '系统节点更新', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('32', 'system.node/clearNode', '清除失效节点', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('33', 'system.node/add', '添加', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('34', 'system.node/edit', '编辑', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('35', 'system.node/delete', '删除', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('36', 'system.node/export', '导出', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('37', 'system.node/modify', '属性修改', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('38', 'system.uploadfile', '上传文件管理', '1', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('39', 'system.uploadfile/index', '列表', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('40', 'system.uploadfile/add', '添加', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('41', 'system.uploadfile/edit', '编辑', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('42', 'system.uploadfile/delete', '删除', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('43', 'system.uploadfile/export', '导出', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('44', 'system.uploadfile/modify', '属性修改', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('45', 'mall.cate', '商品分类管理', '1', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('46', 'mall.cate/index', '列表', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('47', 'mall.cate/add', '添加', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('48', 'mall.cate/edit', '编辑', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('49', 'mall.cate/delete', '删除', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('50', 'mall.cate/export', '导出', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('51', 'mall.cate/modify', '属性修改', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('52', 'mall.goods', '商城商品管理', '1', '1', '1589580432', '1617274894');
INSERT INTO `ea_system_node` VALUES ('53', 'mall.goods/index', '列表', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('54', 'mall.goods/stock', '入库', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('55', 'mall.goods/add', '添加', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('56', 'mall.goods/edit', '编辑', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('57', 'mall.goods/delete', '删除', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('58', 'mall.goods/export', '导出', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('59', 'mall.goods/modify', '属性修改', '2', '1', '1589580432', '1589580432');
INSERT INTO `ea_system_node` VALUES ('60', 'system.quick', '快捷入口管理', '1', '1', '1589623188', '1589623188');
INSERT INTO `ea_system_node` VALUES ('61', 'system.quick/index', '列表', '2', '1', '1589623188', '1589623188');
INSERT INTO `ea_system_node` VALUES ('62', 'system.quick/add', '添加', '2', '1', '1589623188', '1589623188');
INSERT INTO `ea_system_node` VALUES ('63', 'system.quick/edit', '编辑', '2', '1', '1589623188', '1589623188');
INSERT INTO `ea_system_node` VALUES ('64', 'system.quick/delete', '删除', '2', '1', '1589623188', '1589623188');
INSERT INTO `ea_system_node` VALUES ('65', 'system.quick/export', '导出', '2', '1', '1589623188', '1589623188');
INSERT INTO `ea_system_node` VALUES ('66', 'system.quick/modify', '属性修改', '2', '1', '1589623188', '1589623188');
INSERT INTO `ea_system_node` VALUES ('67', 'system.log', '操作日志管理', '1', '1', '1589623188', '1589623188');
INSERT INTO `ea_system_node` VALUES ('68', 'system.log/index', '列表', '2', '1', '1589623188', '1589623188');
INSERT INTO `ea_system_node` VALUES ('76', 'main.company', '主体公司', '1', '1', '1617332182', '1617341766');
INSERT INTO `ea_system_node` VALUES ('77', 'main.company/index', '列表', '2', '1', '1617332182', '1617332182');
INSERT INTO `ea_system_node` VALUES ('78', 'main.company/add', '添加', '2', '1', '1617332182', '1617332182');
INSERT INTO `ea_system_node` VALUES ('79', 'main.company/edit', '编辑', '2', '1', '1617332182', '1617332182');
INSERT INTO `ea_system_node` VALUES ('80', 'main.company/delete', '删除', '2', '1', '1617332182', '1617332182');
INSERT INTO `ea_system_node` VALUES ('81', 'main.company/export', '导出', '2', '1', '1617332182', '1617332182');
INSERT INTO `ea_system_node` VALUES ('82', 'main.company/modify', '属性修改', '2', '1', '1617332182', '1617332182');
INSERT INTO `ea_system_node` VALUES ('83', 'customer.information', '客户信息', '1', '1', '1617334155', '1617341786');
INSERT INTO `ea_system_node` VALUES ('84', 'customer.information/index', '列表', '2', '1', '1617334155', '1617334155');
INSERT INTO `ea_system_node` VALUES ('85', 'customer.information/add', '添加', '2', '1', '1617334155', '1617334155');
INSERT INTO `ea_system_node` VALUES ('86', 'customer.information/edit', '编辑', '2', '1', '1617334155', '1617334155');
INSERT INTO `ea_system_node` VALUES ('87', 'customer.information/delete', '删除', '2', '1', '1617334155', '1617334155');
INSERT INTO `ea_system_node` VALUES ('88', 'customer.information/export', '导出', '2', '1', '1617334155', '1617334155');
INSERT INTO `ea_system_node` VALUES ('89', 'customer.information/modify', '属性修改', '2', '1', '1617334155', '1617334155');
INSERT INTO `ea_system_node` VALUES ('90', 'customer.contract', '客户合同', '1', '1', '1617341723', '1617341797');
INSERT INTO `ea_system_node` VALUES ('91', 'customer.contract/index', '列表', '2', '1', '1617341723', '1617341723');
INSERT INTO `ea_system_node` VALUES ('92', 'customer.contract/add', '添加', '2', '1', '1617341723', '1617341723');
INSERT INTO `ea_system_node` VALUES ('93', 'customer.contract/edit', '编辑', '2', '1', '1617341723', '1617341723');
INSERT INTO `ea_system_node` VALUES ('94', 'customer.contract/delete', '删除', '2', '1', '1617341723', '1617341723');
INSERT INTO `ea_system_node` VALUES ('95', 'customer.contract/export', '导出', '2', '1', '1617341723', '1617341723');
INSERT INTO `ea_system_node` VALUES ('96', 'customer.contract/modify', '属性修改', '2', '1', '1617341723', '1617341723');
INSERT INTO `ea_system_node` VALUES ('97', 'database.content', '词库内容', '1', '1', '1617345687', '1617345701');
INSERT INTO `ea_system_node` VALUES ('98', 'database.content/index', '列表', '2', '1', '1617345687', '1617345687');
INSERT INTO `ea_system_node` VALUES ('99', 'database.content/add', '添加', '2', '1', '1617345687', '1617345687');
INSERT INTO `ea_system_node` VALUES ('100', 'database.content/edit', '编辑', '2', '1', '1617345687', '1617345687');
INSERT INTO `ea_system_node` VALUES ('101', 'database.content/delete', '删除', '2', '1', '1617345687', '1617345687');
INSERT INTO `ea_system_node` VALUES ('102', 'database.content/export', '导出', '2', '1', '1617345687', '1617345687');
INSERT INTO `ea_system_node` VALUES ('103', 'database.content/modify', '属性修改', '2', '1', '1617345687', '1617345687');
INSERT INTO `ea_system_node` VALUES ('111', 'database.directory', '词库目录', '1', '1', '1617346557', '1617346574');
INSERT INTO `ea_system_node` VALUES ('112', 'database.directory/index', '列表', '2', '1', '1617346557', '1617346557');
INSERT INTO `ea_system_node` VALUES ('113', 'database.directory/add', '添加', '2', '1', '1617346557', '1617346557');
INSERT INTO `ea_system_node` VALUES ('114', 'database.directory/edit', '编辑', '2', '1', '1617346557', '1617346557');
INSERT INTO `ea_system_node` VALUES ('115', 'database.directory/delete', '删除', '2', '1', '1617346557', '1617346557');
INSERT INTO `ea_system_node` VALUES ('116', 'database.directory/export', '导出', '2', '1', '1617346557', '1617346557');
INSERT INTO `ea_system_node` VALUES ('117', 'database.directory/modify', '属性修改', '2', '1', '1617346557', '1617346557');
INSERT INTO `ea_system_node` VALUES ('118', 'customer.demand', '来稿需求', '1', '1', '1617685556', '1617685569');
INSERT INTO `ea_system_node` VALUES ('119', 'customer.demand/index', '列表', '2', '1', '1617685556', '1617685556');
INSERT INTO `ea_system_node` VALUES ('120', 'customer.demand/add', '添加', '2', '1', '1617685556', '1617685556');
INSERT INTO `ea_system_node` VALUES ('121', 'customer.demand/edit', '编辑', '2', '1', '1617685556', '1617685556');
INSERT INTO `ea_system_node` VALUES ('122', 'customer.demand/delete', '删除', '2', '1', '1617685556', '1617685556');
INSERT INTO `ea_system_node` VALUES ('123', 'customer.demand/export', '导出', '2', '1', '1617685556', '1617685556');
INSERT INTO `ea_system_node` VALUES ('124', 'customer.demand/modify', '属性修改', '2', '1', '1617685556', '1617685556');
INSERT INTO `ea_system_node` VALUES ('125', 'customer.file', '文件信息', '1', '1', '1617765323', '1617765335');
INSERT INTO `ea_system_node` VALUES ('126', 'customer.file/index', '列表', '2', '1', '1617765323', '1617765323');
INSERT INTO `ea_system_node` VALUES ('127', 'customer.file/add', '添加', '2', '1', '1617765323', '1617765323');
INSERT INTO `ea_system_node` VALUES ('128', 'customer.file/edit', '编辑', '2', '1', '1617765323', '1617765323');
INSERT INTO `ea_system_node` VALUES ('129', 'customer.file/delete', '删除', '2', '1', '1617765323', '1617765323');
INSERT INTO `ea_system_node` VALUES ('130', 'customer.file/export', '导出', '2', '1', '1617765323', '1617765323');
INSERT INTO `ea_system_node` VALUES ('131', 'customer.file/modify', '属性修改', '2', '1', '1617765323', '1617765323');

-- ----------------------------
-- Table structure for ea_system_quick
-- ----------------------------
DROP TABLE IF EXISTS `ea_system_quick`;
CREATE TABLE `ea_system_quick` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL COMMENT '快捷入口名称',
  `icon` varchar(100) DEFAULT NULL COMMENT '图标',
  `href` varchar(255) DEFAULT NULL COMMENT '快捷链接',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态(1:禁用,2:启用)',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注说明',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统快捷入口表';

-- ----------------------------
-- Records of ea_system_quick
-- ----------------------------
INSERT INTO `ea_system_quick` VALUES ('1', '管理员管理', 'fa fa-user', 'system.admin/index', '0', '1', '', '1589624097', '1589624792', null);
INSERT INTO `ea_system_quick` VALUES ('2', '角色管理', 'fa fa-bitbucket-square', 'system.auth/index', '0', '1', '', '1589624772', '1589624781', null);
INSERT INTO `ea_system_quick` VALUES ('3', '菜单管理', 'fa fa-tree', 'system.menu/index', '0', '1', null, '1589624097', '1589624792', null);
INSERT INTO `ea_system_quick` VALUES ('6', '节点管理', 'fa fa-list', 'system.node/index', '0', '1', null, '1589624772', '1589624781', null);
INSERT INTO `ea_system_quick` VALUES ('7', '配置管理', 'fa fa-asterisk', 'system.config/index', '0', '1', null, '1589624097', '1589624792', null);
INSERT INTO `ea_system_quick` VALUES ('8', '上传管理', 'fa fa-arrow-up', 'system.uploadfile/index', '0', '1', null, '1589624772', '1589624781', null);
INSERT INTO `ea_system_quick` VALUES ('10', '商品分类', 'fa fa-calendar-check-o', 'mall.cate/index', '0', '1', null, '1589624097', '1589624792', null);
INSERT INTO `ea_system_quick` VALUES ('11', '商品管理', 'fa fa-list', 'mall.goods/index', '0', '0', null, '1589624772', '1617280627', null);

-- ----------------------------
-- Table structure for ea_system_uploadfile
-- ----------------------------
DROP TABLE IF EXISTS `ea_system_uploadfile`;
CREATE TABLE `ea_system_uploadfile` (
  `id` int(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `upload_type` varchar(20) NOT NULL DEFAULT 'local' COMMENT '存储位置',
  `original_name` varchar(255) DEFAULT NULL COMMENT '文件原名',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '物理路径',
  `image_width` varchar(30) NOT NULL DEFAULT '' COMMENT '宽度',
  `image_height` varchar(30) NOT NULL DEFAULT '' COMMENT '高度',
  `image_type` varchar(30) NOT NULL DEFAULT '' COMMENT '图片类型',
  `image_frames` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图片帧数',
  `mime_type` varchar(100) NOT NULL DEFAULT '' COMMENT 'mime类型',
  `file_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `file_ext` varchar(100) DEFAULT NULL,
  `sha1` varchar(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `create_time` int(10) DEFAULT NULL COMMENT '创建日期',
  `update_time` int(10) DEFAULT NULL COMMENT '更新时间',
  `upload_time` int(10) DEFAULT NULL COMMENT '上传时间',
  PRIMARY KEY (`id`),
  KEY `upload_type` (`upload_type`),
  KEY `original_name` (`original_name`)
) ENGINE=InnoDB AUTO_INCREMENT=317 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='上传文件表';

-- ----------------------------
-- Records of ea_system_uploadfile
-- ----------------------------
INSERT INTO `ea_system_uploadfile` VALUES ('286', 'alioss', 'image/jpeg', 'https://lxn-99php.oss-cn-shenzhen.aliyuncs.com/upload/20191111/0a6de1ac058ee134301501899b84ecb1.jpg', '', '', '', '0', 'image/jpeg', '0', 'jpg', '', null, null, null);
INSERT INTO `ea_system_uploadfile` VALUES ('287', 'alioss', 'image/jpeg', 'https://lxn-99php.oss-cn-shenzhen.aliyuncs.com/upload/20191111/46d7384f04a3bed331715e86a4095d15.jpg', '', '', '', '0', 'image/jpeg', '0', 'jpg', '', null, null, null);
INSERT INTO `ea_system_uploadfile` VALUES ('288', 'alioss', 'image/x-icon', 'https://lxn-99php.oss-cn-shenzhen.aliyuncs.com/upload/20191111/7d32671f4c1d1b01b0b28f45205763f9.ico', '', '', '', '0', 'image/x-icon', '0', 'ico', '', null, null, null);
INSERT INTO `ea_system_uploadfile` VALUES ('289', 'alioss', 'image/jpeg', 'https://lxn-99php.oss-cn-shenzhen.aliyuncs.com/upload/20191111/28cefa547f573a951bcdbbeb1396b06f.jpg', '', '', '', '0', 'image/jpeg', '0', 'jpg', '', null, null, null);
INSERT INTO `ea_system_uploadfile` VALUES ('290', 'alioss', 'image/jpeg', 'https://lxn-99php.oss-cn-shenzhen.aliyuncs.com/upload/20191111/2c412adf1b30c8be3a913e603c7b6e4a.jpg', '', '', '', '0', 'image/jpeg', '0', 'jpg', '', null, null, null);
INSERT INTO `ea_system_uploadfile` VALUES ('291', 'alioss', 'timg (1).jpg', 'http://easyadmin.oss-cn-shenzhen.aliyuncs.com/upload/20191113/ff793ced447febfa9ea2d86f9f88fa8e.jpg', '', '', '', '0', 'image/jpeg', '0', 'jpg', '', '1573612437', null, null);
INSERT INTO `ea_system_uploadfile` VALUES ('296', 'txcos', '22243.jpg', 'https://easyadmin-1251997243.cos.ap-guangzhou.myqcloud.com/upload/20191114/2381eaf81208ac188fa994b6f2579953.jpg', '', '', '', '0', 'image/jpeg', '0', 'jpg', '', '1573712153', null, null);
INSERT INTO `ea_system_uploadfile` VALUES ('297', 'local', 'timg.jpg', 'http://admin.host/upload/20200423/5055a273cf8e3f393d699d622b74f247.jpg', '', '', '', '0', 'image/jpeg', '0', 'jpg', '', '1587614155', null, null);
INSERT INTO `ea_system_uploadfile` VALUES ('298', 'local', 'timg.jpg', 'http://admin.host/upload/20200423/243f4e59f1b929951ef79c5f8be7468a.jpg', '', '', '', '0', 'image/jpeg', '0', 'jpg', '', '1587614269', null, null);
INSERT INTO `ea_system_uploadfile` VALUES ('299', 'local', 'head.jpg', 'http://admin.host/upload/20200512/a5ce9883379727324f5686ef61205ce2.jpg', '', '', '', '0', 'image/jpeg', '0', 'jpg', '', '1589255649', null, null);
INSERT INTO `ea_system_uploadfile` VALUES ('300', 'local', '896e5b87c9ca70e4.jpg', 'http://admin.host/upload/20200514/577c65f101639f53dbbc9e7aa346f81c.jpg', '', '', '', '0', 'image/jpeg', '0', 'jpg', '', '1589427798', null, null);
INSERT INTO `ea_system_uploadfile` VALUES ('301', 'local', '896e5b87c9ca70e4.jpg', 'http://admin.host/upload/20200514/98fc09b0c4ad4d793a6f04bef79a0edc.jpg', '', '', '', '0', 'image/jpeg', '0', 'jpg', '', '1589427840', null, null);
INSERT INTO `ea_system_uploadfile` VALUES ('302', 'local', '18811e7611c8f292.jpg', 'http://admin.host/upload/20200514/e1c6c9ef6a4b98b8f7d95a1a0191a2df.jpg', '', '', '', '0', 'image/jpeg', '0', 'jpg', '', '1589438645', null, null);
INSERT INTO `ea_system_uploadfile` VALUES ('316', 'local', 'QQ图片20210329173056.png', 'http://easyadmin.test/upload/20210401/0afd939a10d07cdb0a2f0e798768768e.png', '', '', '', '0', 'image/png', '0', 'png', '', '1617277499', null, null);
