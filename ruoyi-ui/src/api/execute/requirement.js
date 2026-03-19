import request from '@/utils/request'

// 查询需求列表
export function listRequirement(query) {
  return request({
    url: '/execute/requirement/list',
    method: 'get',
    params: query
  })
}

// 查询需求详细
export function getRequirement(reqId) {
  return request({
    url: '/execute/requirement/' + reqId,
    method: 'get'
  })
}

// 新增需求
export function addRequirement(data) {
  return request({
    url: '/execute/requirement',
    method: 'post',
    data: data
  })
}

// 修改需求
export function updateRequirement(data) {
  return request({
    url: '/execute/requirement',
    method: 'put',
    data: data
  })
}

// 删除需求
export function delRequirement(reqId) {
  return request({
    url: '/execute/requirement/' + reqId,
    method: 'delete'
  })
}
