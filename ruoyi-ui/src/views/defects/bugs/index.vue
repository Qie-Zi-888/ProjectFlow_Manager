<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="80px">
      <el-form-item label="所属项目" prop="projectId">
        <el-select v-model="queryParams.projectId" placeholder="请选择所属项目" clearable>
          <el-option
            v-for="project in projectList"
            :key="project.projectId"
            :label="project.projectName"
            :value="project.projectId"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="发现版本" prop="foundVersion">
        <el-input
          v-model="queryParams.foundVersion"
          placeholder="请输入发现版本"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="缺陷标题" prop="bugTitle">
        <el-input
          v-model="queryParams.bugTitle"
          placeholder="请输入缺陷标题"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="严重程度" prop="severity">
        <el-select v-model="queryParams.severity" placeholder="请选择严重程度" clearable>
          <el-option label="致命" value="1" />
          <el-option label="严重" value="2" />
          <el-option label="一般" value="3" />
          <el-option label="轻微" value="4" />
        </el-select>
      </el-form-item>
      <el-form-item label="优先级" prop="priority">
        <el-select v-model="queryParams.priority" placeholder="请选择优先级" clearable>
          <el-option label="最高" value="1" />
          <el-option label="高" value="2" />
          <el-option label="中" value="3" />
          <el-option label="低" value="4" />
          <el-option label="最低" value="5" />
        </el-select>
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
          <el-option label="新建" :value="0" />
          <el-option label="已分配" :value="1" />
          <el-option label="处理中" :value="2" />
          <el-option label="已修复" :value="3" />
          <el-option label="关闭" :value="4" />
          <el-option label="拒绝" :value="5" />
        </el-select>
      </el-form-item>
      <el-form-item label="指派给" prop="assignTo">
        <el-select v-model="queryParams.assignTo" placeholder="请选择指派给" clearable>
          <el-option
            v-for="user in userList"
            :key="user.userId"
            :label="user.nickName"
            :value="user.userId"
          />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['defects:bugs:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['defects:bugs:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['defects:bugs:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['defects:bugs:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="bugsList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="缺陷ID" align="center" prop="bugId" width="60" />
      <el-table-column label="所属项目" align="center" prop="projectId" min-width="150">
        <template slot-scope="scope">
          <span>{{ getProjectName(scope.row.projectId) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="缺陷标题" align="center" prop="bugTitle" min-width="200" show-overflow-tooltip />
      <el-table-column label="严重程度" align="center" prop="severity" width="90">
        <template slot-scope="scope">
          <span>{{ severityFormatter(scope.row.severity) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="优先级" align="center" prop="priority" width="60">
        <template slot-scope="scope">
          <span :class="'pri-' + scope.row.priority">{{ scope.row.priority }}</span>
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center" prop="status" width="90">
        <template slot-scope="scope">
          <span>{{ statusFormatter(scope.row.status) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="指派给" align="center" prop="assignTo" width="100">
        <template slot-scope="scope">
          <span>{{ getUserName(scope.row.assignTo) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="发现版本" align="center" prop="foundVersion" width="100" />
      <el-table-column label="修复版本" align="center" prop="fixedVersion" width="100" />
      <el-table-column label="创建时间" align="center" prop="createTime" width="120">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['defects:bugs:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['defects:bugs:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改缺陷对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="800px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="所属项目" prop="projectId">
              <el-select v-model="form.projectId" placeholder="请选择所属项目" style="width: 100%">
                <el-option
                  v-for="project in projectList"
                  :key="project.projectId"
                  :label="project.projectName"
                  :value="project.projectId"
                />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="关联需求ID" prop="reqId">
              <el-input v-model="form.reqId" placeholder="请输入关联需求ID" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="所属模块" prop="moduleId">
              <el-input v-model="form.moduleId" placeholder="请输入所属模块" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="发现版本" prop="foundVersion">
              <el-input v-model="form.foundVersion" placeholder="请输入发现版本" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="修复版本" prop="fixedVersion">
              <el-input v-model="form.fixedVersion" placeholder="请输入修复版本" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="缺陷标题" prop="bugTitle">
              <el-input v-model="form.bugTitle" placeholder="请输入缺陷标题" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="详细描述" prop="description">
          <el-input v-model="form.description" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-row>
          <el-col :span="12">
            <el-form-item label="严重程度" prop="severity">
              <el-select v-model="form.severity" placeholder="请选择严重程度" style="width: 100%">
                <el-option label="致命" value="1" />
                <el-option label="严重" value="2" />
                <el-option label="一般" value="3" />
                <el-option label="轻微" value="4" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="优先级" prop="priority">
              <el-select v-model="form.priority" placeholder="请选择优先级" style="width: 100%">
                <el-option label="最高" value="1" />
                <el-option label="高" value="2" />
                <el-option label="中" value="3" />
                <el-option label="低" value="4" />
                <el-option label="最低" value="5" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="状态" prop="status">
              <el-select v-model="form.status" placeholder="请选择状态" style="width: 100%">
                <el-option label="新建" :value="0" />
                <el-option label="已分配" :value="1" />
                <el-option label="处理中" :value="2" />
                <el-option label="已修复" :value="3" />
                <el-option label="关闭" :value="4" />
                <el-option label="拒绝" :value="5" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="指派给" prop="assignTo">
              <el-select v-model="form.assignTo" placeholder="请选择指派给" style="width: 100%">
                <el-option
                  v-for="user in userList"
                  :key="user.userId"
                  :label="user.nickName"
                  :value="user.userId"
                />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="解决人" prop="resolvedBy">
              <el-select v-model="form.resolvedBy" placeholder="请选择解决人" style="width: 100%">
                <el-option
                  v-for="user in userList"
                  :key="user.userId"
                  :label="user.nickName"
                  :value="user.userId"
                />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="解决时间" prop="resolvedTime">
              <el-date-picker clearable
                v-model="form.resolvedTime"
                type="date"
                value-format="yyyy-MM-dd"
                placeholder="请选择解决时间">
              </el-date-picker>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="关闭人" prop="closedBy">
              <el-select v-model="form.closedBy" placeholder="请选择关闭人" style="width: 100%">
                <el-option
                  v-for="user in userList"
                  :key="user.userId"
                  :label="user.nickName"
                  :value="user.userId"
                />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="关闭时间" prop="closedTime">
              <el-date-picker clearable
                v-model="form.closedTime"
                type="date"
                value-format="yyyy-MM-dd"
                placeholder="请选择关闭时间">
              </el-date-picker>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listBugs, getBugs, delBugs, addBugs, updateBugs } from "@/api/defects/bugs"
import { listProject } from "@/api/project/project"
import { listUser } from "@/api/system/user"

export default {
  name: "Bugs",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 缺陷表格数据
      bugsList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 项目列表
      projectList: [],
      // 用户列表
      userList: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        projectId: null,
        foundVersion: null,
        bugTitle: null,
        severity: null,
        priority: null,
        status: null,
        assignTo: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        projectId: [
          { required: true, message: "所属项目不能为空", trigger: "change" }
        ],
        bugTitle: [
          { required: true, message: "缺陷标题不能为空", trigger: "blur" }
        ],
      }
    }
  },
  created() {
    this.getList()
    this.getProjectList()
    this.getUserList()
  },
  methods: {
    /** 查询缺陷列表 */
    getList() {
      this.loading = true
      listBugs(this.queryParams).then(response => {
        this.bugsList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    /** 查询项目列表 */
    getProjectList() {
      listProject({ pageNum: 1, pageSize: 1000 }).then(response => {
        this.projectList = response.rows
      })
    },
    /** 查询用户列表 */
    getUserList() {
      listUser({ pageNum: 1, pageSize: 1000 }).then(response => {
        this.userList = response.rows
      })
    },
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表单重置
    reset() {
      this.form = {
        bugId: null,
        projectId: null,
        reqId: null,
        moduleId: null,
        foundVersion: null,
        fixedVersion: null,
        bugTitle: null,
        description: null,
        severity: null,
        priority: null,
        status: null,
        assignTo: null,
        resolvedBy: null,
        resolvedTime: null,
        closedBy: null,
        closedTime: null,
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null,
        delFlag: null
      }
      this.resetForm("form")
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.bugId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加缺陷"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const bugId = row.bugId || this.ids
      getBugs(bugId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改缺陷"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.bugId != null) {
            updateBugs(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addBugs(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const bugIds = row.bugId || this.ids
      this.$modal.confirm('是否确认删除缺陷编号为"' + bugIds + '"的数据项？').then(function() {
        return delBugs(bugIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('defects/bugs/export', {
        ...this.queryParams
      }, `bugs_${new Date().getTime()}.xlsx`)
    },
    /** 获取项目名称 */
    getProjectName(projectId) {
      if (!projectId) return '-'
      const project = this.projectList.find(p => p.projectId === projectId)
      return project ? project.projectName : projectId
    },
    /** 获取用户名称 */
    getUserName(userId) {
      if (!userId) return '-'
      // 类型转换，确保比较时类型一致
      const user = this.userList.find(u => Number(u.userId) === Number(userId))
      return user ? user.nickName : userId
    },
    /** 严重程度格式化 */
    severityFormatter(severity) {
      const map = {
        '1': '致命',
        '2': '严重',
        '3': '一般',
        '4': '轻微'
      }
      return map[severity] || severity
    },
    /** 优先级格式化 */
    priorityFormatter(priority) {
      const map = {
        '1': '最高',
        '2': '高',
        '3': '中',
        '4': '低',
        '5': '最低'
      }
      return map[priority] || priority
    },
    /** 状态格式化 */
    statusFormatter(status) {
      const map = {
        0: '新建',
        1: '已分配',
        2: '处理中',
        3: '已修复',
        4: '关闭',
        5: '拒绝'
      }
      return map[status] !== undefined ? map[status] : status
    }
  }
}
</script>

<style scoped>
/* 优先级圆形徽章 */
.pri-1,
.pri-2,
.pri-3,
.pri-4,
.pri-5 {
  display: inline-block;
  width: 20px;
  height: 20px;
  line-height: 18px;
  text-align: center;
  border-radius: 50%;
  font-size: 12px;
  font-weight: bold;
  border: 1px solid;
}

.pri-1 {
  color: #FF4D4F;
  border-color: #FF4D4F;
}

.pri-2 {
  color: #FFA940;
  border-color: #FFA940;
}

.pri-3 {
  color: #2B80FF;
  border-color: #2B80FF;
}

.pri-4 {
  color: #52c41a;
  border-color: #52c41a;
}

.pri-5 {
  color: #8c8c8c;
  border-color: #8c8c8c;
}
</style>