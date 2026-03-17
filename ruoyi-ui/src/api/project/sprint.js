import request from '@/utils/request'

// 查询迭代列表
export function listSprint(query) {
  return request({
    url: '/project/sprint/list',
    method: 'get',
    params: query
  })
}

// 查询迭代详细
export function getSprint(sprintId) {
  return request({
    url: '/project/sprint/' + sprintId,
    method: 'get'
  })
}

// 新增迭代
export function addSprint(data) {
  return request({
    url: '/project/sprint',
    method: 'post',
    data: data
  })
}

// 修改迭代
export function updateSprint(data) {
  return request({
    url: '/project/sprint',
    method: 'put',
    data: data
  })
}

// 删除迭代
export function delSprint(sprintId) {
  return request({
    url: '/project/sprint/' + sprintId,
    method: 'delete'
  })
}
