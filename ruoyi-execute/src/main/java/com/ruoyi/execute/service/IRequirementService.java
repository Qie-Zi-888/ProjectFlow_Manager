package com.ruoyi.execute.service;

import java.util.List;
import com.ruoyi.execute.domain.Requirement;

/**
 * 需求Service接口
 * 
 * @author Qie_Zi
 * @date 2026-03-18
 */
public interface IRequirementService 
{
    /**
     * 查询需求
     * 
     * @param reqId 需求主键
     * @return 需求
     */
    public Requirement selectRequirementByReqId(Long reqId);

    /**
     * 查询需求列表
     * 
     * @param requirement 需求
     * @return 需求集合
     */
    public List<Requirement> selectRequirementList(Requirement requirement);

    /**
     * 新增需求
     * 
     * @param requirement 需求
     * @return 结果
     */
    public int insertRequirement(Requirement requirement);

    /**
     * 修改需求
     * 
     * @param requirement 需求
     * @return 结果
     */
    public int updateRequirement(Requirement requirement);

    /**
     * 批量删除需求
     * 
     * @param reqIds 需要删除的需求主键集合
     * @return 结果
     */
    public int deleteRequirementByReqIds(Long[] reqIds);

    /**
     * 删除需求信息
     * 
     * @param reqId 需求主键
     * @return 结果
     */
    public int deleteRequirementByReqId(Long reqId);
}
