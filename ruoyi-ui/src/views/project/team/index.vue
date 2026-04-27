<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="团队ID" prop="teamId">
        <el-input
          v-model="queryParams.teamId"
          placeholder="请输入团队ID"
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
          v-hasPermi="['project:team:add']"
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
          v-hasPermi="['project:team:edit']"
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
          v-hasPermi="['project:team:remove']"
        >删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="teamList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="团队ID" align="center" prop="teamId" />
      <el-table-column label="团队名称" align="center" prop="teamName" />
      <el-table-column label="成员数量" align="center" prop="memberCount" />
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
            v-hasPermi="['project:team:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['project:team:remove']"
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

    <!-- 添加或修改团队对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="800px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="团队ID" prop="teamId">
              <el-input v-model="form.teamId" placeholder="请输入团队ID" :disabled="form.teamId != null" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="团队名称" prop="teamName">
              <el-input v-model="form.teamName" placeholder="请输入团队名称" />
            </el-form-item>
          </el-col>
        </el-row>
        
        <el-divider content-position="center">团队成员信息</el-divider>
        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button type="primary" icon="el-icon-plus" size="mini" @click="handleAddMember">添加成员</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="danger" icon="el-icon-delete" size="mini" @click="handleDeleteMember">删除成员</el-button>
          </el-col>
        </el-row>
        <el-table :data="memberList" :row-class-name="rowMemberIndex" @selection-change="handleMemberSelectionChange" ref="member">
          <el-table-column type="selection" width="50" align="center" />
          <el-table-column label="序号" align="center" prop="index" width="50"/>
          <el-table-column label="用户ID" prop="userId" width="120">
            <template slot-scope="scope">
              <el-input-number v-model="scope.row.userId" :min="1" :precision="0" step-strictly placeholder="用户ID" style="width: 100%;" />
            </template>
          </el-table-column>
          <el-table-column label="用户昵称" prop="nickName" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.nickName" placeholder="用户昵称" disabled />
            </template>
          </el-table-column>
          <el-table-column label="项目角色" prop="projectRole" width="150">
            <template slot-scope="scope">
              <el-select v-model="scope.row.projectRole" placeholder="请选择角色" style="width: 100%;">
                <el-option label="系统管理员" value="0" />
                <el-option label="项目经理" value="1" />
                <el-option label="开发人员" value="2" />
                <el-option label="测试人员" value="3" />
              </el-select>
            </template>
          </el-table-column>
          <el-table-column label="加入时间" prop="joinTime" width="180">
            <template slot-scope="scope">
              <el-date-picker clearable
                v-model="scope.row.joinTime"
                type="date"
                value-format="yyyy-MM-dd"
                placeholder="选择加入时间"
                style="width: 100%;">
              </el-date-picker>
            </template>
          </el-table-column>
          <el-table-column label="已用工时" prop="investment" width="120">
            <template slot-scope="scope">
              <el-input-number v-model="scope.row.investment" :precision="1" :min="0" :max="9999" :step="0.5" step-strictly placeholder="工时" style="width: 100%;" disabled />
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
import { listTeam, getTeam, delTeam, addTeam, updateTeam } from "@/api/project/team"

export default {
  name: "Team",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 子表选中数据
      checkedMember: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 团队表格数据
      teamList: [],
      // 团队成员表格数据
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
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        teamId: [
          { required: true, message: "团队ID不能为空", trigger: "blur" }
        ],
        teamName: [
          { required: true, message: "团队名称不能为空", trigger: "blur" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询团队列表 */
    getList() {
      this.loading = true
      listTeam(this.queryParams).then(response => {
        this.teamList = response.rows
        this.total = response.total
        this.loading = false
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
        teamId: null,
        teamName: null,
      }
      this.memberList = []
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
      this.ids = selection.map(item => item.teamId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加团队"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const teamId = row.teamId || this.ids
      getTeam(teamId).then(response => {
        this.form = response.data
        this.memberList = response.data.memberList || []
        this.open = true
        this.title = "修改团队"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          // 处理子表数据，移除空值字段
          if (this.memberList && this.memberList.length > 0) {
            this.form.memberList = this.memberList.map(item => {
              // 创建一个新对象，只保留有值的字段
              const newItem = {}
              for (const key in item) {
                if (item[key] !== null && item[key] !== '' && item[key] !== undefined) {
                  newItem[key] = item[key]
                }
              }
              return newItem
            })
          }
          if (this.form.teamId != null) {
            updateTeam(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addTeam(this.form).then(response => {
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
      const teamIds = row.teamId || this.ids
      this.$modal.confirm('是否确认删除团队编号为"' + teamIds + '"的数据项？').then(function() {
        return delTeam(teamIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 团队成员序号 */
    rowMemberIndex({ row, rowIndex }) {
      row.index = rowIndex + 1
    },
    /** 团队成员添加按钮操作 */
    handleAddMember() {
      let obj = {}
      obj.userId = null
      obj.nickName = ""
      obj.projectRole = "2"
      obj.joinTime = null
      obj.investment = 0
      this.memberList.push(obj)
    },
    /** 团队成员删除按钮操作 */
    handleDeleteMember() {
      if (this.checkedMember.length == 0) {
        this.$modal.msgError("请先选择要删除的成员数据")
      } else {
        const memberList = this.memberList
        const checkedMember = this.checkedMember
        this.memberList = memberList.filter(function(item) {
          return checkedMember.indexOf(item.index) == -1
        })
      }
    },
    /** 复选框选中数据 */
    handleMemberSelectionChange(selection) {
      this.checkedMember = selection.map(item => item.index)
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('project/team/export', {
        ...this.queryParams
      }, `team_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>

<style scoped>
/* 增加表格行高 */
::v-deep .el-table td,
::v-deep .el-table th {
  padding: 12px 0;
}
</style>
