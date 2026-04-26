<template>
  <div class="app-container">
    <!-- 项目信息头部 -->
    <el-card class="box-card" shadow="hover">
      <div slot="header" class="clearfix">
        <span style="font-size: 18px; font-weight: bold;">项目视图</span>
        <el-button style="float: right; padding: 3px 0" type="text" @click="goBack">返回</el-button>
      </div>
      <el-descriptions :column="6" border class="project-info-descriptions">
        <el-descriptions-item label="选择项目" :span="3">
          <el-select
            v-model="projectId"
            placeholder="请选择项目"
            size="medium"
            style="width: 100%;"
            @change="handleProjectChange"
          >
            <el-option
              v-for="item in projectList"
              :key="item.projectId"
              :label="item.projectName"
              :value="item.projectId"
            >
              <span style="font-size: 14px;">{{ item.projectName }}</span>
            </el-option>
          </el-select>
        </el-descriptions-item>
        <el-descriptions-item label="项目状态">
          <el-tag :type="getStatusType(projectInfo.status)">{{ getStatusText(projectInfo.status) }}</el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="项目进度">
          <div class="dtable-cell-content">
            <svg width="48" height="48">
              <circle cx="24" cy="24" r="22" stroke-width="2" stroke="#e5e6eb" fill="transparent"></circle>
              <circle cx="24" cy="24" r="22" stroke-width="2" stroke="#67c23a" fill="transparent" stroke-linecap="round" 
                :stroke-dasharray="circumference" 
                :stroke-dashoffset="circumference - (circumference * (projectInfo.progress || 0) / 100)" 
                style="transform-origin:center center; transform: rotate(-90deg);">
              </circle>
              <text x="24" y="24.5" dominant-baseline="middle" text-anchor="middle" style="font-size: 14px; fill: currentColor;">{{ projectInfo.progress || 0 }}</text>
            </svg>
          </div>
        </el-descriptions-item>
        <el-descriptions-item label="负责人">{{ projectInfo.ownerName }}</el-descriptions-item>
      </el-descriptions>
    </el-card>

    <!-- 图表切换标签页 -->
    <el-card class="box-card" style="margin-top: 20px;">
      <el-tabs v-model="activeTab" @tab-click="handleTabClick">
        <!-- 甘特图 -->
        <el-tab-pane label="甘特图" name="gantt">
          <div ref="ganttChart" style="height: 500px;"></div>
        </el-tab-pane>

        <!-- 燃尽图 -->
        <el-tab-pane label="燃尽图" name="burndown">
          <div ref="burndownChart" style="height: 500px;"></div>
        </el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script>
import { getProject, listProject } from "@/api/project/project"
import { getSprint, listSprint } from "@/api/project/sprint"
import * as echarts from 'echarts'

