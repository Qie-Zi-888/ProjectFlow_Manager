import request from '@/utils/request'

// 获取项目统计概览
export function getStatistics() {
  return request({
    url: '/project/dashboard/statistics',
    method: 'get'
  })
}

// 获取项目状态分布
export function getStatusDistribution() {
  return request({
    url: '/project/dashboard/statusDistribution',
    method: 'get'
  })
}

// 获取最近项目列表
export function getRecentProjects() {
  return request({
    url: '/project/dashboard/recent',
    method: 'get'
  })
}

// 获取未关闭的项目列表
export function getUnclosedProjects() {
  return request({
    url: '/project/dashboard/unclosed',
    method: 'get'
  })
}

// 获取年度发布榜
export function getAnnualRanking() {
  return request({
    url: '/project/dashboard/annualRanking',
    method: 'get'
  })
}

// 获取指定项目的需求统计数据
export function getProjectRequirementStats(projectId) {
  return request({
    url: '/project/dashboard/projectRequirementStats',
    method: 'get',
    params: { projectId }
  })
}

// 获取指定项目的月度需求趋势
export function getProjectMonthTrend(projectId) {
  return request({
    url: '/project/dashboard/projectMonthTrend',
    method: 'get',
    params: { projectId }
  })
}
