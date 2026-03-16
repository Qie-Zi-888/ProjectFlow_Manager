-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: projectflow_manager
-- ------------------------------------------------------
-- Server version	8.0.38

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `attachment`
--

DROP TABLE IF EXISTS `attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attachment` (
  `attach_id` bigint NOT NULL AUTO_INCREMENT COMMENT '附件ID',
  `target_type` varchar(30) NOT NULL COMMENT '目标类型（requirement/task/bug/comment等）',
  `target_id` bigint NOT NULL COMMENT '目标ID',
  `file_name` varchar(200) NOT NULL COMMENT '文件名',
  `file_path` varchar(500) NOT NULL COMMENT '存储路径',
  `file_size` bigint DEFAULT '0' COMMENT '文件大小',
  `file_type` varchar(50) DEFAULT NULL COMMENT '文件类型',
  `create_by` varchar(64) DEFAULT '' COMMENT '上传人',
  `create_time` datetime DEFAULT NULL COMMENT '上传时间',
  `del_flag` tinyint DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (`attach_id`),
  KEY `idx_target` (`target_type`,`target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='附件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attachment`
--

LOCK TABLES `attachment` WRITE;
/*!40000 ALTER TABLE `attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bug`
--

DROP TABLE IF EXISTS `bug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bug` (
  `bug_id` bigint NOT NULL AUTO_INCREMENT COMMENT '缺陷ID',
  `project_id` bigint NOT NULL COMMENT '所属项目',
  `req_id` bigint DEFAULT NULL COMMENT '关联需求ID',
  `module_id` bigint DEFAULT NULL COMMENT '所属模块',
  `found_version` varchar(30) DEFAULT NULL COMMENT '发现版本',
  `fixed_version` varchar(30) DEFAULT NULL COMMENT '修复版本',
  `bug_title` varchar(200) NOT NULL COMMENT '缺陷标题',
  `description` text COMMENT '详细描述',
  `severity` char(1) DEFAULT '2' COMMENT '严重程度（1致命 2严重 3一般 4轻微）',
  `priority` char(1) DEFAULT '2' COMMENT '优先级',
  `status` tinyint DEFAULT '0' COMMENT '状态（0新建 1已分配 2打开 3已修复 4关闭 5拒绝）',
  `assign_to` bigint DEFAULT NULL COMMENT '指派给（当前处理人）',
  `resolved_by` bigint DEFAULT NULL COMMENT '解决人',
  `resolved_time` datetime DEFAULT NULL COMMENT '解决时间',
  `closed_by` bigint DEFAULT NULL COMMENT '关闭人',
  `closed_time` datetime DEFAULT NULL COMMENT '关闭时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` tinyint DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (`bug_id`),
  KEY `idx_project_id` (`project_id`),
  KEY `idx_assign_to` (`assign_to`),
  KEY `idx_status` (`status`),
  KEY `idx_req_id` (`req_id`),
  KEY `idx_module_id` (`module_id`),
  CONSTRAINT `fk_bug_module` FOREIGN KEY (`module_id`) REFERENCES `project_module` (`module_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_bug_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_bug_req` FOREIGN KEY (`req_id`) REFERENCES `requirement` (`req_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='缺陷表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bug`
--

LOCK TABLES `bug` WRITE;
/*!40000 ALTER TABLE `bug` DISABLE KEYS */;
/*!40000 ALTER TABLE `bug` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `comment_id` bigint NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `target_type` varchar(30) NOT NULL COMMENT '目标类型（requirement/task/bug/document等）',
  `target_id` bigint NOT NULL COMMENT '目标ID',
  `content` text NOT NULL COMMENT '评论内容',
  `parent_id` bigint DEFAULT '0' COMMENT '父评论ID（用于回复）',
  `create_by` varchar(64) DEFAULT '' COMMENT '评论人',
  `create_time` datetime DEFAULT NULL COMMENT '评论时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` tinyint DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (`comment_id`),
  KEY `idx_target` (`target_type`,`target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='评论表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document`
--

DROP TABLE IF EXISTS `document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document` (
  `doc_id` bigint NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `project_id` bigint NOT NULL COMMENT '所属项目',
  `folder_id` bigint DEFAULT '0' COMMENT '文件夹ID（可自关联实现目录）',
  `doc_name` varchar(200) NOT NULL COMMENT '文档名称',
  `file_path` varchar(500) DEFAULT NULL COMMENT '存储路径',
  `file_size` bigint DEFAULT '0' COMMENT '文件大小（字节）',
  `file_type` varchar(50) DEFAULT NULL COMMENT '文件类型（扩展名）',
  `version` varchar(20) DEFAULT '1.0' COMMENT '版本号',
  `description` varchar(500) DEFAULT NULL COMMENT '描述',
  `create_by` varchar(64) DEFAULT '' COMMENT '上传人',
  `create_time` datetime DEFAULT NULL COMMENT '上传时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` tinyint DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (`doc_id`),
  KEY `idx_project_id` (`project_id`),
  CONSTRAINT `fk_doc_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='文档表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document`
--

LOCK TABLES `document` WRITE;
/*!40000 ALTER TABLE `document` DISABLE KEYS */;
/*!40000 ALTER TABLE `document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_version`
--

DROP TABLE IF EXISTS `document_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document_version` (
  `ver_id` bigint NOT NULL AUTO_INCREMENT COMMENT '版本ID',
  `doc_id` bigint NOT NULL COMMENT '文档ID',
  `version` varchar(20) NOT NULL COMMENT '版本号',
  `file_path` varchar(500) NOT NULL COMMENT '该版本文件路径',
  `file_size` bigint DEFAULT '0' COMMENT '文件大小',
  `change_log` varchar(500) DEFAULT NULL COMMENT '变更日志',
  `create_by` varchar(64) DEFAULT '' COMMENT '上传人',
  `create_time` datetime DEFAULT NULL COMMENT '上传时间',
  PRIMARY KEY (`ver_id`),
  KEY `idx_doc_id` (`doc_id`),
  CONSTRAINT `fk_docver_doc` FOREIGN KEY (`doc_id`) REFERENCES `document` (`doc_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='文档版本表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_version`
--

LOCK TABLES `document_version` WRITE;
/*!40000 ALTER TABLE `document_version` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table`
--

DROP TABLE IF EXISTS `gen_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gen_table` (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COMMENT='代码生成业务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table`
--

LOCK TABLES `gen_table` WRITE;
/*!40000 ALTER TABLE `gen_table` DISABLE KEYS */;
INSERT INTO `gen_table` VALUES (1,'project','项目表','project_module','project_id','Project','sub','element-ui','com.ruoyi.project','project','project','项目','Qie_Zi','0','/','{\"parentMenuId\":2000}','admin','2026-03-14 15:55:13','','2026-03-15 17:11:11',NULL),(2,'project_member','项目成员表',NULL,NULL,'ProjectMember','crud','element-ui','com.ruoyi.project','project','member','项目成员','Qie_Zi','0','/','{\"parentMenuId\":2000}','admin','2026-03-14 16:57:01','','2026-03-15 19:58:52',NULL),(3,'project_module','项目模块表',NULL,NULL,'ProjectModule','crud','element-ui','com.ruoyi.system','system','module','项目模块','Qie_Zi','0','/','{}','admin','2026-03-14 20:34:01','','2026-03-14 20:35:43',NULL);
/*!40000 ALTER TABLE `gen_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table_column`
--

DROP TABLE IF EXISTS `gen_table_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gen_table_column` (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) DEFAULT '' COMMENT '字典类型',
  `sort` int DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb3 COMMENT='代码生成业务表字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table_column`
--

LOCK TABLES `gen_table_column` WRITE;
/*!40000 ALTER TABLE `gen_table_column` DISABLE KEYS */;
INSERT INTO `gen_table_column` VALUES (1,1,'project_id','项目ID','bigint','Long','projectId','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2026-03-14 15:55:13','','2026-03-15 17:11:11'),(2,1,'project_name','项目名称','varchar(100)','String','projectName','0','0','1','1','1','1','1','LIKE','input','',2,'admin','2026-03-14 15:55:13','','2026-03-15 17:11:11'),(3,1,'project_code','项目编码（唯一）','varchar(50)','String','projectCode','0','0','0','1','1','0','1','EQ','input','',3,'admin','2026-03-14 15:55:13','','2026-03-15 17:11:11'),(4,1,'description','项目描述','varchar(500)','String','description','0','0','0','1','1','0','0','EQ','textarea','',4,'admin','2026-03-14 15:55:13','','2026-03-15 17:11:11'),(5,1,'start_date','计划开始日期','date','Date','startDate','0','0','0','1','1','1','1','EQ','datetime','',10,'admin','2026-03-14 15:55:13','','2026-03-15 17:11:11'),(6,1,'end_date','计划结束日期','date','Date','endDate','0','0','0','1','1','1','1','EQ','datetime','',11,'admin','2026-03-14 15:55:13','','2026-03-15 17:11:11'),(7,1,'real_start_date','实际开始日期','date','Date','realStartDate','0','0','0','1','1','1','1','EQ','datetime','',12,'admin','2026-03-14 15:55:13','','2026-03-15 17:11:11'),(8,1,'real_end_date','实际结束日期','date','Date','realEndDate','0','0','0','1','1','1','1','EQ','datetime','',13,'admin','2026-03-14 15:55:13','','2026-03-15 17:11:11'),(9,1,'status','项目状态（0进行中 1已完成 2暂停 3已取消）','tinyint','Long','status','0','0','0','1','1','1','1','EQ','radio','',5,'admin','2026-03-14 15:55:13','','2026-03-15 17:11:11'),(10,1,'priority','优先级（1最高 2高 3中 4低 5最低）','tinyint','Long','priority','0','0','0','1','1','1','1','EQ','input','',6,'admin','2026-03-14 15:55:13','','2026-03-15 17:11:11'),(11,1,'progress','项目进度（0-100）','tinyint','Long','progress','0','0','0','1','1','1','0','EQ','input','',14,'admin','2026-03-14 15:55:13','','2026-03-15 17:11:11'),(12,1,'owner_id','项目负责人ID','bigint','Long','ownerId','0','0','0','1','1','0','0','EQ','input','',15,'admin','2026-03-14 15:55:13','','2026-03-15 17:11:11'),(13,1,'owner_name','项目负责人姓名','varchar(50)','String','ownerName','0','0','0','1','1','1','1','LIKE','input','',16,'admin','2026-03-14 15:55:13','','2026-03-15 17:11:11'),(14,1,'board_style','看板样式（1标准看板 2敏捷看板 3自定义）','tinyint','Long','boardStyle','0','0','0','1','1','0','0','EQ','input','',17,'admin','2026-03-14 15:55:13','','2026-03-15 17:11:11'),(15,1,'col_width','列宽度','smallint','Long','colWidth','0','0','0','1','1','0','0','EQ','input','',18,'admin','2026-03-14 15:55:13','','2026-03-15 17:11:11'),(16,1,'display_cards','显示卡片数量','tinyint','Long','displayCards','0','0','0','1','1','0','0','EQ','input','',19,'admin','2026-03-14 15:55:13','','2026-03-15 17:11:11'),(17,1,'fluid_board','流体看板（0禁用 1启用）','char(1)','String','fluidBoard','0','0','0','1','1','0','0','EQ','input','',20,'admin','2026-03-14 15:55:13','','2026-03-15 17:11:11'),(18,1,'create_by','创建者','varchar(64)','String','createBy','0','0','0','1',NULL,'1','1','EQ','input','',21,'admin','2026-03-14 15:55:13','','2026-03-15 17:11:11'),(19,1,'create_time','创建时间','datetime','Date','createTime','0','0','0','1',NULL,'1','0','EQ','datetime','',22,'admin','2026-03-14 15:55:13','','2026-03-15 17:11:11'),(20,1,'update_by','更新者','varchar(64)','String','updateBy','0','0','0','1','0','1',NULL,'EQ','input','',23,'admin','2026-03-14 15:55:13','','2026-03-15 17:11:11'),(21,1,'update_time','更新时间','datetime','Date','updateTime','0','0','0','1','0','1',NULL,'EQ','datetime','',24,'admin','2026-03-14 15:55:13','','2026-03-15 17:11:11'),(22,1,'del_flag','删除标志（0存在 1删除）','tinyint','Long','delFlag','0','0','0','1',NULL,NULL,NULL,'EQ','input','',25,'admin','2026-03-14 15:55:13','','2026-03-15 17:11:11'),(23,1,'Budget','预算','bigint','Long','Budget','0','0','0','1','1','1','0','EQ','input','',7,'','2026-03-14 16:25:37','','2026-03-15 17:11:11'),(24,1,'Investment','已投入','bigint','Long','Investment','0','0','0','1','1','1','0','EQ','input','',9,'','2026-03-14 16:25:37','','2026-03-15 17:11:11'),(25,2,'id','关联ID','bigint','Long','id','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2026-03-14 16:57:01','','2026-03-15 19:58:52'),(26,2,'project_id','项目ID','bigint','Long','projectId','0','0','1','1','1','1','1','EQ','input','',2,'admin','2026-03-14 16:57:01','','2026-03-15 19:58:52'),(27,2,'user_id','用户ID（关联sys_user）','bigint','Long','userId','0','0','1','1','1','1','1','EQ','input','',4,'admin','2026-03-14 16:57:01','','2026-03-15 19:58:52'),(28,2,'project_role','项目角色（owner:负责人，developer:开发，tester:测试，visitor:访客）','varchar(30)','String','projectRole','0','0','0','1','1','1','1','EQ','select','',5,'admin','2026-03-14 16:57:01','','2026-03-15 19:58:52'),(29,2,'join_time','加入时间','datetime','Date','joinTime','0','0','0','1','1','1','1','EQ','datetime','',6,'admin','2026-03-14 16:57:01','','2026-03-15 19:58:52'),(30,2,'create_by','创建者','varchar(64)','String','createBy','0','0','0','1',NULL,NULL,'1','EQ','input','',7,'admin','2026-03-14 16:57:01','','2026-03-15 19:58:52'),(31,2,'create_time','创建时间','datetime','Date','createTime','0','0','0','1',NULL,'1','0','EQ','datetime','',8,'admin','2026-03-14 16:57:01','','2026-03-15 19:58:52'),(32,2,'update_by','更新者','varchar(64)','String','updateBy','0','0','0','1','1',NULL,NULL,'EQ','input','',9,'admin','2026-03-14 16:57:01','','2026-03-15 19:58:52'),(33,2,'update_time','更新时间','datetime','Date','updateTime','0','0','0','1','1',NULL,NULL,'EQ','datetime','',10,'admin','2026-03-14 16:57:01','','2026-03-15 19:58:52'),(34,2,'Investment','已用工时','bigint','Long','Investment','0','0','0','1','1','1','1','EQ','input','',11,'','2026-03-14 17:04:31','','2026-03-15 19:58:52'),(35,3,'module_id','模块ID','bigint','Long','moduleId','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2026-03-14 20:34:01','','2026-03-14 20:35:43'),(36,3,'project_id','项目ID','bigint','Long','projectId','0','0','1','1','1','1','1','EQ','input','',2,'admin','2026-03-14 20:34:01','','2026-03-14 20:35:43'),(37,3,'module_name','模块名称','varchar(50)','String','moduleName','0','0','1','1','1','1','1','LIKE','input','',3,'admin','2026-03-14 20:34:01','','2026-03-14 20:35:43'),(38,3,'parent_id','父模块ID（支持树形结构）','bigint','Long','parentId','0','0','0','1','1','1','1','EQ','input','',4,'admin','2026-03-14 20:34:01','','2026-03-14 20:35:43'),(39,3,'order_num','显示顺序','int','Long','orderNum','0','0','0','1','1','1','1','EQ','input','',5,'admin','2026-03-14 20:34:01','','2026-03-14 20:35:43'),(40,3,'create_by','创建者','varchar(64)','String','createBy','0','0','0','1',NULL,'1','1','EQ','input','',6,'admin','2026-03-14 20:34:01','','2026-03-14 20:35:43'),(41,3,'create_time','创建时间','datetime','Date','createTime','0','0','0','1',NULL,'1',NULL,'EQ','datetime','',7,'admin','2026-03-14 20:34:01','','2026-03-14 20:35:43'),(42,3,'update_by','更新者','varchar(64)','String','updateBy','0','0','0','1','1',NULL,NULL,'EQ','input','',8,'admin','2026-03-14 20:34:01','','2026-03-14 20:35:43'),(43,3,'update_time','更新时间','datetime','Date','updateTime','0','0','0','1','1',NULL,NULL,'EQ','datetime','',9,'admin','2026-03-14 20:34:01','','2026-03-14 20:35:43'),(44,3,'del_flag','删除标志','tinyint','Long','delFlag','0','0','0','1',NULL,NULL,NULL,'EQ','input','',10,'admin','2026-03-14 20:34:01','','2026-03-14 20:35:43'),(45,1,'requirement_count','需求总数','bigint','Long','requirementCount','0','0','0','1','1','1','0','EQ','input','',8,'','2026-03-14 21:16:46','','2026-03-15 17:11:11'),(46,2,'project_name','项目名称','varchar(100)','String','projectName','0','0','0','1','1','1','1','LIKE','input','',3,'','2026-03-15 19:58:35','','2026-03-15 19:58:52');
/*!40000 ALTER TABLE `gen_table_column` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `notif_id` bigint NOT NULL AUTO_INCREMENT COMMENT '通知ID',
  `title` varchar(200) NOT NULL COMMENT '通知标题',
  `content` text COMMENT '通知内容',
  `type` varchar(30) DEFAULT 'system' COMMENT '类型（system:系统，task:任务，bug:缺陷等）',
  `target_type` varchar(30) DEFAULT NULL COMMENT '关联对象类型（project/task/bug等）',
  `target_id` bigint DEFAULT NULL COMMENT '关联对象ID',
  `sender_id` bigint DEFAULT NULL COMMENT '发送者（0表示系统）',
  `create_time` datetime NOT NULL COMMENT '发送时间',
  PRIMARY KEY (`notif_id`),
  KEY `idx_target` (`target_type`,`target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='通知表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_user`
--

DROP TABLE IF EXISTS `notification_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '关联ID',
  `notif_id` bigint NOT NULL COMMENT '通知ID',
  `user_id` bigint NOT NULL COMMENT '接收人ID',
  `is_read` char(1) DEFAULT '0' COMMENT '是否已读（0未读 1已读）',
  `read_time` datetime DEFAULT NULL COMMENT '阅读时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_notif_user` (`notif_id`,`user_id`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `fk_notifuser_notif` FOREIGN KEY (`notif_id`) REFERENCES `notification` (`notif_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='通知接收人表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_user`
--

LOCK TABLES `notification_user` WRITE;
/*!40000 ALTER TABLE `notification_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project` (
  `project_id` bigint NOT NULL AUTO_INCREMENT COMMENT '项目ID',
  `project_name` varchar(100) NOT NULL COMMENT '项目名称',
  `project_code` varchar(50) DEFAULT NULL COMMENT '项目编码（唯一）',
  `description` varchar(500) DEFAULT NULL COMMENT '项目描述',
  `start_date` date DEFAULT NULL COMMENT '计划开始日期',
  `end_date` date DEFAULT NULL COMMENT '计划结束日期',
  `real_start_date` date DEFAULT NULL COMMENT '实际开始日期',
  `real_end_date` date DEFAULT NULL COMMENT '实际结束日期',
  `status` tinyint DEFAULT '0' COMMENT '项目状态（0进行中 1已完成 2暂停 3已取消）',
  `priority` tinyint DEFAULT '3' COMMENT '优先级（1最高 2高 3中 4低 5最低）',
  `progress` tinyint DEFAULT '0' COMMENT '项目进度（0-100）',
  `owner_id` bigint DEFAULT NULL COMMENT '项目负责人ID',
  `owner_name` varchar(50) DEFAULT NULL COMMENT '项目负责人姓名',
  `board_style` tinyint DEFAULT '1' COMMENT '看板样式（1标准看板 2敏捷看板 3自定义）',
  `col_width` smallint DEFAULT '264' COMMENT '列宽度',
  `display_cards` tinyint DEFAULT '0' COMMENT '显示卡片数量',
  `fluid_board` char(1) DEFAULT '0' COMMENT '流体看板（0禁用 1启用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` tinyint DEFAULT '0' COMMENT '删除标志（0存在 1删除）',
  `Budget` bigint DEFAULT NULL COMMENT '预算',
  `Investment` bigint DEFAULT NULL COMMENT '已投入',
  `requirement_count` bigint DEFAULT NULL COMMENT '需求条目数',
  PRIMARY KEY (`project_id`),
  UNIQUE KEY `idx_project_code` (`project_code`),
  KEY `idx_status` (`status`),
  KEY `idx_owner` (`owner_id`),
  KEY `idx_date_range` (`start_date`,`end_date`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='项目表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES (1,'无敌原子弹','BBB','把杂碎炸飞天','2026-03-15','2026-03-16','2026-03-17','2026-03-18',1,3,20,1,'茄子大大',1,264,0,'0','me','2026-03-15 11:49:41','','2026-03-16 10:28:43',0,9,10,0),(2,'超级大飞机',NULL,'飞往火星',NULL,NULL,NULL,NULL,0,2,0,NULL,NULL,1,264,0,'0','','2026-03-15 17:05:38','','2026-03-16 10:27:01',0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_member`
--

DROP TABLE IF EXISTS `project_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_member` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '关联ID',
  `project_id` bigint NOT NULL COMMENT '项目ID',
  `user_id` bigint NOT NULL COMMENT '用户ID（关联sys_user）',
  `project_role` varchar(30) DEFAULT 'developer' COMMENT '项目角色（owner:负责人，developer:开发，tester:测试，visitor:访客）',
  `join_time` datetime DEFAULT NULL COMMENT '加入时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `Investment` bigint DEFAULT NULL COMMENT '已用工时',
  `project_name` varchar(100) DEFAULT NULL COMMENT '项目名称',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_project_user` (`project_id`,`user_id`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `fk_pm_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 COMMENT='项目成员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_member`
--

LOCK TABLES `project_member` WRITE;
/*!40000 ALTER TABLE `project_member` DISABLE KEYS */;
INSERT INTO `project_member` VALUES (5,1,1,'owner','2026-03-03 00:00:00','','2026-03-15 11:57:21','admin','2026-03-16 10:34:28',30,NULL),(6,2,100,'developer',NULL,'','2026-03-15 17:43:42','','2026-03-15 21:07:03',NULL,NULL),(7,1,101,'visitor',NULL,'','2026-03-15 21:19:29','','2026-03-15 21:19:54',NULL,NULL),(9,1,12,'developer',NULL,'admin','2026-03-15 21:32:39','admin','2026-03-16 10:34:43',NULL,NULL);
/*!40000 ALTER TABLE `project_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_milestone`
--

DROP TABLE IF EXISTS `project_milestone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_milestone` (
  `milestone_id` bigint NOT NULL AUTO_INCREMENT COMMENT '里程碑ID',
  `project_id` bigint NOT NULL COMMENT '项目ID',
  `milestone_name` varchar(100) NOT NULL COMMENT '里程碑名称',
  `due_date` date DEFAULT NULL COMMENT '计划完成日期',
  `status` tinyint DEFAULT '0' COMMENT '状态（0未开始 1进行中 2已完成 3延期）',
  `description` varchar(500) DEFAULT NULL COMMENT '说明',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` tinyint DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (`milestone_id`),
  KEY `idx_project_id` (`project_id`),
  CONSTRAINT `fk_milestone_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='里程碑表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_milestone`
--

LOCK TABLES `project_milestone` WRITE;
/*!40000 ALTER TABLE `project_milestone` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_milestone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_module`
--

DROP TABLE IF EXISTS `project_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_module` (
  `module_id` bigint NOT NULL AUTO_INCREMENT COMMENT '模块ID',
  `project_id` bigint NOT NULL COMMENT '项目ID',
  `module_name` varchar(50) NOT NULL COMMENT '模块名称',
  `parent_id` bigint DEFAULT '0' COMMENT '父模块ID（支持树形结构）',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` tinyint DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (`module_id`),
  KEY `idx_project_id` (`project_id`),
  CONSTRAINT `fk_module_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COMMENT='项目模块表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_module`
--

LOCK TABLES `project_module` WRITE;
/*!40000 ALTER TABLE `project_module` DISABLE KEYS */;
INSERT INTO `project_module` VALUES (1,2,'螺旋桨',1,NULL,'我',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `project_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_version`
--

DROP TABLE IF EXISTS `project_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_version` (
  `version_id` bigint NOT NULL AUTO_INCREMENT COMMENT '版本ID',
  `project_id` bigint NOT NULL COMMENT '项目ID',
  `version_name` varchar(30) NOT NULL COMMENT '版本名称（如v1.0）',
  `description` varchar(500) DEFAULT NULL COMMENT '版本描述',
  `release_date` date DEFAULT NULL COMMENT '发布日期',
  `status` tinyint DEFAULT '0' COMMENT '状态（0规划中 1已发布 2已归档）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` tinyint DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (`version_id`),
  UNIQUE KEY `uk_project_version` (`project_id`,`version_name`),
  KEY `idx_project_id` (`project_id`),
  CONSTRAINT `fk_version_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='项目版本表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_version`
--

LOCK TABLES `project_version` WRITE;
/*!40000 ALTER TABLE `project_version` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_blob_triggers`
--

DROP TABLE IF EXISTS `qrtz_blob_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_blob_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Blob类型的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_blob_triggers`
--

LOCK TABLES `qrtz_blob_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_blob_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_blob_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_calendars`
--

DROP TABLE IF EXISTS `qrtz_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_calendars` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`,`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='日历信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_calendars`
--

LOCK TABLES `qrtz_calendars` WRITE;
/*!40000 ALTER TABLE `qrtz_calendars` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_calendars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_cron_triggers`
--

DROP TABLE IF EXISTS `qrtz_cron_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_cron_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Cron类型的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_cron_triggers`
--

LOCK TABLES `qrtz_cron_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_cron_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_cron_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_fired_triggers`
--

DROP TABLE IF EXISTS `qrtz_fired_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_fired_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) NOT NULL COMMENT '状态',
  `job_name` varchar(200) DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`,`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='已触发的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_fired_triggers`
--

LOCK TABLES `qrtz_fired_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_fired_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_fired_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_job_details`
--

DROP TABLE IF EXISTS `qrtz_job_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_job_details` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) NOT NULL COMMENT '任务组名',
  `description` varchar(250) DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='任务详细信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_job_details`
--

LOCK TABLES `qrtz_job_details` WRITE;
/*!40000 ALTER TABLE `qrtz_job_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_job_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_locks`
--

DROP TABLE IF EXISTS `qrtz_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_locks` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`,`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='存储的悲观锁信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_locks`
--

LOCK TABLES `qrtz_locks` WRITE;
/*!40000 ALTER TABLE `qrtz_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_paused_trigger_grps`
--

DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='暂停的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_paused_trigger_grps`
--

LOCK TABLES `qrtz_paused_trigger_grps` WRITE;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_scheduler_state`
--

DROP TABLE IF EXISTS `qrtz_scheduler_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_scheduler_state` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`,`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='调度器状态表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_scheduler_state`
--

LOCK TABLES `qrtz_scheduler_state` WRITE;
/*!40000 ALTER TABLE `qrtz_scheduler_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_scheduler_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_simple_triggers`
--

DROP TABLE IF EXISTS `qrtz_simple_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_simple_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='简单触发器的信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_simple_triggers`
--

LOCK TABLES `qrtz_simple_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_simple_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simple_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_simprop_triggers`
--

DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_simprop_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='同步机制的行锁表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_simprop_triggers`
--

LOCK TABLES `qrtz_simprop_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_simprop_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simprop_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_triggers`
--

DROP TABLE IF EXISTS `qrtz_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `sched_name` (`sched_name`,`job_name`,`job_group`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='触发器详细信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_triggers`
--

LOCK TABLES `qrtz_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requirement`
--

DROP TABLE IF EXISTS `requirement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `requirement` (
  `req_id` bigint NOT NULL AUTO_INCREMENT COMMENT '需求ID',
  `project_id` bigint NOT NULL COMMENT '所属项目',
  `module_id` bigint DEFAULT NULL COMMENT '所属模块',
  `version_id` bigint DEFAULT NULL COMMENT '计划发布版本',
  `req_title` varchar(200) NOT NULL COMMENT '需求标题',
  `description` text COMMENT '详细描述',
  `priority` char(1) DEFAULT '2' COMMENT '优先级（1最高 2高 3中 4低）',
  `status` tinyint DEFAULT '0' COMMENT '状态（0草稿 1进行中 2已解决 3关闭）',
  `assign_to` bigint DEFAULT NULL COMMENT '指派给（用户ID）',
  `estimate_time` decimal(10,1) DEFAULT NULL COMMENT '预估工时（小时）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` tinyint DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (`req_id`),
  KEY `idx_project_id` (`project_id`),
  KEY `idx_assign_to` (`assign_to`),
  KEY `idx_module_id` (`module_id`),
  KEY `idx_version_id` (`version_id`),
  CONSTRAINT `fk_req_module` FOREIGN KEY (`module_id`) REFERENCES `project_module` (`module_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_req_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_req_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`version_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='需求表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requirement`
--

LOCK TABLES `requirement` WRITE;
/*!40000 ALTER TABLE `requirement` DISABLE KEYS */;
/*!40000 ALTER TABLE `requirement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sprint`
--

DROP TABLE IF EXISTS `sprint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sprint` (
  `sprint_id` bigint NOT NULL AUTO_INCREMENT COMMENT '迭代ID',
  `project_id` bigint NOT NULL COMMENT '项目ID',
  `sprint_name` varchar(100) NOT NULL COMMENT '迭代名称',
  `start_date` date DEFAULT NULL COMMENT '迭代开始日期',
  `end_date` date DEFAULT NULL COMMENT '迭代结束日期',
  `status` tinyint DEFAULT '0' COMMENT '状态（0规划中 1进行中 2已完成 3已取消）',
  `goal` varchar(500) DEFAULT NULL COMMENT '迭代目标',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` tinyint DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (`sprint_id`),
  KEY `idx_project_id` (`project_id`),
  CONSTRAINT `fk_sprint_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='迭代表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sprint`
--

LOCK TABLES `sprint` WRITE;
/*!40000 ALTER TABLE `sprint` DISABLE KEYS */;
/*!40000 ALTER TABLE `sprint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sprint_burndown`
--

DROP TABLE IF EXISTS `sprint_burndown`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sprint_burndown` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `sprint_id` bigint NOT NULL COMMENT '迭代ID',
  `stat_date` date NOT NULL COMMENT '统计日期',
  `total_tasks` int DEFAULT '0' COMMENT '迭代总任务数',
  `done_tasks` int DEFAULT '0' COMMENT '已完成任务数',
  `remaining_tasks` int DEFAULT '0' COMMENT '剩余任务数',
  `total_hours` decimal(10,1) DEFAULT '0.0' COMMENT '迭代总工时',
  `remaining_hours` decimal(10,1) DEFAULT '0.0' COMMENT '剩余工时',
  `ideal_remaining_hours` decimal(10,1) DEFAULT '0.0' COMMENT '理想剩余工时(可选)',
  `create_time` datetime NOT NULL COMMENT '生成时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_sprint_date` (`sprint_id`,`stat_date`),
  KEY `idx_sprint_id` (`sprint_id`),
  CONSTRAINT `fk_burndown_sprint` FOREIGN KEY (`sprint_id`) REFERENCES `sprint` (`sprint_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='燃尽图统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sprint_burndown`
--

LOCK TABLES `sprint_burndown` WRITE;
/*!40000 ALTER TABLE `sprint_burndown` DISABLE KEYS */;
/*!40000 ALTER TABLE `sprint_burndown` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_config`
--

DROP TABLE IF EXISTS `sys_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_config` (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb3 COMMENT='参数配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_config`
--

LOCK TABLES `sys_config` WRITE;
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;
INSERT INTO `sys_config` VALUES (1,'主框架页-默认皮肤样式名称','sys.index.skinName','skin-blue','Y','admin','2026-03-11 20:19:22','',NULL,'蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),(2,'用户管理-账号初始密码','sys.user.initPassword','123456','Y','admin','2026-03-11 20:19:22','',NULL,'初始化密码 123456'),(3,'主框架页-侧边栏主题','sys.index.sideTheme','theme-dark','Y','admin','2026-03-11 20:19:22','',NULL,'深色主题theme-dark，浅色主题theme-light'),(4,'账号自助-验证码开关','sys.account.captchaEnabled','true','Y','admin','2026-03-11 20:19:22','',NULL,'是否开启验证码功能（true开启，false关闭）'),(5,'账号自助-是否开启用户注册功能','sys.account.registerUser','false','Y','admin','2026-03-11 20:19:22','',NULL,'是否开启注册用户功能（true开启，false关闭）'),(6,'用户登录-黑名单列表','sys.login.blackIPList','','Y','admin','2026-03-11 20:19:22','',NULL,'设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）'),(7,'用户管理-初始密码修改策略','sys.account.initPasswordModify','1','Y','admin','2026-03-11 20:19:22','',NULL,'0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框'),(8,'用户管理-账号密码更新周期','sys.account.passwordValidateDays','0','Y','admin','2026-03-11 20:19:22','',NULL,'密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');
/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dept`
--

DROP TABLE IF EXISTS `sys_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dept` (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(50) DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb3 COMMENT='部门表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dept`
--

LOCK TABLES `sys_dept` WRITE;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;
INSERT INTO `sys_dept` VALUES (100,0,'0','X科技',0,'李先生','15888888888','ry@qq.com','0','0','admin','2026-03-11 20:19:21','admin','2026-03-13 11:26:15'),(101,100,'0,100','深圳总公司',1,'若依','15888888888','ry@qq.com','0','0','admin','2026-03-11 20:19:21','',NULL),(102,100,'0,100','北京分公司',2,'若依','15888888888','ry@qq.com','0','0','admin','2026-03-11 20:19:21','',NULL),(103,101,'0,100,101','研发1部',1,'若依','15888888888','ry@qq.com','0','0','admin','2026-03-11 20:19:21','admin','2026-03-13 11:27:57'),(104,101,'0,100,101','市场部门',6,'若依','15888888888','ry@qq.com','0','0','admin','2026-03-11 20:19:21','admin','2026-03-13 11:27:48'),(105,101,'0,100,101','测试部门',3,'若依','15888888888','ry@qq.com','0','0','admin','2026-03-11 20:19:21','',NULL),(106,101,'0,100,101','财务部门',4,'若依','15888888888','ry@qq.com','0','0','admin','2026-03-11 20:19:21','',NULL),(107,101,'0,100,101','运维部门',5,'若依','15888888888','ry@qq.com','0','0','admin','2026-03-11 20:19:21','',NULL),(108,102,'0,100,102','市场部门',1,'若依','15888888888','ry@qq.com','0','0','admin','2026-03-11 20:19:21','',NULL),(109,102,'0,100,102','财务部门',2,'若依','15888888888','ry@qq.com','0','0','admin','2026-03-11 20:19:21','',NULL),(200,101,'0,100,101','研发2部',2,NULL,NULL,NULL,'0','0','admin','2026-03-13 11:27:35','',NULL);
/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_data`
--

DROP TABLE IF EXISTS `sys_dict_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb3 COMMENT='字典数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_data`
--

LOCK TABLES `sys_dict_data` WRITE;
/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;
INSERT INTO `sys_dict_data` VALUES (1,1,'男','0','sys_user_sex','','','Y','0','admin','2026-03-11 20:19:22','',NULL,'性别男'),(2,2,'女','1','sys_user_sex','','','N','0','admin','2026-03-11 20:19:22','',NULL,'性别女'),(3,3,'未知','2','sys_user_sex','','','N','0','admin','2026-03-11 20:19:22','',NULL,'性别未知'),(4,1,'显示','0','sys_show_hide','','primary','Y','0','admin','2026-03-11 20:19:22','',NULL,'显示菜单'),(5,2,'隐藏','1','sys_show_hide','','danger','N','0','admin','2026-03-11 20:19:22','',NULL,'隐藏菜单'),(6,1,'正常','0','sys_normal_disable','','primary','Y','0','admin','2026-03-11 20:19:22','',NULL,'正常状态'),(7,2,'停用','1','sys_normal_disable','','danger','N','0','admin','2026-03-11 20:19:22','',NULL,'停用状态'),(8,1,'正常','0','sys_job_status','','primary','Y','0','admin','2026-03-11 20:19:22','',NULL,'正常状态'),(9,2,'暂停','1','sys_job_status','','danger','N','0','admin','2026-03-11 20:19:22','',NULL,'停用状态'),(10,1,'默认','DEFAULT','sys_job_group','','','Y','0','admin','2026-03-11 20:19:22','',NULL,'默认分组'),(11,2,'系统','SYSTEM','sys_job_group','','','N','0','admin','2026-03-11 20:19:22','',NULL,'系统分组'),(12,1,'是','Y','sys_yes_no','','primary','Y','0','admin','2026-03-11 20:19:22','',NULL,'系统默认是'),(13,2,'否','N','sys_yes_no','','danger','N','0','admin','2026-03-11 20:19:22','',NULL,'系统默认否'),(14,1,'通知','1','sys_notice_type','','warning','Y','0','admin','2026-03-11 20:19:22','',NULL,'通知'),(15,2,'公告','2','sys_notice_type','','success','N','0','admin','2026-03-11 20:19:22','',NULL,'公告'),(16,1,'正常','0','sys_notice_status','','primary','Y','0','admin','2026-03-11 20:19:22','',NULL,'正常状态'),(17,2,'关闭','1','sys_notice_status','','danger','N','0','admin','2026-03-11 20:19:22','',NULL,'关闭状态'),(18,99,'其他','0','sys_oper_type','','info','N','0','admin','2026-03-11 20:19:22','',NULL,'其他操作'),(19,1,'新增','1','sys_oper_type','','info','N','0','admin','2026-03-11 20:19:22','',NULL,'新增操作'),(20,2,'修改','2','sys_oper_type','','info','N','0','admin','2026-03-11 20:19:22','',NULL,'修改操作'),(21,3,'删除','3','sys_oper_type','','danger','N','0','admin','2026-03-11 20:19:22','',NULL,'删除操作'),(22,4,'授权','4','sys_oper_type','','primary','N','0','admin','2026-03-11 20:19:22','',NULL,'授权操作'),(23,5,'导出','5','sys_oper_type','','warning','N','0','admin','2026-03-11 20:19:22','',NULL,'导出操作'),(24,6,'导入','6','sys_oper_type','','warning','N','0','admin','2026-03-11 20:19:22','',NULL,'导入操作'),(25,7,'强退','7','sys_oper_type','','danger','N','0','admin','2026-03-11 20:19:22','',NULL,'强退操作'),(26,8,'生成代码','8','sys_oper_type','','warning','N','0','admin','2026-03-11 20:19:22','',NULL,'生成操作'),(27,9,'清空数据','9','sys_oper_type','','danger','N','0','admin','2026-03-11 20:19:22','',NULL,'清空操作'),(28,1,'成功','0','sys_common_status','','primary','N','0','admin','2026-03-11 20:19:22','',NULL,'正常状态'),(29,2,'失败','1','sys_common_status','','danger','N','0','admin','2026-03-11 20:19:22','',NULL,'停用状态');
/*!40000 ALTER TABLE `sys_dict_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_type`
--

DROP TABLE IF EXISTS `sys_dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_type` (`dict_type`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb3 COMMENT='字典类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_type`
--

LOCK TABLES `sys_dict_type` WRITE;
/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;
INSERT INTO `sys_dict_type` VALUES (1,'用户性别','sys_user_sex','0','admin','2026-03-11 20:19:22','',NULL,'用户性别列表'),(2,'菜单状态','sys_show_hide','0','admin','2026-03-11 20:19:22','',NULL,'菜单状态列表'),(3,'系统开关','sys_normal_disable','0','admin','2026-03-11 20:19:22','',NULL,'系统开关列表'),(4,'任务状态','sys_job_status','0','admin','2026-03-11 20:19:22','',NULL,'任务状态列表'),(5,'任务分组','sys_job_group','0','admin','2026-03-11 20:19:22','',NULL,'任务分组列表'),(6,'系统是否','sys_yes_no','0','admin','2026-03-11 20:19:22','',NULL,'系统是否列表'),(7,'通知类型','sys_notice_type','0','admin','2026-03-11 20:19:22','',NULL,'通知类型列表'),(8,'通知状态','sys_notice_status','0','admin','2026-03-11 20:19:22','',NULL,'通知状态列表'),(9,'操作类型','sys_oper_type','0','admin','2026-03-11 20:19:22','',NULL,'操作类型列表'),(10,'系统状态','sys_common_status','0','admin','2026-03-11 20:19:22','',NULL,'登录状态列表');
/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job`
--

DROP TABLE IF EXISTS `sys_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_job` (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb3 COMMENT='定时任务调度表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job`
--

LOCK TABLES `sys_job` WRITE;
/*!40000 ALTER TABLE `sys_job` DISABLE KEYS */;
INSERT INTO `sys_job` VALUES (1,'系统默认（无参）','DEFAULT','ryTask.ryNoParams','0/10 * * * * ?','3','1','1','admin','2026-03-11 20:19:22','',NULL,''),(2,'系统默认（有参）','DEFAULT','ryTask.ryParams(\'ry\')','0/15 * * * * ?','3','1','1','admin','2026-03-11 20:19:22','',NULL,''),(3,'系统默认（多参）','DEFAULT','ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)','0/20 * * * * ?','3','1','1','admin','2026-03-11 20:19:22','',NULL,'');
/*!40000 ALTER TABLE `sys_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job_log`
--

DROP TABLE IF EXISTS `sys_job_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_job_log` (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) DEFAULT NULL COMMENT '日志信息',
  `status` char(1) DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) DEFAULT '' COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='定时任务调度日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job_log`
--

LOCK TABLES `sys_job_log` WRITE;
/*!40000 ALTER TABLE `sys_job_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_job_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_logininfor`
--

DROP TABLE IF EXISTS `sys_logininfor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
  `status` char(1) DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`),
  KEY `idx_sys_logininfor_s` (`status`),
  KEY `idx_sys_logininfor_lt` (`login_time`)
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=utf8mb3 COMMENT='系统访问记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_logininfor`
--

LOCK TABLES `sys_logininfor` WRITE;
/*!40000 ALTER TABLE `sys_logininfor` DISABLE KEYS */;
INSERT INTO `sys_logininfor` VALUES (100,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','登录成功','2026-03-11 20:41:01'),(101,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','1','验证码已失效','2026-03-12 09:59:16'),(102,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','登录成功','2026-03-12 09:59:16'),(103,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','退出成功','2026-03-12 10:03:12'),(104,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','登录成功','2026-03-12 10:03:16'),(105,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','登录成功','2026-03-12 12:46:26'),(106,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','登录成功','2026-03-13 11:25:01'),(107,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','1','验证码已失效','2026-03-13 16:33:04'),(108,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','1','验证码错误','2026-03-13 16:33:04'),(109,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','1','验证码错误','2026-03-13 16:33:06'),(110,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','登录成功','2026-03-13 16:33:10'),(111,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','登录成功','2026-03-13 20:22:52'),(112,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','登录成功','2026-03-13 21:00:01'),(113,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','登录成功','2026-03-14 10:08:35'),(114,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','1','验证码错误','2026-03-14 15:13:45'),(115,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','登录成功','2026-03-14 15:13:53'),(116,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','1','验证码已失效','2026-03-14 16:24:57'),(117,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','1','验证码错误','2026-03-14 16:24:57'),(118,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','登录成功','2026-03-14 16:24:59'),(119,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','登录成功','2026-03-14 19:13:18'),(120,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','退出成功','2026-03-14 20:19:47'),(121,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','1','验证码错误','2026-03-14 20:19:56'),(122,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','登录成功','2026-03-14 20:19:59'),(123,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','退出成功','2026-03-14 20:23:35'),(124,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','登录成功','2026-03-14 20:23:39'),(125,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','登录成功','2026-03-15 09:14:05'),(126,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','退出成功','2026-03-15 09:25:26'),(127,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','退出成功','2026-03-15 09:25:26'),(128,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','登录成功','2026-03-15 09:25:29'),(129,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','登录成功','2026-03-15 11:25:20'),(130,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','登录成功','2026-03-15 11:57:12'),(131,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','登录成功','2026-03-15 15:52:38'),(132,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','1','验证码已失效','2026-03-15 17:03:39'),(133,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','登录成功','2026-03-15 17:03:45'),(134,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','退出成功','2026-03-15 17:16:55'),(135,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','登录成功','2026-03-15 17:16:59'),(136,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','登录成功','2026-03-15 19:47:46'),(137,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','登录成功','2026-03-15 21:00:12'),(138,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','退出成功','2026-03-15 21:13:22'),(139,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','1','验证码错误','2026-03-15 21:13:24'),(140,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','登录成功','2026-03-15 21:13:26'),(141,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','退出成功','2026-03-15 21:26:19'),(142,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','登录成功','2026-03-15 21:26:21'),(143,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','退出成功','2026-03-15 21:32:18'),(144,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','登录成功','2026-03-15 21:32:20'),(145,'admin','127.0.0.1','内网IP','Chrome 145','Windows10','0','登录成功','2026-03-16 10:23:30');
/*!40000 ALTER TABLE `sys_logininfor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_menu` (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
  `parent_id` bigint DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) DEFAULT '' COMMENT '路由名称',
  `is_frame` int DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `is_cache` int DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2004 DEFAULT CHARSET=utf8mb3 COMMENT='菜单权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,'系统管理',0,1,'system',NULL,'','',1,0,'M','0','0','','system','admin','2026-03-11 20:19:21','',NULL,'系统管理目录'),(2,'系统监控',0,4,'monitor',NULL,'','',1,0,'M','0','0','','monitor','admin','2026-03-11 20:19:21','admin','2026-03-13 11:47:12','系统监控目录'),(3,'系统工具',0,3,'tool',NULL,'','',1,0,'M','0','0','','tool','admin','2026-03-11 20:19:21','',NULL,'系统工具目录'),(4,'若依官网',0,9,'http://ruoyi.vip',NULL,'','',0,0,'M','0','0','','guide','admin','2026-03-11 20:19:21','admin','2026-03-14 10:22:32','若依官网地址'),(100,'用户管理',1,1,'user','system/user/index','','',1,0,'C','0','0','system:user:list','user','admin','2026-03-11 20:19:21','',NULL,'用户管理菜单'),(101,'角色管理',1,2,'role','system/role/index','','',1,0,'C','0','0','system:role:list','peoples','admin','2026-03-11 20:19:21','',NULL,'角色管理菜单'),(102,'菜单管理',1,3,'menu','system/menu/index','','',1,0,'C','0','0','system:menu:list','tree-table','admin','2026-03-11 20:19:21','',NULL,'菜单管理菜单'),(103,'部门管理',1,4,'dept','system/dept/index','','',1,0,'C','0','0','system:dept:list','tree','admin','2026-03-11 20:19:21','',NULL,'部门管理菜单'),(104,'岗位管理',1,5,'post','system/post/index','','',1,0,'C','0','0','system:post:list','post','admin','2026-03-11 20:19:21','',NULL,'岗位管理菜单'),(105,'字典管理',1,6,'dict','system/dict/index','','',1,0,'C','0','0','system:dict:list','dict','admin','2026-03-11 20:19:21','',NULL,'字典管理菜单'),(106,'参数设置',1,7,'config','system/config/index','','',1,0,'C','0','0','system:config:list','edit','admin','2026-03-11 20:19:21','',NULL,'参数设置菜单'),(107,'通知公告',1,8,'notice','system/notice/index','','',1,0,'C','0','0','system:notice:list','message','admin','2026-03-11 20:19:21','',NULL,'通知公告菜单'),(108,'日志管理',1,9,'log','','','',1,0,'M','0','0','','log','admin','2026-03-11 20:19:21','',NULL,'日志管理菜单'),(109,'在线用户',2,1,'online','monitor/online/index','','',1,0,'C','0','0','monitor:online:list','online','admin','2026-03-11 20:19:21','',NULL,'在线用户菜单'),(110,'定时任务',2,2,'job','monitor/job/index','','',1,0,'C','0','0','monitor:job:list','job','admin','2026-03-11 20:19:21','',NULL,'定时任务菜单'),(111,'数据监控',2,3,'druid','monitor/druid/index','','',1,0,'C','0','0','monitor:druid:list','druid','admin','2026-03-11 20:19:21','',NULL,'数据监控菜单'),(112,'服务监控',2,4,'server','monitor/server/index','','',1,0,'C','0','0','monitor:server:list','server','admin','2026-03-11 20:19:21','',NULL,'服务监控菜单'),(113,'缓存监控',2,5,'cache','monitor/cache/index','','',1,0,'C','0','0','monitor:cache:list','redis','admin','2026-03-11 20:19:21','',NULL,'缓存监控菜单'),(114,'缓存列表',2,6,'cacheList','monitor/cache/list','','',1,0,'C','0','0','monitor:cache:list','redis-list','admin','2026-03-11 20:19:21','',NULL,'缓存列表菜单'),(115,'表单构建',3,1,'build','tool/build/index','','',1,0,'C','0','0','tool:build:list','build','admin','2026-03-11 20:19:21','',NULL,'表单构建菜单'),(116,'代码生成',3,2,'gen','tool/gen/index','','',1,0,'C','0','0','tool:gen:list','code','admin','2026-03-11 20:19:21','',NULL,'代码生成菜单'),(117,'系统接口',3,3,'swagger','tool/swagger/index','','',1,0,'C','0','0','tool:swagger:list','swagger','admin','2026-03-11 20:19:21','',NULL,'系统接口菜单'),(500,'操作日志',108,1,'operlog','monitor/operlog/index','','',1,0,'C','0','0','monitor:operlog:list','form','admin','2026-03-11 20:19:21','',NULL,'操作日志菜单'),(501,'登录日志',108,2,'logininfor','monitor/logininfor/index','','',1,0,'C','0','0','monitor:logininfor:list','logininfor','admin','2026-03-11 20:19:21','',NULL,'登录日志菜单'),(1000,'用户查询',100,1,'','','','',1,0,'F','0','0','system:user:query','#','admin','2026-03-11 20:19:21','',NULL,''),(1001,'用户新增',100,2,'','','','',1,0,'F','0','0','system:user:add','#','admin','2026-03-11 20:19:21','',NULL,''),(1002,'用户修改',100,3,'','','','',1,0,'F','0','0','system:user:edit','#','admin','2026-03-11 20:19:21','',NULL,''),(1003,'用户删除',100,4,'','','','',1,0,'F','0','0','system:user:remove','#','admin','2026-03-11 20:19:21','',NULL,''),(1004,'用户导出',100,5,'','','','',1,0,'F','0','0','system:user:export','#','admin','2026-03-11 20:19:21','',NULL,''),(1005,'用户导入',100,6,'','','','',1,0,'F','0','0','system:user:import','#','admin','2026-03-11 20:19:22','',NULL,''),(1006,'重置密码',100,7,'','','','',1,0,'F','0','0','system:user:resetPwd','#','admin','2026-03-11 20:19:22','',NULL,''),(1007,'角色查询',101,1,'','','','',1,0,'F','0','0','system:role:query','#','admin','2026-03-11 20:19:22','',NULL,''),(1008,'角色新增',101,2,'','','','',1,0,'F','0','0','system:role:add','#','admin','2026-03-11 20:19:22','',NULL,''),(1009,'角色修改',101,3,'','','','',1,0,'F','0','0','system:role:edit','#','admin','2026-03-11 20:19:22','',NULL,''),(1010,'角色删除',101,4,'','','','',1,0,'F','0','0','system:role:remove','#','admin','2026-03-11 20:19:22','',NULL,''),(1011,'角色导出',101,5,'','','','',1,0,'F','0','0','system:role:export','#','admin','2026-03-11 20:19:22','',NULL,''),(1012,'菜单查询',102,1,'','','','',1,0,'F','0','0','system:menu:query','#','admin','2026-03-11 20:19:22','',NULL,''),(1013,'菜单新增',102,2,'','','','',1,0,'F','0','0','system:menu:add','#','admin','2026-03-11 20:19:22','',NULL,''),(1014,'菜单修改',102,3,'','','','',1,0,'F','0','0','system:menu:edit','#','admin','2026-03-11 20:19:22','',NULL,''),(1015,'菜单删除',102,4,'','','','',1,0,'F','0','0','system:menu:remove','#','admin','2026-03-11 20:19:22','',NULL,''),(1016,'部门查询',103,1,'','','','',1,0,'F','0','0','system:dept:query','#','admin','2026-03-11 20:19:22','',NULL,''),(1017,'部门新增',103,2,'','','','',1,0,'F','0','0','system:dept:add','#','admin','2026-03-11 20:19:22','',NULL,''),(1018,'部门修改',103,3,'','','','',1,0,'F','0','0','system:dept:edit','#','admin','2026-03-11 20:19:22','',NULL,''),(1019,'部门删除',103,4,'','','','',1,0,'F','0','0','system:dept:remove','#','admin','2026-03-11 20:19:22','',NULL,''),(1020,'岗位查询',104,1,'','','','',1,0,'F','0','0','system:post:query','#','admin','2026-03-11 20:19:22','',NULL,''),(1021,'岗位新增',104,2,'','','','',1,0,'F','0','0','system:post:add','#','admin','2026-03-11 20:19:22','',NULL,''),(1022,'岗位修改',104,3,'','','','',1,0,'F','0','0','system:post:edit','#','admin','2026-03-11 20:19:22','',NULL,''),(1023,'岗位删除',104,4,'','','','',1,0,'F','0','0','system:post:remove','#','admin','2026-03-11 20:19:22','',NULL,''),(1024,'岗位导出',104,5,'','','','',1,0,'F','0','0','system:post:export','#','admin','2026-03-11 20:19:22','',NULL,''),(1025,'字典查询',105,1,'#','','','',1,0,'F','0','0','system:dict:query','#','admin','2026-03-11 20:19:22','',NULL,''),(1026,'字典新增',105,2,'#','','','',1,0,'F','0','0','system:dict:add','#','admin','2026-03-11 20:19:22','',NULL,''),(1027,'字典修改',105,3,'#','','','',1,0,'F','0','0','system:dict:edit','#','admin','2026-03-11 20:19:22','',NULL,''),(1028,'字典删除',105,4,'#','','','',1,0,'F','0','0','system:dict:remove','#','admin','2026-03-11 20:19:22','',NULL,''),(1029,'字典导出',105,5,'#','','','',1,0,'F','0','0','system:dict:export','#','admin','2026-03-11 20:19:22','',NULL,''),(1030,'参数查询',106,1,'#','','','',1,0,'F','0','0','system:config:query','#','admin','2026-03-11 20:19:22','',NULL,''),(1031,'参数新增',106,2,'#','','','',1,0,'F','0','0','system:config:add','#','admin','2026-03-11 20:19:22','',NULL,''),(1032,'参数修改',106,3,'#','','','',1,0,'F','0','0','system:config:edit','#','admin','2026-03-11 20:19:22','',NULL,''),(1033,'参数删除',106,4,'#','','','',1,0,'F','0','0','system:config:remove','#','admin','2026-03-11 20:19:22','',NULL,''),(1034,'参数导出',106,5,'#','','','',1,0,'F','0','0','system:config:export','#','admin','2026-03-11 20:19:22','',NULL,''),(1035,'公告查询',107,1,'#','','','',1,0,'F','0','0','system:notice:query','#','admin','2026-03-11 20:19:22','',NULL,''),(1036,'公告新增',107,2,'#','','','',1,0,'F','0','0','system:notice:add','#','admin','2026-03-11 20:19:22','',NULL,''),(1037,'公告修改',107,3,'#','','','',1,0,'F','0','0','system:notice:edit','#','admin','2026-03-11 20:19:22','',NULL,''),(1038,'公告删除',107,4,'#','','','',1,0,'F','0','0','system:notice:remove','#','admin','2026-03-11 20:19:22','',NULL,''),(1039,'操作查询',500,1,'#','','','',1,0,'F','0','0','monitor:operlog:query','#','admin','2026-03-11 20:19:22','',NULL,''),(1040,'操作删除',500,2,'#','','','',1,0,'F','0','0','monitor:operlog:remove','#','admin','2026-03-11 20:19:22','',NULL,''),(1041,'日志导出',500,3,'#','','','',1,0,'F','0','0','monitor:operlog:export','#','admin','2026-03-11 20:19:22','',NULL,''),(1042,'登录查询',501,1,'#','','','',1,0,'F','0','0','monitor:logininfor:query','#','admin','2026-03-11 20:19:22','',NULL,''),(1043,'登录删除',501,2,'#','','','',1,0,'F','0','0','monitor:logininfor:remove','#','admin','2026-03-11 20:19:22','',NULL,''),(1044,'日志导出',501,3,'#','','','',1,0,'F','0','0','monitor:logininfor:export','#','admin','2026-03-11 20:19:22','',NULL,''),(1045,'账户解锁',501,4,'#','','','',1,0,'F','0','0','monitor:logininfor:unlock','#','admin','2026-03-11 20:19:22','',NULL,''),(1046,'在线查询',109,1,'#','','','',1,0,'F','0','0','monitor:online:query','#','admin','2026-03-11 20:19:22','',NULL,''),(1047,'批量强退',109,2,'#','','','',1,0,'F','0','0','monitor:online:batchLogout','#','admin','2026-03-11 20:19:22','',NULL,''),(1048,'单条强退',109,3,'#','','','',1,0,'F','0','0','monitor:online:forceLogout','#','admin','2026-03-11 20:19:22','',NULL,''),(1049,'任务查询',110,1,'#','','','',1,0,'F','0','0','monitor:job:query','#','admin','2026-03-11 20:19:22','',NULL,''),(1050,'任务新增',110,2,'#','','','',1,0,'F','0','0','monitor:job:add','#','admin','2026-03-11 20:19:22','',NULL,''),(1051,'任务修改',110,3,'#','','','',1,0,'F','0','0','monitor:job:edit','#','admin','2026-03-11 20:19:22','',NULL,''),(1052,'任务删除',110,4,'#','','','',1,0,'F','0','0','monitor:job:remove','#','admin','2026-03-11 20:19:22','',NULL,''),(1053,'状态修改',110,5,'#','','','',1,0,'F','0','0','monitor:job:changeStatus','#','admin','2026-03-11 20:19:22','',NULL,''),(1054,'任务导出',110,6,'#','','','',1,0,'F','0','0','monitor:job:export','#','admin','2026-03-11 20:19:22','',NULL,''),(1055,'生成查询',116,1,'#','','','',1,0,'F','0','0','tool:gen:query','#','admin','2026-03-11 20:19:22','',NULL,''),(1056,'生成修改',116,2,'#','','','',1,0,'F','0','0','tool:gen:edit','#','admin','2026-03-11 20:19:22','',NULL,''),(1057,'生成删除',116,3,'#','','','',1,0,'F','0','0','tool:gen:remove','#','admin','2026-03-11 20:19:22','',NULL,''),(1058,'导入代码',116,4,'#','','','',1,0,'F','0','0','tool:gen:import','#','admin','2026-03-11 20:19:22','',NULL,''),(1059,'预览代码',116,5,'#','','','',1,0,'F','0','0','tool:gen:preview','#','admin','2026-03-11 20:19:22','',NULL,''),(1060,'生成代码',116,6,'#','','','',1,0,'F','0','0','tool:gen:code','#','admin','2026-03-11 20:19:22','',NULL,''),(2000,'项目管理',0,2,'projects',NULL,NULL,'',1,0,'M','0','0','','form','admin','2026-03-13 11:46:48','admin','2026-03-15 11:29:03',''),(2002,'团队管理',2000,3,'member','project/member/index',NULL,'',1,0,'C','0','0','project:member:list','peoples','admin','2026-03-14 16:51:54','admin','2026-03-15 09:16:57',''),(2003,'项目列表',2000,1,'project','project/project/index',NULL,'',1,0,'C','0','0','project:project:list','bug','admin','2026-03-15 11:25:50','admin','2026-03-15 11:29:38','');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_notice`
--

DROP TABLE IF EXISTS `sys_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_notice` (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) NOT NULL COMMENT '公告标题',
  `notice_type` char(1) NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COMMENT='通知公告表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_notice`
--

LOCK TABLES `sys_notice` WRITE;
/*!40000 ALTER TABLE `sys_notice` DISABLE KEYS */;
INSERT INTO `sys_notice` VALUES (1,'温馨提醒：2018-07-01 若依新版本发布啦','2',_binary '新版本内容','0','admin','2026-03-11 20:19:22','',NULL,'管理员'),(2,'维护通知：2018-07-01 若依系统凌晨维护','1',_binary '维护内容','0','admin','2026-03-11 20:19:22','',NULL,'管理员'),(10,'dddd','2',NULL,'0','admin','2026-03-14 19:35:20','',NULL,NULL);
/*!40000 ALTER TABLE `sys_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_oper_log`
--

DROP TABLE IF EXISTS `sys_oper_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) DEFAULT '' COMMENT '模块标题',
  `business_type` int DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) DEFAULT '' COMMENT '请求方式',
  `operator_type` int DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) DEFAULT '' COMMENT '返回参数',
  `status` int DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint DEFAULT '0' COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`),
  KEY `idx_sys_oper_log_bt` (`business_type`),
  KEY `idx_sys_oper_log_s` (`status`),
  KEY `idx_sys_oper_log_ot` (`oper_time`)
) ENGINE=InnoDB AUTO_INCREMENT=222 DEFAULT CHARSET=utf8mb3 COMMENT='操作日志记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oper_log`
--

LOCK TABLES `sys_oper_log` WRITE;
/*!40000 ALTER TABLE `sys_oper_log` DISABLE KEYS */;
INSERT INTO `sys_oper_log` VALUES (100,'部门管理',2,'com.ruoyi.web.controller.system.SysDeptController.edit()','PUT',1,'admin','研发部门','/system/dept','127.0.0.1','内网IP','{\"ancestors\":\"0\",\"children\":[],\"deptId\":100,\"deptName\":\"X科技\",\"email\":\"ry@qq.com\",\"leader\":\"李先生\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-13 11:26:15',28),(101,'部门管理',2,'com.ruoyi.web.controller.system.SysDeptController.edit()','PUT',1,'admin','研发部门','/system/dept','127.0.0.1','内网IP','{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"研发1部门\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"parentName\":\"深圳总公司\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-13 11:27:10',31),(102,'部门管理',1,'com.ruoyi.web.controller.system.SysDeptController.add()','POST',1,'admin','研发部门','/system/dept','127.0.0.1','内网IP','{\"ancestors\":\"0,100,101\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"研发2部\",\"orderNum\":2,\"params\":{},\"parentId\":101,\"status\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-13 11:27:35',19),(103,'部门管理',2,'com.ruoyi.web.controller.system.SysDeptController.edit()','PUT',1,'admin','研发部门','/system/dept','127.0.0.1','内网IP','{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":104,\"deptName\":\"市场部门\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":6,\"params\":{},\"parentId\":101,\"parentName\":\"深圳总公司\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-13 11:27:48',20),(104,'部门管理',2,'com.ruoyi.web.controller.system.SysDeptController.edit()','PUT',1,'admin','研发部门','/system/dept','127.0.0.1','内网IP','{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"研发1部\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"parentName\":\"深圳总公司\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-13 11:27:57',21),(105,'个人信息',2,'com.ruoyi.web.controller.system.SysProfileController.updateProfile()','PUT',1,'admin','研发部门','/system/user/profile','127.0.0.1','内网IP','{\"admin\":false,\"email\":\"ry@163.com\",\"nickName\":\"李先生\",\"params\":{},\"phonenumber\":\"15888888888\",\"sex\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-13 11:33:43',49),(106,'用户头像',2,'com.ruoyi.web.controller.system.SysProfileController.avatar()','POST',1,'admin','研发部门','/system/user/profile/avatar','127.0.0.1','内网IP','','{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2026/03/13/1c6b3de44c7c4697acb2746ccaaa8483.jpg\",\"code\":200}',0,NULL,'2026-03-13 11:34:53',101),(107,'用户头像',2,'com.ruoyi.web.controller.system.SysProfileController.avatar()','POST',1,'admin','研发部门','/system/user/profile/avatar','127.0.0.1','内网IP','','{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2026/03/13/bd9b1a8087694a4a8e007f64f18a5bb7.jpg\",\"code\":200}',0,NULL,'2026-03-13 11:35:18',57),(108,'用户管理',1,'com.ruoyi.web.controller.system.SysUserController.add()','POST',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"deptId\":103,\"nickName\":\"橙子\",\"params\":{},\"postIds\":[],\"roleIds\":[],\"status\":\"0\",\"userId\":100,\"userName\":\"chengzi\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-13 11:39:08',88),(109,'用户管理',1,'com.ruoyi.web.controller.system.SysUserController.add()','POST',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"deptId\":200,\"nickName\":\"东东\",\"params\":{},\"postIds\":[],\"roleIds\":[],\"status\":\"0\",\"userId\":101,\"userName\":\"dong\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-13 11:39:45',79),(110,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"form\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"项目管理\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"/\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-13 11:46:48',21),(111,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2026-03-11 20:19:21\",\"icon\":\"monitor\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2,\"menuName\":\"系统监控\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"monitor\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-13 11:47:12',11),(112,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2026-03-13 11:46:48\",\"icon\":\"form\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"项目管理\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"projectSys\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 10:14:34',30),(113,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2026-03-11 20:19:21\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":9,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 10:22:32',58),(114,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2026-03-13 11:46:48\",\"icon\":\"form\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"项目管理\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"project\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 15:47:54',42),(115,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"list\",\"perms\":\"project:\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 15:50:35',12),(116,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"project/prolist/index\",\"createTime\":\"2026-03-14 15:50:35\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"prolist\",\"perms\":\"project:prolist:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 15:52:09',12),(117,'代码生成',6,'com.ruoyi.generator.controller.GenController.importTableSave()','POST',1,'admin','研发1部','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"project\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 15:55:13',182),(118,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发1部','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"project\",\"className\":\"Project\",\"columns\":[{\"capJavaField\":\"ProjectId\",\"columnComment\":\"项目ID\",\"columnId\":1,\"columnName\":\"project_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"projectId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ProjectName\",\"columnComment\":\"项目名称\",\"columnId\":2,\"columnName\":\"project_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"projectName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ProjectCode\",\"columnComment\":\"项目编码（唯一）\",\"columnId\":3,\"columnName\":\"project_code\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"projectCode\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Description\",\"columnComment\":\"项目描述\",\"columnId\":4,\"columnName\":\"description\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\"','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 15:56:31',114),(119,'代码生成',2,'com.ruoyi.generator.controller.GenController.synchDb()','GET',1,'admin','研发1部','/tool/gen/synchDb/project','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 16:25:37',58),(120,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发1部','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"project\",\"className\":\"Project\",\"columns\":[{\"capJavaField\":\"ProjectId\",\"columnComment\":\"项目ID\",\"columnId\":1,\"columnName\":\"project_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"projectId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 16:25:37\",\"usableColumn\":false},{\"capJavaField\":\"ProjectName\",\"columnComment\":\"项目名称\",\"columnId\":2,\"columnName\":\"project_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"projectName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 16:25:37\",\"usableColumn\":false},{\"capJavaField\":\"ProjectCode\",\"columnComment\":\"项目编码（唯一）\",\"columnId\":3,\"columnName\":\"project_code\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"projectCode\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 16:25:37\",\"usableColumn\":false},{\"capJavaField\":\"Description\",\"columnComment\":\"项目描述\",\"columnId\":4,\"columnName\":\"description\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlTy','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 16:29:00',47),(121,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发1部','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"project\",\"className\":\"Project\",\"columns\":[{\"capJavaField\":\"ProjectId\",\"columnComment\":\"项目ID\",\"columnId\":1,\"columnName\":\"project_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"projectId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 16:29:00\",\"usableColumn\":false},{\"capJavaField\":\"ProjectName\",\"columnComment\":\"项目名称\",\"columnId\":2,\"columnName\":\"project_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"projectName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 16:29:00\",\"usableColumn\":false},{\"capJavaField\":\"ProjectCode\",\"columnComment\":\"项目编码（唯一）\",\"columnId\":3,\"columnName\":\"project_code\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"projectCode\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 16:29:00\",\"usableColumn\":false},{\"capJavaField\":\"Description\",\"columnComment\":\"项目描述\",\"columnId\":4,\"columnName\":\"description\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlTy','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 16:30:38',49),(122,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"团队管理\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2000,\"path\":\"1\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 16:51:54',11),(123,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"project/member/index\",\"createTime\":\"2026-03-14 16:51:54\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"团队管理\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2000,\"path\":\"member\",\"perms\":\"project/member/index\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 16:55:33',44),(124,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"project:member:list\",\"createTime\":\"2026-03-14 16:51:54\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"团队管理\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2000,\"path\":\"member\",\"perms\":\"project/member/index\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 16:55:57',8),(125,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"project/member/index\",\"createTime\":\"2026-03-14 16:51:54\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"团队管理\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2000,\"path\":\"member\",\"perms\":\"project:member:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 16:56:21',7),(126,'代码生成',6,'com.ruoyi.generator.controller.GenController.importTableSave()','POST',1,'admin','研发1部','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"project_member\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 16:57:01',61),(127,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发1部','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"member\",\"className\":\"ProjectMember\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"关联ID\",\"columnId\":25,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ProjectId\",\"columnComment\":\"项目ID\",\"columnId\":26,\"columnName\":\"project_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"projectId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户ID（关联sys_user）\",\"columnId\":27,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"0\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ProjectRole\",\"columnComment\":\"项目角色（owner:负责人，developer:开发，tester:测试，visitor:访客）\",\"columnId\":28,\"columnName\":\"project_role\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 16:58:58',16),(128,'代码生成',2,'com.ruoyi.generator.controller.GenController.synchDb()','GET',1,'admin','研发1部','/tool/gen/synchDb/project_member','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 17:04:31',24),(129,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发1部','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"member\",\"className\":\"ProjectMember\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"关联ID\",\"columnId\":25,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 17:04:31\",\"usableColumn\":false},{\"capJavaField\":\"ProjectId\",\"columnComment\":\"项目ID\",\"columnId\":26,\"columnName\":\"project_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"projectId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 17:04:31\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户ID（关联sys_user）\",\"columnId\":27,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 17:04:31\",\"usableColumn\":false},{\"capJavaField\":\"ProjectRole\",\"columnComment\":\"项目角色（owner:负责人，developer:开发，tester:测试，visitor:访客）\",\"columnId\":28,\"columnName\":\"project_role\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":true,\"htmlT','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 17:07:21',19),(130,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发1部','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"member\",\"className\":\"ProjectMember\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"关联ID\",\"columnId\":25,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 17:07:21\",\"usableColumn\":false},{\"capJavaField\":\"ProjectId\",\"columnComment\":\"项目ID\",\"columnId\":26,\"columnName\":\"project_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"projectId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 17:07:21\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户ID（关联sys_user）\",\"columnId\":27,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 17:07:21\",\"usableColumn\":false},{\"capJavaField\":\"ProjectRole\",\"columnComment\":\"项目角色（owner:负责人，developer:开发，tester:测试，visitor:访客）\",\"columnId\":28,\"columnName\":\"project_role\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":true,\"htmlT','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 17:21:38',23),(131,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发1部','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"member\",\"className\":\"ProjectMember\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"关联ID\",\"columnId\":25,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 17:21:38\",\"usableColumn\":false},{\"capJavaField\":\"ProjectId\",\"columnComment\":\"项目ID\",\"columnId\":26,\"columnName\":\"project_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"projectId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 17:21:38\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户ID（关联sys_user）\",\"columnId\":27,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 17:21:38\",\"usableColumn\":false},{\"capJavaField\":\"ProjectRole\",\"columnComment\":\"项目角色（owner:负责人，developer:开发，tester:测试，visitor:访客）\",\"columnId\":28,\"columnName\":\"project_role\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":true,\"htmlT','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 17:27:16',26),(132,'通知公告',1,'com.ruoyi.web.controller.system.SysNoticeController.add()','POST',1,'admin','研发1部','/system/notice','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"noticeTitle\":\"dddd\",\"noticeType\":\"2\",\"params\":{},\"status\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 19:35:20',20),(133,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发1部','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"member\",\"className\":\"ProjectMember\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"关联ID\",\"columnId\":25,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 17:27:16\",\"usableColumn\":false},{\"capJavaField\":\"ProjectId\",\"columnComment\":\"项目ID\",\"columnId\":26,\"columnName\":\"project_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"projectId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 17:27:16\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户ID（关联sys_user）\",\"columnId\":27,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 17:27:16\",\"usableColumn\":false},{\"capJavaField\":\"ProjectRole\",\"columnComment\":\"项目角色（owner:负责人，developer:开发，tester:测试，visitor:访客）\",\"columnId\":28,\"columnName\":\"project_role\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":true,\"htmlT','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 19:56:09',35),(134,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发1部','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"member\",\"className\":\"ProjectMember\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"关联ID\",\"columnId\":25,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 19:56:09\",\"usableColumn\":false},{\"capJavaField\":\"ProjectId\",\"columnComment\":\"项目ID\",\"columnId\":26,\"columnName\":\"project_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"projectId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 19:56:09\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户ID（关联sys_user）\",\"columnId\":27,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 19:56:09\",\"usableColumn\":false},{\"capJavaField\":\"ProjectRole\",\"columnComment\":\"项目角色（owner:负责人，developer:开发，tester:测试，visitor:访客）\",\"columnId\":28,\"columnName\":\"project_role\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":true,\"htmlT','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 19:56:43',22),(135,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发1部','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"project_member\"}',NULL,0,NULL,'2026-03-14 19:56:54',51),(136,'项目成员',1,'com.ruoyi.project.controller.ProjectMemberController.add()','POST',1,'admin','研发1部','/project/member','127.0.0.1','内网IP','{\"createTime\":\"2026-03-14 20:29:57\",\"params\":{},\"projectId\":1,\"userId\":2} ',NULL,1,'\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`projectflow_manager`.`project_member`, CONSTRAINT `fk_pm_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE)\r\n### The error may exist in file [E:\\Project\\ProjectFlow_Manager\\ruoyi-project\\target\\classes\\mapper\\project\\ProjectMemberMapper.xml]\r\n### The error may involve com.ruoyi.project.mapper.ProjectMemberMapper.insertProjectMember-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into project_member          ( project_id,             user_id,                                                    create_time )           values ( ?,             ?,                                                    ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`projectflow_manager`.`project_member`, CONSTRAINT `fk_pm_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE)\n; Cannot add or update a child row: a foreign key constraint fails (`projectflow_manager`.`project_member`, CONSTRAINT `fk_pm_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE)','2026-03-14 20:29:57',300),(137,'项目成员',1,'com.ruoyi.project.controller.ProjectMemberController.add()','POST',1,'admin','研发1部','/project/member','127.0.0.1','内网IP','{\"createTime\":\"2026-03-14 20:30:07\",\"params\":{},\"projectId\":1,\"userId\":2} ',NULL,1,'\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`projectflow_manager`.`project_member`, CONSTRAINT `fk_pm_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE)\r\n### The error may exist in file [E:\\Project\\ProjectFlow_Manager\\ruoyi-project\\target\\classes\\mapper\\project\\ProjectMemberMapper.xml]\r\n### The error may involve com.ruoyi.project.mapper.ProjectMemberMapper.insertProjectMember-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into project_member          ( project_id,             user_id,                                                    create_time )           values ( ?,             ?,                                                    ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`projectflow_manager`.`project_member`, CONSTRAINT `fk_pm_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE)\n; Cannot add or update a child row: a foreign key constraint fails (`projectflow_manager`.`project_member`, CONSTRAINT `fk_pm_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE)','2026-03-14 20:30:07',6),(138,'代码生成',6,'com.ruoyi.generator.controller.GenController.importTableSave()','POST',1,'admin','研发1部','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"project_module\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 20:34:01',85),(139,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发1部','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"module\",\"className\":\"ProjectModule\",\"columns\":[{\"capJavaField\":\"ModuleId\",\"columnComment\":\"模块ID\",\"columnId\":35,\"columnName\":\"module_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 20:34:01\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"moduleId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ProjectId\",\"columnComment\":\"项目ID\",\"columnId\":36,\"columnName\":\"project_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 20:34:01\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"projectId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ModuleName\",\"columnComment\":\"模块名称\",\"columnId\":37,\"columnName\":\"module_name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 20:34:01\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"moduleName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ParentId\",\"columnComment\":\"父模块ID（支持树形结构）\",\"columnId\":38,\"columnName\":\"parent_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 20:34:01\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\"','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 20:35:43',53),(140,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发1部','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"project\",\"className\":\"Project\",\"columns\":[{\"capJavaField\":\"ProjectId\",\"columnComment\":\"项目ID\",\"columnId\":1,\"columnName\":\"project_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"projectId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 16:30:38\",\"usableColumn\":false},{\"capJavaField\":\"ProjectName\",\"columnComment\":\"项目名称\",\"columnId\":2,\"columnName\":\"project_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"projectName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 16:30:38\",\"usableColumn\":false},{\"capJavaField\":\"ProjectCode\",\"columnComment\":\"项目编码（唯一）\",\"columnId\":3,\"columnName\":\"project_code\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"projectCode\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 16:30:38\",\"usableColumn\":false},{\"capJavaField\":\"Description\",\"columnComment\":\"项目描述\",\"columnId\":4,\"columnName\":\"description\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlTy','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 20:59:49',96),(141,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发1部','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"project\",\"className\":\"Project\",\"columns\":[{\"capJavaField\":\"ProjectId\",\"columnComment\":\"项目ID\",\"columnId\":1,\"columnName\":\"project_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"projectId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 20:59:49\",\"usableColumn\":false},{\"capJavaField\":\"ProjectName\",\"columnComment\":\"项目名称\",\"columnId\":2,\"columnName\":\"project_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"projectName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 20:59:49\",\"usableColumn\":false},{\"capJavaField\":\"ProjectCode\",\"columnComment\":\"项目编码（唯一）\",\"columnId\":3,\"columnName\":\"project_code\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"projectCode\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 20:59:49\",\"usableColumn\":false},{\"capJavaField\":\"Description\",\"columnComment\":\"项目描述\",\"columnId\":4,\"columnName\":\"description\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlTy','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 21:00:48',54),(142,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发1部','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"project\",\"className\":\"Project\",\"columns\":[{\"capJavaField\":\"ProjectId\",\"columnComment\":\"项目ID\",\"columnId\":1,\"columnName\":\"project_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"projectId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 21:00:48\",\"usableColumn\":false},{\"capJavaField\":\"ProjectName\",\"columnComment\":\"项目名称\",\"columnId\":2,\"columnName\":\"project_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"projectName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 21:00:48\",\"usableColumn\":false},{\"capJavaField\":\"ProjectCode\",\"columnComment\":\"项目编码（唯一）\",\"columnId\":3,\"columnName\":\"project_code\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"projectCode\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 21:00:48\",\"usableColumn\":false},{\"capJavaField\":\"Description\",\"columnComment\":\"项目描述\",\"columnId\":4,\"columnName\":\"description\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlTy','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 21:05:39',41),(143,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发1部','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"project\",\"className\":\"Project\",\"columns\":[{\"capJavaField\":\"ProjectId\",\"columnComment\":\"项目ID\",\"columnId\":1,\"columnName\":\"project_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"projectId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 21:05:39\",\"usableColumn\":false},{\"capJavaField\":\"ProjectName\",\"columnComment\":\"项目名称\",\"columnId\":2,\"columnName\":\"project_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"projectName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 21:05:39\",\"usableColumn\":false},{\"capJavaField\":\"ProjectCode\",\"columnComment\":\"项目编码（唯一）\",\"columnId\":3,\"columnName\":\"project_code\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"projectCode\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 21:05:39\",\"usableColumn\":false},{\"capJavaField\":\"Description\",\"columnComment\":\"项目描述\",\"columnId\":4,\"columnName\":\"description\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlTy','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 21:14:43',49),(144,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发1部','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"member\",\"className\":\"ProjectMember\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"关联ID\",\"columnId\":25,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 19:56:43\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户ID（关联sys_user）\",\"columnId\":27,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 19:56:43\",\"usableColumn\":false},{\"capJavaField\":\"ProjectId\",\"columnComment\":\"项目ID\",\"columnId\":26,\"columnName\":\"project_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"projectId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 19:56:43\",\"usableColumn\":false},{\"capJavaField\":\"ProjectRole\",\"columnComment\":\"项目角色（owner:负责人，developer:开发，tester:测试，visitor:访客）\",\"columnId\":28,\"columnName\":\"project_role\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":true,\"htmlT','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 21:15:19',28),(145,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发1部','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"member\",\"className\":\"ProjectMember\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"关联ID\",\"columnId\":25,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 21:15:19\",\"usableColumn\":false},{\"capJavaField\":\"ProjectId\",\"columnComment\":\"项目ID\",\"columnId\":26,\"columnName\":\"project_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"projectId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 21:15:19\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户ID（关联sys_user）\",\"columnId\":27,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 21:15:19\",\"usableColumn\":false},{\"capJavaField\":\"ProjectRole\",\"columnComment\":\"项目角色（owner:负责人，developer:开发，tester:测试，visitor:访客）\",\"columnId\":28,\"columnName\":\"project_role\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":true,\"htmlT','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 21:15:55',26),(146,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发1部','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"project\",\"className\":\"Project\",\"columns\":[{\"capJavaField\":\"ProjectId\",\"columnComment\":\"项目ID\",\"columnId\":1,\"columnName\":\"project_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"projectId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 21:14:43\",\"usableColumn\":false},{\"capJavaField\":\"ProjectName\",\"columnComment\":\"项目名称\",\"columnId\":2,\"columnName\":\"project_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"projectName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 21:14:43\",\"usableColumn\":false},{\"capJavaField\":\"ProjectCode\",\"columnComment\":\"项目编码（唯一）\",\"columnId\":3,\"columnName\":\"project_code\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"projectCode\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 21:14:43\",\"usableColumn\":false},{\"capJavaField\":\"Description\",\"columnComment\":\"项目描述\",\"columnId\":4,\"columnName\":\"description\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlTy','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 21:16:27',40),(147,'代码生成',2,'com.ruoyi.generator.controller.GenController.synchDb()','GET',1,'admin','研发1部','/tool/gen/synchDb/project','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 21:16:46',85),(148,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发1部','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"project\",\"className\":\"Project\",\"columns\":[{\"capJavaField\":\"ProjectId\",\"columnComment\":\"项目ID\",\"columnId\":1,\"columnName\":\"project_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"projectId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 21:16:46\",\"usableColumn\":false},{\"capJavaField\":\"ProjectName\",\"columnComment\":\"项目名称\",\"columnId\":2,\"columnName\":\"project_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"projectName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 21:16:46\",\"usableColumn\":false},{\"capJavaField\":\"ProjectCode\",\"columnComment\":\"项目编码（唯一）\",\"columnId\":3,\"columnName\":\"project_code\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"projectCode\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 21:16:46\",\"usableColumn\":false},{\"capJavaField\":\"Description\",\"columnComment\":\"项目描述\",\"columnId\":4,\"columnName\":\"description\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlTy','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 21:19:44',71),(149,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发1部','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"project\",\"className\":\"Project\",\"columns\":[{\"capJavaField\":\"ProjectId\",\"columnComment\":\"项目ID\",\"columnId\":1,\"columnName\":\"project_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"projectId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 21:19:44\",\"usableColumn\":false},{\"capJavaField\":\"ProjectName\",\"columnComment\":\"项目名称\",\"columnId\":2,\"columnName\":\"project_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"projectName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 21:19:44\",\"usableColumn\":false},{\"capJavaField\":\"ProjectCode\",\"columnComment\":\"项目编码（唯一）\",\"columnId\":3,\"columnName\":\"project_code\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"0\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"projectCode\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 21:19:44\",\"usableColumn\":false},{\"capJavaField\":\"Description\",\"columnComment\":\"项目描述\",\"columnId\":4,\"columnName\":\"description\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlT','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 21:23:19',43),(150,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发1部','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"project\",\"className\":\"Project\",\"columns\":[{\"capJavaField\":\"ProjectId\",\"columnComment\":\"项目ID\",\"columnId\":1,\"columnName\":\"project_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"projectId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 21:23:19\",\"usableColumn\":false},{\"capJavaField\":\"ProjectName\",\"columnComment\":\"项目名称\",\"columnId\":2,\"columnName\":\"project_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"projectName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 21:23:19\",\"usableColumn\":false},{\"capJavaField\":\"ProjectCode\",\"columnComment\":\"项目编码（唯一）\",\"columnId\":3,\"columnName\":\"project_code\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"0\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"projectCode\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 21:23:19\",\"usableColumn\":false},{\"capJavaField\":\"Description\",\"columnComment\":\"项目描述\",\"columnId\":4,\"columnName\":\"description\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlT','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 21:24:15',32),(151,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发1部','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"project\"}',NULL,0,NULL,'2026-03-14 21:24:20',82),(152,'项目成员',1,'com.ruoyi.project.controller.ProjectMemberController.add()','POST',1,'admin','研发1部','/project/member','127.0.0.1','内网IP','{\"createTime\":\"2026-03-14 21:30:27\",\"params\":{},\"projectId\":2,\"userId\":1} ',NULL,1,'\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`projectflow_manager`.`project_member`, CONSTRAINT `fk_pm_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE)\r\n### The error may exist in file [E:\\Project\\ProjectFlow_Manager\\ruoyi-project\\target\\classes\\mapper\\project\\ProjectMemberMapper.xml]\r\n### The error may involve com.ruoyi.project.mapper.ProjectMemberMapper.insertProjectMember-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into project_member          ( project_id,             user_id,                                                    create_time )           values ( ?,             ?,                                                    ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`projectflow_manager`.`project_member`, CONSTRAINT `fk_pm_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE)\n; Cannot add or update a child row: a foreign key constraint fails (`projectflow_manager`.`project_member`, CONSTRAINT `fk_pm_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE)','2026-03-14 21:30:27',302),(153,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"project/project/index\",\"createTime\":\"2026-03-14 15:50:35\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"project\",\"perms\":\"project:project:list\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"修改菜单\'项目列表\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-14 21:35:22',19),(154,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"project/project/index\",\"createTime\":\"2026-03-14 15:50:35\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"project\",\"perms\":\"project:project:list\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"修改菜单\'项目列表\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-14 21:35:25',8),(155,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"project/project/index\",\"createTime\":\"2026-03-14 15:50:35\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"project\",\"perms\":\"project:project:list\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"修改菜单\'项目列表\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-14 21:35:29',7),(156,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"project/project/index\",\"createTime\":\"2026-03-14 15:50:35\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"project\",\"perms\":\"project:project:list\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"修改菜单\'项目列表\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-14 21:35:32',7),(157,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2026-03-13 11:46:48\",\"icon\":\"form\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"项目管理\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"projects\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 21:36:25',16),(158,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"projects/member/index\",\"createTime\":\"2026-03-14 16:51:54\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"团队管理\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2000,\"path\":\"member\",\"perms\":\"projects:member:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-14 21:36:46',12),(159,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"projects/project/index\",\"createTime\":\"2026-03-14 15:50:35\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"projects\",\"perms\":\"projects:project:list\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"修改菜单\'项目列表\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-14 21:37:45',6),(160,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"projects/project/index\",\"createTime\":\"2026-03-14 15:50:35\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"projects\",\"perms\":\"projects:project:list\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"修改菜单\'项目列表\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-14 21:37:47',5),(161,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"projects/project/index\",\"createTime\":\"2026-03-14 15:50:35\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"projects\",\"perms\":\"projects:project:list\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"修改菜单\'项目列表\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-14 21:37:50',6),(162,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"projects/project/index\",\"createTime\":\"2026-03-14 15:50:35\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"projects\",\"perms\":\"projects:project:list\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"修改菜单\'项目列表\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-14 21:37:52',8),(163,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"projects/project/index\",\"createTime\":\"2026-03-14 15:50:35\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"projects\",\"perms\":\"projects:project:list\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"修改菜单\'项目列表\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-14 21:41:07',10),(164,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2026-03-13 11:46:48\",\"icon\":\"form\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"项目管理\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"project\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 09:16:50',46),(165,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"project/member/index\",\"createTime\":\"2026-03-14 16:51:54\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"团队管理\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2000,\"path\":\"member\",\"perms\":\"project:member:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 09:16:57',13),(166,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"project/prolist/index\",\"createTime\":\"2026-03-14 15:50:35\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"project\",\"perms\":\"project:prolist:list\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"修改菜单\'项目列表\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-15 09:17:12',5),(167,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"project/prolist/index\",\"createTime\":\"2026-03-14 15:50:35\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"project\",\"perms\":\"project:prolist:list\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"修改菜单\'项目列表\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-15 09:17:15',8),(168,'菜单管理',3,'com.ruoyi.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发1部','/system/menu/2001','127.0.0.1','内网IP','2001 ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 09:17:42',112),(169,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"project:prolist/index\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"project\",\"perms\":\"project:prolist:list\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"新增菜单\'项目列表\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-15 09:18:55',6),(170,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"project:prolist/index\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"project\",\"perms\":\"project:prolist:list\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"新增菜单\'项目列表\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-15 09:18:57',7),(171,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"project:prolist/index\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"project\",\"perms\":\"project:prolist:list\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"新增菜单\'项目列表\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-15 09:18:59',6),(172,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"project:prolist/index\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"project\",\"perms\":\"project:prolist:list\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"新增菜单\'项目列表\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-15 09:19:00',7),(173,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"project:prolist/index\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"project\",\"perms\":\"project:prolist:list\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"新增菜单\'项目列表\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-15 09:19:03',5),(174,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"project:prolist/index\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"project\",\"perms\":\"project:prolist:list\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"新增菜单\'项目列表\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-15 09:19:05',6),(175,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"1\",\"createBy\":\"admin\",\"icon\":\"bug\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"1\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 11:25:50',49),(176,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"project/project/index\",\"createTime\":\"2026-03-15 11:25:50\",\"icon\":\"bug\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"1\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 11:26:12',17),(177,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"project/project/index\",\"createTime\":\"2026-03-15 11:25:50\",\"icon\":\"bug\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"project:project:list\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 11:26:45',10),(178,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"project/project/index\",\"createTime\":\"2026-03-15 11:25:50\",\"icon\":\"bug\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"project\",\"perms\":\"project:project:list\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"修改菜单\'项目列表\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-15 11:27:26',17),(179,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"project/project/index\",\"createTime\":\"2026-03-15 11:25:50\",\"icon\":\"bug\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"project\",\"perms\":\"project:project:list\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"修改菜单\'项目列表\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-15 11:27:31',6),(180,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"project/project/index\",\"createTime\":\"2026-03-15 11:25:50\",\"icon\":\"bug\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"project\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"修改菜单\'项目列表\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-15 11:28:25',7),(181,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"project/project/index\",\"createTime\":\"2026-03-15 11:25:50\",\"icon\":\"bug\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"project\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"} ','{\"msg\":\"修改菜单\'项目列表\'失败，路由名称或地址已存在\",\"code\":500}',0,NULL,'2026-03-15 11:28:27',8),(182,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"project/project/index\",\"createTime\":\"2026-03-15 11:25:50\",\"icon\":\"bug\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"2\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 11:28:30',10),(183,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"project/project/index\",\"createTime\":\"2026-03-15 11:25:50\",\"icon\":\"bug\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"1\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 11:28:36',47),(184,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2026-03-13 11:46:48\",\"icon\":\"form\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"项目管理\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"projects\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 11:29:03',10),(185,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发1部','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"project/project/index\",\"createTime\":\"2026-03-15 11:25:50\",\"icon\":\"bug\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"project\",\"perms\":\"project:project:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 11:29:38',11),(186,'项目成员',1,'com.ruoyi.project.controller.ProjectMemberController.add()','POST',1,'admin','研发1部','/project/member','127.0.0.1','内网IP','{\"createTime\":\"2026-03-15 11:34:38\",\"params\":{},\"projectId\":1,\"userId\":1} ',NULL,1,'\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`projectflow_manager`.`project_member`, CONSTRAINT `fk_pm_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE)\r\n### The error may exist in file [E:\\Project\\ProjectFlow_Manager\\ruoyi-project\\target\\classes\\mapper\\project\\ProjectMemberMapper.xml]\r\n### The error may involve com.ruoyi.project.mapper.ProjectMemberMapper.insertProjectMember-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into project_member          ( project_id,             user_id,                                                    create_time )           values ( ?,             ?,                                                    ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`projectflow_manager`.`project_member`, CONSTRAINT `fk_pm_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE)\n; Cannot add or update a child row: a foreign key constraint fails (`projectflow_manager`.`project_member`, CONSTRAINT `fk_pm_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE)','2026-03-15 11:34:38',246),(187,'项目成员',1,'com.ruoyi.project.controller.ProjectMemberController.add()','POST',1,'admin','研发1部','/project/member','127.0.0.1','内网IP','{\"createTime\":\"2026-03-15 11:57:21\",\"id\":5,\"params\":{},\"projectId\":1,\"userId\":1} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 11:57:21',6),(188,'项目',1,'com.ruoyi.project.controller.ProjectController.add()','POST',1,'admin','研发1部','/project/project','127.0.0.1','内网IP','{\"createTime\":\"2026-03-15 17:05:37\",\"description\":\"飞往火星\",\"params\":{},\"priority\":2,\"projectId\":2,\"projectModuleList\":[{\"createBy\":\"我\",\"moduleName\":\"螺旋桨\",\"params\":{},\"parentId\":1,\"projectId\":2}],\"projectName\":\"超级大飞机\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 17:05:37',219),(189,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发1部','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"project\",\"className\":\"Project\",\"columns\":[{\"capJavaField\":\"ProjectId\",\"columnComment\":\"项目ID\",\"columnId\":1,\"columnName\":\"project_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"projectId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 21:24:15\",\"usableColumn\":false},{\"capJavaField\":\"ProjectName\",\"columnComment\":\"项目名称\",\"columnId\":2,\"columnName\":\"project_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"projectName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 21:24:15\",\"usableColumn\":false},{\"capJavaField\":\"ProjectCode\",\"columnComment\":\"项目编码（唯一）\",\"columnId\":3,\"columnName\":\"project_code\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"0\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"projectCode\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 21:24:15\",\"usableColumn\":false},{\"capJavaField\":\"Description\",\"columnComment\":\"项目描述\",\"columnId\":4,\"columnName\":\"description\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlT','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 17:07:20',71),(190,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发1部','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"project\",\"className\":\"Project\",\"columns\":[{\"capJavaField\":\"ProjectId\",\"columnComment\":\"项目ID\",\"columnId\":1,\"columnName\":\"project_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"projectId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-15 17:07:20\",\"usableColumn\":false},{\"capJavaField\":\"ProjectName\",\"columnComment\":\"项目名称\",\"columnId\":2,\"columnName\":\"project_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"projectName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-15 17:07:20\",\"usableColumn\":false},{\"capJavaField\":\"ProjectCode\",\"columnComment\":\"项目编码（唯一）\",\"columnId\":3,\"columnName\":\"project_code\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"0\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"projectCode\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-15 17:07:20\",\"usableColumn\":false},{\"capJavaField\":\"Description\",\"columnComment\":\"项目描述\",\"columnId\":4,\"columnName\":\"description\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 15:55:13\",\"dictType\":\"\",\"edit\":true,\"htmlT','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 17:11:11',60),(191,'项目',2,'com.ruoyi.project.controller.ProjectController.edit()','PUT',1,'admin','研发1部','/project/project','127.0.0.1','内网IP','{\"boardStyle\":1,\"budget\":9,\"colWidth\":264,\"createBy\":\"me\",\"createTime\":\"2026-03-15 11:49:41\",\"delFlag\":0,\"description\":\"把杂碎炸飞天\",\"displayCards\":0,\"endDate\":\"2026-03-16\",\"fluidBoard\":\"0\",\"investment\":10,\"ownerId\":1,\"ownerName\":\"茄子大大\",\"params\":{},\"priority\":3,\"progress\":20,\"projectCode\":\"BBB\",\"projectId\":1,\"projectModuleList\":[],\"projectName\":\"无敌原子弹\",\"realEndDate\":\"2026-03-18\",\"realStartDate\":\"2026-03-17\",\"requirementCount\":0,\"startDate\":\"2026-03-15\",\"status\":0,\"updateBy\":\"\",\"updateTime\":\"2026-03-15 17:28:34\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 17:28:34',42),(192,'项目',2,'com.ruoyi.project.controller.ProjectController.edit()','PUT',1,'admin','研发1部','/project/project','127.0.0.1','内网IP','{\"boardStyle\":1,\"budget\":9,\"colWidth\":264,\"createBy\":\"me\",\"createTime\":\"2026-03-15 11:49:41\",\"delFlag\":0,\"description\":\"把杂碎炸飞天\",\"displayCards\":0,\"endDate\":\"2026-03-16\",\"fluidBoard\":\"0\",\"investment\":10,\"ownerId\":1,\"ownerName\":\"茄子大大\",\"params\":{},\"priority\":3,\"progress\":20,\"projectCode\":\"BBB\",\"projectId\":1,\"projectModuleList\":[],\"projectName\":\"无敌原子弹\",\"realEndDate\":\"2026-03-18\",\"realStartDate\":\"2026-03-17\",\"requirementCount\":0,\"startDate\":\"2026-03-15\",\"status\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-15 17:28:44\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 17:28:44',8),(193,'项目成员',2,'com.ruoyi.project.controller.ProjectMemberController.edit()','PUT',1,'admin','研发1部','/project/member','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2026-03-15 11:57:21\",\"id\":5,\"params\":{},\"projectId\":1,\"projectRole\":\"developer\",\"updateBy\":\"\",\"updateTime\":\"2026-03-15 17:35:52\",\"userId\":1} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 17:35:52',4),(194,'项目成员',2,'com.ruoyi.project.controller.ProjectMemberController.edit()','PUT',1,'admin','研发1部','/project/member','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2026-03-15 11:57:21\",\"id\":5,\"params\":{},\"projectId\":1,\"projectRole\":\"developer\",\"updateBy\":\"\",\"updateTime\":\"2026-03-15 17:35:59\",\"userId\":1} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 17:35:59',46),(195,'项目成员',2,'com.ruoyi.project.controller.ProjectMemberController.edit()','PUT',1,'admin','研发1部','/project/member','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2026-03-15 11:57:21\",\"id\":5,\"params\":{},\"projectId\":1,\"projectRole\":\"developer\",\"updateBy\":\"\",\"updateTime\":\"2026-03-15 17:36:09\",\"userId\":1} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 17:36:09',5),(196,'项目成员',2,'com.ruoyi.project.controller.ProjectMemberController.edit()','PUT',1,'admin','研发1部','/project/member','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2026-03-15 11:57:21\",\"id\":5,\"params\":{},\"projectId\":1,\"projectRole\":\"developer\",\"updateBy\":\"\",\"updateTime\":\"2026-03-15 17:36:56\",\"userId\":1} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 17:36:56',43),(197,'项目成员',2,'com.ruoyi.project.controller.ProjectMemberController.edit()','PUT',1,'admin','研发1部','/project/member','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2026-03-15 11:57:21\",\"id\":5,\"joinTime\":\"2026-03-03\",\"params\":{},\"projectId\":1,\"projectRole\":\"developer\",\"updateBy\":\"\",\"updateTime\":\"2026-03-15 17:37:08\",\"userId\":1} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 17:37:08',39),(198,'项目成员',2,'com.ruoyi.project.controller.ProjectMemberController.edit()','PUT',1,'admin','研发1部','/project/member','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2026-03-15 11:57:21\",\"id\":5,\"investment\":30,\"joinTime\":\"2026-03-03\",\"params\":{},\"projectId\":1,\"projectRole\":\"developer\",\"updateBy\":\"\",\"updateTime\":\"2026-03-15 17:41:13\",\"userId\":1} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 17:41:13',4),(199,'项目成员',1,'com.ruoyi.project.controller.ProjectMemberController.add()','POST',1,'admin','研发1部','/project/member','127.0.0.1','内网IP','{\"createTime\":\"2026-03-15 17:43:41\",\"id\":6,\"params\":{},\"projectId\":2,\"userId\":100} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 17:43:41',7),(200,'项目',5,'com.ruoyi.project.controller.ProjectController.export()','POST',1,'admin','研发1部','/project/project/export','127.0.0.1','内网IP','{\"pageSize\":\"10\",\"pageNum\":\"1\"}',NULL,0,NULL,'2026-03-15 19:49:25',867),(201,'代码生成',2,'com.ruoyi.generator.controller.GenController.synchDb()','GET',1,'admin','研发1部','/tool/gen/synchDb/project_member','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 19:58:35',82),(202,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发1部','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"member\",\"className\":\"ProjectMember\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"关联ID\",\"columnId\":25,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-15 19:58:35\",\"usableColumn\":false},{\"capJavaField\":\"ProjectId\",\"columnComment\":\"项目ID\",\"columnId\":26,\"columnName\":\"project_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"projectId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-15 19:58:35\",\"usableColumn\":false},{\"capJavaField\":\"ProjectName\",\"columnComment\":\"项目名称\",\"columnId\":46,\"columnName\":\"project_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"\",\"createTime\":\"2026-03-15 19:58:35\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"projectName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户ID（关联sys_user）\",\"columnId\":27,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-14 16:57:01\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 19:58:52',22),(203,'项目成员',2,'com.ruoyi.project.controller.ProjectMemberController.edit()','PUT',1,'admin','研发1部','/project/member','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2026-03-15 11:57:21\",\"email\":\"ry@163.com\",\"id\":5,\"investment\":30,\"joinTime\":\"2026-03-03\",\"nickName\":\"李先生\",\"params\":{},\"phonenumber\":\"15888888888\",\"projectId\":1,\"projectRole\":\"developer\",\"updateBy\":\"\",\"updateTime\":\"2026-03-15 21:00:49\",\"userId\":1,\"userName\":\"admin\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 21:00:49',15),(204,'项目成员',2,'com.ruoyi.project.controller.ProjectMemberController.edit()','PUT',1,'admin','研发1部','/project/member','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2026-03-15 11:57:21\",\"email\":\"ry@163.com\",\"id\":5,\"investment\":30,\"joinTime\":\"2026-03-03\",\"nickName\":\"李先生\",\"params\":{},\"phonenumber\":\"15888888888\",\"projectId\":1,\"projectRole\":\"developer\",\"updateBy\":\"\",\"updateTime\":\"2026-03-15 21:04:21\",\"userId\":1,\"userName\":\"admin\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 21:04:21',8),(205,'项目成员',2,'com.ruoyi.project.controller.ProjectMemberController.edit()','PUT',1,'admin','研发1部','/project/member','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2026-03-15 11:57:21\",\"email\":\"ry@163.com\",\"id\":5,\"investment\":30,\"joinTime\":\"2026-03-03\",\"nickName\":\"李先生\",\"params\":{},\"phonenumber\":\"15888888888\",\"projectId\":1,\"projectRole\":\"developer\",\"updateBy\":\"\",\"updateTime\":\"2026-03-15 21:06:44\",\"userId\":1,\"userName\":\"admin\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 21:06:44',5),(206,'项目成员',2,'com.ruoyi.project.controller.ProjectMemberController.edit()','PUT',1,'admin','研发1部','/project/member','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2026-03-15 17:43:42\",\"email\":\"\",\"id\":6,\"nickName\":\"橙子\",\"params\":{},\"phonenumber\":\"\",\"projectId\":2,\"projectRole\":\"developer\",\"updateBy\":\"\",\"updateTime\":\"2026-03-15 21:07:02\",\"userId\":100,\"userName\":\"chengzi\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 21:07:02',7),(207,'项目成员',2,'com.ruoyi.project.controller.ProjectMemberController.edit()','PUT',1,'admin','研发1部','/project/member','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2026-03-15 11:57:21\",\"email\":\"ry@163.com\",\"id\":5,\"investment\":30,\"joinTime\":\"2026-03-03\",\"nickName\":\"李先生\",\"params\":{},\"phonenumber\":\"15888888888\",\"projectId\":1,\"projectName\":\"无敌原子弹\",\"projectRole\":\"owner\",\"updateBy\":\"\",\"updateTime\":\"2026-03-15 21:18:16\",\"userId\":1,\"userName\":\"admin\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 21:18:16',18),(208,'项目成员',1,'com.ruoyi.project.controller.ProjectMemberController.add()','POST',1,'admin','研发1部','/project/member','127.0.0.1','内网IP','{\"createTime\":\"2026-03-15 21:19:28\",\"id\":7,\"params\":{},\"projectId\":1,\"projectRole\":\"visitor\",\"userId\":105} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 21:19:28',7),(209,'项目成员',2,'com.ruoyi.project.controller.ProjectMemberController.edit()','PUT',1,'admin','研发1部','/project/member','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2026-03-15 21:19:29\",\"id\":7,\"params\":{},\"projectId\":1,\"projectName\":\"无敌原子弹\",\"projectRole\":\"visitor\",\"updateBy\":\"\",\"updateTime\":\"2026-03-15 21:19:38\",\"userId\":102} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 21:19:38',7),(210,'项目成员',2,'com.ruoyi.project.controller.ProjectMemberController.edit()','PUT',1,'admin','研发1部','/project/member','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2026-03-15 21:19:29\",\"id\":7,\"params\":{},\"projectId\":1,\"projectName\":\"无敌原子弹\",\"projectRole\":\"visitor\",\"updateBy\":\"\",\"updateTime\":\"2026-03-15 21:19:54\",\"userId\":101} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 21:19:54',8),(211,'项目成员',2,'com.ruoyi.project.controller.ProjectMemberController.edit()','PUT',1,'admin','研发1部','/project/member','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2026-03-15 11:57:21\",\"email\":\"ry@163.com\",\"id\":5,\"investment\":30,\"joinTime\":\"2026-03-03\",\"nickName\":\"李先生\",\"params\":{},\"phonenumber\":\"15888888888\",\"projectId\":1,\"projectName\":\"无敌原子弹\",\"projectRole\":\"owner\",\"updateBy\":\"\",\"updateTime\":\"2026-03-15 21:20:30\",\"userId\":1,\"userName\":\"admin\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 21:20:30',40),(212,'项目成员',1,'com.ruoyi.project.controller.ProjectMemberController.add()','POST',1,'admin','研发1部','/project/member','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2026-03-15 21:32:34\",\"params\":{},\"projectId\":1,\"userId\":1} ',NULL,1,'\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1-1\' for key \'project_member.uk_project_user\'\r\n### The error may exist in file [E:\\Project\\ProjectFlow_Manager\\ruoyi-project\\target\\classes\\mapper\\project\\ProjectMemberMapper.xml]\r\n### The error may involve com.ruoyi.project.mapper.ProjectMemberMapper.insertProjectMember-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into project_member          ( project_id,             user_id,                                       create_by,             create_time )           values ( ?,             ?,                                       ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1-1\' for key \'project_member.uk_project_user\'\n; Duplicate entry \'1-1\' for key \'project_member.uk_project_user\'','2026-03-15 21:32:34',22),(213,'项目成员',1,'com.ruoyi.project.controller.ProjectMemberController.add()','POST',1,'admin','研发1部','/project/member','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2026-03-15 21:32:39\",\"id\":9,\"params\":{},\"projectId\":1,\"userId\":12} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-15 21:32:39',4),(214,'项目',2,'com.ruoyi.project.controller.ProjectController.edit()','PUT',1,'admin','研发1部','/project/project','127.0.0.1','内网IP','{\"boardStyle\":1,\"budget\":9,\"colWidth\":264,\"createBy\":\"me\",\"createTime\":\"2026-03-15 11:49:41\",\"delFlag\":0,\"description\":\"把杂碎炸飞天\",\"displayCards\":0,\"endDate\":\"2026-03-16\",\"fluidBoard\":\"0\",\"investment\":10,\"ownerId\":1,\"ownerName\":\"茄子大大\",\"params\":{},\"priority\":3,\"progress\":20,\"projectCode\":\"BBB\",\"projectId\":1,\"projectModuleList\":[],\"projectName\":\"无敌原子弹\",\"realEndDate\":\"2026-03-18\",\"realStartDate\":\"2026-03-17\",\"requirementCount\":0,\"startDate\":\"2026-03-15\",\"status\":0,\"updateBy\":\"\",\"updateTime\":\"2026-03-16 10:26:12\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-16 10:26:12',54),(215,'项目',2,'com.ruoyi.project.controller.ProjectController.edit()','PUT',1,'admin','研发1部','/project/project','127.0.0.1','内网IP','{\"boardStyle\":1,\"colWidth\":264,\"createBy\":\"\",\"createTime\":\"2026-03-15 17:05:38\",\"delFlag\":0,\"description\":\"飞往火星\",\"displayCards\":0,\"fluidBoard\":\"0\",\"params\":{},\"priority\":2,\"progress\":0,\"projectId\":2,\"projectModuleList\":[{\"createBy\":\"我\",\"moduleId\":1,\"moduleName\":\"螺旋桨\",\"params\":{},\"parentId\":1,\"projectId\":2}],\"projectName\":\"超级大飞机\",\"status\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-16 10:26:33\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-16 10:26:33',20),(216,'项目',2,'com.ruoyi.project.controller.ProjectController.edit()','PUT',1,'admin','研发1部','/project/project','127.0.0.1','内网IP','{\"boardStyle\":1,\"budget\":9,\"colWidth\":264,\"createBy\":\"me\",\"createTime\":\"2026-03-15 11:49:41\",\"delFlag\":0,\"description\":\"把杂碎炸飞天\",\"displayCards\":0,\"endDate\":\"2026-03-16\",\"fluidBoard\":\"0\",\"investment\":10,\"ownerId\":1,\"ownerName\":\"茄子大大\",\"params\":{},\"priority\":3,\"progress\":20,\"projectCode\":\"BBB\",\"projectId\":1,\"projectModuleList\":[],\"projectName\":\"无敌原子弹\",\"realEndDate\":\"2026-03-18\",\"realStartDate\":\"2026-03-17\",\"requirementCount\":0,\"startDate\":\"2026-03-15\",\"status\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-16 10:26:55\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-16 10:26:55',11),(217,'项目',2,'com.ruoyi.project.controller.ProjectController.edit()','PUT',1,'admin','研发1部','/project/project','127.0.0.1','内网IP','{\"boardStyle\":1,\"colWidth\":264,\"createBy\":\"\",\"createTime\":\"2026-03-15 17:05:38\",\"delFlag\":0,\"description\":\"飞往火星\",\"displayCards\":0,\"fluidBoard\":\"0\",\"params\":{},\"priority\":2,\"progress\":0,\"projectId\":2,\"projectModuleList\":[{\"createBy\":\"我\",\"moduleId\":1,\"moduleName\":\"螺旋桨\",\"params\":{},\"parentId\":1,\"projectId\":2}],\"projectName\":\"超级大飞机\",\"status\":0,\"updateBy\":\"\",\"updateTime\":\"2026-03-16 10:27:00\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-16 10:27:00',12),(218,'项目',2,'com.ruoyi.project.controller.ProjectController.edit()','PUT',1,'admin','研发1部','/project/project','127.0.0.1','内网IP','{\"boardStyle\":1,\"budget\":9,\"colWidth\":264,\"createBy\":\"me\",\"createTime\":\"2026-03-15 11:49:41\",\"delFlag\":0,\"description\":\"把杂碎炸飞天\",\"displayCards\":0,\"endDate\":\"2026-03-16\",\"fluidBoard\":\"0\",\"investment\":10,\"ownerId\":1,\"ownerName\":\"茄子大大\",\"params\":{},\"priority\":3,\"progress\":20,\"projectCode\":\"BBB\",\"projectId\":1,\"projectModuleList\":[],\"projectName\":\"无敌原子弹\",\"realEndDate\":\"2026-03-18\",\"realStartDate\":\"2026-03-17\",\"requirementCount\":0,\"startDate\":\"2026-03-15\",\"status\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-16 10:28:18\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-16 10:28:18',9),(219,'项目',2,'com.ruoyi.project.controller.ProjectController.edit()','PUT',1,'admin','研发1部','/project/project','127.0.0.1','内网IP','{\"boardStyle\":1,\"budget\":9,\"colWidth\":264,\"createBy\":\"me\",\"createTime\":\"2026-03-15 11:49:41\",\"delFlag\":0,\"description\":\"把杂碎炸飞天\",\"displayCards\":0,\"endDate\":\"2026-03-16\",\"fluidBoard\":\"0\",\"investment\":10,\"ownerId\":1,\"ownerName\":\"茄子大大\",\"params\":{},\"priority\":3,\"progress\":20,\"projectCode\":\"BBB\",\"projectId\":1,\"projectModuleList\":[],\"projectName\":\"无敌原子弹\",\"realEndDate\":\"2026-03-18\",\"realStartDate\":\"2026-03-17\",\"requirementCount\":0,\"startDate\":\"2026-03-15\",\"status\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-16 10:28:42\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-16 10:28:42',45),(220,'项目成员',2,'com.ruoyi.project.controller.ProjectMemberController.edit()','PUT',1,'admin','研发1部','/project/member','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2026-03-15 11:57:21\",\"email\":\"ry@163.com\",\"id\":5,\"investment\":30,\"joinTime\":\"2026-03-03\",\"nickName\":\"李先生\",\"params\":{},\"phonenumber\":\"15888888888\",\"projectId\":1,\"projectName\":\"无敌原子弹\",\"projectRole\":\"owner\",\"updateBy\":\"admin\",\"updateTime\":\"2026-03-16 10:34:27\",\"userId\":1,\"userName\":\"admin\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-16 10:34:27',18),(221,'项目成员',2,'com.ruoyi.project.controller.ProjectMemberController.edit()','PUT',1,'admin','研发1部','/project/member','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2026-03-15 21:32:39\",\"id\":9,\"params\":{},\"projectId\":1,\"projectName\":\"无敌原子弹\",\"projectRole\":\"developer\",\"updateBy\":\"admin\",\"updateTime\":\"2026-03-16 10:34:42\",\"userId\":12} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-03-16 10:34:42',6);
/*!40000 ALTER TABLE `sys_oper_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_post`
--

DROP TABLE IF EXISTS `sys_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_post` (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COMMENT='岗位信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_post`
--

LOCK TABLES `sys_post` WRITE;
/*!40000 ALTER TABLE `sys_post` DISABLE KEYS */;
INSERT INTO `sys_post` VALUES (1,'ceo','董事长',1,'0','admin','2026-03-11 20:19:21','',NULL,''),(2,'se','项目经理',2,'0','admin','2026-03-11 20:19:21','',NULL,''),(3,'hr','人力资源',3,'0','admin','2026-03-11 20:19:21','',NULL,''),(4,'user','普通员工',4,'0','admin','2026-03-11 20:19:21','',NULL,'');
/*!40000 ALTER TABLE `sys_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role` (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb3 COMMENT='角色信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'超级管理员','admin',1,'1',1,1,'0','0','admin','2026-03-11 20:19:21','',NULL,'超级管理员'),(2,'普通角色','common',2,'2',1,1,'0','0','admin','2026-03-11 20:19:21','',NULL,'普通角色');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_dept`
--

DROP TABLE IF EXISTS `sys_role_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='角色和部门关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_dept`
--

LOCK TABLES `sys_role_dept` WRITE;
/*!40000 ALTER TABLE `sys_role_dept` DISABLE KEYS */;
INSERT INTO `sys_role_dept` VALUES (2,100),(2,101),(2,105);
/*!40000 ALTER TABLE `sys_role_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='角色和菜单关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
INSERT INTO `sys_role_menu` VALUES (2,1),(2,2),(2,3),(2,4),(2,100),(2,101),(2,102),(2,103),(2,104),(2,105),(2,106),(2,107),(2,108),(2,109),(2,110),(2,111),(2,112),(2,113),(2,114),(2,115),(2,116),(2,117),(2,500),(2,501),(2,1000),(2,1001),(2,1002),(2,1003),(2,1004),(2,1005),(2,1006),(2,1007),(2,1008),(2,1009),(2,1010),(2,1011),(2,1012),(2,1013),(2,1014),(2,1015),(2,1016),(2,1017),(2,1018),(2,1019),(2,1020),(2,1021),(2,1022),(2,1023),(2,1024),(2,1025),(2,1026),(2,1027),(2,1028),(2,1029),(2,1030),(2,1031),(2,1032),(2,1033),(2,1034),(2,1035),(2,1036),(2,1037),(2,1038),(2,1039),(2,1040),(2,1041),(2,1042),(2,1043),(2,1044),(2,1045),(2,1046),(2,1047),(2,1048),(2,1049),(2,1050),(2,1051),(2,1052),(2,1053),(2,1054),(2,1055),(2,1056),(2,1057),(2,1058),(2,1059),(2,1060);
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
  `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) DEFAULT '' COMMENT '密码',
  `status` char(1) DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb3 COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,103,'admin','李先生','00','ry@163.com','15888888888','0','/profile/avatar/2026/03/13/bd9b1a8087694a4a8e007f64f18a5bb7.jpg','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2026-03-16 10:23:28','2026-03-11 20:19:21','admin','2026-03-11 20:19:21','','2026-03-13 11:35:18','管理员'),(2,105,'ry','若依','00','ry@qq.com','15666666666','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2026-03-11 20:19:21','2026-03-11 20:19:21','admin','2026-03-11 20:19:21','',NULL,'测试员'),(100,103,'chengzi','橙子','00','','','0','','$2a$10$MBWZEOrixKjy9bjT4HunZeCISQ0XuVfOHKP.HgkLkZ.HkMzGIFHpy','0','0','',NULL,NULL,'admin','2026-03-13 11:39:08','',NULL,NULL),(101,200,'dong','东东','00','','','0','','$2a$10$4U6lo56pUVZDOmVs/IVL5eD04h1NQiwTAeYodZOjRq8fNPRWtka92','0','0','',NULL,NULL,'admin','2026-03-13 11:39:45','',NULL,NULL);
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_post`
--

DROP TABLE IF EXISTS `sys_user_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_post` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='用户与岗位关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_post`
--

LOCK TABLES `sys_user_post` WRITE;
/*!40000 ALTER TABLE `sys_user_post` DISABLE KEYS */;
INSERT INTO `sys_user_post` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `sys_user_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_role` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='用户和角色关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task` (
  `task_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `project_id` bigint NOT NULL COMMENT '所属项目',
  `req_id` bigint DEFAULT NULL COMMENT '关联需求ID',
  `module_id` bigint DEFAULT NULL COMMENT '所属模块',
  `task_name` varchar(200) NOT NULL COMMENT '任务名称',
  `description` text COMMENT '详细描述',
  `task_type` varchar(20) DEFAULT 'development' COMMENT '任务类型（development:开发，test:测试，design:设计，meeting:会议等）',
  `priority` char(1) DEFAULT '2' COMMENT '优先级',
  `status` tinyint DEFAULT '0' COMMENT '状态（0待办 1进行中 2已完成 3暂停）',
  `assign_to` bigint DEFAULT NULL COMMENT '指派给',
  `estimate_time` decimal(10,1) DEFAULT NULL COMMENT '预估工时',
  `consumed_time` decimal(10,1) DEFAULT '0.0' COMMENT '已消耗工时',
  `plan_start_date` date DEFAULT NULL COMMENT '计划开始日期',
  `plan_end_date` date DEFAULT NULL COMMENT '计划结束日期',
  `deadline` date DEFAULT NULL COMMENT '截止日期',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` tinyint DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (`task_id`),
  KEY `idx_project_id` (`project_id`),
  KEY `idx_assign_to` (`assign_to`),
  KEY `idx_req_id` (`req_id`),
  KEY `idx_module_id` (`module_id`),
  CONSTRAINT `fk_task_module` FOREIGN KEY (`module_id`) REFERENCES `project_module` (`module_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_task_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_task_req` FOREIGN KEY (`req_id`) REFERENCES `requirement` (`req_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='任务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_daily_snapshot`
--

DROP TABLE IF EXISTS `task_daily_snapshot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_daily_snapshot` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '快照ID',
  `task_id` bigint NOT NULL COMMENT '任务ID',
  `snapshot_date` date NOT NULL COMMENT '快照日期',
  `status` tinyint NOT NULL COMMENT '任务状态',
  `remaining_hours` decimal(10,1) DEFAULT '0.0' COMMENT '剩余工时(当日)',
  `create_time` datetime NOT NULL COMMENT '生成时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_task_date` (`task_id`,`snapshot_date`),
  KEY `idx_task_id` (`task_id`),
  CONSTRAINT `fk_snapshot_task` FOREIGN KEY (`task_id`) REFERENCES `task` (`task_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='任务每日快照表(可选)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_daily_snapshot`
--

LOCK TABLES `task_daily_snapshot` WRITE;
/*!40000 ALTER TABLE `task_daily_snapshot` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_daily_snapshot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_history`
--

DROP TABLE IF EXISTS `task_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_history` (
  `history_id` bigint NOT NULL AUTO_INCREMENT COMMENT '历史ID',
  `task_id` bigint NOT NULL COMMENT '任务ID',
  `from_status` tinyint DEFAULT NULL COMMENT '变更前状态',
  `to_status` tinyint NOT NULL COMMENT '变更后状态',
  `operator_id` bigint DEFAULT NULL COMMENT '操作人',
  `change_time` datetime NOT NULL COMMENT '变更时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`history_id`),
  KEY `idx_task_id` (`task_id`),
  KEY `idx_change_time` (`change_time`),
  CONSTRAINT `fk_taskhistory_task` FOREIGN KEY (`task_id`) REFERENCES `task` (`task_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='任务状态变更历史表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_history`
--

LOCK TABLES `task_history` WRITE;
/*!40000 ALTER TABLE `task_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_sprint`
--

DROP TABLE IF EXISTS `task_sprint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_sprint` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '关联ID',
  `sprint_id` bigint NOT NULL COMMENT '迭代ID',
  `task_id` bigint NOT NULL COMMENT '任务ID',
  `added_time` datetime DEFAULT NULL COMMENT '加入迭代时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_sprint_task` (`sprint_id`,`task_id`),
  KEY `idx_sprint_id` (`sprint_id`),
  KEY `idx_task_id` (`task_id`),
  CONSTRAINT `fk_tasksprint_sprint` FOREIGN KEY (`sprint_id`) REFERENCES `sprint` (`sprint_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_tasksprint_task` FOREIGN KEY (`task_id`) REFERENCES `task` (`task_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='迭代任务关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_sprint`
--

LOCK TABLES `task_sprint` WRITE;
/*!40000 ALTER TABLE `task_sprint` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_sprint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work_log`
--

DROP TABLE IF EXISTS `work_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work_log` (
  `log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `task_id` bigint NOT NULL COMMENT '关联任务ID',
  `user_id` bigint NOT NULL COMMENT '记录人',
  `work_date` date NOT NULL COMMENT '工作日期',
  `hours` decimal(5,1) NOT NULL COMMENT '工时数',
  `description` varchar(500) DEFAULT NULL COMMENT '工作描述',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`log_id`),
  KEY `idx_task_id` (`task_id`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `fk_worklog_task` FOREIGN KEY (`task_id`) REFERENCES `task` (`task_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='工时记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_log`
--

LOCK TABLES `work_log` WRITE;
/*!40000 ALTER TABLE `work_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `work_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'projectflow_manager'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-16 11:02:28
