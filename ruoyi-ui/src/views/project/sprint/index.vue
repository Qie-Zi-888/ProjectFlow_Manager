<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="项目名称" prop="projectName">
        <el-input
          v-model="queryParams.projectName"
          placeholder="请输入项目名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="项目 ID" prop="projectId">
        <el-input
          v-model="queryParams.projectId"
          placeholder="请输入项目ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="书签标识" prop="bookmark">
        <el-input
          v-model="queryParams.bookmark"
          placeholder="请输入书签标识"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="迭代名称" prop="sprintName">
        <el-input
          v-model="queryParams.sprintName"
          placeholder="请输入迭代名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
          <el-option label="规划中" value="0" />
          <el-option label="进行中" value="1" />
          <el-option label="已完成" value="2" />
          <el-option label="已取消" value="3" />
        </el-select>
      </el-form-item>
      <el-form-item label="进度" prop="progress">
        <el-input
          v-model="queryParams.progress"
          placeholder="请输入进度"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="迭代开始日期" prop="startDate">
        <el-date-picker clearable
          v-model="queryParams.startDate"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择迭代开始日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="迭代结束日期" prop="endDate">
        <el-date-picker clearable
          v-model="queryParams.endDate"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择迭代结束日期">
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
          v-hasPermi="['project:sprint:add']"
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
          v-hasPermi="['project:sprint:edit']"
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
          v-hasPermi="['project:sprint:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['project:sprint:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="sprintList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="迭代ID" align="center" prop="sprintId" />
      <el-table-column label="书签标识" align="center" prop="bookmark" />
      <el-table-column label="迭代名称" align="center" prop="sprintName" />
      <el-table-column label="状态" align="center" prop="status" :formatter="statusFormatter" />
      <el-table-column label="进度" align="center" prop="progress" />
      <el-table-column label="迭代开始日期" align="center" prop="startDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.startDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="迭代结束日期" align="center" prop="endDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.endDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="迭代目标" align="center" prop="goal" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['project:sprint:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['project:sprint:remove']"
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

    <!-- 添加或修改迭代对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="项目ID" prop="projectId">
          <el-input v-model="form.projectId" placeholder="请输入项目ID" />
        </el-form-item>
        <el-form-item label="书签标识" prop="bookmark">
          <el-input v-model="form.bookmark" placeholder="请输入书签标识" />
        </el-form-item>
        <el-form-item label="迭代数" prop="sprintNumber">
          <el-input v-model="form.sprintNumber" placeholder="请输入迭代数" />
        </el-form-item>
        <el-form-item label="迭代名称" prop="sprintName">
          <el-input v-model="form.sprintName" placeholder="请输入迭代名称" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-select v-model="form.status" placeholder="请选择状态" style="width: 100%;">
            <el-option label="规划中" value="0" />
            <el-option label="进行中" value="1" />
            <el-option label="已完成" value="2" />
            <el-option label="已取消" value="3" />
          </el-select>
        </el-form-item>
        <el-form-item label="进度" prop="progress">
          <el-input v-model="form.progress" placeholder="请输入进度" />
        </el-form-item>
        <el-form-item label="迭代开始日期" prop="startDate">
          <el-date-picker clearable
            v-model="form.startDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择迭代开始日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="迭代结束日期" prop="endDate">
          <el-date-picker clearable
            v-model="form.endDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择迭代结束日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="迭代目标" prop="goal">
          <el-input v-model="form.goal" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="删除标志" prop="delFlag">
        </el-form-item>
        <el-divider content-position="center">燃尽图统计信息</el-divider>
        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button type="primary" icon="el-icon-plus" size="mini" @click="handleAddSprintBurndown">添加</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="danger" icon="el-icon-delete" size="mini" @click="handleDeleteSprintBurndown">删除</el-button>
          </el-col>
        </el-row>
        <el-table :data="sprintBurndownList" :row-class-name="rowSprintBurndownIndex" @selection-change="handleSprintBurndownSelectionChange" ref="sprintBurndown">
          <el-table-column type="selection" width="50" align="center" />
          <el-table-column label="序号" align="center" prop="index" width="50"/>
          <el-table-column label="统计日期" prop="statDate" width="240">
            <template slot-scope="scope">
              <el-date-picker clearable v-model="scope.row.statDate" type="date" value-format="yyyy-MM-dd" placeholder="请选择统计日期" />
            </template>
          </el-table-column>
          <el-table-column label="迭代总任务数" prop="totalTasks" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.totalTasks" placeholder="请输入迭代总任务数" />
            </template>
          </el-table-column>
          <el-table-column label="已完成任务数" prop="doneTasks" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.doneTasks" placeholder="请输入已完成任务数" />
            </template>
          </el-table-column>
          <el-table-column label="剩余任务数" prop="remainingTasks" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.remainingTasks" placeholder="请输入剩余任务数" />
            </template>
          </el-table-column>
          <el-table-column label="迭代总工时" prop="totalHours" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.totalHours" placeholder="请输入迭代总工时" />
            </template>
          </el-table-column>
          <el-table-column label="剩余工时" prop="remainingHours" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.remainingHours" placeholder="请输入剩余工时" />
            </template>
          </el-table-column>
          <el-table-column label="理想剩余工时(可选)" prop="idealRemainingHours" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.idealRemainingHours" placeholder="请输入理想剩余工时(可选)" />
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
import { listSprint, getSprint, delSprint, addSprint, updateSprint } from "@/api/project/sprint"

export default {
  name: "Sprint",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 子表选中数据
      checkedSprintBurndown: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 迭代表格数据
      sprintList: [],
      // 燃尽图统计表格数据
      sprintBurndownList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        projectId: null,
        bookmark: null,
        sprintName: null,
        status: null,
        progress: null,
        startDate: null,
        endDate: null,
        goal: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        projectId: [
          { required: true, message: "项目 ID 不能为空", trigger: "blur" }
        ],
        sprintNumber: [
          { required: true, message: "迭代数不能为空", trigger: "blur" }
        ],
        sprintName: [
          { required: true, message: "迭代名称不能为空", trigger: "blur" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询迭代列表 */
    getList() {
      this.loading = true
      listSprint(this.queryParams).then(response => {
        this.sprintList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    // 状态格式化显示
    statusFormatter(row) {
      const statusMap = {
        0: '规划中',
        1: '进行中',
        2: '已完成',
        3: '已取消'
      }
      return statusMap[row.status] || row.status
    },
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表单重置
    reset() {
      this.form = {
        sprintId: null,
        projectId: null,
        bookmark: null,
        sprintNumber: null,
        sprintName: null,
        status: null,
        progress: null,
        startDate: null,
        endDate: null,
        goal: null,
        projectName: null,
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null,
        delFlag: null
      }
      this.sprintBurndownList = []
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
      this.ids = selection.map(item => item.sprintId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加迭代"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const sprintId = row.sprintId || this.ids
      getSprint(sprintId).then(response => {
        this.form = response.data
        this.sprintBurndownList = response.data.sprintBurndownList
        this.open = true
        this.title = "修改迭代"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.form.sprintBurndownList = this.sprintBurndownList
          if (this.form.sprintId != null) {
            updateSprint(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addSprint(this.form).then(response => {
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
      const sprintIds = row.sprintId || this.ids
      this.$modal.confirm('是否确认删除迭代编号为"' + sprintIds + '"的数据项？').then(function() {
        return delSprint(sprintIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
	/** 燃尽图统计序号 */
    rowSprintBurndownIndex({ row, rowIndex }) {
      row.index = rowIndex + 1
    },
    /** 燃尽图统计添加按钮操作 */
    handleAddSprintBurndown() {
      let obj = {}
      obj.statDate = ""
      obj.totalTasks = ""
      obj.doneTasks = ""
      obj.remainingTasks = ""
      obj.totalHours = ""
      obj.remainingHours = ""
      obj.idealRemainingHours = ""
      this.sprintBurndownList.push(obj)
    },
    /** 燃尽图统计删除按钮操作 */
    handleDeleteSprintBurndown() {
      if (this.checkedSprintBurndown.length == 0) {
        this.$modal.msgError("请先选择要删除的燃尽图统计数据")
      } else {
        const sprintBurndownList = this.sprintBurndownList
        const checkedSprintBurndown = this.checkedSprintBurndown
        this.sprintBurndownList = sprintBurndownList.filter(function(item) {
          return checkedSprintBurndown.indexOf(item.index) == -1
        })
      }
    },
    /** 复选框选中数据 */
    handleSprintBurndownSelectionChange(selection) {
      this.checkedSprintBurndown = selection.map(item => item.index)
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('project/sprint/export', {
        ...this.queryParams
      }, `sprint_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
