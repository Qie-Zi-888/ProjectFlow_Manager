<template>
  <div id="dashboard">
    <div class="row">
      <!-- 左侧主内容区 -->
      <div class="col-main">
        <!-- 欢迎总览 -->
        <div class="panel block-welcome">
          <div class="panel-heading">
            <div class="welcome-header">
              <div class="date-info">{{ currentDate }}</div>
              <div class="companion-info">
                已陪伴您55天：<strong>昨日</strong>您暂未处理任务和Bug，今日期待优秀的您来处理！
              </div>
            </div>
          </div>
          <div class="panel-body">
            <div class="welcome-content">
              <div class="user-section">
                <div class="user-greeting">{{ userName }}，晚上好</div>
                <div class="avatar">
                  <img :src="userAvatar" :alt="userName">
                </div>
              </div>
              <div class="divider"></div>
              <div class="stats-section">
                <div class="stats-labels-row">
                  <div class="stats-label">待我评审</div>
                  <div class="divider"></div>
                  <div class="stats-label">指派给我</div>
                </div>
                <div class="stats-numbers-row">
                  <div class="stat-item" v-for="(item, index) in statsList" :key="index">
                    <div class="stats-number">
                      <a href="#">{{ item.count }}</a>
                    </div>
                    <div class="stats-desc">{{ item.label }}</div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- 我的待处理 -->
        <div class="panel assigntome-block">
          <div class="panel-heading">
            <div class="panel-title">我的待处理</div>
            <ul class="nav-tabs">
              <li><a href="#" :class="{ active: activeTab === 'task' }" @click.prevent="switchTab('task')">任务</a></li>
              <li><a href="#" :class="{ active: activeTab === 'bug' }" @click.prevent="switchTab('bug')">BUG</a></li>
              <li><a href="#" :class="{ active: activeTab === 'review' }" @click.prevent="switchTab('review')">测试</a></li>
              <li><a href="#" :class="{ active: activeTab === 'story' }" @click.prevent="switchTab('story')">需求</a></li>
              <li><a href="#" :class="{ active: activeTab === 'requirement' }" @click.prevent="switchTab('requirement')">用户需求</a></li>
            </ul>
          </div>
          <div class="panel-body">
            <div class="tab-content">
              <!-- 测试 Tab -->
              <div v-show="activeTab === 'review'" class="tab-pane">
                <div class="table-container">
                  <table class="dtable">
                    <thead>
                      <tr>
                        <th>ID</th>
                        <th>评审标题</th>
                        <th>评审对象</th>
                        <th>所属产品</th>
                        <th>提交时间</th>
                        <th>状态</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr v-for="item in reviewList" :key="item.id">
                        <td>{{ item.id }}</td>
                        <td><a href="#">{{ item.title }}</a></td>
                        <td>{{ item.object }}</td>
                        <td>{{ item.product }}</td>
                        <td>{{ item.submitTime }}</td>
                        <td><span class="status-reviewing">{{ item.status }}</span></td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>

              <!-- 任务 Tab -->
              <div v-show="activeTab === 'task'" class="tab-pane">
                <div class="table-container">
                  <table class="dtable">
                    <thead>
                      <tr>
                        <th>ID</th>
                        <th>任务名称</th>
                        <th>P</th>
                        <th>状态</th>
                        <th>截止</th>
                        <th>预计</th>
                        <th>剩余</th>
                        <th>进度</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr v-for="item in taskList" :key="item.id">
                        <td>{{ item.id }}</td>
                        <td><a href="#">{{ item.name }}</a></td>
                        <td>{{ item.priority }}</td>
                        <td>{{ item.status }}</td>
                        <td>{{ item.deadline }}</td>
                        <td>{{ item.estimated }}</td>
                        <td>{{ item.remaining }}</td>
                        <td>{{ item.progress }}</td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>

              <!-- 需求 Tab -->
              <div v-show="activeTab === 'story'" class="tab-pane">
                <div class="table-container">
                  <table class="dtable">
                    <thead>
                      <tr>
                        <th>ID</th>
                        <th>需求名称</th>
                        <th>所属产品</th>
                        <th>状态</th>
                        <th>优先级</th>
                        <th>预计工时</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr v-for="item in storyList" :key="item.id">
                        <td>{{ item.id }}</td>
                        <td><a href="#">{{ item.name }}</a></td>
                        <td>{{ item.product }}</td>
                        <td>{{ item.status }}</td>
                        <td>{{ item.priority }}</td>
                        <td>{{ item.estimatedHours }}</td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>

              <!-- 用户需求 Tab -->
              <div v-show="activeTab === 'requirement'" class="tab-pane">
                <div class="table-container">
                  <table class="dtable">
                    <thead>
                      <tr>
                        <th>ID</th>
                        <th>需求名称</th>
                        <th>所属产品</th>
                        <th>状态</th>
                        <th>提交人</th>
                        <th>提交时间</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr v-for="item in requirementList" :key="item.id">
                        <td>{{ item.id }}</td>
                        <td><a href="#">{{ item.name }}</a></td>
                        <td>{{ item.product }}</td>
                        <td>{{ item.status }}</td>
                        <td>{{ item.submitter }}</td>
                        <td>{{ item.submitTime }}</td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>

              <!-- BUG Tab -->
              <div v-show="activeTab === 'bug'" class="tab-pane">
                <div class="table-container">
                  <table class="dtable">
                    <thead>
                      <tr>
                        <th>ID</th>
                        <th>Bug标题</th>
                        <th>所属产品</th>
                        <th>严重程度</th>
                        <th>优先级</th>
                        <th>状态</th>
                        <th>指派给</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr v-for="item in bugList" :key="item.id">
                        <td>{{ item.id }}</td>
                        <td><a href="#">{{ item.title }}</a></td>
                        <td>{{ item.product }}</td>
                        <td>{{ item.severity }}</td>
                        <td>{{ item.priority }}</td>
                        <td><span class="status-reviewing">{{ item.status }}</span></td>
                        <td>{{ item.assignee }}</td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- 我最近参与的项目 -->
        <div class="panel recentproject-block">
          <div class="panel-heading">
            <div class="panel-title">我最近参与的项目</div>
            <div class="toolbar">
              <a href="#" class="btn ghost size-sm" style="text-decoration: none; color: #318ef6; font-size: 13px; padding: 4px 8px;">
                <span>更多</span>
                <span style="margin-left: 2px;">›</span>
              </a>
            </div>
          </div>
          <div class="panel-body" style="padding: 6px 6px 4px;">
            <div class="project-cards">
              <div class="project-card" v-for="project in recentProjects" :key="project.id">
                <div class="mb-2">
                  <a class="font-bold text-md" href="#">{{ project.name }}</a>
                </div>
                <div class="space-y-3">
                  <div><span class="text-gray mr-1">项目成员: </span>共 {{ project.members }} 人</div>
                  <div><span class="text-gray mr-1">计划完成: </span>{{ project.endDate }}</div>
                  <div><span class="text-gray mr-1">近期执行: </span>
                    <a v-if="project.execution" href="#">{{ project.execution }}</a>
                    <span v-else class="text-gray">暂无</span>
                  </div>
                  <div><span class="text-gray mr-1">备注: </span>
                    <span class="status-badge" :class="project.statusClass">{{ project.statusText }}</span>
                  </div>
                  <div class="flex items-center">
                    <span class="num mr-1">{{ project.progress }}%</span>
                    <div class="progress-bar-container">
                      <div class="progress-bar-fill" :style="{ width: project.progress + '%' }"></div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 右侧边栏 -->
      <div class="col-side">
        <!-- 最新动态 -->
        <div class="panel dynamic-block">
          <div class="panel-heading" style="display: flex; align-items: center; justify-content: space-between;">
            <div class="panel-title">最新动态</div>
            <div class="toolbar">
              <a href="#" style="text-decoration: none; color: #318ef6; font-size: 13px; padding: 4px 8px;">
                <span>更多</span>
                <span style="margin-left: 2px;">›</span>
              </a>
            </div>
          </div>
          <div class="panel-body">
            <ul class="dynamic dynamic-tag-left has-time">
              <li v-for="(activity, index) in activities" :key="index" :class="activity.type">
                <div>
                  <span class="dynamic-tag">{{ activity.time }}</span>
                  <div class="dynamic-text">
                    <div class="clip">
                      {{ activity.user }}<span class="text-gray">{{ activity.action }}</span>{{ activity.objectType }} <span class="dynamic-id">{{ activity.id }}</span> <a href="#">{{ activity.title }}</a>
                    </div>
                  </div>
                </div>
              </li>
            </ul>
          </div>
        </div>

        <!-- 团队成就 -->
        <div class="panel teamachievement-block">
          <div class="panel-heading">
            <div class="panel-title">团队成就</div>
          </div>
          <div class="panel-body">
            <div class="achievement-list">
              <div class="achievement-item" v-for="(group, groupIndex) in achievementGroups" :key="groupIndex">
                <div class="achievement-col" v-for="(item, itemIndex) in group" :key="itemIndex" :class="'item-' + item.type">
                  <div class="achievement-icon"></div>
                  <div class="achievement-text">
                    <div class="achievement-title">{{ item.title }}</div>
                    <div class="achievement-stats">
                      <div class="stat-group border-r">
                        <span class="stat-label">{{ item.yesterdayLabel }}</span>
                        <span class="stat-value text-gray">{{ item.yesterdayValue }}</span>
                      </div>
                      <div class="stat-group">
                        <span class="stat-label">{{ item.todayLabel }}</span>
                        <span class="stat-value text-success">{{ item.todayValue }}</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Dashboard',
  data() {
    return {
      userName: '李先生',
      currentDate: '2026年04月17日 星期五',
      userAvatar: "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'%3E%3Crect width='100' height='100' fill='%23318ef6'/%3E%3Ctext x='50' y='50' font-size='40' fill='white' text-anchor='middle' dy='.3em'%3E李%3C/text%3E%3C/svg%3E",
      activeTab: 'task',
      statsList: [
        { count: 32, label: '待我评审数' },
        { count: 32, label: '任务数' },
        { count: 68, label: 'BUG数' },
        { count: 36, label: '需求数' },
        { count: 2, label: '测试数' }
      ],
      reviewList: [
        { id: 692, title: '新增客户信息功能', object: '需求', product: 'CRM客户关系管理系统', submitTime: '04-17 19:33', status: '评审中' },
        { id: 684, title: 'gfsdgfsgfsd', object: '需求', product: 'aaa-11201', submitTime: '04-17 10:07', status: '评审中' },
        { id: 682, title: '系统key登录', object: '需求', product: '领导服务系统', submitTime: '2025-11-11 11:57', status: '评审中' },
        { id: 681, title: '01 需求', object: '需求', product: 'Test-JGX', submitTime: '2025-11-11 09:34', status: '评审中' },
        { id: 679, title: '需求1', object: '需求', product: '测ZL产品', submitTime: '2025-11-10 15:25', status: '评审中' },
        { id: 678, title: '用户登录优化', object: '需求', product: 'CRM客户关系管理系统', submitTime: '2025-11-10 14:20', status: '评审中' }
      ],
      taskList: [
        { id: 256, name: '总结任务', priority: 3, status: '已完成', deadline: '-', estimated: '0.00h', remaining: '0.00h', progress: '100%' },
        { id: 255, name: '研究任务', priority: 3, status: '已完成', deadline: '-', estimated: '0.00h', remaining: '0.00h', progress: '100%' },
        { id: 254, name: '测试任务', priority: 3, status: '已完成', deadline: '-', estimated: '0.00h', remaining: '0.00h', progress: '100%' },
        { id: 253, name: '开发任务', priority: 3, status: '进行中', deadline: '05-01', estimated: '8.00h', remaining: '4.00h', progress: '50%' },
        { id: 252, name: '设计任务', priority: 3, status: '进行中', deadline: '04-28', estimated: '6.00h', remaining: '2.00h', progress: '67%' },
        { id: 251, name: '文档编写', priority: 3, status: '未开始', deadline: '05-05', estimated: '12.00h', remaining: '12.00h', progress: '0%' }
      ],
      storyList: [
        { id: 156, name: '用户登录功能优化', product: 'CRM系统', status: '激活', priority: 2, estimatedHours: '8.0h' },
        { id: 155, name: '数据导出功能', product: 'CRM系统', status: '激活', priority: 3, estimatedHours: '12.0h' },
        { id: 154, name: '报表统计功能', product: '管理系统', status: '激活', priority: 2, estimatedHours: '16.0h' },
        { id: 153, name: '权限管理优化', product: '管理系统', status: '激活', priority: 1, estimatedHours: '10.0h' },
        { id: 152, name: '消息通知功能', product: 'CRM系统', status: '激活', priority: 3, estimatedHours: '6.0h' },
        { id: 151, name: '首页仪表盘优化', product: '管理系统', status: '激活', priority: 2, estimatedHours: '8.0h' }
      ],
      requirementList: [
        { id: 89, name: '移动端适配需求', product: 'CRM系统', status: '激活', submitter: '张三', submitTime: '2026-04-15' },
        { id: 88, name: '批量导入功能', product: '管理系统', status: '激活', submitter: '李四', submitTime: '2026-04-14' },
        { id: 87, name: '数据备份功能', product: 'CRM系统', status: '激活', submitter: '王五', submitTime: '2026-04-13' },
        { id: 86, name: '日志查询功能', product: '管理系统', status: '激活', submitter: '赵六', submitTime: '2026-04-12' },
        { id: 85, name: '用户反馈功能', product: 'CRM系统', status: '激活', submitter: '钱七', submitTime: '2026-04-11' },
        { id: 84, name: '数据统计报表', product: '管理系统', status: '激活', submitter: '孙八', submitTime: '2026-04-10' }
      ],
      bugList: [
        { id: 518, title: '用户协议复选框文字及默认状态正确', product: 'CRM系统', severity: 3, priority: 3, status: '激活', assignee: '张三' },
        { id: 517, title: '登录页面验证码不显示', product: '管理系统', severity: 2, priority: 2, status: '激活', assignee: '李四' },
        { id: 516, title: '数据导出功能异常', product: 'CRM系统', severity: 3, priority: 3, status: '已解决', assignee: '王五' },
        { id: 515, title: '首页加载速度慢', product: '管理系统', severity: 2, priority: 2, status: '激活', assignee: '赵六' },
        { id: 514, title: '权限控制失效', product: 'CRM系统', severity: 1, priority: 1, status: '激活', assignee: '钱七' },
        { id: 513, title: '消息通知延迟', product: '管理系统', severity: 3, priority: 3, status: '已关闭', assignee: '孙八' }
      ],
      recentProjects: [
        {
          id: 1,
          name: 'like的第二个项目',
          members: 6,
          endDate: '2026-04-30',
          execution: '需求',
          statusText: '进行中',
          statusClass: 'status-doing',
          progress: 100
        },
        {
          id: 2,
          name: 'like的第一个项目',
          members: 1,
          endDate: '2026-04-30',
          execution: null,
          statusText: '未开始',
          statusClass: 'status-not-started',
          progress: 0
        },
        {
          id: 3,
          name: '大屏项目-2',
          members: 1,
          endDate: '2026-04-30',
          execution: '大屏项目5月上线',
          statusText: '进行中',
          statusClass: 'status-doing',
          progress: 100
        }
      ],
      activities: [
        { time: '4月17日 21:12', user: '李先生', action: '删除了', objectType: 'Bug', id: 518, title: '用户协议复选框文字及默认状态正确', type: '' },
        { time: '4月17日 21:11', user: '李先生', action: '激活了', objectType: 'Bug', id: 518, title: '用户协议复选框文字及默认状态正确', type: '' },
        { time: '4月17日 21:11', user: '李先生', action: '指派了', objectType: 'Bug', id: 519, title: '密码输入框显示/隐藏图标功能不存在(期望:存在)', type: 'blue' },
        { time: '4月17日 21:11', user: '李先生', action: '创建了', objectType: 'Bug', id: 519, title: '密码输入框显示/隐藏图标功能不存在(期望:存在)', type: '' },
        { time: '4月17日 21:08', user: '李先生', action: '执行了', objectType: '用例', id: 753, title: '密码输入框显示/隐藏图标功能验证（原型存在时）', type: '' },
        { time: '4月17日 21:08', user: '李先生', action: '评审了', objectType: '用例', id: 753, title: '密码输入框显示/隐藏图标功能验证（原型存在时）', type: '' },
        { time: '4月17日 21:05', user: '李先生', action: '关闭了', objectType: 'Bug', id: 518, title: '用户协议复选框文字及默认状态正确', type: 'green' },
        { time: '4月17日 21:04', user: '李先生', action: '解决了', objectType: 'Bug', id: 518, title: '用户协议复选框文字及默认状态正确', type: 'green' }
      ],
      achievementGroups: [
        [
          { type: 'task', title: '完成任务数量', yesterdayLabel: '昨日', yesterdayValue: 0, todayLabel: '今日', todayValue: 1 },
          { type: 'story', title: '创建需求数量', yesterdayLabel: '昨日', yesterdayValue: 0, todayLabel: '今日', todayValue: 1 }
        ],
        [
          { type: 'bug', title: '关闭的Bug数', yesterdayLabel: '昨日', yesterdayValue: 0, todayLabel: '今日', todayValue: 1 },
          { type: 'case', title: '执行的用例数', yesterdayLabel: '昨日', yesterdayValue: 0, todayLabel: '今日', todayValue: 3 }
        ],
        [
          { type: 'hour', title: '消耗工时 / h', yesterdayLabel: '昨日', yesterdayValue: 0, todayLabel: '今日', todayValue: 2 },
          { type: 'project', title: '已完成的项目数量', yesterdayLabel: '上月', yesterdayValue: 3, todayLabel: '本月', todayValue: 2 }
        ]
      ]
    }
  },
  methods: {
    switchTab(tabId) {
      this.activeTab = tabId
    }
  }
}
</script>

