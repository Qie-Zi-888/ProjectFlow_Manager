-- 为任务表添加书签标识字段
ALTER TABLE task ADD COLUMN bookmark VARCHAR(50) DEFAULT NULL COMMENT '书签标识' AFTER module_id;
