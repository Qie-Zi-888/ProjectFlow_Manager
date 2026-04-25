<template>
  <div class="dashboard-container">
    <!-- 两列布局 -->
    <div class="dashboard-layout">

      <!-- 主列（左侧 66.67%） -->
      <div class="col-main">

        <!-- 产品总览 -->
        <div class="dashboard-block">
          <div class="panel">
            <div class="panel-body" style="padding: 12px 16px;">
              <div class="overview-header" style="margin-bottom: 12px;">项目总览</div>
              <div class="overview-stats">
                <div class="stat-item" style="padding: 8px;">
                  <div class="stat-number" style="font-size: 24px; color: #3c4353;">{{ statistics.totalProjects }}</div>
                  <div class="stat-label" style="color: #3c4353;">项目总量</div>
                </div>
                <div class="stat-item stat-divider" style="padding: 8px;">
                  <div class="stat-number" style="font-size: 24px; color: #3c4353;">{{ statistics.inProgressProjects }}</div>
                  <div class="stat-label" style="color: #3c4353;">进行中项目</div>
                </div>
                <div class="stat-item stat-divider" style="padding: 8px;">
                  <div class="stat-number" style="font-size: 24px; color: #3c4353;">{{ statistics.completedProjects }}</div>
                  <div class="stat-label" style="color: #3c4353;">已完成项目</div>
                </div>
                <div class="stat-item stat-divider" style="padding: 8px;">
                  <div class="stat-number" style="font-size: 24px; color: #3c4353;">{{ statistics.delayedProjects }}</div>
                  <div class="stat-label" style="color: #3c4353;">延期项目</div>
                </div>
              </div>

              <div style="margin-top: 16px; padding-top: 16px; border-top: 1px solid #e5e6eb;">
                <div class="overview-header" style="margin-bottom: 12px;">产品年度推进统计</div>
                <div class="annual-stats">
                  <div class="stat-item" style="padding: 8px;">
                    <div class="stat-number" style="font-size: 28px;">{{ annualStats.completedReleases }}</div>
                    <div class="stat-label">已完成发布数</div>
                  </div>
                  <div class="stat-item stat-divider" style="padding: 8px;">
                    <div class="stat-number" style="font-size: 28px;">{{ annualStats.completedRequirements }}</div>
                    <div class="stat-label">已完成需求数</div>
                  </div>
                  <div class="stat-item stat-divider" style="padding: 8px;">
                    <div class="stat-number stat-number-with-unit" style="font-size: 28px;">{{ Math.round(annualStats.completedRequirementHours) || 0 }}</div>
                    <div class="stat-label">已完成需求规模(H)</div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- 未关闭的项目统计 -->
        <div class="dashboard-block">
          <div class="panel">
            <div class="panel-heading" style="border-bottom: 1px solid #e5e6eb;">
              <div class="panel-title">未关闭的项目统计</div>
              <div class="toolbar">
                <a href="#" class="btn ghost size-sm" style="text-decoration: none; color: #2B80FF; font-size: 14px;">
                  <span>更多</span>
                  <span style="margin-left: 4px;">›</span>
                </a>
              </div>
            </div>
            <div class="panel-body" style="padding: 0;">
              <div class="block-statistic">
                <div class="block-statistic-nav">
                  <div
                    v-for="(project, index) in unclosedProjects"
                    :key="project.projectId"
                    :class="['nav-item', { active: selectedProject && selectedProject.projectId === project.projectId }]"
                    @click="selectProject(project)"
                  >
                    <a :title="project.projectName">{{ project.projectName }}</a>
                  </div>
                  <div v-if="unclosedProjects.length === 0" style="padding: 12px; color: #8f959e; text-align: center;">
                    暂无未关闭项目
                  </div>
                </div>
                <div class="block-statistic-panes" style="padding: 16px 16px 16px 0;">
                  <!-- 需求交付率区域 -->
                  <div style="display: flex; height: 100%; padding-left: 0;">
                    <div style="flex: 1; display: flex; flex-direction: column; justify-content: center; align-items: center;">
                      <div style="font-size: 14px; font-weight: bold; margin-bottom: 16px;">需求交付率</div>

                      <!-- 环形进度图 -->
                      <div class="progress-circle" style="width: 96px; height: 96px;">
                        <svg width="96" height="96">
                          <circle cx="48" cy="48" r="45.12" stroke-width="5.76" stroke="#f5f6f7" fill="transparent"></circle>
                          <circle cx="48" cy="48" r="45.12" stroke-width="5.76" stroke="#2B80FF" fill="transparent"
                                  stroke-linecap="round"
                                  stroke-dasharray="283.5"
                                  stroke-dashoffset="283.5"
                                  style="transform-origin: center center; transform: rotate(-90deg);"></circle>
                        </svg>
                        <div class="progress-circle-text">
                          <div><span class="progress-circle-value" style="font-size: 20px;">0</span><span class="progress-circle-percent">%</span></div>
                        </div>
                      </div>

                      <!-- 统计数据 -->
                      <div class="stat-row">
                        <div class="stat-col">
                          <div class="stat-col-value">0</div>
                          <div class="stat-col-label">有效需求</div>
                        </div>
                        <div class="stat-col">
                          <div class="stat-col-value">0</div>
                          <div class="stat-col-label">已交付</div>
                        </div>
                        <div class="stat-col">
                          <div class="stat-col-value">0</div>
                          <div class="stat-col-label">未关闭</div>
                        </div>
                      </div>
                    </div>

                    <!-- 需求统计区域 -->
                    <div style="flex: 1; padding-left: 8px; display: flex; flex-direction: column;">
                      <div class="trend-header">需求统计</div>
                      <div class="trend-info">
                        <span>本月完成 <span class="success">{{ requirementStats.thisMonthCompleted }}</span></span>
                        <span style="color: #e5e6eb;">|</span>
                        <span>本月新增 <span class="primary">{{ requirementStats.thisMonthNew }}</span></span>
                      </div>

                      <!-- ECharts 折线图 -->
                      <div ref="storyTrendChart" style="flex: 1; min-height: 175px;"></div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- 未关闭的Bug统计 -->
        <div class="dashboard-block">
          <div class="panel">
            <div class="panel-heading" style="border-bottom: 1px solid #e5e6eb;">
              <div class="panel-title">未关闭的Bug统计</div>
              <div class="toolbar">
                <a href="#" class="btn ghost size-sm" style="text-decoration: none; color: #2B80FF; font-size: 14px;">
                  <span>更多</span>
                  <span style="margin-left: 4px;">›</span>
                </a>
              </div>
            </div>
            <div class="panel-body" style="padding: 0;">
              <div class="block-statistic">
                <div class="block-statistic-nav">
                  <div
                    v-for="(project, index) in unclosedProjects"
                    :key="project.projectId"
                    :class="['nav-item', { active: selectedBugProject && selectedBugProject.projectId === project.projectId }]"
                    @click="selectBugProject(project)"
                  >
                    <a :title="project.projectName">{{ project.projectName }}</a>
                  </div>
                  <div v-if="unclosedProjects.length === 0" style="padding: 12px; color: #8f959e; text-align: center;">
                    暂无未关闭项目
                  </div>
                </div>
                <div class="block-statistic-panes bug-statistic-panes" style="padding: 16px 16px 16px 0;">
                  <!-- Bug解决率区域 -->
                  <div style="display: flex; height: 100%; padding-left: 0;">
                    <div style="flex: 1; display: flex; flex-direction: column; justify-content: center; align-items: center;">
                      <div style="font-size: 14px; font-weight: bold; margin-bottom: 16px;">Bug解决率</div>

                      <!-- 环形进度图 -->
                      <div class="progress-circle" style="width: 96px; height: 96px;">
                        <svg width="96" height="96">
                          <circle cx="48" cy="48" r="45.12" stroke-width="5.76" stroke="#f5f6f7" fill="transparent"></circle>
                          <circle cx="48" cy="48" r="45.12" stroke-width="5.76" stroke="#2B80FF" fill="transparent"
                                  stroke-linecap="round"
                                  stroke-dasharray="283.5"
                                  stroke-dashoffset="283.5"
                                  style="transform-origin: center center; transform: rotate(-90deg);"></circle>
                        </svg>
                        <div class="progress-circle-text">
                          <div><span class="progress-circle-value" style="font-size: 20px;">0</span><span class="progress-circle-percent">%</span></div>
                        </div>
                      </div>

                      <!-- 统计数据 -->
                      <div class="stat-row">
                        <div class="stat-col">
                          <div class="stat-col-value">0</div>
                          <div class="stat-col-label">有效Bug</div>
                        </div>
                        <div class="stat-col">
                          <div class="stat-col-value">0</div>
                          <div class="stat-col-label">已解决</div>
                        </div>
                        <div class="stat-col">
                          <div class="stat-col-value">0</div>
                          <div class="stat-col-label">未关闭</div>
                        </div>
                      </div>
                    </div>

                    <!-- Bug统计区域 -->
                    <div style="flex: 1; padding-left: 8px; display: flex; flex-direction: column;">
                      <div class="trend-header">Bug统计</div>
                      <div class="trend-info">
                        <span>本月解决 <span class="success">0</span></span>
                        <span style="color: #e5e6eb;">|</span>
                        <span>本月新增 <span class="primary">0</span></span>
                      </div>

                      <!-- ECharts 折线图 -->
                      <div ref="bugTrendChart" style="flex: 1; min-height: 175px;"></div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>

      <!-- 侧列（右侧 33.33%） -->
      <div class="col-side">

        <!-- 产品发布统计 -->
        <div class="dashboard-block">
          <div class="panel">
            <div class="panel-heading" style="border-bottom: 1px solid #e5e6eb;">
              <div class="panel-title">产品发布统计</div>
              <div class="toolbar">
                <a href="#" class="btn ghost size-sm" style="text-decoration: none; color: #2B80FF; font-size: 14px;">
                  <span>更多</span>
                  <span style="margin-left: 4px;">›</span>
                </a>
              </div>
            </div>
            <div class="panel-body">
              <div class="chart-title" style="font-size: 13px; margin-bottom: 12px;">月度发布次数趋势图</div>
              <div class="bar-chart">
                <div class="bar-item">
                  <div class="bar" style="height: 100px;">
                    <div class="bar-value">5</div>
                  </div>
                  <div class="bar-label">12月</div>
                </div>
                <div class="bar-item">
                  <div class="bar" style="height: 60px;">
                    <div class="bar-value">3</div>
                  </div>
                  <div class="bar-label">1月</div>
                </div>
                <div class="bar-item">
                  <div class="bar" style="height: 40px;">
                    <div class="bar-value">2</div>
                  </div>
                  <div class="bar-label">2月</div>
                </div>
                <div class="bar-item">
                  <div class="bar" style="height: 80px;">
                    <div class="bar-value">4</div>
                  </div>
                  <div class="bar-label">3月</div>
                </div>
                <div class="bar-item">
                  <div class="bar" style="height: 60px;">
                    <div class="bar-value">3</div>
                  </div>
                  <div class="bar-label">4月</div>
                </div>
                <div class="bar-item">
                  <div class="bar" style="height: 20px;">
                    <div class="bar-value">1</div>
                  </div>
                  <div class="bar-label">5月</div>
                </div>
              </div>

              <div style="margin-top: 24px;">
                <div class="chart-title" style="font-size: 13px; margin-bottom: 12px;">
                  📊 年度发布榜（{{ currentYear }}年）
                </div>
                <div v-if="annualRanking.length > 0">
                  <div
                    v-for="(item, index) in annualRanking"
                    :key="index"
                    class="ranking-item"
                  >
                    <span>
                      <span :class="['rank-badge', getRankClass(index)]">{{ index + 1 }}</span>
                      {{ item.projectName }}
                    </span>
                    <span style="color: #8f959e;">{{ item.completedCount }}</span>
                  </div>
                </div>
                <div v-else style="padding: 20px; text-align: center; color: #8f959e;">
                  暂无数据
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- 指派给我的任务 -->
        <div class="dashboard-block">
          <div class="panel">
            <div class="panel-heading" style="border-bottom: 1px solid #e5e6eb;">
              <div class="panel-title">指派给我的任务</div>
              <div class="toolbar">
                <a href="#" class="btn ghost size-sm" style="text-decoration: none; color: #2B80FF; font-size: 14px;">
                  <span>更多</span>
                  <span style="margin-left: 4px;">›</span>
                </a>
              </div>
            </div>
            <div class="panel-body" style="padding: 0;">
              <table class="story-table">
                <thead>
                <tr>
                  <th style="width: 60px; text-align: center;">ID</th>
                  <th>任务名称</th>
                  <th style="width: 60px; text-align: center;">P</th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="task in taskList" :key="task.id">
                  <td style="text-align: center;">{{ task.id }}</td>
                  <td><a href="#" style="color: #2B80FF; text-decoration: none;">{{ task.name }}</a></td>
                  <td style="text-align: center;"><span :class="['pri-' + task.priority]">{{ task.priority }}</span></td>
                </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>

      </div>
      <!-- 侧列结束 -->

    </div>
    <!-- 两列布局结束 -->
  </div>
