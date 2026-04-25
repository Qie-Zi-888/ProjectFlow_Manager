import request from '@/utils/request'

// 查询缺陷列表
export function listBugs(query) {
  return request({
    url: '/defects/bugs/list',
    method: 'get',
    params: query
  })
}

// 查询缺陷详细
export function getBugs(bugId) {
  return request({
    url: '/defects/bugs/' + bugId,
    method: 'get'
  })
}

// 新增缺陷
export function addBugs(data) {
  return request({
    url: '/defects/bugs',
    method: 'post',
    data: data
  })
}

// 修改缺陷
export function updateBugs(data) {
  return request({
    url: '/defects/bugs',
    method: 'put',
    data: data
  })
}

// 删除缺陷
export function delBugs(bugId) {
  return request({
    url: '/defects/bugs/' + bugId,
    method: 'delete'
  })
}
