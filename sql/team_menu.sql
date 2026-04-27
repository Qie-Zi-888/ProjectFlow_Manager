-- 团队管理菜单SQL脚本
-- 执行此脚本后，需要刷新浏览器或重新登录才能看到变化

-- 1. 删除旧的团队管理菜单（menu_id=2002）
DELETE FROM sys_menu WHERE menu_id = 2002;

-- 2. 插入新的团队管理菜单
INSERT INTO `sys_menu` VALUES (
  2002,                           -- menu_id
  '团队管理',                      -- menu_name
  2000,                           -- parent_id (项目管理目录下)
  3,                              -- order_num
  'team',                         -- path
  'project/team/index',           -- component
  NULL,                           -- query
  '',                             -- route_name
  1,                              -- is_frame
  0,                              -- is_cache
  'C',                            -- menu_type (C=菜单)
  '0',                            -- visible (0=显示)
  '0',                            -- status (0=正常)
  'project:team:list',            -- perms
  'peoples',                      -- icon
  'admin',                        -- create_by
  NOW(),                          -- create_time
  '',                             -- update_by
  NULL,                           -- update_time
  '团队管理菜单'                   -- remark
);

-- 3. 添加团队管理的按钮权限
-- 团队查询
INSERT INTO `sys_menu` VALUES (
  2010, '团队查询', 2002, 1, '', '', '', 1, 0, 'F', '0', '0', 'project:team:query', '#',
  'admin', NOW(), '', NULL, ''
);

-- 团队新增
INSERT INTO `sys_menu` VALUES (
  2011, '团队新增', 2002, 2, '', '', '', 1, 0, 'F', '0', '0', 'project:team:add', '#',
  'admin', NOW(), '', NULL, ''
);

-- 团队修改
INSERT INTO `sys_menu` VALUES (
  2012, '团队修改', 2002, 3, '', '', '', 1, 0, 'F', '0', '0', 'project:team:edit', '#',
  'admin', NOW(), '', NULL, ''
);

-- 团队删除
INSERT INTO `sys_menu` VALUES (
  2013, '团队删除', 2002, 4, '', '', '', 1, 0, 'F', '0', '0', 'project:team:remove', '#',
  'admin', NOW(), '', NULL, ''
);

-- 团队导出
INSERT INTO `sys_menu` VALUES (
  2014, '团队导出', 2002, 5, '', '', '', 1, 0, 'F', '0', '0', 'project:team:export', '#',
  'admin', NOW(), '', NULL, ''
);