</template>

<script>
import * as echarts from 'echarts'
import { getStatistics, getStatusDistribution, getRecentProjects, getUnclosedProjects, getAnnualRanking, getProjectRequirementStats, getProjectMonthTrend, getProjectBugStats, getProjectBugMonthTrend } from '@/api/project/dashboard'
import { listProject } from '@/api/project/project'
import { listRequirement } from '@/api/execute/requirement'
import { listTask } from '@/api/execute/task'

export default {
  name: 'ProjectDashboard',
  data() {
    return {
      storyChart: null,
      bugChart: null,
      loading: false,
      // 项目统计数据
      statistics: {
        totalProjects: 0,
        completedProjects: 0,
        inProgressProjects: 0,
        delayedProjects: 0
      },
      // 需求和任务统计（用于未关闭项目统计区域）
      requirementStats: {
        total: 0,
        active: 0,
        thisMonthNew: 0,
        thisMonthCompleted: 0
      },
      // Bug统计（用于未关闭的Bug统计区域）
      bugStats: {
        totalBugs: 0,
        unclosedBugs: 0,
        resolvedBugs: 0,
        closedBugs: 0,
        rejectedBugs: 0,
        thisMonthNew: 0,
        thisMonthResolved: 0
      },
      // Bug月度趋势数据
      bugMonthTrend: {
        months: [],
        bugNew: [],
        bugResolved: []
      },
      // 产品年度推进统计（全局数据，不受项目选择影响）
      annualStats: {
        completedReleases: 0,
        completedRequirements: 0,
        completedRequirementHours: 0
      },
      taskList: [],
      // 状态分布数据
      statusDistribution: [],
      // 月度趋势数据
      monthTrend: {
        months: [],
        requirementNew: [],
        requirementCompleted: [],
        taskNew: [],
        taskCompleted: []
      },
      // 未关闭的项目列表
      unclosedProjects: [],
      // 当前选中的项目（需求统计）
      selectedProject: null,
      // 当前选中的项目（Bug统计）
      selectedBugProject: null,
      // 当前年份
      currentYear: new Date().getFullYear(),
      // 年度发布榜数据
      annualRanking: []
    }
  },
  created() {
    this.loadData()
  },
  beforeDestroy() {
    window.removeEventListener('resize', this.handleResize)
    if (this.storyChart) {
      this.storyChart.dispose()
    }
    if (this.bugChart) {
      this.bugChart.dispose()
    }
  },
  methods: {
    // 加载所有数据
    async loadData() {
      this.loading = true
      try {
        await Promise.all([
          this.loadStatistics(),
          this.loadAnnualStats(),
          this.loadTaskList(),
          this.loadStatusDistribution(),
          this.loadMonthTrend(),
          this.loadUnclosedProjects(),
          this.loadAnnualRanking()
        ])
        this.$nextTick(() => {
          this.initStoryTrendChart()
          this.initBugTrendChart()
        })
      } catch (error) {
        console.error('加载仪表盘数据失败:', error)
      } finally {
        this.loading = false
      }
    },

    // 加载项目统计
    async loadStatistics() {
      try {
        const response = await getStatistics()
        if (response.code === 200) {
          this.statistics = response.data
        }
      } catch (error) {
        console.error('加载项目统计失败:', error)
      }
    },

    // 加载产品年度推进统计（全局数据）
    async loadAnnualStats() {
      try {
        const thisYear = new Date().getFullYear()

        // 已完成发布数（暂时使用项目完成数代替）
        const projectResponse = await listProject({ pageNum: 1, pageSize: 1000 })
        if (projectResponse.code === 200 && projectResponse.rows) {
          const completedProjects = projectResponse.rows.filter(p => p.status === 1)
          this.annualStats.completedReleases = completedProjects.length
        }

        // 获取需求数据
        const reqResponse = await listRequirement({ pageNum: 1, pageSize: 1000 })
        if (reqResponse.code === 200 && reqResponse.rows) {
          const requirements = reqResponse.rows

          // 今年已完成需求数（只统计已解决的需求，不包括已关闭）
          const completedReqs = requirements.filter(r => {
            const updateTime = new Date(r.updateTime || r.createTime)
            return r.status === 2 && updateTime.getFullYear() === thisYear
          })

          this.annualStats.completedRequirements = completedReqs.length

          // 已完成需求规模（工时）= 总工时 / 已完成需求数
          const totalHours = completedReqs.reduce((sum, r) => {
            return sum + (parseFloat(r.estimateTime) || 0)
          }, 0)

          if (this.annualStats.completedRequirements > 0) {
            this.annualStats.completedRequirementHours = totalHours / this.annualStats.completedRequirements
          } else {
            this.annualStats.completedRequirementHours = 0
          }
        }
      } catch (error) {
        console.error('加载年度推进统计失败:', error)
      }
    },

    // 加载任务列表
    async loadTaskList() {
      try {
        const response = await listTask({ pageNum: 1, pageSize: 8 })
        if (response.code === 200 && response.rows) {
          this.taskList = response.rows.map(task => ({
            id: task.taskId,
            name: task.taskName,
            priority: parseInt(task.priority) || 3,
            status: task.status
          }))
        }
      } catch (error) {
        console.error('加载任务列表失败:', error)
      }
    },

    // 加载状态分布
    async loadStatusDistribution() {
      try {
        const response = await getStatusDistribution()
        if (response.code === 200) {
          this.statusDistribution = response.data || []
        }
      } catch (error) {
        console.error('加载状态分布失败:', error)
      }
    },

    // 加载月度趋势
    async loadMonthTrend() {
      try {
        const reqResponse = await listRequirement({ pageNum: 1, pageSize: 1000 })
        const taskResponse = await listTask({ pageNum: 1, pageSize: 1000 })

        if (reqResponse.code === 200 && taskResponse.code === 200) {
          const requirements = reqResponse.rows || []
          const tasks = taskResponse.rows || []

          // 生成最近6个月的月份
          const months = []
          const requirementNew = []
          const requirementCompleted = []
          const taskNew = []
          const taskCompleted = []

          const now = new Date()
          for (let i = 5; i >= 0; i--) {
            const date = new Date(now.getFullYear(), now.getMonth() - i, 1)
            const monthStr = `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}`
            months.push(monthStr)

            // 需求统计
            const monthReqs = requirements.filter(r => {
              const createTime = new Date(r.createTime)
              return createTime.getFullYear() === date.getFullYear() && createTime.getMonth() === date.getMonth()
            })
            requirementNew.push(monthReqs.length)
            requirementCompleted.push(monthReqs.filter(r => r.status === 2 || r.status === 3).length)

            // 任务统计
            const monthTasks = tasks.filter(t => {
              const createTime = new Date(t.createTime)
              return createTime.getFullYear() === date.getFullYear() && createTime.getMonth() === date.getMonth()
            })
            taskNew.push(monthTasks.length)
            taskCompleted.push(monthTasks.filter(t => t.status === 2).length)
          }

          this.monthTrend = { months, requirementNew, requirementCompleted, taskNew, taskCompleted }
        }
      } catch (error) {
        console.error('加载月度趋势失败:', error)
      }
    },

    // 加载未关闭的项目列表
    async loadUnclosedProjects() {
      try {
        const response = await getUnclosedProjects()
        if (response.code === 200) {
          this.unclosedProjects = response.data || []
          // 默认选中第一个项目并加载其需求统计、Bug统计和月度趋势
          if (this.unclosedProjects.length > 0) {
            this.selectedProject = this.unclosedProjects[0]
            this.selectedBugProject = this.unclosedProjects[0]
            await Promise.all([
              this.loadProjectRequirementStats(this.unclosedProjects[0].projectId),
              this.loadProjectMonthTrend(this.unclosedProjects[0].projectId),
              this.loadProjectBugStats(this.unclosedProjects[0].projectId),
              this.loadProjectBugMonthTrend(this.unclosedProjects[0].projectId)
            ])
          }
        }
      } catch (error) {
        console.error('加载未关闭项目列表失败:', error)
      }
    },

    // 选择项目（需求统计）
    async selectProject(project) {
      this.selectedProject = project
      console.log('切换到项目（需求统计）:', project.projectName)

      // 加载该项目的需求统计数据
      if (project.projectId) {
        await Promise.all([
          this.loadProjectRequirementStats(project.projectId),
          this.loadProjectMonthTrend(project.projectId)
        ])
      }
    },

    // 选择项目（Bug统计）
    async selectBugProject(project) {
      this.selectedBugProject = project
      console.log('切换到项目（Bug统计）:', project.projectName)
      // 加载选中项目的Bug统计数据和月度趋势
      if (project.projectId) {
        await Promise.all([
          this.loadProjectBugStats(project.projectId),
          this.loadProjectBugMonthTrend(project.projectId)
        ])
      }
    },

    // 加载指定项目的需求统计
    async loadProjectRequirementStats(projectId) {
      try {
        const response = await getProjectRequirementStats(projectId)
        if (response.code === 200 && response.data) {
          const stats = response.data
          // 更新需求统计数据
          this.requirementStats.total = parseInt(stats.totalRequirements) || 0
          this.requirementStats.active = parseInt(stats.activeRequirements) || 0
          this.requirementStats.thisMonthNew = parseInt(stats.thisMonthNew) || 0
          this.requirementStats.thisMonthCompleted = parseInt(stats.thisMonthCompleted) || 0

          // 计算需求交付率
          const total = parseInt(stats.totalRequirements) || 0
          const completed = parseInt(stats.completedRequirements) || 0
          const deliveryRate = total > 0 ? Math.round((completed / total) * 100) : 0

          // 更新环形进度图
          this.$nextTick(() => {
            this.updateProgressCircle(deliveryRate, completed, total - completed)
          })

          console.log('项目需求统计:', stats, '交付率:', deliveryRate + '%')
        }
      } catch (error) {
        console.error('加载项目需求统计失败:', error)
      }
    },

    // 更新环形进度图
    updateProgressCircle(percentage, completed, active) {
      // 更新环形图的数值显示
      const progressValueEl = document.querySelector('.progress-circle-value')
      if (progressValueEl) {
        progressValueEl.textContent = percentage
      }

      // 更新SVG圆环的进度
      const circle = document.querySelector('.progress-circle svg circle:nth-child(2)')
      if (circle) {
        const circumference = 283.5 // 2 * PI * 45.12
        const offset = circumference - (circumference * percentage / 100)
        circle.style.strokeDashoffset = offset
      }

      // 更新统计数据
      const statCols = document.querySelectorAll('.stat-col-value')
      if (statCols.length >= 3) {
        statCols[0].textContent = completed + active // 有效需求
        statCols[1].textContent = completed // 已交付
        statCols[2].textContent = active // 未关闭
      }
    },

    // 加载指定项目的Bug统计
    async loadProjectBugStats(projectId) {
      try {
        const response = await getProjectBugStats(projectId)
        if (response.code === 200 && response.data) {
          const stats = response.data
          // 更新Bug统计数据
          this.bugStats.totalBugs = parseInt(stats.totalBugs) || 0
          this.bugStats.unclosedBugs = parseInt(stats.unclosedBugs) || 0
          this.bugStats.resolvedBugs = parseInt(stats.resolvedBugs) || 0
          this.bugStats.closedBugs = parseInt(stats.closedBugs) || 0
          this.bugStats.rejectedBugs = parseInt(stats.rejectedBugs) || 0
          this.bugStats.thisMonthNew = parseInt(stats.thisMonthNew) || 0
          this.bugStats.thisMonthResolved = parseInt(stats.thisMonthResolved) || 0

          // 计算Bug解决率
          const total = parseInt(stats.totalBugs) || 0
          const resolved = parseInt(stats.resolvedBugs) || 0
          const resolveRate = total > 0 ? Math.round((resolved / total) * 100) : 0

          // 更新Bug统计页面显示
          this.$nextTick(() => {
            this.updateBugStatsDisplay(resolveRate)
          })

          console.log('项目Bug统计:', stats, '解决率:', resolveRate + '%')
        }
      } catch (error) {
        console.error('加载项目Bug统计失败:', error)
      }
    },

    // 加载指定项目的Bug月度趋势
    async loadProjectBugMonthTrend(projectId) {
      try {
        const response = await getProjectBugMonthTrend(projectId)
        if (response.code === 200 && response.data) {
          const trendData = response.data

          // 生成最近6个月的月份
          const months = []
          const bugNew = []
          const bugResolved = []

          const now = new Date()
          for (let i = 5; i >= 0; i--) {
            const date = new Date(now.getFullYear(), now.getMonth() - i, 1)
            const monthStr = `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}`
            months.push(monthStr)

            // 查找该月的数据
            const monthData = trendData.find(d => d.month === monthStr)
            bugNew.push(monthData ? parseInt(monthData.newCount) : 0)
            bugResolved.push(monthData ? parseInt(monthData.resolvedCount) : 0)
          }

          this.bugMonthTrend = { months, bugNew, bugResolved }

          // 重新渲染Bug图表
          this.$nextTick(() => {
            if (this.bugChart) {
              this.bugChart.dispose()
            }
            this.initBugTrendChart()
          })

          console.log('项目Bug月度趋势:', this.bugMonthTrend)
        }
      } catch (error) {
        console.error('加载项目Bug月度趋势失败:', error)
      }
    },

    // 更新Bug统计显示
    updateBugStatsDisplay(resolveRate) {
      // 查找所有block-statistic-panes元素，找到包含"Bug解决率"文本的那个
      const allPanes = document.querySelectorAll('.block-statistic-panes')
      let bugStatSection = null

      for (let pane of allPanes) {
        if (pane.textContent.includes('Bug解决率')) {
          bugStatSection = pane
          break
        }
      }

      if (!bugStatSection) return

      // 更新环形图百分比
      const progressValueEl = bugStatSection.querySelector('.progress-circle-value')
      if (progressValueEl) {
        progressValueEl.textContent = resolveRate
      }

      // 更新SVG圆环的进度
      const circle = bugStatSection.querySelector('.progress-circle svg circle:nth-child(2)')
      if (circle) {
        const circumference = 283.5 // 2 * PI * 45.12
        const offset = circumference - (circumference * resolveRate / 100)
        circle.style.strokeDashoffset = offset
      }

      // 更新统计数据（有效Bug、已解决、未关闭）
      const statCols = bugStatSection.querySelectorAll('.stat-col-value')
      if (statCols.length >= 3) {
        statCols[0].textContent = this.bugStats.totalBugs // 有效Bug
        statCols[1].textContent = this.bugStats.resolvedBugs // 已解决
        statCols[2].textContent = this.bugStats.unclosedBugs // 未关闭
      }

      // 更新本月解决和新增数据
      const trendInfoSpans = bugStatSection.querySelectorAll('.trend-info span')
      if (trendInfoSpans.length >= 2) {
        // 本月解决
        const resolvedSpan = trendInfoSpans[0].querySelector('.success')
        if (resolvedSpan) {
          resolvedSpan.textContent = this.bugStats.thisMonthResolved
        }
        // 本月新增
        const newSpan = trendInfoSpans[2].querySelector('.primary')
        if (newSpan) {
          newSpan.textContent = this.bugStats.thisMonthNew
        }
      }
    },

    // 加载指定项目的月度趋势
    async loadProjectMonthTrend(projectId) {
      try {
        const response = await getProjectMonthTrend(projectId)
        if (response.code === 200 && response.data) {
          const trendData = response.data

          // 生成最近6个月的月份
          const months = []
          const requirementNew = []
          const requirementCompleted = []

          const now = new Date()
          for (let i = 5; i >= 0; i--) {
            const date = new Date(now.getFullYear(), now.getMonth() - i, 1)
            const monthStr = `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}`
            months.push(monthStr)

            // 查找该月的数据
            const monthData = trendData.find(d => d.month === monthStr)
            requirementNew.push(monthData ? parseInt(monthData.newCount) : 0)
            requirementCompleted.push(monthData ? parseInt(monthData.completedCount) : 0)
          }

          this.monthTrend = {
            months,
            requirementNew,
            requirementCompleted,
            taskNew: [],
            taskCompleted: []
          }

          // 重新渲染图表
          this.$nextTick(() => {
            if (this.storyChart) {
              this.storyChart.dispose()
            }
            this.initStoryTrendChart()
          })

          console.log('项目月度趋势:', this.monthTrend)
        }
      } catch (error) {
        console.error('加载项目月度趋势失败:', error)
      }
    },

    // 加载年度发布榜
    async loadAnnualRanking() {
      try {
        const response = await getAnnualRanking()
        if (response.code === 200) {
          this.annualRanking = response.data || []
        }
      } catch (error) {
        console.error('加载年度发布榜失败:', error)
      }
    },

    // 获取排名样式类
    getRankClass(index) {
      if (index === 0) return 'rank-1'
      if (index === 1) return 'rank-2'
      if (index === 2) return 'rank-3'
      return 'rank-other'
    },
    initStoryTrendChart() {
      const chartDom = this.$refs.storyTrendChart
      if (!chartDom) return

      this.storyChart = echarts.init(chartDom)
      const option = {
        color: ['#2B80FF', '#17CE97'],
        tooltip: {
          trigger: 'axis'
        },
        legend: {
          data: ['新增需求', '完成需求'],
          top: 0,
          right: '30px',
          textStyle: {
            fontSize: 12
          }
        },
        grid: {
          left: '20px',
          right: '30px',
          top: '30px',
          bottom: '25px',
          containLabel: true
        },
        xAxis: {
          type: 'category',
          boundaryGap: false,
          data: this.monthTrend.months,
          axisTick: {
            alignWithLabel: true
          },
          axisLabel: {
            rotate: 45,
            fontSize: 11
          }
        },
        yAxis: {
          type: 'value',
          name: '个',
          nameTextStyle: {
            fontSize: 11
          },
          axisLine: {
            show: true,
            lineStyle: {
              color: '#DDD'
            }
          },
          splitLine: {
            show: false
          }
        },
        series: [
          {
            name: '新增需求',
            type: 'line',
            data: this.monthTrend.requirementNew,
            smooth: true,
            emphasis: {
              label: {
                show: true
              }
            }
          },
          {
            name: '完成需求',
            type: 'line',
            data: this.monthTrend.requirementCompleted,
            smooth: true,
            emphasis: {
              label: {
                show: true
              }
            }
          }
        ]
      }
      this.storyChart.setOption(option)
    },

    initBugTrendChart() {
      const chartDom = this.$refs.bugTrendChart
      if (!chartDom) return

      this.bugChart = echarts.init(chartDom)
      const option = {
        color: ['#FF6B6B', '#17CE97'],
        tooltip: {
          trigger: 'axis'
        },
        legend: {
          data: ['新增Bug', '解决Bug'],
          top: 0,
          right: '30px',
          textStyle: {
            fontSize: 12
          }
        },
        grid: {
          left: '20px',
          right: '30px',
          top: '30px',
          bottom: '25px',
          containLabel: true
        },
        xAxis: {
          type: 'category',
          boundaryGap: false,
          data: this.bugMonthTrend.months,
          axisTick: {
            alignWithLabel: true
          },
          axisLabel: {
            rotate: 45,
            fontSize: 11
          }
        },
        yAxis: {
          type: 'value',
          name: '个',
          nameTextStyle: {
            fontSize: 11
          },
          axisLine: {
            show: true,
            lineStyle: {
              color: '#DDD'
            }
          },
          splitLine: {
            show: false
          }
        },
        series: [
          {
            name: '新增Bug',
            type: 'line',
            data: this.bugMonthTrend.bugNew,
            smooth: true,
            emphasis: {
              label: {
                show: true
              }
            }
          },
          {
            name: '解决Bug',
            type: 'line',
            data: this.bugMonthTrend.bugResolved,
            smooth: true,
            emphasis: {
              label: {
                show: true
              }
            }
          }
        ]
      }
      this.bugChart.setOption(option)
    },

    handleResize() {
      if (this.storyChart) {
        this.storyChart.resize()
      }
      if (this.bugChart) {
        this.bugChart.resize()
      }
    }
  }
}
</script>

