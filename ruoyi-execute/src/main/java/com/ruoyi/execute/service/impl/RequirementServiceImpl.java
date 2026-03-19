package com.ruoyi.execute.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import com.ruoyi.common.utils.StringUtils;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.execute.domain.Task;
import com.ruoyi.execute.mapper.RequirementMapper;
import com.ruoyi.execute.domain.Requirement;
import com.ruoyi.execute.service.IRequirementService;

/**
 * 需求Service业务层处理
 * 
 * @author Qie_Zi
 * @date 2026-03-18
 */
@Service
public class RequirementServiceImpl implements IRequirementService 
{
    @Autowired
    private RequirementMapper requirementMapper;

    /**
     * 查询需求
     * 
     * @param reqId 需求主键
     * @return 需求
     */
    @Override
    public Requirement selectRequirementByReqId(Long reqId)
    {
        return requirementMapper.selectRequirementByReqId(reqId);
    }

    /**
     * 查询需求列表
     * 
     * @param requirement 需求
     * @return 需求
     */
    @Override
    public List<Requirement> selectRequirementList(Requirement requirement)
    {
        return requirementMapper.selectRequirementList(requirement);
    }

    /**
     * 新增需求
     * 
     * @param requirement 需求
     * @return 结果
     */
    @Transactional
    @Override
    public int insertRequirement(Requirement requirement)
    {
        requirement.setCreateTime(DateUtils.getNowDate());
        int rows = requirementMapper.insertRequirement(requirement);
        insertTask(requirement);
        return rows;
    }

    /**
     * 修改需求
     * 
     * @param requirement 需求
     * @return 结果
     */
    @Transactional
    @Override
    public int updateRequirement(Requirement requirement)
    {
        requirement.setUpdateTime(DateUtils.getNowDate());
        requirementMapper.deleteTaskByReqId(requirement.getReqId());
        insertTask(requirement);
        return requirementMapper.updateRequirement(requirement);
    }

    /**
     * 批量删除需求
     * 
     * @param reqIds 需要删除的需求主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteRequirementByReqIds(Long[] reqIds)
    {
        requirementMapper.deleteTaskByReqIds(reqIds);
        return requirementMapper.deleteRequirementByReqIds(reqIds);
    }

    /**
     * 删除需求信息
     * 
     * @param reqId 需求主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteRequirementByReqId(Long reqId)
    {
        requirementMapper.deleteTaskByReqId(reqId);
        return requirementMapper.deleteRequirementByReqId(reqId);
    }

    /**
     * 新增任务信息
     * 
     * @param requirement 需求对象
     */
    public void insertTask(Requirement requirement)
    {
        List<Task> taskList = requirement.getTaskList();
        Long reqId = requirement.getReqId();
        if (StringUtils.isNotNull(taskList))
        {
            List<Task> list = new ArrayList<Task>();
            for (Task task : taskList)
            {
                task.setReqId(reqId);
                list.add(task);
            }
            if (list.size() > 0)
            {
                requirementMapper.batchTask(list);
            }
        }
    }
}