<style>
/* 全局样式 - 不使用scoped，确保伪元素和:root变量正常工作 */
:root {
  --color-primary-500: #318ef6;
  --color-primary-50: #e6f4ff;
  --color-primary-600: #267ae0;
  --color-gray-50: #fafafa;
  --color-gray-100: #f5f5f5;
  --color-gray-200: #f0f0f0;
  --color-gray-300: #e5e5e5;
  --color-gray-500: #9ea3b0;
  --color-gray-600: #838a9d;
  --color-gray-700: #666;
  --color-gray-900: #3c4353;
  --color-canvas: #fff;
  --color-secondary-50: #f0f7ff;
  --color-success: #52c41a;
  --color-warning: #faad14;
  --color-error: #fb2b2b;
  --color-inverse: #000;
  --zt-menu-bg: var(--color-gray-900);
  --zt-menu-hover-bg: var(--color-primary-600);
  --zt-menu-active-bg: var(--color-primary-500);
}

/* 最新动态 - 伪元素选择器必须在非scoped样式中 */
.dynamic > li {
  position: relative;
}

.dynamic > li:before {
  position: absolute;
  top: 25%;
  transform: translateY(-50%);
  left: -16px;
  z-index: 3;
  display: block;
  width: 12px;
  height: 12px;
  content: ' ';
  border-radius: 50%;
  background-color: var(--color-canvas);
  border: 2px solid var(--color-gray-300);
}