<style scoped>
.dashboard-container {
  padding: 20px;
  background: #f5f6f7;
  min-height: calc(100vh - 84px);
}

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

/* 禅道风格的两列布局 */
.dashboard-layout {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 16px;
  width: 100%;
}

.col-main {
  min-width: 0;
}

.col-side {
  min-width: 0;
}

/* 响应式：小屏幕时变为单列 */
@media (max-width: 1200px) {
  .dashboard-layout {
    grid-template-columns: 1fr;
  }
}

.dashboard-block {
  margin-bottom: 16px;
}

.panel {
  background: white;
  border-radius: 4px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.1);
  overflow: hidden;
}

.panel-heading {
  padding: 12px 16px;
  border-bottom: 1px solid #e5e6eb;
  background: #fafafa;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.panel-title {
  font-size: 14px;
  font-weight: bold;
  color: #3c4353;
}

.panel-body {
  padding: 11px;
}

/* 产品总览样式 */
.overview-stats {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 0;
}

.stat-item {
  text-align: center;
  padding: 12px;
}

.stat-item.stat-divider {
  border-left: 1px solid #e5e6eb;
}

.stat-number {
  font-size: 28px;
  font-weight: bold;
  color: #2B80FF;
  margin-bottom: 4px;
}

.stat-label {
  font-size: 12px;
  color: #8f959e;
}