export default {
  name: "ProjectView",
  data() {
    return {
      projectId: null,
      projectName: '',
      projectInfo: {},
      projectList: [],
      activeTab: 'gantt',
      ganttChart: null,
      burndownChart: null
    }
  },
  computed: {
    // 计算圆环周长 (2 * PI * r, r=22)
    circumference() {
      return 2 * Math.PI * 22
    }
  },
  created() {
    this.projectId = this.$route.params.projectId ? parseInt(this.$route.params.projectId) : null
    this.loadProjectList()
  },
  mounted() {
    this.$nextTick(() => {
      if (this.activeTab === 'gantt') {
        this.initGanttChart()
      } else {
        this.initBurndownChart()
      }
    })
  },
  beforeDestroy() {
    // 销毁图表实例
    if (this.ganttChart) {
      this.ganttChart.dispose()
    }
    if (this.burndownChart) {
      this.burndownChart.dispose()
    }
  },
  methods: {
    /** 加载项目列表 */
    loadProjectList() {
      listProject({ pageNum: 1, pageSize: 1000 }).then(response => {
        this.projectList = response.rows || []
        // 确保 projectId 是数字类型
        if (this.projectId) {
          this.projectId = parseInt(this.projectId)
          this.getProjectInfo()
        }
      })
    },
    /** 项目切换 */
    handleProjectChange(projectId) {
      this.projectId = projectId
      this.getProjectInfo()
      // 更新URL
      this.$router.replace({
        path: '/project/view/' + projectId
      })
    },
    /** 获取项目信息 */
    getProjectInfo() {
      if (!this.projectId) return

      getProject(this.projectId).then(response => {
        this.projectInfo = response.data
        this.projectName = response.data.projectName
        // 初始化当前激活的图表
        this.$nextTick(() => {
          if (this.activeTab === 'gantt') {
            this.initGanttChart()
          } else {
            this.initBurndownChart()
          }
        })
      })
    },
    /** 初始化甘特图 */
    initGanttChart() {
      if (!this.$refs.ganttChart) return

      if (this.ganttChart) {
        this.ganttChart.dispose()
      }

      this.ganttChart = echarts.init(this.$refs.ganttChart)

      const option = {
        title: {
          text: '项目甘特图',
          left: 'center'
        },
        tooltip: {
          formatter: function (params) {
            return params.name + '<br/>开始: ' + params.value[1] + '<br/>结束: ' + params.value[2]
          }
        },
        grid: {
          containLabel: true,
          left: 20,
          right: 20,
          bottom: 20
        },
        xAxis: {
          type: 'time',
          minInterval: 86400000 * 10,
          axisLabel: {
            formatter: '{MM}-{dd}',
            rotate: 30,
            fontSize: 13,
            margin: 20
          },
          splitLine: {
            show: true,
            lineStyle: {
              type: 'dashed',
              color: '#e0e0e0'
            }
          }
        },
        yAxis: {
          type: 'category',
          inverse: true,
          data: ['测试阶段', '开发阶段', '设计阶段', '需求阶段'],
          axisLabel: {
            fontSize: 13,
            fontWeight: 'bold'
          }
        },
        series: [
          {
            type: 'custom',
            renderItem: function (params, api) {
              const categoryIndex = api.value(0)
              const start = api.coord([api.value(1), categoryIndex])
              const end = api.coord([api.value(2), categoryIndex])
              const height = api.size([0, 1])[1] * 0.6

              // 绘制任务条
              return {
                type: 'group',
                children: [
                  {
                    type: 'rect',
                    shape: {
                      x: start[0],
                      y: start[1] - height / 2,
                      width: end[0] - start[0],
                      height: height
                    },
                    style: api.style()
                  },
                  {
                    type: 'text',
                    style: {
                      text: params.name,
                      x: (start[0] + end[0]) / 2,
                      y: start[1],
                      textAlign: 'center',
                      textVerticalAlign: 'middle',
                      fill: '#fff',
                      fontSize: 11,
                      fontWeight: 'bold'
                    }
                  }
                ]
              }
            },
            encode: {
              x: [1, 2],
              y: 0
            },
            data: [
              { name: '需求调研', value: [3, '2024-03-01', '2024-03-20'], itemStyle: { color: '#5470c6' } },
              { name: '系统设计', value: [2, '2024-03-15', '2024-04-10'], itemStyle: { color: '#91cc75' } },
              { name: '开发阶段', value: [1, '2024-04-01', '2024-05-01'], itemStyle: { color: '#fac858' } },
              { name: '测试阶段', value: [0, '2024-04-20', '2024-05-15'], itemStyle: { color: '#ee6666' } }
            ]
          }
        ]
      }

      this.ganttChart.setOption(option)
    },
    /** 初始化燃尽图 */
    initBurndownChart() {
      if (!this.$refs.burndownChart) return

      if (this.burndownChart) {
        this.burndownChart.dispose()
      }

      this.burndownChart = echarts.init(this.$refs.burndownChart)

      // 获取当前项目的迭代数据来构建燃尽图
      this.loadBurndownData()
    },
    /** 加载燃尽图数据 */
    loadBurndownData() {
      // 这里假设我们获取第一个迭代的数据作为示例
      // 在实际应用中，可能需要根据具体需求选择合适的迭代
      const params = {
        projectId: this.projectId,
        pageNum: 1,
        pageSize: 1
      }
      
      listSprint(params).then(response => {
        const sprints = response.rows || []
        if (sprints.length > 0) {
          const sprintId = sprints[0].sprintId
          getSprint(sprintId).then(sprintResponse => {
            const sprint = sprintResponse.data
            this.renderBurndownChart(sprint)
          })
        } else {
          // 如果没有迭代数据，使用默认数据
          this.renderDefaultBurndownChart()
        }
      }).catch(() => {
        // 出错时使用默认数据
        this.renderDefaultBurndownChart()
      })
    },
    /** 渲染燃尽图 */
    renderBurndownChart(sprint) {
      const burndownList = sprint.sprintBurndownList || []
      
      if (burndownList.length === 0) {
        this.renderDefaultBurndownChart()
        return
      }

      // 按日期排序
      burndownList.sort((a, b) => new Date(a.statDate) - new Date(b.statDate))
      
      // 提取日期和剩余工时数据，每隔7天取一个数据点，保持显示10个点
      const dates = []
      const idealHours = []
      const actualHours = []
      
      // 保持显示10个数据点，但每个点间隔7天
      const displayPoints = 10
      const step = 7 // 每7天一个间隔
      
      for (let i = 0; i < burndownList.length && dates.length < displayPoints; i += step) {
        const item = burndownList[i]
        const date = new Date(item.statDate)
        const month = String(date.getMonth() + 1).padStart(2, '0')
        const day = String(date.getDate()).padStart(2, '0')
        dates.push(`${month}月${day}日`)
        idealHours.push(item.idealRemainingHours || 0)
        actualHours.push(item.remainingHours || 0)
      }

      const option = {
        title: {
          text: '项目燃尽图',
          left: 'center'
        },
        tooltip: {
          trigger: 'axis'
        },
        legend: {
          data: ['理想剩余工时', '实际剩余工时'],
          top: 30
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '3%',
          containLabel: true
        },
        xAxis: {
          type: 'category',
          boundaryGap: false,
          data: dates
        },
        yAxis: {
          type: 'value',
          name: '剩余工时(h)'
        },
        series: [
          {
            name: '理想剩余工时',
            type: 'line',
            data: idealHours,
            lineStyle: {
              type: 'dashed'
            },
            itemStyle: {
              color: '#91cc75'
            }
          },
          {
            name: '实际剩余工时',
            type: 'line',
            data: actualHours,
            smooth: true,
            itemStyle: {
              color: '#5470c6'
            },
            areaStyle: {
              color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                { offset: 0, color: 'rgba(84, 112, 198, 0.3)' },
                { offset: 1, color: 'rgba(84, 112, 198, 0.05)' }
              ])
            }
          }
        ]
      }

      this.burndownChart.setOption(option)
    },
    /** 渲染默认燃尽图 */
    renderDefaultBurndownChart() {
      const option = {
        title: {
          text: '项目燃尽图',
          left: 'center'
        },
        tooltip: {
          trigger: 'axis'
        },
        legend: {
          data: ['理想剩余工时', '实际剩余工时'],
          top: 30
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '3%',
          containLabel: true
        },
        xAxis: {
          type: 'category',
          boundaryGap: false,
          data: ['03月01日', '03月08日', '03月15日', '03月22日', '03月29日', '04月05日', '04月12日', '04月19日', '04月26日', '05月03日']
        },
        yAxis: {
          type: 'value',
          name: '剩余工时(h)',
          max: 500
        },
        series: [
          {
            name: '理想剩余工时',
            type: 'line',
            data: [500, 450, 400, 350, 300, 250, 200, 150, 100, 50],
            lineStyle: {
              type: 'dashed'
            },
            itemStyle: {
              color: '#91cc75'
            }
          },
          {
            name: '实际剩余工时',
            type: 'line',
            data: [500, 460, 390, 335, 310, 275, 240, 175, 125, 60],
            smooth: true,
            itemStyle: {
              color: '#5470c6'
            },
            areaStyle: {
              color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                { offset: 0, color: 'rgba(84, 112, 198, 0.3)' },
                { offset: 1, color: 'rgba(84, 112, 198, 0.05)' }
              ])
            }
          }
        ]
      }

      this.burndownChart.setOption(option)
    },
    /** 标签页切换 */
    handleTabClick(tab) {
      this.$nextTick(() => {
        if (tab.name === 'gantt') {
          this.initGanttChart()
        } else if (tab.name === 'burndown') {
          this.initBurndownChart()
        }
      })
    },
    /** 返回上一页 */
    goBack() {
      this.$router.go(-1)
    },
    /** 获取状态类型 */
    getStatusType(status) {
      const typeMap = {
        '0': '',
        '1': 'success',
        '2': 'warning',
        '3': 'danger'
      }
      return typeMap[status] || ''
    },
    /** 获取状态文本 */
    getStatusText(status) {
      const statusMap = {
        '0': '进行中',
        '1': '已完成',
        '2': '暂停',
        '3': '已取消'
      }
      return statusMap[status] || status
    }
  }
}
</script>

<style scoped>
.box-card {
  margin-bottom: 20px;
}

/* 调整项目信息描述列表的布局 */
.project-info-descriptions ::v-deep .el-descriptions__body {
  table-layout: fixed;
}

.project-info-descriptions ::v-deep .el-descriptions-item__cell {
  width: auto;
}

/* 选择项目单元格占更宽 */
.project-info-descriptions ::v-deep .project-select-item .el-descriptions-item__cell {
  width: 50% !important;
}

/* 环形进度条容器样式 */
.dtable-cell-content {
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>
