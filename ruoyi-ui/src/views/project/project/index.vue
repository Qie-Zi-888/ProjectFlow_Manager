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
      <el-form-item label="项目编码" prop="projectCode">
        <el-input
          v-model="queryParams.projectCode"
          placeholder="请输入项目编码"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="优先级" prop="priority">
        <el-input
          v-model="queryParams.priority"
          placeholder="请输入优先级"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="计划开始日期" prop="startDate">
        <el-date-picker clearable
                        v-model="queryParams.startDate"
                        type="date"
                        value-format="yyyy-MM-dd"
                        placeholder="请选择计划开始日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="计划结束日期" prop="endDate">
        <el-date-picker clearable
                        v-model="queryParams.endDate"
                        type="date"
                        value-format="yyyy-MM-dd"
                        placeholder="请选择计划结束日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="实际开始日期" prop="realStartDate">
        <el-date-picker clearable
                        v-model="queryParams.realStartDate"
                        type="date"
                        value-format="yyyy-MM-dd"
                        placeholder="请选择实际开始日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="实际结束日期" prop="realEndDate">
        <el-date-picker clearable
                        v-model="queryParams.realEndDate"
                        type="date"
                        value-format="yyyy-MM-dd"
                        placeholder="请选择实际结束日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="项目负责人姓名" prop="ownerName">
        <el-input
          v-model="queryParams.ownerName"
          placeholder="请输入项目负责人姓名"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="项目状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择项目状态" clearable>
          <el-option label="进行中" value="0" />
          <el-option label="已完成" value="1" />
          <el-option label="暂停" value="2" />
          <el-option label="已取消" value="3" />
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
          v-hasPermi="['project:project:add']"
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
          v-hasPermi="['project:project:edit']"
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
          v-hasPermi="['project:project:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['project:project:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="projectList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="项目ID" align="center" prop="projectId" />
      <el-table-column label="项目名称" align="center" prop="projectName" />
      <el-table-column label="项目状态" align="center" prop="status"  :formatter="statusFormatter"/>
      <el-table-column label="优先级" align="center" prop="priority" />
      <el-table-column label="预算" align="center" prop="Budget" />
      <el-table-column label="需求总数" align="center" prop="requirementCount" />
      <el-table-column label="已投入" align="center" prop="Investment" />
      <el-table-column label="计划开始日期" align="center" prop="startDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.startDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="计划结束日期" align="center" prop="endDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.endDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="实际开始日期" align="center" prop="realStartDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.realStartDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="实际结束日期" align="center" prop="realEndDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.realEndDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="项目进度" align="center" prop="progress" />
      <el-table-column label="项目负责人姓名" align="center" prop="ownerName" />
      <el-table-column label="创建者" align="center" prop="createBy" />
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="更新者" align="center" prop="updateBy" />
      <el-table-column label="更新时间" align="center" prop="updateTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.updateTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['project:project:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['project:project:remove']"
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

    <!-- 添加或修改项目对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="项目名称" prop="projectName">
          <el-input v-model="form.projectName" placeholder="请输入项目名称" />
        </el-form-item>
        <el-form-item label="项目编码" prop="projectCode">
          <el-input v-model="form.projectCode" placeholder="请输入项目编码" />
        </el-form-item>
        <el-form-item label="项目描述" prop="description">
          <el-input v-model="form.description" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="项目状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio label="0">进行中</el-radio>
            <el-radio label="1">已完成</el-radio>
            <el-radio label="2">暂停</el-radio>
            <el-radio label="3">已取消</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="优先级" prop="priority">
          <el-input v-model="form.priority" placeholder="请输入优先级" />
        </el-form-item>
        <el-form-item label="预算" prop="Budget">
          <el-input v-model="form.Budget" placeholder="请输入预算" />
        </el-form-item>
        <el-form-item label="需求总数" prop="requirementCount">
          <el-input v-model="form.requirementCount" placeholder="请输入需求总数" />
        </el-form-item>
        <el-form-item label="已投入" prop="Investment">
          <el-input v-model="form.Investment" placeholder="请输入已投入" />
        </el-form-item>
        <el-form-item label="计划开始日期" prop="startDate">
          <el-date-picker clearable
                          v-model="form.startDate"
                          type="date"
                          value-format="yyyy-MM-dd"
                          placeholder="请选择计划开始日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="计划结束日期" prop="endDate">
          <el-date-picker clearable
                          v-model="form.endDate"
                          type="date"
                          value-format="yyyy-MM-dd"
                          placeholder="请选择计划结束日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="实际开始日期" prop="realStartDate">
          <el-date-picker clearable
                          v-model="form.realStartDate"
                          type="date"
                          value-format="yyyy-MM-dd"
                          placeholder="请选择实际开始日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="实际结束日期" prop="realEndDate">
          <el-date-picker clearable
                          v-model="form.realEndDate"
                          type="date"
                          value-format="yyyy-MM-dd"
                          placeholder="请选择实际结束日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="项目进度" prop="progress">
          <el-input v-model="form.progress" placeholder="请输入项目进度" />
        </el-form-item>
        <el-form-item label="项目负责人ID" prop="ownerId">
          <el-input v-model="form.ownerId" placeholder="请输入项目负责人ID" />
        </el-form-item>
        <el-form-item label="项目负责人姓名" prop="ownerName">
          <el-input v-model="form.ownerName" placeholder="请输入项目负责人姓名" />
        </el-form-item>
        <el-form-item label="看板样式" prop="boardStyle">
          <el-input v-model="form.boardStyle" placeholder="请输入看板样式" />
        </el-form-item>
        <el-form-item label="列宽度" prop="colWidth">
          <el-input v-model="form.colWidth" placeholder="请输入列宽度" />
        </el-form-item>
        <el-form-item label="显示卡片数量" prop="displayCards">
          <el-input v-model="form.displayCards" placeholder="请输入显示卡片数量" />
        </el-form-item>
        <el-form-item label="流体看板" prop="fluidBoard">
          <el-input v-model="form.fluidBoard" placeholder="请输入流体看板" />
        </el-form-item>
        <el-form-item label="删除标志" prop="delFlag">
          <el-input v-model="form.delFlag" placeholder="请输入删除标志" />
        </el-form-item>
        <el-divider content-position="center">项目模块信息</el-divider>
        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button type="primary" icon="el-icon-plus" size="mini" @click="handleAddProjectModule">添加</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="danger" icon="el-icon-delete" size="mini" @click="handleDeleteProjectModule">删除</el-button>
          </el-col>
        </el-row>
        <el-table :data="projectModuleList" :row-class-name="rowProjectModuleIndex" @selection-change="handleProjectModuleSelectionChange" ref="projectModule">
          <el-table-column type="selection" width="50" align="center" />
          <el-table-column label="序号" align="center" prop="index" width="50"/>
          <el-table-column label="模块名称" prop="moduleName" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.moduleName" placeholder="请输入模块名称" />
            </template>
          </el-table-column>
          <el-table-column label="父模块ID" prop="parentId" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.parentId" placeholder="请输入父模块ID" />
            </template>
          </el-table-column>
          <el-table-column label="显示顺序" prop="orderNum" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.orderNum" placeholder="请输入显示顺序" />
            </template>
          </el-table-column>
          <el-table-column label="创建者" prop="createBy" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.createBy" placeholder="请输入创建者" />
            </template>
          </el-table-column>
          <el-table-column label="创建时间" prop="createTime" width="240">
            <template slot-scope="scope">
              <el-date-picker clearable v-model="scope.row.createTime" type="date" value-format="yyyy-MM-dd" placeholder="请选择创建时间" />
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
import { listProject, getProject, delProject, addProject, updateProject } from "@/api/project/project"