/* 带单位后缀的数字 */
.stat-number-with-unit::after {
  content: '/h';
  font-size: 0.6em;
  color: inherit;
}

.overview-header {
  font-size: 14px;
  font-weight: bold;
  color: #3c4353;
  margin-bottom: 16px;
}

.annual-stats {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 0;
}

/* 产品统计样式 */
.block-statistic {
  display: flex;
  height: 250px;
}

.block-statistic-nav {
  width: 208px;
  border-right: 1px solid #e5e6eb;
  overflow-y: auto;
  padding: 8px;
}

.block-statistic-panes {
  flex: 1;
  overflow: hidden;
}

.nav-item a {
  display: block;
  padding: 6px 12px;
  color: #3c4353;
  text-decoration: none;
  cursor: pointer;
  border-radius: 4px;
  margin-bottom: 2px;
  font-size: 13px;
}

.nav-item.active a,
.nav-item a:hover {
  background: #e8f3ff;
  color: #2B80FF;
}

/* 环形进度图 */
.progress-circle {
  position: relative;
  width: 112px;
  height: 112px;
  margin: 0 auto;
}

.progress-circle svg {
  transform: rotate(-90deg);
}

.progress-circle-text {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  text-align: center;
}

.progress-circle-value {
  font-size: 24px;
  font-weight: bold;
  line-height: 1;
}

