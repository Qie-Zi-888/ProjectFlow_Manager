package com.ruoyi.execute.mapper;

import java.util.List;
import com.ruoyi.execute.domain.Requirement;
import com.ruoyi.execute.domain.Task;

/**
 * 需求Mapper接口
 * 
 * @author Qie_Zi
 * @date 2026-03-18
 */
public interface RequirementMapper 
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
     * 删除需求
     * 
     * @param reqId 需求主键
     * @return 结果
     */
    public int deleteRequirementByReqId(Long reqId);

    /**
     * 批量删除需求
     * 
     * @param reqIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteRequirementByReqIds(Long[] reqIds);

    /**
     * 批量删除任务
     * 
     * @param reqIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteTaskByReqIds(Long[] reqIds);
    
    /**
     * 批量新增任务
     * 
     * @param taskList 任务列表
     * @return 结果
     */
    public int batchTask(List<Task> taskList);
    

    /**
     * 通过需求主键删除任务信息
     * 
     * @param reqId 需求ID
     * @return 结果
     */
    public int deleteTaskByReqId(Long reqId);
}