.dynamic > li > div:after {
  position: absolute;
  top: 25%;
  transform: translateY(-50%);
  left: -13px;
  z-index: 4;
  display: block;
  width: 5px;
  height: 5px;
  content: ' ';
  border-radius: 50%;
  background-color: var(--color-gray-500);
}

.dynamic > li.blue > div:after {
  background-color: #2e7fff;
}

.dynamic > li.green > div:after {
  background-color: rgb(25, 190, 131);
}

.dynamic > li:first-child:after {
  position: absolute;
  top: 30%;
  bottom: -12px;
  left: -10px;
  z-index: 1;
  display: block;
  content: ' ';
  border-left: 2px solid var(--color-gray-200);
}

.dynamic > li + li:after {
  position: absolute;
  top: -12px;
  bottom: -12px;
  left: -10px;
  z-index: 1;
  display: block;
  content: ' ';
  border-left: 2px solid var(--color-gray-200);
}

.dynamic > li:last-child:after {
  bottom: 12px;
}

.dynamic-id {
  display: inline-block;
  padding: 1px 6px;
  margin: 0 4px;
  border: 1px solid var(--color-gray-300);
  border-radius: 3px;
  font-size: 12px;
  color: var(--color-gray-700);
  background-color: var(--color-gray-50);
  vertical-align: middle;
}
</style>

