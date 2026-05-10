# TeamController 创建说明

## 问题描述
前端调用 `/project/team/list` 接口时出现错误：
```
NoResourceFoundException: No static resource project/team/list
```

原因是后端缺少 TeamController。

## 解决方案

创建了 `TeamController.java`，提供团队相关的 API 接口。

### 文件位置
`ruoyi-project/src/main/java/com/ruoyi/project/controller/TeamController.java`

### 主要功能

#### 1. 查询团队列表
- **接口**: `GET /project/team/list`
- **权限**: `project:team:list`
- **功能**: 从 project_member 表中获取所有不同的团队
- **实现**: 通过 stream 对 team_id 进行去重

#### 2. 获取团队详情
- **接口**: `GET /project/team/{teamId}`
- **权限**: `project:team:query`
- **功能**: 根据 teamId 获取团队详细信息

## 注意事项

### 1. 数据依赖
TeamController 依赖于 `project_member` 表中的 `team_id` 和 `team_name` 字段。

**必须先执行数据库迁移脚本**：
```bash
mysql -u username -p database_name < sql/add_team_fields.sql
```

### 2. 团队数据来源
团队信息来源于 `project_member` 表：
- 每个团队成员记录包含 `team_id` 和 `team_name`
- Controller 会对相同 `team_id` 的记录进行去重
- 返回唯一的团队列表

### 3. 权限配置
确保在数据库中添加了以下权限：
- `project:team:list` - 团队查询
- `project:team:query` - 团队详细查询

这些权限已在 `sql/team_menu.sql` 中定义。

### 4. 如果 team_id 为空的情况
如果 `project_member` 表中还没有 team_id 数据：
- 团队列表将返回空
- 需要先为项目成员分配 team_id

**示例 SQL**：
```sql
-- 为现有的项目成员分配团队ID（根据实际情况修改）
UPDATE project_member 
SET team_id = 1, team_name = '开发团队'
WHERE project_role = 'developer';

UPDATE project_member 
SET team_id = 2, team_name = '测试团队'
WHERE project_role = 'tester';
```

## 使用流程

1. **执行数据库迁移**
   ```bash
   mysql -u username -p database_name < sql/add_team_fields.sql
   ```

2. **初始化团队数据**（如果需要）
   ```sql
   -- 为现有成员分配团队
   UPDATE project_member SET team_id = 1, team_name = '默认团队' WHERE team_id IS NULL;
   ```

3. **重新编译后端**
   ```bash
   mvn clean package
   ```

4. **重启应用**

5. **测试接口**
   - 访问项目列表页面
   - 点击"新增"或"修改"项目
   - "负责团队"选择器应该能正常加载团队列表

## 替代方案

如果希望团队管理更加独立，可以考虑：

### 方案A：创建独立的 team 表
```sql
CREATE TABLE team (
  team_id BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '团队ID',
  team_name VARCHAR(100) NOT NULL COMMENT '团队名称',
  description VARCHAR(500) DEFAULT NULL COMMENT '团队描述',
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (team_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='团队表';
```

然后修改 TeamController 直接查询 team 表。

### 方案B：使用字典数据
将团队作为字典类型管理，使用若依自带的字典功能。

## 当前实现的优缺点

### 优点
- ✅ 无需创建新表，利用现有数据结构
- ✅ 团队成员和团队信息在同一张表，便于管理
- ✅ 实现简单，代码量少

### 缺点
- ❌ 团队信息分散在多个成员记录中，需要去重
- ❌ 如果成员没有 team_id，团队列表为空
- ❌ 团队名称可能不一致（不同记录的 team_name 可能不同）

## 建议

对于生产环境，建议采用**方案A**（独立的 team 表），这样可以：
1. 更好地管理团队信息
2. 避免数据冗余和不一致
3. 支持团队的独立 CRUD 操作
4. 更清晰的数据库设计
