-- ======================================================
-- 1. 项目表（project）
-- 描述：存储项目的基本信息、时间、负责人、看板配置与进度等
-- ======================================================
DROP TABLE IF EXISTS project;
CREATE TABLE project (
  project_id       BIGINT(20)   NOT NULL AUTO_INCREMENT COMMENT '项目ID',
  project_name     VARCHAR(100) NOT NULL COMMENT '项目名称',
  project_code     VARCHAR(50)  DEFAULT NULL COMMENT '项目编码（唯一）',
  description      VARCHAR(500) DEFAULT NULL COMMENT '项目描述',
  -- 时间相关
  start_date       DATE         DEFAULT NULL COMMENT '计划开始日期',
  end_date         DATE         DEFAULT NULL COMMENT '计划结束日期',
  real_start_date  DATE         DEFAULT NULL COMMENT '实际开始日期',
  real_end_date    DATE         DEFAULT NULL COMMENT '实际结束日期',
  -- 项目属性
  status           TINYINT      DEFAULT 0 COMMENT '项目状态（0进行中 1已完成 2暂停 3已取消）',
  priority         TINYINT      DEFAULT 3 COMMENT '优先级（1最高 2高 3中 4低 5最低）',
  progress         TINYINT      DEFAULT 0 COMMENT '项目进度（0-100）',
  -- 负责人
  owner_id         BIGINT(20)   DEFAULT NULL COMMENT '项目负责人ID',
  owner_name       VARCHAR(50)  DEFAULT NULL COMMENT '项目负责人姓名',
  -- 看板相关配置
  board_style      TINYINT      DEFAULT 1 COMMENT '看板样式（1标准看板 2敏捷看板 3自定义）',
  col_width        SMALLINT(4)  DEFAULT 264 COMMENT '列宽度',
  display_cards    TINYINT      DEFAULT 0 COMMENT '显示卡片数量',
  fluid_board      CHAR(1)      DEFAULT '0' COMMENT '流体看板（0禁用 1启用）',
  -- 审计字段
  create_by        VARCHAR(64)  DEFAULT '' COMMENT '创建者',
  create_time      DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  update_by        VARCHAR(64)  DEFAULT '' COMMENT '更新者',
  update_time      DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  del_flag         TINYINT      DEFAULT '0' COMMENT '删除标志（0存在 1删除）',
  PRIMARY KEY (project_id),
  UNIQUE KEY idx_project_code (project_code),
  KEY idx_status (status),
  KEY idx_owner (owner_id),
  KEY idx_date_range (start_date, end_date)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='项目表';

-- ======================================================
-- 2. 项目成员表（project_member）
-- 描述：项目与成员的关联关系，包含项目内角色
-- ======================================================
DROP TABLE IF EXISTS project_member;
CREATE TABLE project_member (
  id               BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '关联ID',
  project_id       BIGINT(20) NOT NULL COMMENT '项目ID',
  user_id          BIGINT(20) NOT NULL COMMENT '用户ID（关联sys_user）',
  project_role     VARCHAR(30) DEFAULT 'developer' COMMENT '项目角色（owner:负责人，developer:开发，tester:测试，visitor:访客）',
  join_time        DATETIME    DEFAULT NULL COMMENT '加入时间',
  create_by        VARCHAR(64) DEFAULT '' COMMENT '创建者',
  create_time      DATETIME    DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  update_by        VARCHAR(64) DEFAULT '' COMMENT '更新者',
  update_time      DATETIME    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (id),
  UNIQUE KEY uk_project_user (project_id, user_id),
  KEY idx_user_id (user_id),
  CONSTRAINT fk_pm_project FOREIGN KEY (project_id) REFERENCES project(project_id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='项目成员表';

-- ======================================================
-- 3. 项目模块表（project_module）
-- 描述：项目功能模块/子模块划分，支持树形结构
-- ======================================================
DROP TABLE IF EXISTS project_module;
CREATE TABLE project_module (
  module_id        BIGINT(20)  NOT NULL AUTO_INCREMENT COMMENT '模块ID',
  project_id       BIGINT(20)  NOT NULL COMMENT '项目ID',
  module_name      VARCHAR(50) NOT NULL COMMENT '模块名称',
  parent_id        BIGINT(20)  DEFAULT 0 COMMENT '父模块ID（支持树形结构）',
  order_num        INT(4)      DEFAULT 0 COMMENT '显示顺序',
  create_by        VARCHAR(64) DEFAULT '' COMMENT '创建者',
  create_time      DATETIME             COMMENT '创建时间',
  update_by        VARCHAR(64) DEFAULT '' COMMENT '更新者',
  update_time      DATETIME             COMMENT '更新时间',
  del_flag         TINYINT     DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (module_id),
  KEY idx_project_id (project_id),
  CONSTRAINT fk_module_project FOREIGN KEY (project_id) REFERENCES project(project_id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='项目模块表';

-- ======================================================
-- 4. 项目版本表（project_version）
-- 描述：记录项目版本发布信息
-- ======================================================
DROP TABLE IF EXISTS project_version;
CREATE TABLE project_version (
  version_id       BIGINT(20)  NOT NULL AUTO_INCREMENT COMMENT '版本ID',
  project_id       BIGINT(20)  NOT NULL COMMENT '项目ID',
  version_name     VARCHAR(30) NOT NULL COMMENT '版本名称（如v1.0）',
  description      VARCHAR(500) DEFAULT NULL COMMENT '版本描述',
  release_date     DATE         DEFAULT NULL COMMENT '发布日期',
  status           TINYINT      DEFAULT 0 COMMENT '状态（0规划中 1已发布 2已归档）',
  create_by        VARCHAR(64)  DEFAULT '' COMMENT '创建者',
  create_time      DATETIME              COMMENT '创建时间',
  update_by        VARCHAR(64)  DEFAULT '' COMMENT '更新者',
  update_time      DATETIME              COMMENT '更新时间',
  del_flag         TINYINT      DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (version_id),
  UNIQUE KEY uk_project_version (project_id, version_name),
  KEY idx_project_id (project_id),
  CONSTRAINT fk_version_project FOREIGN KEY (project_id) REFERENCES project(project_id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='项目版本表';

-- ======================================================
-- 5. 需求表（requirement）
-- 描述：记录项目需求及其状态、优先级、计划版本
-- ======================================================
DROP TABLE IF EXISTS requirement;
CREATE TABLE requirement (
  req_id           BIGINT(20)   NOT NULL AUTO_INCREMENT COMMENT '需求ID',
  project_id       BIGINT(20)   NOT NULL COMMENT '所属项目',
  module_id        BIGINT(20)   DEFAULT NULL COMMENT '所属模块',
  version_id       BIGINT(20)   DEFAULT NULL COMMENT '计划发布版本',
  req_title        VARCHAR(200) NOT NULL COMMENT '需求标题',
  description      TEXT         COMMENT '详细描述',
  priority         CHAR(1)      DEFAULT '2' COMMENT '优先级（1最高 2高 3中 4低）',
  status           TINYINT      DEFAULT 0 COMMENT '状态（0草稿 1进行中 2已解决 3关闭）',
  assign_to        BIGINT(20)   DEFAULT NULL COMMENT '指派给（用户ID）',
  estimate_time    DECIMAL(10,1) DEFAULT NULL COMMENT '预估工时（小时）',
  create_by        VARCHAR(64)  DEFAULT '' COMMENT '创建者',
  create_time      DATETIME               COMMENT '创建时间',
  update_by        VARCHAR(64)  DEFAULT '' COMMENT '更新者',
  update_time      DATETIME               COMMENT '更新时间',
  del_flag         TINYINT      DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (req_id),
  KEY idx_project_id (project_id),
  KEY idx_assign_to (assign_to),
  KEY idx_module_id (module_id),
  KEY idx_version_id (version_id),
  CONSTRAINT fk_req_project FOREIGN KEY (project_id) REFERENCES project(project_id) ON DELETE CASCADE,
  CONSTRAINT fk_req_module  FOREIGN KEY (module_id) REFERENCES project_module(module_id) ON DELETE SET NULL,
  CONSTRAINT fk_req_version FOREIGN KEY (version_id) REFERENCES project_version(version_id) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='需求表';

-- ======================================================
-- 6. 任务表（task）
-- 描述：记录具体任务、计划时间、负责人、工时与状态
-- ======================================================
DROP TABLE IF EXISTS task;
CREATE TABLE task (
  task_id          BIGINT(20)   NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  project_id       BIGINT(20)   NOT NULL COMMENT '所属项目',
  req_id           BIGINT(20)   DEFAULT NULL COMMENT '关联需求ID',
  module_id        BIGINT(20)   DEFAULT NULL COMMENT '所属模块',
  task_name        VARCHAR(200) NOT NULL COMMENT '任务名称',
  description      TEXT         COMMENT '详细描述',
  task_type        VARCHAR(20)  DEFAULT 'development' COMMENT '任务类型（development:开发，test:测试，design:设计，meeting:会议等）',
  priority         CHAR(1)      DEFAULT '2' COMMENT '优先级',
  status           TINYINT      DEFAULT 0 COMMENT '状态（0待办 1进行中 2已完成 3暂停）',
  assign_to        BIGINT(20)   DEFAULT NULL COMMENT '指派给',
  estimate_time    DECIMAL(10,1) DEFAULT NULL COMMENT '预估工时',
  consumed_time    DECIMAL(10,1) DEFAULT 0 COMMENT '已消耗工时',
  plan_start_date  DATE         DEFAULT NULL COMMENT '计划开始日期',
  plan_end_date    DATE         DEFAULT NULL COMMENT '计划结束日期',
  deadline         DATE         DEFAULT NULL COMMENT '截止日期',
  create_by        VARCHAR(64)  DEFAULT '' COMMENT '创建者',
  create_time      DATETIME               COMMENT '创建时间',
  update_by        VARCHAR(64)  DEFAULT '' COMMENT '更新者',
  update_time      DATETIME               COMMENT '更新时间',
  del_flag         TINYINT      DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (task_id),
  KEY idx_project_id (project_id),
  KEY idx_assign_to (assign_to),
  KEY idx_req_id (req_id),
  KEY idx_module_id (module_id),
  CONSTRAINT fk_task_project FOREIGN KEY (project_id) REFERENCES project(project_id) ON DELETE CASCADE,
  CONSTRAINT fk_task_req     FOREIGN KEY (req_id) REFERENCES requirement(req_id) ON DELETE SET NULL,
  CONSTRAINT fk_task_module  FOREIGN KEY (module_id) REFERENCES project_module(module_id) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='任务表';

-- ======================================================
-- 7. 缺陷表（bug）
-- 描述：记录缺陷信息、严重等级、处理人与状态流转
-- ======================================================
DROP TABLE IF EXISTS bug;
CREATE TABLE bug (
  bug_id           BIGINT(20)   NOT NULL AUTO_INCREMENT COMMENT '缺陷ID',
  project_id       BIGINT(20)   NOT NULL COMMENT '所属项目',
  req_id           BIGINT(20)   DEFAULT NULL COMMENT '关联需求ID',
  module_id        BIGINT(20)   DEFAULT NULL COMMENT '所属模块',
  found_version    VARCHAR(30)  DEFAULT NULL COMMENT '发现版本',
  fixed_version    VARCHAR(30)  DEFAULT NULL COMMENT '修复版本',
  bug_title        VARCHAR(200) NOT NULL COMMENT '缺陷标题',
  description      TEXT         COMMENT '详细描述',
  severity         CHAR(1)      DEFAULT '2' COMMENT '严重程度（1致命 2严重 3一般 4轻微）',
  priority         CHAR(1)      DEFAULT '2' COMMENT '优先级',
  status           TINYINT      DEFAULT 0 COMMENT '状态（0新建 1已分配 2打开 3已修复 4关闭 5拒绝）',
  assign_to        BIGINT(20)   DEFAULT NULL COMMENT '指派给（当前处理人）',
  resolved_by      BIGINT(20)   DEFAULT NULL COMMENT '解决人',
  resolved_time    DATETIME     DEFAULT NULL COMMENT '解决时间',
  closed_by        BIGINT(20)   DEFAULT NULL COMMENT '关闭人',
  closed_time      DATETIME     DEFAULT NULL COMMENT '关闭时间',
  create_by        VARCHAR(64)  DEFAULT '' COMMENT '创建者',
  create_time      DATETIME              COMMENT '创建时间',
  update_by        VARCHAR(64)  DEFAULT '' COMMENT '更新者',
  update_time      DATETIME              COMMENT '更新时间',
  del_flag         TINYINT      DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (bug_id),
  KEY idx_project_id (project_id),
  KEY idx_assign_to (assign_to),
  KEY idx_status (status),
  KEY idx_req_id (req_id),
  KEY idx_module_id (module_id),
  CONSTRAINT fk_bug_project FOREIGN KEY (project_id) REFERENCES project(project_id) ON DELETE CASCADE,
  CONSTRAINT fk_bug_req     FOREIGN KEY (req_id) REFERENCES requirement(req_id) ON DELETE SET NULL,
  CONSTRAINT fk_bug_module  FOREIGN KEY (module_id) REFERENCES project_module(module_id) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='缺陷表';

-- ======================================================
-- 8. 文档表（document）
-- 描述：项目文档元数据与版本号信息
-- ======================================================
DROP TABLE IF EXISTS document;
CREATE TABLE document (
  doc_id           BIGINT(20)   NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  project_id       BIGINT(20)   NOT NULL COMMENT '所属项目',
  folder_id        BIGINT(20)   DEFAULT 0 COMMENT '文件夹ID（可自关联实现目录）',
  doc_name         VARCHAR(200) NOT NULL COMMENT '文档名称',
  file_path        VARCHAR(500) DEFAULT NULL COMMENT '存储路径',
  file_size        BIGINT(20)   DEFAULT 0 COMMENT '文件大小（字节）',
  file_type        VARCHAR(50)  DEFAULT NULL COMMENT '文件类型（扩展名）',
  version          VARCHAR(20)  DEFAULT '1.0' COMMENT '版本号',
  description      VARCHAR(500) DEFAULT NULL COMMENT '描述',
  create_by        VARCHAR(64)  DEFAULT '' COMMENT '上传人',
  create_time      DATETIME              COMMENT '上传时间',
  update_by        VARCHAR(64)  DEFAULT '' COMMENT '更新者',
  update_time      DATETIME              COMMENT '更新时间',
  del_flag         TINYINT      DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (doc_id),
  KEY idx_project_id (project_id),
  CONSTRAINT fk_doc_project FOREIGN KEY (project_id) REFERENCES project(project_id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='文档表';

-- ======================================================
-- 9. 文档版本表（document_version）
-- 描述：文档历史版本记录，用于版本回溯
-- ======================================================
DROP TABLE IF EXISTS document_version;
CREATE TABLE document_version (
  ver_id           BIGINT(20)   NOT NULL AUTO_INCREMENT COMMENT '版本ID',
  doc_id           BIGINT(20)   NOT NULL COMMENT '文档ID',
  version          VARCHAR(20)  NOT NULL COMMENT '版本号',
  file_path        VARCHAR(500) NOT NULL COMMENT '该版本文件路径',
  file_size        BIGINT(20)   DEFAULT 0 COMMENT '文件大小',
  change_log       VARCHAR(500) DEFAULT NULL COMMENT '变更日志',
  create_by        VARCHAR(64)  DEFAULT '' COMMENT '上传人',
  create_time      DATETIME              COMMENT '上传时间',
  PRIMARY KEY (ver_id),
  KEY idx_doc_id (doc_id),
  CONSTRAINT fk_docver_doc FOREIGN KEY (doc_id) REFERENCES document(doc_id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='文档版本表';

-- ======================================================
-- 10. 工时记录表（work_log）
-- 描述：记录用户在任务上的实际工时
-- ======================================================
DROP TABLE IF EXISTS work_log;
CREATE TABLE work_log (
  log_id           BIGINT(20)    NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  task_id          BIGINT(20)    NOT NULL COMMENT '关联任务ID',
  user_id          BIGINT(20)    NOT NULL COMMENT '记录人',
  work_date        DATE          NOT NULL COMMENT '工作日期',
  hours            DECIMAL(5,1)  NOT NULL COMMENT '工时数',
  description      VARCHAR(500)  DEFAULT NULL COMMENT '工作描述',
  create_by        VARCHAR(64)   DEFAULT '' COMMENT '创建者',
  create_time      DATETIME               COMMENT '创建时间',
  update_by        VARCHAR(64)   DEFAULT '' COMMENT '更新者',
  update_time      DATETIME               COMMENT '更新时间',
  PRIMARY KEY (log_id),
  KEY idx_task_id (task_id),
  KEY idx_user_id (user_id),
  CONSTRAINT fk_worklog_task FOREIGN KEY (task_id) REFERENCES task(task_id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='工时记录表';

-- ======================================================
-- 11. 通知表（notification）
-- 描述：系统通知主体，记录通知内容与关联业务对象
-- ======================================================
DROP TABLE IF EXISTS notification;
CREATE TABLE notification (
  notif_id         BIGINT(20)   NOT NULL AUTO_INCREMENT COMMENT '通知ID',
  title            VARCHAR(200) NOT NULL COMMENT '通知标题',
  content          TEXT         COMMENT '通知内容',
  type             VARCHAR(30)  DEFAULT 'system' COMMENT '类型（system:系统，task:任务，bug:缺陷等）',
  target_type      VARCHAR(30)  DEFAULT NULL COMMENT '关联对象类型（project/task/bug等）',
  target_id        BIGINT(20)   DEFAULT NULL COMMENT '关联对象ID',
  sender_id        BIGINT(20)   DEFAULT NULL COMMENT '发送者（0表示系统）',
  create_time      DATETIME     NOT NULL COMMENT '发送时间',
  PRIMARY KEY (notif_id),
  KEY idx_target (target_type, target_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='通知表';

-- ======================================================
-- 12. 通知接收人表（notification_user）
-- 描述：通知与接收用户关系，包含已读状态
-- ======================================================
DROP TABLE IF EXISTS notification_user;
CREATE TABLE notification_user (
  id               BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '关联ID',
  notif_id         BIGINT(20) NOT NULL COMMENT '通知ID',
  user_id          BIGINT(20) NOT NULL COMMENT '接收人ID',
  is_read          CHAR(1)    DEFAULT '0' COMMENT '是否已读（0未读 1已读）',
  read_time        DATETIME   DEFAULT NULL COMMENT '阅读时间',
  PRIMARY KEY (id),
  UNIQUE KEY uk_notif_user (notif_id, user_id),
  KEY idx_user_id (user_id),
  CONSTRAINT fk_notifuser_notif FOREIGN KEY (notif_id) REFERENCES notification(notif_id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='通知接收人表';

-- ======================================================
-- 13. 评论表（comment）
-- 描述：通用评论，支持需求/任务/缺陷/文档等对象
-- ======================================================
DROP TABLE IF EXISTS comment;
CREATE TABLE comment (
  comment_id       BIGINT(20)   NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  target_type      VARCHAR(30)  NOT NULL COMMENT '目标类型（requirement/task/bug/document等）',
  target_id        BIGINT(20)   NOT NULL COMMENT '目标ID',
  content          TEXT         NOT NULL COMMENT '评论内容',
  parent_id        BIGINT(20)   DEFAULT 0 COMMENT '父评论ID（用于回复）',
  create_by        VARCHAR(64)  DEFAULT '' COMMENT '评论人',
  create_time      DATETIME              COMMENT '评论时间',
  update_by        VARCHAR(64)  DEFAULT '' COMMENT '更新者',
  update_time      DATETIME              COMMENT '更新时间',
  del_flag         TINYINT      DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (comment_id),
  KEY idx_target (target_type, target_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='评论表';

-- ======================================================
-- 14. 附件表（attachment）
-- 描述：通用附件表，支持多业务对象关联
-- ======================================================
DROP TABLE IF EXISTS attachment;
CREATE TABLE attachment (
  attach_id        BIGINT(20)   NOT NULL AUTO_INCREMENT COMMENT '附件ID',
  target_type      VARCHAR(30)  NOT NULL COMMENT '目标类型（requirement/task/bug/comment等）',
  target_id        BIGINT(20)   NOT NULL COMMENT '目标ID',
  file_name        VARCHAR(200) NOT NULL COMMENT '文件名',
  file_path        VARCHAR(500) NOT NULL COMMENT '存储路径',
  file_size        BIGINT(20)   DEFAULT 0 COMMENT '文件大小',
  file_type        VARCHAR(50)  DEFAULT NULL COMMENT '文件类型',
  create_by        VARCHAR(64)  DEFAULT '' COMMENT '上传人',
  create_time      DATETIME              COMMENT '上传时间',
  del_flag         TINYINT      DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (attach_id),
  KEY idx_target (target_type, target_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='附件表';

-- ======================================================
-- 15. 迭代表（sprint）
-- 描述：敏捷迭代信息，支持迭代周期与目标管理
-- ======================================================
DROP TABLE IF EXISTS sprint;
CREATE TABLE sprint (
  sprint_id        BIGINT(20)  NOT NULL AUTO_INCREMENT COMMENT '迭代ID',
  project_id       BIGINT(20)  NOT NULL COMMENT '项目ID',
  sprint_name      VARCHAR(100) NOT NULL COMMENT '迭代名称',
  start_date       DATE         DEFAULT NULL COMMENT '迭代开始日期',
  end_date         DATE         DEFAULT NULL COMMENT '迭代结束日期',
  status           TINYINT      DEFAULT 0 COMMENT '状态（0规划中 1进行中 2已完成 3已取消）',
  goal             VARCHAR(500) DEFAULT NULL COMMENT '迭代目标',
  create_by        VARCHAR(64)  DEFAULT '' COMMENT '创建者',
  create_time      DATETIME              COMMENT '创建时间',
  update_by        VARCHAR(64)  DEFAULT '' COMMENT '更新者',
  update_time      DATETIME              COMMENT '更新时间',
  del_flag         TINYINT      DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (sprint_id),
  KEY idx_project_id (project_id),
  CONSTRAINT fk_sprint_project FOREIGN KEY (project_id) REFERENCES project(project_id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='迭代表';

-- ======================================================
-- 16. 里程碑表（project_milestone）
-- 描述：项目里程碑节点，用于阶段性管理与跟踪
-- ======================================================
DROP TABLE IF EXISTS project_milestone;
CREATE TABLE project_milestone (
  milestone_id     BIGINT(20)  NOT NULL AUTO_INCREMENT COMMENT '里程碑ID',
  project_id       BIGINT(20)  NOT NULL COMMENT '项目ID',
  milestone_name   VARCHAR(100) NOT NULL COMMENT '里程碑名称',
  due_date         DATE         DEFAULT NULL COMMENT '计划完成日期',
  status           TINYINT      DEFAULT 0 COMMENT '状态（0未开始 1进行中 2已完成 3延期）',
  description      VARCHAR(500) DEFAULT NULL COMMENT '说明',
  create_by        VARCHAR(64)  DEFAULT '' COMMENT '创建者',
  create_time      DATETIME              COMMENT '创建时间',
  update_by        VARCHAR(64)  DEFAULT '' COMMENT '更新者',
  update_time      DATETIME              COMMENT '更新时间',
  del_flag         TINYINT      DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (milestone_id),
  KEY idx_project_id (project_id),
  CONSTRAINT fk_milestone_project FOREIGN KEY (project_id) REFERENCES project(project_id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='里程碑表';

-- ======================================================
-- 17. 任务历史表（task_history）
-- 描述：记录任务状态流转与操作日志（状态级别）
-- ======================================================
DROP TABLE IF EXISTS task_history;
CREATE TABLE task_history (
  history_id       BIGINT(20)  NOT NULL AUTO_INCREMENT COMMENT '历史ID',
  task_id          BIGINT(20)  NOT NULL COMMENT '任务ID',
  from_status      TINYINT     DEFAULT NULL COMMENT '变更前状态',
  to_status        TINYINT     NOT NULL COMMENT '变更后状态',
  operator_id      BIGINT(20)  DEFAULT NULL COMMENT '操作人',
  change_time      DATETIME    NOT NULL COMMENT '变更时间',
  remark           VARCHAR(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (history_id),
  KEY idx_task_id (task_id),
  KEY idx_change_time (change_time),
  CONSTRAINT fk_taskhistory_task FOREIGN KEY (task_id) REFERENCES task(task_id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='任务状态变更历史表';

-- ======================================================
-- 18. 迭代与任务关联表（task_sprint）
-- 描述：关联任务与迭代（Sprint），支持敏捷迭代规划
-- ======================================================
DROP TABLE IF EXISTS task_sprint;
CREATE TABLE task_sprint (
  id               BIGINT(20)  NOT NULL AUTO_INCREMENT COMMENT '关联ID',
  sprint_id        BIGINT(20)  NOT NULL COMMENT '迭代ID',
  task_id          BIGINT(20)  NOT NULL COMMENT '任务ID',
  added_time       DATETIME     DEFAULT NULL COMMENT '加入迭代时间',
  create_by        VARCHAR(64)  DEFAULT '' COMMENT '创建者',
  create_time      DATETIME              COMMENT '创建时间',
  PRIMARY KEY (id),
  UNIQUE KEY uk_sprint_task (sprint_id, task_id),
  KEY idx_sprint_id (sprint_id),
  KEY idx_task_id (task_id),
  CONSTRAINT fk_tasksprint_sprint FOREIGN KEY (sprint_id) REFERENCES sprint(sprint_id) ON DELETE CASCADE,
  CONSTRAINT fk_tasksprint_task   FOREIGN KEY (task_id) REFERENCES task(task_id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='迭代任务关联表';

-- ======================================================
-- 19. 燃尽图统计表（sprint_burndown）
-- 描述：按天统计迭代剩余任务数/工时，用于燃尽图生成
-- ======================================================
DROP TABLE IF EXISTS sprint_burndown;
CREATE TABLE sprint_burndown (
  id               BIGINT(20)  NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  sprint_id        BIGINT(20)  NOT NULL COMMENT '迭代ID',
  stat_date        DATE         NOT NULL COMMENT '统计日期',
  total_tasks      INT          DEFAULT 0 COMMENT '迭代总任务数',
  done_tasks       INT          DEFAULT 0 COMMENT '已完成任务数',
  remaining_tasks  INT          DEFAULT 0 COMMENT '剩余任务数',
  total_hours      DECIMAL(10,1) DEFAULT 0 COMMENT '迭代总工时',
  remaining_hours  DECIMAL(10,1) DEFAULT 0 COMMENT '剩余工时',
  ideal_remaining_hours DECIMAL(10,1) DEFAULT 0 COMMENT '理想剩余工时(可选)',
  create_time      DATETIME     NOT NULL COMMENT '生成时间',
  PRIMARY KEY (id),
  UNIQUE KEY uk_sprint_date (sprint_id, stat_date),
  KEY idx_sprint_id (sprint_id),
  CONSTRAINT fk_burndown_sprint FOREIGN KEY (sprint_id) REFERENCES sprint(sprint_id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='燃尽图统计表';

-- ======================================================
-- 20. 任务快照表（task_daily_snapshot）
-- 描述：记录任务每日状态与剩余工时，用于精确燃尽曲线回放
-- ======================================================
DROP TABLE IF EXISTS task_daily_snapshot;
CREATE TABLE task_daily_snapshot (
  id               BIGINT(20)  NOT NULL AUTO_INCREMENT COMMENT '快照ID',
  task_id          BIGINT(20)  NOT NULL COMMENT '任务ID',
  snapshot_date    DATE         NOT NULL COMMENT '快照日期',
  status           TINYINT      NOT NULL COMMENT '任务状态',
  remaining_hours  DECIMAL(10,1) DEFAULT 0 COMMENT '剩余工时(当日)',
  create_time      DATETIME     NOT NULL COMMENT '生成时间',
  PRIMARY KEY (id),
  UNIQUE KEY uk_task_date (task_id, snapshot_date),
  KEY idx_task_id (task_id),
  CONSTRAINT fk_snapshot_task FOREIGN KEY (task_id) REFERENCES task(task_id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='任务每日快照表(可选)';