<style scoped>
/* 组件作用域样式 */

#dashboard {
  max-width: 1400px;
  margin: 0 auto;
  padding: 20px;
}

@media (min-width: 992px) {
  #dashboard > .row {
    display: table;
    width: 100%;
    margin: 0;
  }
  #dashboard > .row > .col-main,
  #dashboard > .row > .col-side {
    display: table-cell;
    float: none;
    padding: 0;
    vertical-align: top;
  }
  #dashboard > .row > .col-main {
    padding-right: 10px;
  }
  #dashboard > .row > .col-side {
    padding-left: 10px;
  }
}

#dashboard > .row {
  display: flex;
  flex-wrap: wrap;
  gap: 0px;
}

.col-main {
  flex: 2;
  min-width: 0;
}

.col-side {
  flex: 1;
  min-width: 300px;
}

/* Panel 样式 */
.panel {
  background: var(--color-canvas);
  border-radius: 4px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.1);
  margin-bottom: 20px;
  overflow: hidden;
}

.panel-heading {
  padding: 8px 10px;
  border-bottom: 1px solid var(--color-gray-300);
  background: var(--color-gray-50);
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.panel-title {
  font-size: 14px;
  font-weight: bold;
  color: var(--color-gray-900);
}

.panel-body {
  padding: 16px;
}

/* 欢迎总览区块 */
.block-welcome .panel-heading {
  padding: 8px 0;
  border-bottom: none;
}

.block-welcome .welcome-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 8px 16px;
}