export default {
  name: "Project",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 子表选中数据
      checkedProjectModule: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 项目表格数据
      projectList: [],
      // 项目模块表格数据
      projectModuleList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        projectName: null,
        projectCode: null,
        status: null,
        priority: null,
        startDate: null,
        endDate: null,
        realStartDate: null,
        realEndDate: null,
        ownerName: null,
        createBy: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        projectName: [
          { required: true, message: "项目名称不能为空", trigger: "blur" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询项目列表 */
    getList() {
      this.loading = true
      listProject(this.queryParams).then(response => {
        this.projectList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    // 状态格式化
    statusFormatter(row) {
      const statusMap = {
        '0': '进行中',
        '1': '已完成',
        '2': '暂停',
        '3': '已取消'
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
        projectId: null,
        projectName: null,
        projectCode: null,
        description: null,
        status: null,
        priority: null,
        Budget: null,
        requirementCount: null,
        Investment: null,
        startDate: null,
        endDate: null,
        realStartDate: null,
        realEndDate: null,
        progress: null,
        ownerId: null,
        ownerName: null,
        boardStyle: null,
        colWidth: null,
        displayCards: null,
        fluidBoard: null,
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null,
        delFlag: null
      }
      this.projectModuleList = []
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
      this.ids = selection.map(item => item.projectId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加项目"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const projectId = row.projectId || this.ids
      getProject(projectId).then(response => {
        this.form = response.data
        this.projectModuleList = response.data.projectModuleList
        this.open = true
        this.title = "修改项目"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.form.projectModuleList = this.projectModuleList
          if (this.form.projectId != null) {
            updateProject(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addProject(this.form).then(response => {
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
      const projectIds = row.projectId || this.ids
      this.$modal.confirm('是否确认删除项目编号为"' + projectIds + '"的数据项？').then(function() {
        return delProject(projectIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 项目模块序号 */
    rowProjectModuleIndex({ row, rowIndex }) {
      row.index = rowIndex + 1
    },
    /** 项目模块添加按钮操作 */
    handleAddProjectModule() {
      let obj = {}
      obj.moduleName = ""
      obj.parentId = ""
      obj.orderNum = ""
      obj.createBy = ""
      obj.createTime = ""
      this.projectModuleList.push(obj)
    },
    /** 项目模块删除按钮操作 */
    handleDeleteProjectModule() {
      if (this.checkedProjectModule.length == 0) {
        this.$modal.msgError("请先选择要删除的项目模块数据")
      } else {
        const projectModuleList = this.projectModuleList
        const checkedProjectModule = this.checkedProjectModule
        this.projectModuleList = projectModuleList.filter(function(item) {
          return checkedProjectModule.indexOf(item.index) == -1
        })
      }
    },
    /** 复选框选中数据 */
    handleProjectModuleSelectionChange(selection) {
      this.checkedProjectModule = selection.map(item => item.index)
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('project/project/export', {
        ...this.queryParams
      }, `project_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
