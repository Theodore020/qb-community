/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50540
 Source Host           : 127.0.0.1:3306
 Source Schema         : qsbk

 Target Server Type    : MySQL
 Target Server Version : 50540
 File Encoding         : 65001

 Date: 15/11/2023 20:38:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for category_info
-- ----------------------------
DROP TABLE IF EXISTS `category_info`;
CREATE TABLE `category_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_at` datetime NOT NULL,
  `update_at` datetime NULL DEFAULT NULL,
  `is_del` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of category_info
-- ----------------------------
INSERT INTO `category_info` VALUES (1, '搞笑', '2023-11-09 11:51:04', '2023-11-09 11:51:18', 0);
INSERT INTO `category_info` VALUES (2, '时尚美妆', '2023-11-09 11:51:27', '2023-11-09 14:02:26', 0);
INSERT INTO `category_info` VALUES (3, '购物', '2023-11-09 11:51:32', '2023-11-09 11:52:35', 0);
INSERT INTO `category_info` VALUES (4, '旅游', '2023-11-09 11:51:39', NULL, 0);
INSERT INTO `category_info` VALUES (5, '美食', '2023-11-09 11:51:44', NULL, 0);
INSERT INTO `category_info` VALUES (6, '闲鱼', '2023-11-09 11:52:30', NULL, 0);
INSERT INTO `category_info` VALUES (7, '闲言碎语', '2023-11-09 14:01:03', NULL, 0);

-- ----------------------------
-- Table structure for comment_info
-- ----------------------------
DROP TABLE IF EXISTS `comment_info`;
CREATE TABLE `comment_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `is_show` tinyint(1) NOT NULL DEFAULT 1,
  `create_at` datetime NOT NULL,
  `update_at` datetime NULL DEFAULT NULL,
  `is_del` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `post_id`(`post_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `comment_info_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `comment_info_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of comment_info
-- ----------------------------

-- ----------------------------
-- Table structure for permission_info
-- ----------------------------
DROP TABLE IF EXISTS `permission_info`;
CREATE TABLE `permission_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permission_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '权限名称',
  `permission_type` int(11) NOT NULL COMMENT '0代表目录，1代表页面，2代表按钮',
  `permission_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '权限标识',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
  `route_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由路径',
  `component_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `parent_id` int(11) NOT NULL COMMENT '父级路径',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  `marks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限备注',
  `create_at` datetime NOT NULL,
  `update_at` datetime NULL DEFAULT NULL,
  `is_del` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of permission_info
-- ----------------------------
INSERT INTO `permission_info` VALUES (1, '用户与角色', 0, 'userInfo', 'avatar', '', '', 0, 0, '用户与角色的菜单目录', '2023-11-12 09:45:24', NULL, 0);
INSERT INTO `permission_info` VALUES (2, '用户列表', 1, 'userInfo:getListByPage', '', '/manager/userInfoList', '/views/userInfo/UserInfoList', 1, 0, '用户列表的界面', '2023-11-12 09:47:26', NULL, 0);
INSERT INTO `permission_info` VALUES (3, '角色列表', 1, 'roleInfo:getListByPage', '', '/manager/roleInfoList', '/views/roleInfo/RoleInfoList', 1, 0, '角色列表的页面', '2023-11-12 09:48:19', NULL, 0);
INSERT INTO `permission_info` VALUES (4, '帖子信息', 0, 'postInfo', 'tools', '', '', 0, 0, '帖子信息的菜单目录', '2023-11-12 09:49:16', NULL, 0);
INSERT INTO `permission_info` VALUES (5, '帖子分类', 1, 'categoryInfo:getListByPage', '', '/manager/categoryInfoList', '/views/categoryInfo/CategoryInfoList', 4, 0, '帖子分类的页面', '2023-11-12 11:10:31', '2023-11-12 14:25:43', 0);
INSERT INTO `permission_info` VALUES (6, '新增用户', 2, 'userInfo:add', '', '', '', 2, 0, '新增用户按钮', '2023-11-12 11:16:26', NULL, 0);
INSERT INTO `permission_info` VALUES (7, '编辑用户', 2, 'userInfo:update', '', '', '', 2, 0, '编辑用户按钮', '2023-11-12 11:16:56', NULL, 0);
INSERT INTO `permission_info` VALUES (8, '删除用户', 2, 'userInfo:deleteById', '', '', '', 2, 0, '删除用户按钮', '2023-11-12 11:17:20', NULL, 0);
INSERT INTO `permission_info` VALUES (9, '分配权限', 2, 'userRoleInfo:saveRoleData', '', '', '', 2, 0, '分配权限的按钮', '2023-11-12 11:18:35', '2023-11-12 11:28:31', 0);
INSERT INTO `permission_info` VALUES (10, '新增角色', 2, 'roleInfo:add', '', '', '', 3, 0, '新增角色按钮', '2023-11-12 11:19:13', NULL, 0);
INSERT INTO `permission_info` VALUES (11, '编辑角色', 2, 'roleInfo:update', '', '', '', 3, 0, '编辑角色按钮', '2023-11-12 11:19:32', NULL, 0);
INSERT INTO `permission_info` VALUES (12, '删除角色', 2, 'roleInfo:deleteById', '', '', '', 3, 0, '删除角色按钮', '2023-11-12 11:20:03', NULL, 0);
INSERT INTO `permission_info` VALUES (13, '权限列表', 1, 'permissionInfo:getPermissionTreeData', '', '/manager/permissionInfoList', '/views/permissionInfo/PermissionInfoList', 1, 0, '权限列表的页面', '2023-11-12 14:18:17', NULL, 0);
INSERT INTO `permission_info` VALUES (14, '编辑权限', 2, 'permissionInfo:update', '', '', '', 13, 0, '编辑权限的按钮', '2023-11-12 14:18:59', NULL, 0);
INSERT INTO `permission_info` VALUES (15, '删除权限', 2, 'permissionInfo:deleteById', '', '', '', 13, 0, '删除权限的按钮', '2023-11-12 14:19:35', NULL, 0);
INSERT INTO `permission_info` VALUES (16, '新增权限', 2, 'permissionInfo:add', '', '', '', 13, 0, '新增权限按钮', '2023-11-12 14:19:59', NULL, 0);
INSERT INTO `permission_info` VALUES (17, '评论信息', 0, 'commentInfo', 'ChatLineRound', '', '', 0, 0, '评论信息的页面', '2023-11-12 14:21:55', NULL, 0);
INSERT INTO `permission_info` VALUES (18, '删除帖子分类', 2, 'categoryInfo:deleteById', '', '', '', 5, 0, '删除帖子分类的按钮', '2023-11-12 14:27:16', NULL, 0);
INSERT INTO `permission_info` VALUES (19, '编辑帖子分类', 2, 'categoryInfo:update', '', '', '', 5, 0, '编辑帖子分类的按钮', '2023-11-12 14:27:57', NULL, 0);
INSERT INTO `permission_info` VALUES (20, '新增帖子分类', 2, 'categoryInfo:add', '', '', '', 5, 0, '新增帖子分类的权限', '2023-11-12 14:28:24', NULL, 0);
INSERT INTO `permission_info` VALUES (22, '帖子列表', 1, 'postInfo:getListByPage', '', '/manager/postInfoList', '/views/postInfo/PostInfoList', 4, 0, '帖子列表页面', '2023-11-13 13:41:58', NULL, 0);
INSERT INTO `permission_info` VALUES (23, '删除帖子', 2, 'postInfo:deleteById', '', '', '', 22, 0, '删除帖子按钮', '2023-11-13 14:08:27', NULL, 0);
INSERT INTO `permission_info` VALUES (24, '角色授权', 2, 'rolePermissionInfo:savePermission', '', '', '', 3, 0, '角色授权的按钮', '2023-11-13 14:33:17', NULL, 0);

-- ----------------------------
-- Table structure for post_img_info
-- ----------------------------
DROP TABLE IF EXISTS `post_img_info`;
CREATE TABLE `post_img_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL,
  `img_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_at` datetime NOT NULL,
  `update_at` datetime NULL DEFAULT NULL,
  `is_del` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `post_id`(`post_id`) USING BTREE,
  CONSTRAINT `post_img_info_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of post_img_info
-- ----------------------------

-- ----------------------------
-- Table structure for post_info
-- ----------------------------
DROP TABLE IF EXISTS `post_info`;
CREATE TABLE `post_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `post_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `category_id` int(11) NOT NULL,
  `like` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `hate` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `create_at` datetime NOT NULL,
  `update_at` datetime NULL DEFAULT NULL,
  `is_del` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `category_id`(`category_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `post_info_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `post_info_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 70 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of post_info