.block-welcome .date-info {
  flex-basis: 22%;
  text-align: center;
  font-weight: bold;
  font-size: 14px;
  white-space: nowrap;
}

.block-welcome .companion-info {
  flex: 1;
  font-size: 13px;
  color: var(--color-gray-700);
  padding-left: 15px;
}

.block-welcome .panel-body {
  padding: 0;
  background: linear-gradient(90deg, var(--color-secondary-50) 0%, var(--color-canvas) 22%);
}

.block-welcome .welcome-content {
  display: flex;
  height: 128px;
}

.block-welcome .user-section {
  flex-basis: 22%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: 16px 0;
}

.block-welcome .user-greeting {
  font-weight: bold;
  font-size: 14px;
}

.block-welcome .avatar {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  overflow: hidden;
}

.block-welcome .avatar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.block-welcome .divider {
  width: 1px;
  height: 40px;
  background: #e5e5e5;
  align-self: center;
}

.block-welcome .stats-section {
  flex: 1;
  display: flex;
  padding: 16px 0;
}

.block-welcome .stats-label {
  font-weight: bold;
  font-size: 14px;
  margin-bottom: 5px;
}

.block-welcome .stats-number {
  font-size: 28px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.block-welcome .stats-number a {
  color: #318ef6;
  text-decoration: none;
  font-weight: bold;
}

.block-welcome .stats-desc {
  font-size: 12px;
  color: var(--color-gray-700);
}

.block-welcome .stats-section {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: center;
  gap: 8px;
  padding: 16px 0;
}

.block-welcome .stats-labels-row {
  display: flex;
  align-items: center;
  width: 100%;
}

.block-welcome .stats-labels-row .divider {
  width: 1px;
  height: 25px;
  background: #e5e5e5;
  align-self: center;
  margin-left: 8px;
}

.block-welcome .stats-labels-row .stats-label {
  text-align: left;
  padding: 0 8px;
}

.block-welcome .stats-labels-row .stats-label:first-child {
  flex: 1;
  margin-left: 35px;
}

.block-welcome .stats-labels-row .stats-label:last-child {
  flex: 4;
}

.block-welcome .stats-numbers-row {
  display: flex;
  justify-content: space-around;
  align-items: center;
  text-align: center;
}

.block-welcome .assign-stats {
  display: flex;
  justify-content: space-around;
  align-items: center;
  text-align: center;
}

.block-welcome .assign-stats .stats-label {
  font-weight: bold;
  font-size: 14px;
  margin: 0 8px;
  display: flex;
  align-items: center;
}

.block-welcome .stat-item {
  padding: 0 8px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

/* 团队成就区块 */
.teamachievement-block .panel-body {
  padding: 12px;
}

.teamachievement-block .achievement-list {
  display: flex;
  flex-wrap: wrap;
  gap: 19px;
}

.teamachievement-block .achievement-item {
  width: 100%;
  display: flex;
  min-height: 60px;
}

.teamachievement-block .achievement-col {
  flex: 1;
  display: flex;
  align-items: flex-start;
  position: relative;
}

.teamachievement-block .achievement-col:first-child {
  flex-basis: 50%;
}

.teamachievement-block .achievement-col:last-child {
  flex-basis: 50%;
}

.teamachievement-block .achievement-icon {
  width: 36px;
  height: 36px;
  position: relative;
  top: 10px;
  background-size: 100%;
  background-repeat: no-repeat;
  background-position: center;
  flex-shrink: 0;
}

.teamachievement-block .item-task .achievement-icon {
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath fill='%23318ef6' d='M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z'/%3E%3C/svg%3E");
}

.teamachievement-block .item-story .achievement-icon {
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath fill='%2352c41a' d='M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-5 14H7v-2h7v2zm3-4H7v-2h10v2zm0-4H7V7h10v2z'/%3E%3C/svg%3E");
}

.teamachievement-block .item-bug .achievement-icon {
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath fill='%23fb2b2b' d='M20 8h-2.81c-.45-.78-1.07-1.45-1.82-1.96L17 4.41 15.59 3l-2.17 2.17C12.96 5.06 12.49 5 12 5c-.49 0-.96.06-1.41.17L8.41 3 7 4.41l1.62 1.63C7.88 6.55 7.26 7.22 6.81 8H4v2h2.81c.15.68.46 1.31.89 1.87L6 13.59 4.59 15l2.17 2.17c.45.11.92.17 1.41.17.49 0 .96-.06 1.41-.17L12 19.41l1.41-1.41 2.17 2.17c.45-.11.92-.17 1.41-.17.49 0 .96.06 1.41.17L20 18l-1.41-1.41c.43-.56.74-1.19.89-1.87H22v-2h-2.81c-.15-.68-.46-1.31-.89-1.87L20 10.41 21.41 9 20 8zM12 17c-2.76 0-5-2.24-5-5s2.24-5 5-5 5 2.24 5 5-2.24 5-5 5z'/%3E%3C/svg%3E");
}

.teamachievement-block .item-case .achievement-icon {
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath fill='%23faad14' d='M14 2H6c-1.1 0-1.99.9-1.99 2L4 20c0 1.1.89 2 1.99 2H18c1.1 0 2-.9 2-2V8l-6-6zm2 16H8v-2h8v2zm0-4H8v-2h8v2zm-3-5V3.5L18.5 9H13z'/%3E%3C/svg%3E");
}

.teamachievement-block .item-hour .achievement-icon {
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath fill='%23722ed1' d='M11.99 2C6.47 2 2 6.48 2 12s4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2zM12 20c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8zm.5-13H11v6l5.25 3.15.75-1.23-4.5-2.67z'/%3E%3C/svg%3E");
}

.teamachievement-block .item-project .achievement-icon {
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath fill='%23318ef6' d='M12 7V3H2v18h20V7H12zM6 19H4v-2h2v2zm0-4H4v-2h2v2zm0-4H4V9h2v2zm0-4H4V5h2v2zm4 12H8v-2h2v2zm0-4H8v-2h2v2zm0-4H8V9h2v2zm0-4H8V5h2v2zm10 12h-8v-2h2v-2h-2v-2h2v-2h-2V9h8v10zm-2-8h-2v2h2v-2zm0 4h-2v2h2v-2z'/%3E%3C/svg%3E");
}

.teamachievement-block .achievement-text {
  flex: 1;
  padding-left: 4px;
}

.teamachievement-block .achievement-title {
  font-size: 13px;
  color: var(--color-gray-700);
  margin-bottom: 8px;
}

.teamachievement-block .achievement-stats {
  display: flex;
  gap: 5px;
  margin-top: 4px;
  justify-content: flex-start;
}

.teamachievement-block .stat-group {
  display: flex;
  align-items: baseline;
  gap: 0px;
}

.teamachievement-block .stat-group.border-r {
  border-right: 1px solid #e5e5e5;
  padding-right: 3px;
}

.teamachievement-block .stat-label {
  font-size: 13px;
  color: var(--color-gray-700);
  line-height: 1;
}

.teamachievement-block .stat-value {
  font-size: 16px;
  font-weight: bold;
  line-height: 1;
}

.teamachievement-block .text-gray {
  color: #666;
  line-height: 1;
  vertical-align: middle;
}

.teamachievement-block .text-success {
  color: #52c41a;
  padding: 0 3px;
  line-height: 1;
  vertical-align: middle;
}

/* 待处理区块 */
.assigntome-block .panel-heading {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.assigntome-block .nav-tabs {
  display: flex;
  gap: 0;
  list-style: none;
  margin: 0;
  padding: 0;
}

.assigntome-block .nav-tabs li {
  position: relative;
}

.assigntome-block .nav-tabs a {
  display: block;
  padding: 6px 12px;
  color: var(--color-gray-700);
  text-decoration: none;
  font-size: 13px;
  border-bottom: 2px solid transparent;
  transition: all 0.2s;
}

.assigntome-block .nav-tabs a:hover {
  color: var(--color-primary-500);
}

.assigntome-block .nav-tabs a.active {
  color: var(--color-primary-500);
  font-weight: 600;
  border-bottom-color: var(--color-primary-500);
}

.assigntome-block .tab-content {
  padding: 0px 0;
}

.assigntome-block .tab-pane {
  min-height: 260px;
}

/* 表格滚动容器 */
.assigntome-block .table-container {
  max-height: 350px;
  overflow: auto;
}

/* 自定义滚动条样式 */
.assigntome-block .table-container::-webkit-scrollbar {
  width: 6px;
}

.assigntome-block .table-container::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 3px;
}

.assigntome-block .table-container::-webkit-scrollbar-thumb {
  background: #c1c1c1;
  border-radius: 3px;
}

.assigntome-block .table-container::-webkit-scrollbar-thumb:hover {
  background: #a1a1a1;
}

/* 表格样式 */
.dtable {
  width: 100%;
  border-collapse: collapse;
  font-size: 13px;
}

.dtable thead th {
  background: var(--color-gray-50);
  padding: 10px 12px;
  text-align: left;
  font-weight: 600;
  color: var(--color-gray-900);
  border-bottom: 1px solid var(--color-gray-300);
  white-space: nowrap;
}

.dtable tbody td {
  padding: 10px 12px;
  border-bottom: 1px solid var(--color-gray-200);
  color: var(--color-gray-700);
}

.dtable tbody tr:hover {
  background: var(--color-primary-50);
}

.dtable a {
  color: var(--color-primary-500);
  text-decoration: none;
}

.dtable a:hover {
  text-decoration: underline;
}

.status-reviewing {
  display: inline-block;
  padding: 2px 8px;
  background: #fff7e6;
  color: #fa8c16;
  border-radius: 2px;
  font-size: 12px;
  line-height: 1;
  vertical-align: middle;
}

.empty-tip {
  text-align: center;
  padding: 40px 0;
  color: #999;
  font-size: 13px;
}

/* 我最近参与的项目 - 卡片布局 */
.recentproject-block .panel-heading {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 8px 16px;
  border-bottom: 1px solid var(--color-gray-300);
  background: var(--color-gray-50);
}

.recentproject-block {
  height: 278px;
}

.project-cards {
  display: flex;
  flex-wrap: nowrap;
  justify-content: space-between;
  gap: 9px;
  padding: 4px;
  align-items: stretch;
  margin-top: 7px;
}

.project-card {
  width: calc(33.333% - 6px);
  min-width: 200px;
  border: 1px solid var(--color-gray-300);
  border-radius: 4px;
  padding: 10px 15px;
  cursor: pointer;
  transition: all 0.2s;
  background: white;
  height: 100%;
}

.project-card:hover {
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  border-color: var(--color-primary-500);
}

.project-card .font-bold {
  font-size: 14px;
  font-weight: bold;
  color: var(--color-gray-900);
  text-decoration: none;
  display: block;
  margin-bottom: 12px;
  line-height: 1.5;
}

.project-card .font-bold:hover {
  color: var(--color-primary-500);
}

.project-card .space-y-3 > div {
  margin-bottom: 12px;
  font-size: 13px;
  line-height: 1.5;
}

.project-card .space-y-3 > div:last-child {
  margin-bottom: 0;
}

.project-card .text-gray {
  color: var(--color-gray-600);
}

.project-card .mr-1 {
  margin-right: 4px;
}

.project-card a {
  color: var(--color-primary-500);
  text-decoration: none;
}

.project-card a:hover {
  text-decoration: underline;
}

/* 状态徽章 */
.status-badge {
  display: inline-block;
  padding: 2px 8px;
  border-radius: 12px;
  font-size: 12px;
  margin-left: 8px;
  line-height: 1.5;
}

.status-doing {
  background: #fff7e6;
  color: #fa8c16;
  border: 1px solid #ffd591;
}

.status-wait {
  background: #f0f5ff;
  color: #318ef6;
  border: 1px solid #adc6ff;
}

.status-suspended {
  background: #fff2e8;
  color: #d46b08;
  border: 1px solid #ffbb96;
}

.status-not-started {
  background: #f5f5f5;
  color: #999;
  border: 1px solid #d9d9d9;
}

/* 进度条容器 */
.progress-bar-container {
  flex: 1;
  height: 8px;
  background: rgba(0, 0, 0, 0.02);
  border-radius: 4px;
  overflow: hidden;
}

.progress-bar-fill {
  height: 100%;
  background: var(--color-primary-500);
  border-radius: 4px;
  transition: width 0.3s ease;
}

.project-card .num {
  font-size: 13px;
  font-weight: bold;
  color: var(--color-gray-900);
  margin-right: 4px;
}

.project-card .flex {
  display: flex;
}

.project-card .items-center {
  align-items: center;
}

.project-card .h-5 {
  height: 20px;
}

.project-card .mb-2 {
  margin-bottom: 8px;
}

/* 响应式：小屏幕时项目卡片变为2列或1列 */
@media (max-width: 1200px) {
  .project-card {
    width: calc(50% - 6px);
  }
}

@media (max-width: 768px) {
  .project-card {
    width: 100%;
  }
}

/* 最新动态区块 */
.dynamic-block {
  background-color: var(--color-canvas);
}

.dynamic-block .panel-heading {
  background-color: var(--color-gray-50);
}

.dynamic-block .panel-body {
  padding-top: 8px;
  background-color: var(--color-canvas);
}

/* 动态列表 */
.dynamic {
  list-style: none;
  margin: 0;
  padding: 4px 12px 0px 95px;
}

.dynamic > li {
  position: relative;
  list-style: none;
  margin-bottom: 13px;
}

.dynamic > li:last-child {
  margin-bottom: 0;
}

/* li > div 容器 */
.dynamic > li > div {
  display: block;
  padding: 2px 0;
  line-height: 1.4;
}

/* 时间标签 */
.dynamic-tag {
  position: absolute;
  top: 4px;
  left: -90px;
  font-size: 11px;
  color: var(--color-gray-600);
  white-space: nowrap;
}

/* 动态文本 */
.dynamic > li .dynamic-text {
  display: flex;
  align-items: center;
  padding: 1px 4px;
  font-size: 13px;
  line-height: 1.5;
  min-height: 20px;
}

.dynamic-text .clip {
  padding: 1px 0;
}

/* hover效果 */
.dynamic > li:hover .dynamic-text {
  background-color: var(--color-primary-50);
  border-radius: 3px;
}

/* 灰色文本 */
.text-gray {
  color: var(--color-gray-600);
  padding: 0 3px;
}

/* 链接 */
.dynamic-text a {
  color: var(--color-primary-500);
  text-decoration: none;
}

.dynamic-text a:hover {
  text-decoration: underline;
  color: var(--color-primary-600);
}

/* 响应式 */
@media (max-width: 768px) {
  #dashboard > .row {
    flex-direction: column;
  }

  .col-main,
  .col-side {
    width: 100%;
  }

  .block-welcome .welcome-content {
    flex-direction: column;
  }

  .block-welcome .user-section,
  .block-welcome .review-stats {
    flex-basis: auto;
    width: 100%;
  }

  .block-welcome .divider {
    width: 100%;
    height: 1px;
  }
}
</style>
