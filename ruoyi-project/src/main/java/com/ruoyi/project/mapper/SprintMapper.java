package com.ruoyi.project.mapper;

import java.util.List;
import com.ruoyi.project.domain.Sprint;
import com.ruoyi.project.domain.SprintBurndown;

/**
 * 迭代Mapper接口
 * 
 * @author Qie_Zi
 * @date 2026-03-17
 */
public interface SprintMapper 
{
    /**
     * 查询迭代
     * 
     * @param sprintId 迭代主键
     * @return 迭代
     */
    public Sprint selectSprintBySprintId(Long sprintId);

    /**
     * 查询迭代列表
     * 
     * @param sprint 迭代
     * @return 迭代集合
     */
    public List<Sprint> selectSprintList(Sprint sprint);

    /**
     * 新增迭代
     * 
     * @param sprint 迭代
     * @return 结果
     */
    public int insertSprint(Sprint sprint);

    /**
     * 修改迭代
     * 
     * @param sprint 迭代
     * @return 结果
     */
    public int updateSprint(Sprint sprint);

    /**
     * 删除迭代
     * 
     * @param sprintId 迭代主键
     * @return 结果
     */
    public int deleteSprintBySprintId(Long sprintId);

    /**
     * 批量删除迭代
     * 
     * @param sprintIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSprintBySprintIds(Long[] sprintIds);

    /**
     * 批量删除燃尽图统计
     * 
     * @param sprintIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSprintBurndownBySprintIds(Long[] sprintIds);
    
    /**
     * 批量新增燃尽图统计
     * 
     * @param sprintBurndownList 燃尽图统计列表
     * @return 结果
     */
    public int batchSprintBurndown(List<SprintBurndown> sprintBurndownList);
    

    /**
     * 通过迭代主键删除燃尽图统计信息
     * 
     * @param sprintId 迭代ID
     * @return 结果
     */
    public int deleteSprintBurndownBySprintId(Long sprintId);
}
