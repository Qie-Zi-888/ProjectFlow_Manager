<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="团队 ID" prop="teamId">
        <el-input
          v-model="queryParams.teamId"
          placeholder="请输入团队 ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="团队名称" prop="teamName">
        <el-input
          v-model="queryParams.teamName"
          placeholder="请输入团队名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="用户昵称" prop="nickName">
        <el-input
          v-model="queryParams.nickName"
          placeholder="请输入用户昵称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="项目角色" prop="projectRole">
        <el-select v-model="queryParams.projectRole" placeholder="请选择项目角色" clearable>
          <el-option label="负责人" value="owner" />
          <el-option label="开发" value="developer" />
          <el-option label="测试" value="tester" />
          <el-option label="访客" value="visitor" />
        </el-select>
      </el-form-item>
      <el-form-item label="加入时间" prop="joinTime">
        <el-date-picker clearable
          v-model="queryParams.joinTime"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择加入时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="创建者" prop="createBy">
        <el-input
          v-model="queryParams.createBy"
          placeholder="请输入创建者"
          clearable
          @keyup.enter.native="handleQuery"
        />
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
          v-hasPermi="['project:member:add']"
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
          v-hasPermi="['project:member:edit']"
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
          v-hasPermi="['project:member:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['project:member:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="memberList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="团队 ID" align="center" prop="teamId" />
      <el-table-column label="团队名称" align="center" prop="teamName" />
      <el-table-column label="用户昵称" align="center" prop="nickName" />
      <el-table-column label="项目角色" align="center" prop="projectRole" :formatter="projectRoleFormatter" />
      <el-table-column label="加入时间" align="center" prop="joinTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.joinTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="已用工时" align="center" prop="investment" />
      <el-table-column label="创建者" align="center" prop="createBy" />
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
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
            v-hasPermi="['project:member:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['project:member:remove']"
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

    <!-- 添加或修改项目成员对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="团队 ID" prop="teamId">
          <el-input v-model="form.teamId" placeholder="请输入团队 ID" />
        </el-form-item>
        <el-form-item label="团队名称" prop="teamName">
          <el-input v-model="form.teamName" placeholder="请输入团队名称" />
        </el-form-item>
        <el-form-item label="用户 ID" prop="userId">
          <el-input-number v-model="form.userId" :min="1" :precision="0" step-strictly placeholder="请输入用户 ID" style="width: 100%;" />
        </el-form-item>
        <el-form-item label="项目角色" prop="projectRole">
          <el-select v-model="form.projectRole" placeholder="请选择项目角色" style="width: 100%;">
            <el-option label="负责人" value="owner" />
            <el-option label="开发" value="developer" />
            <el-option label="测试" value="tester" />
            <el-option label="访客" value="visitor" />
          </el-select>
        </el-form-item>
        <el-form-item label="加入时间" prop="joinTime">
          <el-date-picker clearable
            v-model="form.joinTime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择加入时间"
            style="width: 100%;">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="已用工时" prop="investment">
          <el-input-number v-model="form.investment" :precision="1" :min="0" :max="9999" :step="0.5" step-strictly placeholder="请输入已用工时" style="width: 100%;" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listMember, getMember, delMember, addMember, updateMember } from "@/api/project/member"

export default {
  name: "Member",
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
      // 项目成员表格数据
      memberList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        teamId: null,
        teamName: null,
        nickName: null,
        projectRole: null,
        joinTime: null,
        createBy: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        teamId: [
          { required: true, message: "团队 ID 不能为空", trigger: "blur" }
        ],
        userId: [
          { required: true, message: "用户 ID 不能为空", trigger: "blur" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询项目成员列表 */
    getList() {
      this.loading = true
      listMember(this.queryParams).then(response => {
        this.memberList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    // 项目角色格式化
    projectRoleFormatter(row) {
      const roleMap = {
        'owner': '负责人',
        'developer': '开发',
        'tester': '测试',
        'visitor': '访客'
      }
      return roleMap[row.projectRole] || row.projectRole
    },
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        teamId: null,
        teamName: null,
        projectId: null,
        userId: null,
        projectRole: null,
        joinTime: null,
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null,
        investment: null
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
      this.ids = selection.map(item => item.id)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加团队成员"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids
      getMember(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改团队成员"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateMember(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addMember(this.form).then(response => {
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
      const ids = row.id || this.ids
      this.$modal.confirm('是否确认删除团队成员编号为"' + ids + '"的数据项？').then(function() {
        return delMember(ids)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('project/member/export', {
        ...this.queryParams
      }, `member_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