.progress-circle-percent {
  font-size: 14px;
  font-weight: bold;
}

/* 需求统计区域 */
.stat-row {
  display: flex;
  justify-content: space-around;
  align-items: center;
  gap: 16px;
  margin-top: 16px;
}

.stat-col {
  text-align: center;
}

.stat-col-value {
  font-size: 18px;
  font-weight: bold;
  color: #3c4353;
}

.stat-col-label {
  font-size: 12px;
  color: #8f959e;
  margin-top: 4px;
}

/* 趋势信息 */
.trend-header {
  font-size: 14px;
  font-weight: bold;
  color: #3c4353;
  margin-bottom: 8px;
}

.trend-info {
  display: flex;
  gap: 16px;
  font-size: 13px;
  color: #8f959e;
  margin-bottom: 12px;
}

.trend-info .success {
  color: #17CE97;
  font-weight: bold;
}

.trend-info .primary {
  color: #2B80FF;
  font-weight: bold;
}

/* 发布统计样式 */
.bar-chart {
  display: flex;
  align-items: flex-end;
  justify-content: space-around;
  height: 150px;
  padding: 0 16px;
}

.bar-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  flex: 1;
}

.bar {
  width: 40px;
  background: #2B80FF;
  border-radius: 4px 4px 0 0;
  position: relative;
  min-height: 2px;
}

