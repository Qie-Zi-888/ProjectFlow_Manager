<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="所属项目" prop="projectId">
        <el-select
          v-model="queryParams.projectId"
          placeholder="请选择所属项目"
          clearable
          style="width: 200px"
          @change="handleQueryProjectChange"
        >
          <el-option
            v-for="item in projectOptions"
            :key="item.projectId"
            :label="item.projectName"
            :value="item.projectId"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="关联需求 ID" prop="reqId">
        <el-input
          v-model="queryParams.reqId"
          placeholder="请输入关联需求 ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="所属模块" prop="moduleId">
        <el-select
          v-model="queryParams.moduleId"
          placeholder="请选择所属模块"
          clearable
          style="width: 200px"
          :disabled="!queryParams.projectId"
        >
          <el-option
            v-for="item in moduleOptions"
            :key="item.moduleId"
            :label="item.moduleName"
            :value="item.moduleId"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="书签标识" prop="bookmark">
        <el-input
          v-model="queryParams.bookmark"
          placeholder="请输入书签标识"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="任务名称" prop="taskName">
        <el-input
          v-model="queryParams.taskName"
          placeholder="请输入任务名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="优先级" prop="priority">
        <el-select
          v-model="queryParams.priority"
          placeholder="请选择优先级"
          clearable
          style="width: 120px"
        >
          <el-option label="最高" value="1" />
          <el-option label="高" value="2" />
          <el-option label="中" value="3" />
          <el-option label="低" value="4" />
        </el-select>
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select
          v-model="queryParams.status"
          placeholder="请选择状态"
          clearable
          style="width: 120px"
        >
          <el-option label="未开始" value="0" />
          <el-option label="进行中" value="1" />
          <el-option label="已完成" value="2" />
          <el-option label="暂停" value="3" />
        </el-select>
      </el-form-item>
      <el-form-item label="指派给" prop="assignTo">
        <el-select
          v-model="queryParams.assignTo"
          placeholder="请选择用户"
          clearable
          style="width: 150px"
          filterable
        >
          <el-option
            v-for="user in userOptions"
            :key="user.userId"
            :label="user.nickName"
            :value="user.userId"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="计划开始日期" prop="planStartDate">
        <el-date-picker clearable
          v-model="queryParams.planStartDate"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择计划开始日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="计划结束日期" prop="planEndDate">
        <el-date-picker clearable
          v-model="queryParams.planEndDate"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择计划结束日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="截止日期" prop="deadline">
        <el-date-picker clearable
          v-model="queryParams.deadline"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择截止日期">
        </el-date-picker>
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
          v-hasPermi="['execute:task:add']"
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
          v-hasPermi="['execute:task:edit']"
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
          v-hasPermi="['execute:task:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['execute:task:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="taskList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="任务ID" align="center" prop="taskId" />
      <el-table-column label="书签标识" align="center" prop="bookmark" />
      <el-table-column label="任务名称" align="center" prop="taskName" />
      <el-table-column label="任务类型" align="center" prop="taskType" />
      <el-table-column label="优先级" align="center">
        <template slot-scope="scope">
          <span>{{ priorityFormat(scope.row.priority) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center">
        <template slot-scope="scope">
          <span>{{ statusFormat(scope.row.status) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="指派给" align="center" prop="assignToName" />
      <el-table-column label="预估工时" align="center" prop="estimateTime" />
      <el-table-column label="已消耗工时" align="center" prop="consumedTime" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['execute:task:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['execute:task:remove']"
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

    <!-- 添加或修改任务对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="所属项目" prop="projectId">
          <el-select
            v-model="form.projectId"
            placeholder="请选择所属项目"
            clearable
            style="width: 240px"
            @change="handleFormProjectChange"
          >
            <el-option
              v-for="item in projectOptions"
              :key="item.projectId"
              :label="item.projectName"
              :value="item.projectId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="关联需求 ID" prop="reqId">
          <el-input v-model="form.reqId" placeholder="请输入关联需求 ID" />
        </el-form-item>
        <el-form-item label="所属模块" prop="moduleId">
          <el-select
            v-model="form.moduleId"
            placeholder="请选择所属模块"
            clearable
            style="width: 240px"
            :disabled="!form.projectId"
          >
            <el-option
              v-for="item in moduleOptions"
              :key="item.moduleId"
              :label="item.moduleName"
              :value="item.moduleId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="书签标识" prop="bookmark">
          <el-input v-model="form.bookmark" placeholder="请输入书签标识" />
        </el-form-item>
        <el-form-item label="任务名称" prop="taskName">
          <el-input v-model="form.taskName" placeholder="请输入任务名称" />
        </el-form-item>
        <el-form-item label="详细描述" prop="description">
          <el-input v-model="form.description" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="任务类型" prop="taskType">
          <el-select v-model="form.taskType" placeholder="请选择任务类型">
            <el-option label="开发" value="development" />
            <el-option label="测试" value="test" />
            <el-option label="设计" value="design" />
            <el-option label="会议" value="meeting" />
          </el-select>
        </el-form-item>
        <el-form-item label="优先级" prop="priority">
          <el-select v-model="form.priority" placeholder="请选择优先级">
            <el-option label="最高" value="1" />
            <el-option label="高" value="2" />
            <el-option label="中" value="3" />
            <el-option label="低" value="4" />
          </el-select>
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-select v-model="form.status" placeholder="请选择状态">
            <el-option label="未开始" value="0" />
            <el-option label="进行中" value="1" />
            <el-option label="已完成" value="2" />
            <el-option label="暂停" value="3" />
          </el-select>
        </el-form-item>
        <el-form-item label="指派给" prop="assignTo">
          <el-select
            v-model="form.assignTo"
            filterable
            placeholder="请选择用户"
            clearable
          >
            <el-option
              v-for="user in userOptions"
              :key="user.userId"
              :label="user.nickName"
              :value="user.userId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="预估工时" prop="estimateTime">
          <el-input-number v-model="form.estimateTime" :precision="1" :min="0" step="0.5" placeholder="请输入预估工时" style="width: 100%;" />
        </el-form-item>
        <el-form-item label="已消耗工时" prop="consumedTime">
          <el-input-number v-model="form.consumedTime" :precision="1" :min="0" step="0.5" placeholder="请输入已消耗工时" style="width: 100%;" />
        </el-form-item>
        <el-form-item label="计划开始日期" prop="planStartDate">
          <el-date-picker clearable
            v-model="form.planStartDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择计划开始日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="计划结束日期" prop="planEndDate">
          <el-date-picker clearable
            v-model="form.planEndDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择计划结束日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="截止日期" prop="deadline">
          <el-date-picker clearable
            v-model="form.deadline"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择截止日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="删除标志" prop="delFlag">
          <el-input v-model="form.delFlag" placeholder="请输入删除标志" />
        </el-form-item>
        <el-divider content-position="center">工时记录信息</el-divider>
        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button type="primary" icon="el-icon-plus" size="mini" @click="handleAddWorkLog">添加</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="danger" icon="el-icon-delete" size="mini" @click="handleDeleteWorkLog">删除</el-button>
          </el-col>
        </el-row>
        <el-table :data="workLogList" :row-class-name="rowWorkLogIndex" @selection-change="handleWorkLogSelectionChange" ref="workLog">
          <el-table-column type="selection" width="50" align="center" />
          <el-table-column label="序号" align="center" prop="index" width="50"/>
          <el-table-column label="记录人" prop="userId" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.userId" placeholder="请输入记录人" />
            </template>
          </el-table-column>
          <el-table-column label="工作日期" prop="workDate" width="240">
            <template slot-scope="scope">
              <el-date-picker clearable v-model="scope.row.workDate" type="date" value-format="yyyy-MM-dd" placeholder="请选择工作日期" />
            </template>
          </el-table-column>
          <el-table-column label="工时数" prop="hours" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.hours" placeholder="请输入工时数" />
            </template>
          </el-table-column>
        </el-table>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listTask, getTask, delTask, addTask, updateTask } from "@/api/execute/task"
import { listProject } from "@/api/project/project"
import { listModule } from "@/api/project/module"
import { listUser } from "@/api/system/user"

export default {
  name: "Task",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 子表选中数据
      checkedWorkLog: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 任务表格数据
      taskList: [],
      // 工时记录表格数据
      workLogList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        projectId: null,
        reqId: null,
        moduleId: null,
        bookmark: null,
        taskName: null,
        priority: null,
        status: null,
        assignTo: null,
        planStartDate: null,
        planEndDate: null,
        deadline: null,
      },
      // 表单参数
      form: {},
      // 项目选项
      projectOptions: [],
      // 模块选项
      moduleOptions: [],
      // 用户选项
      userOptions: [],
      // 优先级字典
      priorityOptions: [
        { label: '最高', value: '1' },
        { label: '高', value: '2' },
        { label: '中', value: '3' },
        { label: '低', value: '4' }
      ],
      // 状态字典
      statusOptions: [
        { label: '未开始', value: '0' },
        { label: '进行中', value: '1' },
        { label: '已完成', value: '2' },
        { label: '暂停', value: '3' }
      ],
      // 表单校验
      rules: {
        projectId: [
          { required: true, message: "所属项目不能为空", trigger: "blur" }
        ],
        taskName: [
          { required: true, message: "任务名称不能为空", trigger: "blur" }
        ],
      }
    }
  },
  created() {
    this.getList()
    this.getProjectOptions()
    this.getModuleOptions()
    this.getUserOptions()
  },
  methods: {
    /** 查询任务列表 */
    getList() {
      this.loading = true
      listTask(this.queryParams).then(response => {
        this.taskList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    /** 查询项目选项 */
    getProjectOptions() {
      listProject({ pageNum: 1, pageSize: 1000 }).then(response => {
        this.projectOptions = response.rows || []
      }).catch(() => {
        this.projectOptions = []
      })
    },
    /** 查询模块选项 */
    getModuleOptions(projectId) {
      if (!projectId) {
        this.moduleOptions = []
        return
      }
      listModule({ pageNum: 1, pageSize: 1000, projectId: projectId }).then(response => {
        this.moduleOptions = response.rows || []
      }).catch(() => {
        this.moduleOptions = []
      })
    },
    /** 查询用户选项 */
    getUserOptions() {
      listUser({ pageNum: 1, pageSize: 1000, status: 0 }).then(response => {
        this.userOptions = response.rows || []
      }).catch(() => {
        this.userOptions = []
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
        taskId: null,
        projectId: null,
        reqId: null,
        moduleId: null,
        bookmark: null,
        taskName: null,
        description: null,
        taskType: null,
        priority: null,
        status: null,
        assignTo: null,
        estimateTime: null,
        consumedTime: null,
        planStartDate: null,
        planEndDate: null,
        deadline: null,
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null,
        delFlag: null
      }
      this.workLogList = []
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
      this.ids = selection.map(item => item.taskId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加任务"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const taskId = row.taskId || this.ids
      getTask(taskId).then(response => {
        this.form = response.data
        this.workLogList = response.data.workLogList
        this.open = true
        this.title = "修改任务"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.form.workLogList = this.workLogList
          if (this.form.taskId != null) {
            updateTask(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addTask(this.form).then(response => {
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
      const taskIds = row.taskId || this.ids
      this.$modal.confirm('是否确认删除任务编号为"' + taskIds + '"的数据项？').then(function() {
        return delTask(taskIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
	/** 工时记录序号 */
    rowWorkLogIndex({ row, rowIndex }) {
      row.index = rowIndex + 1
    },
    /** 工时记录添加按钮操作 */
    handleAddWorkLog() {
      let obj = {}
      obj.userId = ""
      obj.workDate = ""
      obj.hours = ""
      obj.description = ""
      this.workLogList.push(obj)
    },
    /** 工时记录删除按钮操作 */
    handleDeleteWorkLog() {
      if (this.checkedWorkLog.length == 0) {
        this.$modal.msgError("请先选择要删除的工时记录数据")
      } else {
        const workLogList = this.workLogList
        const checkedWorkLog = this.checkedWorkLog
        this.workLogList = workLogList.filter(function(item) {
          return checkedWorkLog.indexOf(item.index) == -1
        })
      }
    },
    /** 复选框选中数据 */
    handleWorkLogSelectionChange(selection) {
      this.checkedWorkLog = selection.map(item => item.index)
    },
    /** 优先级格式化 */
    priorityFormat(priority) {
      if (!priority) return ''
      const option = this.priorityOptions.find(item => item.value === String(priority))
      return option ? option.label : ''
    },
    /** 状态格式化 */
    statusFormat(status) {
      if (status === null || status === undefined) return ''
      const option = this.statusOptions.find(item => item.value === String(status))
      return option ? option.label : ''
    },
    /** 搜索栏项目变更处理 */
    handleQueryProjectChange(projectId) {
      if (projectId) {
        this.getModuleOptions(projectId)
      } else {
        this.moduleOptions = []
        this.queryParams.moduleId = null
      }
    },
    /** 表单项目变更处理 */
    handleFormProjectChange(projectId) {
      if (projectId) {
        this.getModuleOptions(projectId)
      } else {
        this.moduleOptions = []
        this.form.moduleId = null
      }
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('execute/task/export', {
        ...this.queryParams
      }, `task_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
