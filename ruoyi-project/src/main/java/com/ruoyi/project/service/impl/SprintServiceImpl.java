package com.ruoyi.project.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import com.ruoyi.common.utils.StringUtils;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.project.domain.SprintBurndown;
import com.ruoyi.project.mapper.SprintMapper;
import com.ruoyi.project.domain.Sprint;
import com.ruoyi.project.service.ISprintService;

/**
 * 迭代Service业务层处理
 * 
 * @author Qie_Zi
 * @date 2026-03-17
 */
@Service
public class SprintServiceImpl implements ISprintService 
{
    @Autowired
    private SprintMapper sprintMapper;

    /**
     * 查询迭代
     * 
     * @param sprintId 迭代主键
     * @return 迭代
     */
    @Override
    public Sprint selectSprintBySprintId(Long sprintId)
    {
        return sprintMapper.selectSprintBySprintId(sprintId);
    }

    /**
     * 查询迭代列表
     * 
     * @param sprint 迭代
     * @return 迭代
     */
    @Override
    public List<Sprint> selectSprintList(Sprint sprint)
    {
        return sprintMapper.selectSprintList(sprint);
    }

    /**
     * 新增迭代
     * 
     * @param sprint 迭代
     * @return 结果
     */
    @Transactional
    @Override
    public int insertSprint(Sprint sprint)
    {
        sprint.setCreateTime(DateUtils.getNowDate());
        int rows = sprintMapper.insertSprint(sprint);
        insertSprintBurndown(sprint);
        return rows;
    }

    /**
     * 修改迭代
     * 
     * @param sprint 迭代
     * @return 结果
     */
    @Transactional
    @Override
    public int updateSprint(Sprint sprint)
    {
        sprint.setUpdateTime(DateUtils.getNowDate());
        sprintMapper.deleteSprintBurndownBySprintId(sprint.getSprintId());
        insertSprintBurndown(sprint);
        return sprintMapper.updateSprint(sprint);
    }

    /**
     * 批量删除迭代
     * 
     * @param sprintIds 需要删除的迭代主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteSprintBySprintIds(Long[] sprintIds)
    {
        sprintMapper.deleteSprintBurndownBySprintIds(sprintIds);
        return sprintMapper.deleteSprintBySprintIds(sprintIds);
    }

    /**
     * 删除迭代信息
     * 
     * @param sprintId 迭代主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteSprintBySprintId(Long sprintId)
    {
        sprintMapper.deleteSprintBurndownBySprintId(sprintId);
        return sprintMapper.deleteSprintBySprintId(sprintId);
    }

    /**
     * 新增燃尽图统计信息
     * 
     * @param sprint 迭代对象
     */
    public void insertSprintBurndown(Sprint sprint)
    {
        List<SprintBurndown> sprintBurndownList = sprint.getSprintBurndownList();
        Long sprintId = sprint.getSprintId();
        if (StringUtils.isNotNull(sprintBurndownList))
        {
            List<SprintBurndown> list = new ArrayList<SprintBurndown>();
            for (SprintBurndown sprintBurndown : sprintBurndownList)
            {
                sprintBurndown.setSprintId(sprintId);
                sprintBurndown.setCreateTime(DateUtils.getNowDate());
                list.add(sprintBurndown);
            }
            if (list.size() > 0)
            {
                sprintMapper.batchSprintBurndown(list);
            }
        }
    }
}