-- ----------------------------
INSERT INTO `post_info` VALUES (1, 77, '时间啊，总是过得这么快', 5, '1,2,3', NULL, '2023-07-01 16:51:25', NULL, 0);
INSERT INTO `post_info` VALUES (2, 33, '床前明月光，李白睡得香', 3, '1,2', NULL, '2023-07-01 16:51:25', NULL, 0);
INSERT INTO `post_info` VALUES (3, 6, '今天照了很久的镜子，一晃眼已经30多岁了，我的青春彻底结束了。我们都低估了时间的善变，才轻易让浓烈的东西翻了篇。\r\n生活的琐碎，吐出来矫情，吞下去呛啜子。百般滋味涌上心并没有。话到嘴边却不值一提。\r\n有时候，词穷不是沉默，而是一言难尽，这烟火人间，这事事值得，事事也遗憾，还用多懂事的理智去压抑心中的不甘与难过…', 5, '2,3', NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (4, 10, '今天照了很久的镜子，一晃眼已经30多岁了，我的青春彻底结束了。我们都低估了时间的善变，才轻易让浓烈的东西翻了篇。\r\n生活的琐碎，吐出来矫情，吞下去呛啜子。百般滋味涌上心并没有。话到嘴边却不值一提。\r\n有时候，词穷不是沉默，而是一言难尽，这烟火人间，这事事值得，事事也遗憾，还用多懂事的理智去压抑心中的不甘与难过…', 3, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (5, 17, '有的爱情可以是轰轰烈烈，也可以是平平淡淡，可以是鸿雁传书，尽诉相思之苦，也可以是举案齐眉，享受生活的点点滴滴，可以是夫妻夜市享受都市的人间烟火，也可以是背母私奔，远离尘世的流言侵扰；可以是人生若只如初见，何事秋风悲画扇；可以是衣带渐宽终不悔，为依消得人憔悴；可以是曾经沧海难为水，除去巫山不是云。古人总结得很好，两情若是久长时，又岂在朝朝暮暮。', 6, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (6, 63, '听说你顺产了小子，不顺产难道还是逆子吗', 2, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (7, 72, '有的人活了一辈子，却没有真正活过完整的一天！因为他们不是追忆过去，就是期许未来，从来没有活在当下。', 1, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (8, 1, '一个有灵魂的女人，才是一个有魅力的女人。一个有信仰的女人，才是一个有能量的女人。可以暂时茫然，但不自怨自艾，可以一时感慨，但不一直沉迷。若是美好，叫做精彩。若是糟糕，叫做经历。', 4, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (9, 84, '迷茫总是一时的，选择的道路一直走下去，才是一世的。', 3, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (10, 40, '有钱的捧个钱场，没钱的回家取点钱来捧个钱场。', 4, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (11, 57, '酸甜苦辣是生命的富有，赤橙黄绿是人生的斑斓', 5, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (12, 56, '我们这一生，会遇到很多人，缘分皆朝生暮死脆弱如露水。唯独与你，像是一条生生不息的河流。', 4, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (13, 54, '当男人遇见女人，从此只有纪念日，没有独立日。', 6, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (14, 86, '左手拿着书，右手拿着打火机，哪里不会点哪里。', 1, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (15, 94, '在你发怒的时候，要紧闭你的嘴，免得增加你的怒气。', 3, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (16, 36, '内心再强大一点，就不会听风是雨。知道的事再多一点，就不会人云亦云。', 5, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (17, 77, '有时候命运是嘲弄人的，让你遇到，但却晚了;让你看到，却不能相依;让我们有了情，却只能分开!曾经把爱深深埋在了心底，以为这样才是最安全的，却不知如此的距离也将自己伤的最深。我试着恨你，却想起你的笑容。', 5, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (18, 15, '把自己当傻瓜，不懂就问，你会学的更多。', 6, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (19, 28, '书画琴棋诗酒花，当年件件不离他；而今七事都更变，柴米油盐酱醋茶。载酒买花年少事，浑不似旧心情。当所有的梦想被现实磨洗的一干二净，当平庸的日子被繁琐填充，我再也没有了年轻时浪漫激越的心情。', 2, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (20, 19, '做有用的事，说正能量的话，想美好的事，睡安稳的觉。把时间发生在进步上，而不是抱怨上。', 1, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (21, 55, '生活就像是跟老天对弈，对你而言，你走棋，那叫选择；老天走棋，那叫挑战。', 1, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (22, 91, '真坏人并不可怕，可怕的是假好人。', 1, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (23, 48, '下辈子我要做你嘴里面的牙，因为我痛你也会痛。', 2, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (24, 78, '生命太短，没留时间给遗憾。若不是终点，请微笑一直向前。', 1, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (25, 75, '如果你是对的，你没必要发脾气；如果你是错的，你没资格去发脾气。这才是真正的智慧。', 5, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (26, 38, '每天晚上盖被子，都感觉像是入土为安', 6, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (27, 49, '你的世界会有光，那是因为我记忆里的太阳庇护着你', 5, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (28, 9, '剑未佩妥，出门已是江湖；酒尚余温，入口不识乾坤。远离尽千帆，归来仍是少年', 6, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (29, 71, '讨厌我。没关系我不介意。我活着不是为了取悦你。', 4, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (30, 17, '记住了：刻薄嘴欠和幽默是两回事，口无遮拦和坦率是两回事，没有教养和随性是两回事，轻重不分和耿直是两回事。', 2, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (31, 57, '人生就像一杯茶，不会苦一辈子，但总会苦一阵子!', 6, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (32, 46, '生气，就是拿别人的过错来惩罚自己。原谅别人，就是善待自己。', 5, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (33, 4, '忙碌是一种幸福，让我们没时间体会痛苦；奔波是一种快乐，让我们真实地感受生活；疲惫是一种享受，让我们无暇空虚。', 3, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (34, 42, '有时侯，觉得自己其实一无所有，仿佛被世界抛弃;有时候，明明自己身边很多朋友，却依然觉得孤单;有时候，走过熟悉的街角，看到熟悉的背影，突然就想起一个人的脸;有时候，突然想哭，却难过的哭不出来;有时候，夜深人静的时候，突然觉得寂寞深入骨髓;有时候，突然找不到自己，把自己丢了。', 1, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (35, 78, '别把自己想的太伟大，要知道，在别人的世界里，不管你做的多好，你都只是个配角而已', 3, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (36, 12, '生活于我们，是一道绚丽的风景，而经历，恰似一把锁，锁着风轻云淡，锁着或悲或喜，锁着无奈和忧郁……', 1, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (37, 64, '天塌下来你先顶着，我去找根棍子', 4, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (38, 92, '即使你已经名花有主，我也要移花接木', 4, NULL, NULL, '2023-07-04 08:44:51', NULL, 0);
INSERT INTO `post_info` VALUES (39, 31, '闹一闹，笑一笑，生活不枯燥', 6, NULL, NULL, '2023-07-05 10:00:30', NULL, 0);
INSERT INTO `post_info` VALUES (40, 87, '好话多说，是非不谈', 3, NULL, NULL, '2023-07-07 15:37:25', NULL, 0);
INSERT INTO `post_info` VALUES (41, 27, '山有木兮木有枝，心悦君兮君不知', 5, NULL, NULL, '2023-07-07 15:41:15', NULL, 0);
INSERT INTO `post_info` VALUES (42, 70, '一朝春去红颜老，花落人亡两不知', 5, NULL, NULL, '2023-07-07 15:41:44', NULL, 0);
INSERT INTO `post_info` VALUES (43, 41, '天不老，情难绝。心似双丝网，中有千千结。', 1, NULL, NULL, '2023-07-07 15:42:27', NULL, 0);
INSERT INTO `post_info` VALUES (44, 10, '如花美景，似水流年，回得了过去，却回不了重前。', 5, NULL, NULL, '2023-07-07 15:43:06', NULL, 0);
INSERT INTO `post_info` VALUES (45, 37, '暮晓春来迟，先于百花知，岁岁种桃树，开在断肠时！', 3, NULL, NULL, '2023-07-07 15:44:27', NULL, 0);
INSERT INTO `post_info` VALUES (46, 18, '愿有岁月可回首，且以深情共白头。', 2, NULL, NULL, '2023-07-07 15:45:20', NULL, 0);
INSERT INTO `post_info` VALUES (47, 20, '我见青山多妩媚，料青山见我应如是。', 1, NULL, NULL, '2023-07-07 15:45:39', NULL, 0);
INSERT INTO `post_info` VALUES (48, 90, '两处相思同淋雪，此生也算共白头！', 6, NULL, NULL, '2023-07-07 15:45:58', NULL, 0);
INSERT INTO `post_info` VALUES (49, 67, '错把陈醋当成墨，写尽半生尽是酸！', 6, NULL, NULL, '2023-07-07 15:46:22', NULL, 0);
INSERT INTO `post_info` VALUES (50, 48, '远赴人间惊鸿宴，一睹人间盛世颜。', 3, NULL, NULL, '2023-07-07 15:47:38', NULL, 0);
INSERT INTO `post_info` VALUES (51, 21, '半生风雨半生寒，一杯浊酒敬流年。', 3, NULL, NULL, '2023-07-07 15:48:07', NULL, 0);
INSERT INTO `post_info` VALUES (52, 96, '人间自是有情痴，此恨不关风与月。', 6, NULL, NULL, '2023-07-07 15:48:28', NULL, 0);
INSERT INTO `post_info` VALUES (53, 17, '何时仗尔看南雪，我与梅花两白头。', 5, NULL, NULL, '2023-07-07 15:49:17', NULL, 0);
INSERT INTO `post_info` VALUES (54, 4, '莫笑江湖少年梦，谁不江湖梦少年', 1, NULL, NULL, '2023-07-07 15:49:53', NULL, 0);
INSERT INTO `post_info` VALUES (55, 59, '辞别再无相见日，终是一人度春秋', 6, NULL, NULL, '2023-07-07 15:50:11', NULL, 0);
INSERT INTO `post_info` VALUES (56, 57, '花开花落花无悔，缘来缘去缘如水。', 4, NULL, NULL, '2023-07-07 15:51:26', NULL, 0);
INSERT INTO `post_info` VALUES (57, 57, '人言落日是天涯，望极天涯不见家。', 5, NULL, NULL, '2023-07-07 15:51:31', NULL, 0);
INSERT INTO `post_info` VALUES (58, 76, '人言落日是天涯，望极天涯不见家。', 4, NULL, NULL, '2023-07-07 15:51:36', NULL, 0);
INSERT INTO `post_info` VALUES (59, 14, '本是青灯不归客，却因浊酒恋红尘。', 4, NULL, NULL, '2023-07-07 15:51:40', NULL, 0);
INSERT INTO `post_info` VALUES (60, 52, '你本无意穿堂风，偏偏孤倨引山洪。', 4, NULL, NULL, '2023-07-07 15:51:44', NULL, 0);
INSERT INTO `post_info` VALUES (61, 26, '下班回家走到窗前抽支烟，发现一只蟑螂，于是它跟聊了很久，把对生活的不爽，对工作的压力，发泄给它听。抽完烟，上拖鞋狠狠拍死它，没办法，它知道的太多了', 1, NULL, NULL, '2023-07-11 18:23:08', NULL, 0);
INSERT INTO `post_info` VALUES (62, 100, '百无一用是深情，不屑一顾是相思', 5, NULL, NULL, '2023-07-11 18:23:30', NULL, 0);
INSERT INTO `post_info` VALUES (63, 13, '自古觉悟留不住，唯有套路得人心', 1, NULL, NULL, '2023-07-11 18:23:46', NULL, 0);
INSERT INTO `post_info` VALUES (64, 13, '同频共振真的很重要，快乐分享错了就成了显摆，难过分享错了就成了矫情', 1, NULL, NULL, '2023-07-11 18:24:33', NULL, 0);
INSERT INTO `post_info` VALUES (65, 53, '人有生老三千疾，唯有相思不可医', 6, NULL, NULL, '2023-07-18 18:59:45', NULL, 0);
INSERT INTO `post_info` VALUES (66, 61, '回头看，轻舟已过万重山,\r\n向前看，长路漫漫亦灿灿，\r\n抬头看，万里明灯照人间，\r\n低头看，脚下黄土千年绵\r\n            ---- 饶清地', 3, NULL, NULL, '2023-07-26 14:44:36', NULL, 0);
INSERT INTO `post_info` VALUES (67, 32, '有时候，身体累了，说明要熬出头了；脚步困了，说明人在上坡。换一种角度思考，让人茅塞顿开。', 6, NULL, NULL, '2023-08-25 08:39:19', NULL, 0);
INSERT INTO `post_info` VALUES (68, 92, '沧海桑田，我们只是一个行路人，何必执念太多呢？荣誉、委屈、金钱、地位、爱恨，到头来都是一缕青烟。', 6, NULL, NULL, '2023-08-25 08:39:23', NULL, 0);
INSERT INTO `post_info` VALUES (69, 44, '好的生活，不是腰缠万贯，而是有模有样：吃饭时，享受美食；睡觉时，踏实，不做噩梦；工作时，专注，不想恋爱；恋爱时，真心，目不斜视。', 3, NULL, NULL, '2023-08-25 08:39:28', NULL, 0);

-- ----------------------------
-- Table structure for role_info
-- ----------------------------
DROP TABLE IF EXISTS `role_info`;
CREATE TABLE `role_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_at` datetime NOT NULL,
  `update_at` datetime NULL DEFAULT NULL,
  `is_del` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of role_info
-- ----------------------------
INSERT INTO `role_info` VALUES (1, '超级管理员', '2023-11-08 09:50:04', NULL, 0);
INSERT INTO `role_info` VALUES (2, '用户', '2023-11-08 09:50:18', NULL, 0);
INSERT INTO `role_info` VALUES (3, '帖子管理员', '2023-11-09 09:32:37', '2023-11-09 09:41:32', 0);
INSERT INTO `role_info` VALUES (4, '帖子管理员123123123', '2023-11-09 09:39:48', '2023-11-09 09:41:12', 1);

-- ----------------------------
-- Table structure for role_permission_info
-- ----------------------------
DROP TABLE IF EXISTS `role_permission_info`;
CREATE TABLE `role_permission_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `create_at` datetime NOT NULL,
  `update_at` datetime NULL DEFAULT NULL,
  `is_del` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `permission_id`(`permission_id`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  CONSTRAINT `role_permission_info_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `role_permission_info_ibfk_1` FOREIGN KEY (`permission_id`) REFERENCES `permission_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 125 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of role_permission_info
-- ----------------------------
INSERT INTO `role_permission_info` VALUES (1, 1, 1, '2023-11-12 12:03:40', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (2, 1, 2, '2023-11-12 12:03:40', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (3, 1, 6, '2023-11-12 12:03:40', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (4, 1, 7, '2023-11-12 12:03:40', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (5, 1, 8, '2023-11-12 12:03:40', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (6, 1, 9, '2023-11-12 12:03:40', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (7, 1, 3, '2023-11-12 12:03:40', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (8, 1, 10, '2023-11-12 12:03:40', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (9, 1, 11, '2023-11-12 12:03:40', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (10, 1, 12, '2023-11-12 12:03:40', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (11, 1, 4, '2023-11-12 12:03:40', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (12, 1, 5, '2023-11-12 12:03:40', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (13, 3, 4, '2023-11-12 12:04:33', '2023-11-12 14:45:38', 1);
INSERT INTO `role_permission_info` VALUES (14, 3, 5, '2023-11-12 12:04:33', '2023-11-12 14:45:38', 1);
INSERT INTO `role_permission_info` VALUES (15, 1, 1, '2023-11-12 14:22:08', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (16, 1, 2, '2023-11-12 14:22:08', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (17, 1, 6, '2023-11-12 14:22:08', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (18, 1, 7, '2023-11-12 14:22:08', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (19, 1, 8, '2023-11-12 14:22:08', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (20, 1, 9, '2023-11-12 14:22:08', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (21, 1, 3, '2023-11-12 14:22:08', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (22, 1, 10, '2023-11-12 14:22:08', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (23, 1, 11, '2023-11-12 14:22:08', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (24, 1, 12, '2023-11-12 14:22:08', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (25, 1, 13, '2023-11-12 14:22:08', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (26, 1, 14, '2023-11-12 14:22:08', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (27, 1, 15, '2023-11-12 14:22:08', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (28, 1, 16, '2023-11-12 14:22:08', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (29, 1, 4, '2023-11-12 14:22:08', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (30, 1, 5, '2023-11-12 14:22:08', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (31, 1, 17, '2023-11-12 14:22:08', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (32, 3, 4, '2023-11-12 14:28:42', '2023-11-12 14:45:38', 1);
INSERT INTO `role_permission_info` VALUES (33, 3, 5, '2023-11-12 14:28:42', '2023-11-12 14:45:38', 1);
INSERT INTO `role_permission_info` VALUES (34, 3, 19, '2023-11-12 14:28:42', '2023-11-12 14:45:38', 1);
INSERT INTO `role_permission_info` VALUES (35, 3, 20, '2023-11-12 14:28:42', '2023-11-12 14:45:38', 1);
INSERT INTO `role_permission_info` VALUES (36, 3, 4, '2023-11-12 14:45:38', NULL, 0);
INSERT INTO `role_permission_info` VALUES (37, 3, 5, '2023-11-12 14:45:38', NULL, 0);
INSERT INTO `role_permission_info` VALUES (38, 3, 18, '2023-11-12 14:45:38', NULL, 0);
INSERT INTO `role_permission_info` VALUES (39, 3, 19, '2023-11-12 14:45:38', NULL, 0);
INSERT INTO `role_permission_info` VALUES (40, 3, 17, '2023-11-12 14:45:38', NULL, 0);
INSERT INTO `role_permission_info` VALUES (41, 1, 1, '2023-11-13 09:56:56', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (42, 1, 2, '2023-11-13 09:56:56', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (43, 1, 6, '2023-11-13 09:56:56', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (44, 1, 7, '2023-11-13 09:56:56', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (45, 1, 8, '2023-11-13 09:56:56', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (46, 1, 9, '2023-11-13 09:56:56', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (47, 1, 3, '2023-11-13 09:56:56', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (48, 1, 10, '2023-11-13 09:56:56', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (49, 1, 11, '2023-11-13 09:56:56', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (50, 1, 12, '2023-11-13 09:56:56', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (51, 1, 13, '2023-11-13 09:56:56', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (52, 1, 14, '2023-11-13 09:56:56', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (53, 1, 15, '2023-11-13 09:56:56', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (54, 1, 16, '2023-11-13 09:56:56', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (55, 1, 4, '2023-11-13 09:56:56', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (56, 1, 5, '2023-11-13 09:56:56', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (59, 1, 1, '2023-11-13 13:42:20', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (60, 1, 2, '2023-11-13 13:42:20', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (61, 1, 6, '2023-11-13 13:42:20', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (62, 1, 7, '2023-11-13 13:42:20', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (63, 1, 8, '2023-11-13 13:42:20', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (64, 1, 9, '2023-11-13 13:42:20', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (65, 1, 3, '2023-11-13 13:42:20', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (66, 1, 10, '2023-11-13 13:42:20', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (67, 1, 11, '2023-11-13 13:42:20', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (68, 1, 12, '2023-11-13 13:42:20', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (69, 1, 13, '2023-11-13 13:42:20', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (70, 1, 14, '2023-11-13 13:42:20', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (71, 1, 15, '2023-11-13 13:42:20', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (72, 1, 16, '2023-11-13 13:42:20', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (73, 1, 4, '2023-11-13 13:42:20', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (74, 1, 5, '2023-11-13 13:42:20', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (75, 1, 18, '2023-11-13 13:42:20', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (76, 1, 19, '2023-11-13 13:42:20', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (77, 1, 20, '2023-11-13 13:42:20', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (78, 1, 22, '2023-11-13 13:42:20', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (79, 1, 17, '2023-11-13 13:42:20', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (80, 1, 1, '2023-11-13 14:08:37', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (81, 1, 2, '2023-11-13 14:08:37', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (82, 1, 6, '2023-11-13 14:08:37', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (83, 1, 7, '2023-11-13 14:08:37', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (84, 1, 8, '2023-11-13 14:08:37', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (85, 1, 9, '2023-11-13 14:08:37', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (86, 1, 3, '2023-11-13 14:08:37', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (87, 1, 10, '2023-11-13 14:08:37', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (88, 1, 11, '2023-11-13 14:08:37', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (89, 1, 12, '2023-11-13 14:08:37', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (90, 1, 13, '2023-11-13 14:08:37', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (91, 1, 14, '2023-11-13 14:08:37', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (92, 1, 15, '2023-11-13 14:08:37', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (93, 1, 16, '2023-11-13 14:08:37', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (94, 1, 4, '2023-11-13 14:08:37', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (95, 1, 5, '2023-11-13 14:08:37', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (96, 1, 18, '2023-11-13 14:08:37', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (97, 1, 19, '2023-11-13 14:08:37', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (98, 1, 20, '2023-11-13 14:08:37', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (99, 1, 22, '2023-11-13 14:08:37', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (100, 1, 23, '2023-11-13 14:08:37', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (101, 1, 17, '2023-11-13 14:08:37', '2023-11-13 14:33:25', 1);
INSERT INTO `role_permission_info` VALUES (102, 1, 1, '2023-11-13 14:33:25', NULL, 0);
INSERT INTO `role_permission_info` VALUES (103, 1, 2, '2023-11-13 14:33:25', NULL, 0);
INSERT INTO `role_permission_info` VALUES (104, 1, 6, '2023-11-13 14:33:25', NULL, 0);
INSERT INTO `role_permission_info` VALUES (105, 1, 7, '2023-11-13 14:33:25', NULL, 0);
INSERT INTO `role_permission_info` VALUES (106, 1, 8, '2023-11-13 14:33:25', NULL, 0);
INSERT INTO `role_permission_info` VALUES (107, 1, 9, '2023-11-13 14:33:25', NULL, 0);
INSERT INTO `role_permission_info` VALUES (108, 1, 3, '2023-11-13 14:33:25', NULL, 0);
INSERT INTO `role_permission_info` VALUES (109, 1, 10, '2023-11-13 14:33:25', NULL, 0);
INSERT INTO `role_permission_info` VALUES (110, 1, 11, '2023-11-13 14:33:25', NULL, 0);
INSERT INTO `role_permission_info` VALUES (111, 1, 12, '2023-11-13 14:33:25', NULL, 0);
INSERT INTO `role_permission_info` VALUES (112, 1, 24, '2023-11-13 14:33:25', NULL, 0);
INSERT INTO `role_permission_info` VALUES (113, 1, 13, '2023-11-13 14:33:25', NULL, 0);
INSERT INTO `role_permission_info` VALUES (114, 1, 14, '2023-11-13 14:33:25', NULL, 0);
INSERT INTO `role_permission_info` VALUES (115, 1, 15, '2023-11-13 14:33:25', NULL, 0);
INSERT INTO `role_permission_info` VALUES (116, 1, 16, '2023-11-13 14:33:25', NULL, 0);
INSERT INTO `role_permission_info` VALUES (117, 1, 4, '2023-11-13 14:33:25', NULL, 0);
INSERT INTO `role_permission_info` VALUES (118, 1, 5, '2023-11-13 14:33:25', NULL, 0);
INSERT INTO `role_permission_info` VALUES (119, 1, 18, '2023-11-13 14:33:25', NULL, 0);
INSERT INTO `role_permission_info` VALUES (120, 1, 19, '2023-11-13 14:33:25', NULL, 0);
INSERT INTO `role_permission_info` VALUES (121, 1, 20, '2023-11-13 14:33:25', NULL, 0);
INSERT INTO `role_permission_info` VALUES (122, 1, 22, '2023-11-13 14:33:25', NULL, 0);
INSERT INTO `role_permission_info` VALUES (123, 1, 23, '2023-11-13 14:33:25', NULL, 0);
INSERT INTO `role_permission_info` VALUES (124, 1, 17, '2023-11-13 14:33:25', NULL, 0);

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `telephone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_at` datetime NOT NULL,
  `update_at` datetime NULL DEFAULT NULL,
  `is_del` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 117 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES (1, 'yangbiao', 'd839190744d0732b461fa05962e308d7', '标哥', '/public/01.jpg', '18627183746', 'lovesnsfi@126.com', '2023-11-08 09:51:47', '2023-11-09 08:58:15', 0);
INSERT INTO `user_info` VALUES (2, 'zhangya', 'd839190744d0732b461fa05962e308d7', '张雅', '/upload/avatar/68303f85-7b64-4f50-a53a-4b0fd4dfee2c.png', '18899999999', 'zy@softeem.xin', '2023-11-08 16:32:57', NULL, 0);
INSERT INTO `user_info` VALUES (3, 'xiaoqi', 'd839190744d0732b461fa05962e308d7', '肖琪', '/public/01.jpg', '86371443874', 'j.givs@ofsoq.mt', '2023-11-08 11:31:28', NULL, 0);
INSERT INTO `user_info` VALUES (4, 'joigqfu', 'd839190744d0732b461fa05962e308d7', '锺秀英', '/public/01.jpg', '30177990612', 'w.koxnrssy@lauqlgko.id', '2023-11-08 11:31:28', NULL, 0);
INSERT INTO `user_info` VALUES (5, 'nrbzilo', 'd839190744d0732b461fa05962e308d7', '傅霞', '/public/01.jpg', '81825717892', 's.ujg@mlvgrn.bw', '2023-11-08 11:31:28', NULL, 1);
INSERT INTO `user_info` VALUES (6, 'rrxtsly', 'd839190744d0732b461fa05962e308d7', '江刚', '/public/01.jpg', '54101565473', 'u.otdiwtinxn@ibhziv.mt', '2023-11-08 11:31:28', NULL, 0);
INSERT INTO `user_info` VALUES (7, 'iklguhx', 'd839190744d0732b461fa05962e308d7', '唐丽', '/public/01.jpg', '33534528735', 'n.yldkncsge@wxl.name', '2023-11-08 11:31:28', NULL, 0);
INSERT INTO `user_info` VALUES (8, 'ozdxdgx', 'd839190744d0732b461fa05962e308d7', '汪杰', '/public/01.jpg', '16672488184', 'p.eycmetn@hhizug.tv', '2023-11-08 11:31:28', NULL, 0);
INSERT INTO `user_info` VALUES (9, 'tjyvihg', 'd839190744d0732b461fa05962e308d7', '董磊', '/public/01.jpg', '01553348626', 'i.hqhko@icenust.ke', '2023-11-08 11:31:28', NULL, 0);
INSERT INTO `user_info` VALUES (10, 'gioyokk', 'd839190744d0732b461fa05962e308d7', '傅涛', '/public/01.jpg', '13275102468', 'd.zfrxy@xcjcdq.sk', '2023-11-08 11:31:28', NULL, 0);
INSERT INTO `user_info` VALUES (11, 'lltciks', 'd839190744d0732b461fa05962e308d7', '刘霞', '/public/01.jpg', '61156493448', 'p.fqabmgugt@awjxjoli.asia', '2023-11-08 11:31:28', NULL, 0);
INSERT INTO `user_info` VALUES (12, 'tcmfflx', 'd839190744d0732b461fa05962e308d7', '杜艳', '/public/01.jpg', '15702576266', 'u.lwpfsfgl@ypffq.bj', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (13, 'dkqnbqb', 'd839190744d0732b461fa05962e308d7', '孙丽', '/public/01.jpg', '53455154754', 'u.bvsrho@vrffdw.cx', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (14, 'kztmgvc', 'd839190744d0732b461fa05962e308d7', '许丽', '/public/01.jpg', '44896644854', 'u.xoexids@isyuvoviih.pm', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (15, 'rtcbidm', 'd839190744d0732b461fa05962e308d7', '郭刚', '/public/01.jpg', '44614256964', 'c.qbujfvpwa@sbvlcuw.cx', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (16, 'afvlgco', 'd839190744d0732b461fa05962e308d7', '林涛', '/public/01.jpg', '51167730357', 'e.igduepq@bqurbim.az', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (17, 'eqopekl', 'd839190744d0732b461fa05962e308d7', '周勇', '/public/01.jpg', '43663555873', 'p.dyjto@dfmhqhxveh.int', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (18, 'yafdqfa', 'd839190744d0732b461fa05962e308d7', '冯丽', '/public/01.jpg', '35454907747', 'l.wnewcp@oxymb.gn', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (19, 'hqwjvla', 'd839190744d0732b461fa05962e308d7', '汤静', '/public/01.jpg', '90382691354', 'f.enjixccl@welp.lc', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (20, 'ufrodwv', 'd839190744d0732b461fa05962e308d7', '卢刚', '/public/01.jpg', '35881654357', 'c.zivmbwf@tjcxkxr.aq', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (21, 'ngtwtwf', 'd839190744d0732b461fa05962e308d7', '赵军', '/public/01.jpg', '22415321798', 'g.rte@hmnxtk.cl', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (22, 'skqexqd', 'd839190744d0732b461fa05962e308d7', '田艳', '/public/01.jpg', '48235383185', 'e.wkxrkex@klo.mx', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (23, 'dgxfljt', 'd839190744d0732b461fa05962e308d7', '孟静', '/public/01.jpg', '74574795557', 't.iqjn@qkqdvg.kw', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (24, 'sfopice', 'd839190744d0732b461fa05962e308d7', '孔杰', '/public/01.jpg', '00204739416', 'h.uelqpiqm@qzhfiu.es', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (25, 'cjdmmoc', 'd839190744d0732b461fa05962e308d7', '李静', '/public/01.jpg', '15534762222', 'c.tbwcoyt@odfuf.li', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (26, 'wngilrx', 'd839190744d0732b461fa05962e308d7', '冯秀兰', '/public/01.jpg', '31982006243', 'x.taroyl@dqfqvnn.co', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (27, 'bxswdhe', 'd839190744d0732b461fa05962e308d7', '汤敏', '/public/01.jpg', '75672333394', 's.rxnay@cfoea.id', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (28, 'olfrbwk', 'd839190744d0732b461fa05962e308d7', '叶娟', '/public/01.jpg', '73193177951', 'r.enwuvk@eeiiz.pn', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (29, 'mvxnhyy', 'd839190744d0732b461fa05962e308d7', '雷平', '/public/01.jpg', '19182356105', 'a.khmhxyqw@mlv.tg', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (30, 'cstnhdh', 'd839190744d0732b461fa05962e308d7', '马超', '/public/01.jpg', '12426364124', 'v.qxpnoqr@sguaboug.sz', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (31, 'ysmcbtc', 'd839190744d0732b461fa05962e308d7', '潘勇', '/public/01.jpg', '83778844518', 'o.svx@nkbcgkqji.gov', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (32, 'ntveoci', 'd839190744d0732b461fa05962e308d7', '陆平', '/public/01.jpg', '75155883847', 'r.hrrwxf@hrhywbp.ls', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (33, 'dadtxyj', 'd839190744d0732b461fa05962e308d7', '郑秀兰', '/public/01.jpg', '25581859716', 'h.btctnrs@fbqjyprc.gov.cn', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (34, 'nluphlo', 'd839190744d0732b461fa05962e308d7', '萧勇', '/public/01.jpg', '68701175336', 'g.wesieat@ttby.eg', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (35, 'yovsjww', 'd839190744d0732b461fa05962e308d7', '金刚', '/public/01.jpg', '08765361664', 't.lursbpr@mqgh.gy', '2023-11-08 11:31:40', NULL, 1);
INSERT INTO `user_info` VALUES (36, 'rhiuicn', 'd839190744d0732b461fa05962e308d7', '朱杰', '/public/01.jpg', '37665547541', 'x.ejcchynrd@ullhksi.com', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (37, 'kdiybne', 'd839190744d0732b461fa05962e308d7', '常霞', '/public/01.jpg', '22728331676', 's.qsqlhescwt@eicw.gb', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (38, 'rypdukd', 'd839190744d0732b461fa05962e308d7', '郑强', '/public/01.jpg', '14882211769', 'k.kbeqs@pdhermxp.vc', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (39, 'lsyrshw', 'd839190744d0732b461fa05962e308d7', '方涛', '/public/01.jpg', '62295143845', 'b.hsi@vdwkntdyb.il', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (40, 'itqfslj', 'd839190744d0732b461fa05962e308d7', '孙秀兰', '/public/01.jpg', '36476399527', 'v.lykovtj@ppknrzq.dk', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (41, 'hhqkcqc', 'd839190744d0732b461fa05962e308d7', '黄静', '/public/01.jpg', '54642511275', 'i.tstj@mcrcfu.by', '2023-11-08 11:31:40', NULL, 0);
INSERT INTO `user_info` VALUES (42, 'vejjepv', 'd839190744d0732b461fa05962e308d7', '韩杰', '/public/01.jpg', '35233338651', 'e.wswrofgg@loehcr.bj', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (43, 'uxuwwwq', 'd839190744d0732b461fa05962e308d7', '潘强', '/public/01.jpg', '31830416181', 'j.jqgco@dkky.ev', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (44, 'ywslsuf', 'd839190744d0732b461fa05962e308d7', '黎艳', '/public/01.jpg', '06721634297', 'b.ccsufd@dnlyqw.fk', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (45, 'bzzbdsy', 'd839190744d0732b461fa05962e308d7', '熊桂英', '/public/01.jpg', '15241267765', 'r.jcgnwcqph@tztpsbxt.dk', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (46, 'ebpxeox', 'd839190744d0732b461fa05962e308d7', '魏刚', '/public/01.jpg', '38131483686', 'm.uwseoyfuv@zuc.mn', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (47, 'ueqxjrm', 'd839190744d0732b461fa05962e308d7', '郭涛', '/public/01.jpg', '40899698233', 'v.zwoyqmr@qolbg.lc', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (48, 'eejkmkf', 'd839190744d0732b461fa05962e308d7', '杨明', '/public/01.jpg', '31658583444', 'm.lfyfypo@jivruu.cx', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (49, 'rkcvczm', 'd839190744d0732b461fa05962e308d7', '汪勇', '/public/01.jpg', '17894572928', 'm.agjanb@poycuf.na', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (50, 'jhnnuue', 'd839190744d0732b461fa05962e308d7', '尹平', '/public/01.jpg', '12170545285', 'v.xfobmzahk@diln.sg', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (51, 'nrretpu', 'd839190744d0732b461fa05962e308d7', '彭军', '/public/01.jpg', '94591760476', 'm.krpqed@aadiklwq.sm', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (52, 'ymigddg', 'd839190744d0732b461fa05962e308d7', '沈超', '/public/01.jpg', '79465722662', 'a.clvgikhn@tvfsa.cx', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (53, 'suqoefy', 'd839190744d0732b461fa05962e308d7', '毛明', '/public/01.jpg', '52156577415', 'f.zoow@eipiobk.io', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (54, 'zbkfiwk', 'd839190744d0732b461fa05962e308d7', '石娟', '/public/01.jpg', '63655575164', 's.fytxkx@mgxtcsz.na', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (55, 'ylynjvy', 'd839190744d0732b461fa05962e308d7', '刘涛', '/public/01.jpg', '83917221044', 'o.mlbr@ruo.ne', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (56, 'ofbvxpy', 'd839190744d0732b461fa05962e308d7', '段娜', '/public/01.jpg', '82387439952', 'z.jqcmwq@lbfejtzto.int', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (57, 'vstgtwy', 'd839190744d0732b461fa05962e308d7', '熊涛', '/public/01.jpg', '83248876550', 'u.zwexodc@bizjyg.rw', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (58, 'dvinsoy', 'd839190744d0732b461fa05962e308d7', '赖超', '/public/01.jpg', '18469361825', 'x.gbmfcfvkvp@bwrclxyiy.tt', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (59, 'bjltxwr', 'd839190744d0732b461fa05962e308d7', '金磊', '/public/01.jpg', '27623873033', 'r.mvz@mbuniyel.by', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (60, 'djslujn', 'd839190744d0732b461fa05962e308d7', '汪超', '/public/01.jpg', '75803104486', 'o.vteotpdu@yixgjcnnrg.lv', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (61, 'rsjjovp', 'd839190744d0732b461fa05962e308d7', '邵霞', '/public/01.jpg', '19732483889', 't.ivphmvt@dymjinuzw.lk', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (62, 'ymvchgl', 'd839190744d0732b461fa05962e308d7', '崔平', '/public/01.jpg', '25230552884', 'b.hcntwfba@wjckg.ev', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (63, 'sejmhbh', 'd839190744d0732b461fa05962e308d7', '郭静', '/public/01.jpg', '05579655163', 'd.bgommnsh@blnzxx.edu', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (64, 'usxddex', 'd839190744d0732b461fa05962e308d7', '郝杰', '/public/01.jpg', '44184705407', 'k.hfutqzf@nsllg.iq', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (65, 'ofhkqin', 'd839190744d0732b461fa05962e308d7', '范秀英', '/public/01.jpg', '41740549201', 'g.bnuctk@stcrof.au', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (66, 'tfetjwu', 'd839190744d0732b461fa05962e308d7', '周秀英', '/public/01.jpg', '77602538116', 'h.uwwvio@rqymcp.kh', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (67, 'jreqlur', 'd839190744d0732b461fa05962e308d7', '萧刚', '/public/01.jpg', '99584416643', 'g.xjxqsov@bedpqj.is', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (68, 'phmfydn', 'd839190744d0732b461fa05962e308d7', '胡静', '/public/01.jpg', '64572843785', 'd.bzdxkragt@dhuodiq.ch', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (69, 'lrbbelk', 'd839190744d0732b461fa05962e308d7', '龚丽', '/public/01.jpg', '57408474653', 's.yfm@lgolueqbz.tz', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (70, 'ubhgtqr', 'd839190744d0732b461fa05962e308d7', '冯敏', '/public/01.jpg', '61183315394', 'j.cuibhl@uuqsuhuk.io', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (71, 'sdyoyzx', 'd839190744d0732b461fa05962e308d7', '曾秀英', '/public/01.jpg', '48634660669', 'u.fokmo@flmg.wf', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (72, 'grbodkb', 'd839190744d0732b461fa05962e308d7', '汤敏', '/public/01.jpg', '32885552924', 'n.qfythgqby@rkkvdfnc.mw', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (73, 'ughibte', 'd839190744d0732b461fa05962e308d7', '杨刚', '/public/01.jpg', '12463151831', 'q.xgfoq@vyq.id', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (74, 'rcfetvk', 'd839190744d0732b461fa05962e308d7', '孔芳', '/public/01.jpg', '40316594382', 'x.kdtcv@lfhcxdxdaz.so', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (75, 'rrsgrth', 'd839190744d0732b461fa05962e308d7', '曹洋', '/public/01.jpg', '14832166977', 's.fdwkspmtt@ljexik.uy', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (76, 'syeqfed', 'd839190744d0732b461fa05962e308d7', '叶霞', '/public/01.jpg', '78668666337', 'd.orux@yglxjyovq.va', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (77, 'thheplw', 'd839190744d0732b461fa05962e308d7', '唐敏', '/public/01.jpg', '41692805151', 'l.lbhsc@ptk.so', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (78, 'pgqxuju', 'd839190744d0732b461fa05962e308d7', '龙艳', '/public/01.jpg', '64160180439', 'm.ltjhf@lxcvsdc.do', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (79, 'xmyetfi', 'd839190744d0732b461fa05962e308d7', '李秀兰', '/public/01.jpg', '67732213857', 'y.desyfggmu@wlxneich.pw', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (80, 'yekkqpz', 'd839190744d0732b461fa05962e308d7', '曹勇', '/public/01.jpg', '15998406489', 'v.mountdoqk@opgm.bs', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (81, 'psounwy', 'd839190744d0732b461fa05962e308d7', '丁娟', '/public/01.jpg', '95352557080', 'h.lphhnary@njrlpofiwx.tn', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (82, 'oqdxbkf', 'd839190744d0732b461fa05962e308d7', '谢平', '/public/01.jpg', '15334630827', 'd.nvotrg@owrshrzvxw.pn', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (83, 'ernpkxo', 'd839190744d0732b461fa05962e308d7', '阎涛', '/public/01.jpg', '55102727521', 'e.xbxurjy@fljmhackdq.ua', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (84, 'osurwgi', 'd839190744d0732b461fa05962e308d7', '梁秀兰', '/public/01.jpg', '96619288604', 'w.fdftnywum@jpikq.bz', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (85, 'jldeurd', 'd839190744d0732b461fa05962e308d7', '贾勇', '/public/01.jpg', '42683592778', 'k.mezmbwkmhi@cmpmjkkkin.yu', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (86, 'idrgtcc', 'd839190744d0732b461fa05962e308d7', '张丽', '/public/01.jpg', '66436459762', 't.ggybkbyi@mrvy.ht', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (87, 'emlnqoy', 'd839190744d0732b461fa05962e308d7', '邹洋', '/public/01.jpg', '99119738086', 'l.nffmc@lpxcclpwci.cn', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (88, 'fyblovc', 'd839190744d0732b461fa05962e308d7', '韩娟', '/public/01.jpg', '72361114586', 's.gwczkswm@xtasygslu.ev', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (89, 'vkvxgfn', 'd839190744d0732b461fa05962e308d7', '刘娜', '/public/01.jpg', '49188656281', 'p.mdixd@pdile.gm', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (90, 'ypewyah', 'd839190744d0732b461fa05962e308d7', '邱涛', '/public/01.jpg', '52561217056', 'o.bqtjmonw@pjfyttu.tk', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (91, 'jkjyprp', 'd839190744d0732b461fa05962e308d7', '廖军', '/public/01.jpg', '72141502237', 'k.jqgbyechgb@mqxydmp.af', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (92, 'bqiwgjk', 'd839190744d0732b461fa05962e308d7', '汤娜', '/public/01.jpg', '34402868963', 'v.cikbdvgmet@fulwf.mil', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (93, 'lnrgkqm', 'd839190744d0732b461fa05962e308d7', '罗秀英', '/public/01.jpg', '85554857132', 'y.wtfxgc@ebg.ge', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (94, 'dbaislg', 'd839190744d0732b461fa05962e308d7', '蔡军', '/public/01.jpg', '54434968360', 'l.eek@seplba.lb', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (95, 'rhdwzwf', 'd839190744d0732b461fa05962e308d7', '曾芳', '/public/01.jpg', '68312552444', 'x.zdv@rmshmy.si', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (96, 'xmkzysq', 'd839190744d0732b461fa05962e308d7', '程霞', '/public/01.jpg', '22592586101', 'z.cpjqxjve@nmgqs.bd', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (97, 'mgyyssr', 'd839190744d0732b461fa05962e308d7', '高芳', '/public/01.jpg', '33482278188', 'k.rurcd@swsk.ch', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (98, 'wzhqgre', 'd839190744d0732b461fa05962e308d7', '罗涛', '/public/01.jpg', '73785780264', 'u.nykiyohc@kankzv.cu', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (99, 'ebgnimd', 'd839190744d0732b461fa05962e308d7', '蔡涛', '/public/01.jpg', '83843235432', 'u.plgtg@yqsf.nt', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (100, 'yxbqtpb', 'd839190744d0732b461fa05962e308d7', '江刚', '/public/01.jpg', '28790273601', 'l.eydjlw@qvqp.pro', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (101, 'rhvljht', 'd839190744d0732b461fa05962e308d7', '秦娜', '/public/01.jpg', '42177109422', 't.vkcxmjvilq@iyxxq.int', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (102, 'rapzglp', 'd839190744d0732b461fa05962e308d7', '宋艳', '/public/01.jpg', '72687013861', 't.fhrxrr@tunkw.hn', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (103, 'inrltrp', 'd839190744d0732b461fa05962e308d7', '汤秀兰', '/public/01.jpg', '49521146141', 'y.wlow@uwnuzfoj.cr', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (104, 'ffcxaol', 'd839190744d0732b461fa05962e308d7', '邹平', '/public/01.jpg', '28244694868', 'y.qhtajojnj@httvpnmt.asia', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (105, 'asbrfsm', 'd839190744d0732b461fa05962e308d7', '冯娟', '/public/01.jpg', '32360876863', 'y.gchuxtpm@vhdlyra.com', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (106, 'vmdvvay', 'd839190744d0732b461fa05962e308d7', '陈秀兰', '/public/01.jpg', '21061130883', 'a.xze@yss.cm', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (107, 'oibsrri', 'd839190744d0732b461fa05962e308d7', '孔丽', '/public/01.jpg', '76445335112', 'm.qsikjrb@nvwpsmohc.dm', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (108, 'rhjjqrz', 'd839190744d0732b461fa05962e308d7', '魏超', '/public/01.jpg', '83624894495', 'i.chzgliahqn@frjowuguf.gy', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (109, 'ylbahfx', 'd839190744d0732b461fa05962e308d7', '曹娜', '/public/01.jpg', '13634631312', 's.qobkxlbm@bbscbfhgc.asia', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (110, 'idvoyaw', 'd839190744d0732b461fa05962e308d7', '毛秀兰', '/public/01.jpg', '35283194612', 'k.jkne@nxpujho.mc', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (111, 'fpdxbew', 'd839190744d0732b461fa05962e308d7', '唐桂英', '/public/01.jpg', '27744834921', 'f.lpcovsrp@ynhdng.lt', '2023-11-08 11:31:41', NULL, 0);
INSERT INTO `user_info` VALUES (200, 'jxmsxgl', 'd839190744d0732b461fa05962e308d7', '万平', '/public/01.jpg', '59148542653', 'b.itgb@pwhfmud.cy', '2023-11-08 11:31:28', NULL, 0);

-- ----------------------------
-- Table structure for user_role_info
-- ----------------------------
DROP TABLE IF EXISTS `user_role_info`;
CREATE TABLE `user_role_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `create_at` datetime NOT NULL,
  `update_at` datetime NULL DEFAULT NULL,
  `is_del` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `user_role_info_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `user_role_info_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user_role_info
-- ----------------------------
INSERT INTO `user_role_info` VALUES (5, 2, 2, '2023-11-08 16:32:57', '2023-11-09 14:46:45', 1);
INSERT INTO `user_role_info` VALUES (9, 1, 1, '2023-11-09 11:17:19', '2023-11-09 14:49:06', 1);
INSERT INTO `user_role_info` VALUES (10, 1, 2, '2023-11-09 11:17:19', '2023-11-09 14:49:06', 1);
INSERT INTO `user_role_info` VALUES (11, 3, 2, '2023-11-09 11:24:08', NULL, 0);
INSERT INTO `user_role_info` VALUES (12, 4, 2, '2023-11-09 11:24:31', NULL, 0);
INSERT INTO `user_role_info` VALUES (13, 6, 2, '2023-11-09 14:46:03', NULL, 0);
INSERT INTO `user_role_info` VALUES (14, 2, 2, '2023-11-09 14:46:45', NULL, 0);
INSERT INTO `user_role_info` VALUES (15, 2, 3, '2023-11-09 14:46:45', NULL, 0);
INSERT INTO `user_role_info` VALUES (16, 1, 1, '2023-11-09 14:47:09', '2023-11-09 14:49:06', 1);
INSERT INTO `user_role_info` VALUES (17, 1, 2, '2023-11-09 14:47:09', '2023-11-09 14:49:06', 1);
INSERT INTO `user_role_info` VALUES (18, 1, 3, '2023-11-09 14:47:09', '2023-11-09 14:49:06', 1);
INSERT INTO `user_role_info` VALUES (19, 1, 1, '2023-11-09 14:49:06', NULL, 0);
INSERT INTO `user_role_info` VALUES (20, 1, 2, '2023-11-09 14:49:06', NULL, 0);
INSERT INTO `user_role_info` VALUES (21, 1, 3, '2023-11-09 14:49:06', NULL, 0);

SET FOREIGN_KEY_CHECKS = 1;