.bar-value {
  position: absolute;
  top: -20px;
  left: 50%;
  transform: translateX(-50%);
  font-size: 12px;
  color: #3c4353;
}

.bar-label {
  margin-top: 8px;
  font-size: 12px;
  color: #8f959e;
}

.ranking-item {
  display: flex;
  justify-content: space-between;
  padding: 8px 16px;
  font-size: 14px;
}

.ranking-item:hover {
  background: #f5f6f7;
}

.rank-badge {
  display: inline-block;
  width: 20px;
  height: 20px;
  line-height: 20px;
  text-align: center;
  border-radius: 50%;
  margin-right: 8px;
  font-size: 12px;
}

.rank-1 {
  background: #FFD700;
  color: white;
}

.rank-2 {
  background: #C0C0C0;
  color: white;
}

.rank-3 {
  background: #CD7F32;
  color: white;
}

.rank-other {
  background: #e5e6eb;
  color: #8f959e;
}

/* 表格样式 */
.story-table {
  width: 100%;
  border-collapse: collapse;
}

.story-table th,
.story-table td {
  padding: 10px 16px;
  text-align: left;
  border-bottom: 1px solid #e5e6eb;
  font-size: 14px;
  vertical-align: middle;
}

/* ID列右边框 */
.story-table th:first-child,
.story-table td:first-child {
  border-right: 1px solid #e5e6eb;
}

/* 需求名称列字体 */
.story-table td:nth-child(2) a {
  font-size: 13px;
}

.story-table th {
  background: #fafafa;
  font-weight: bold;
  color: #3c4353;
}

.story-table tbody tr:hover {
  background: #f5f6f7;
}

/* 优先级 */
.pri-1,
.pri-2,
.pri-3,
.pri-4 {
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
</style>
