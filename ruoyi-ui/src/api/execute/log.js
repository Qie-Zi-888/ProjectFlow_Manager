import request from '@/utils/request'

// 查询工时记录列表
export function listLog(query) {
  return request({
    url: '/execute/log/list',
    method: 'get',
    params: query
  })
}

// 查询工时记录详细
export function getLog(logId) {
  return request({
    url: '/execute/log/' + logId,
    method: 'get'
  })
}

// 新增工时记录
export function addLog(data) {
  return request({
    url: '/execute/log',
    method: 'post',
    data: data
  })
}

// 修改工时记录
export function updateLog(data) {
  return request({
    url: '/execute/log',
    method: 'put',
    data: data
  })
}

// 删除工时记录
export function delLog(logId) {
  return request({
    url: '/execute/log/' + logId,
    method: 'delete'
  })
}
