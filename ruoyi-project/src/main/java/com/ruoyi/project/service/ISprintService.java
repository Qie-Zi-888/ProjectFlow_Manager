package com.ruoyi.project.service;

import java.util.List;
import com.ruoyi.project.domain.Sprint;

/**
 * 迭代Service接口
 * 
 * @author Qie_Zi
 * @date 2026-03-17
 */
public interface ISprintService 
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
     * 批量删除迭代
     * 
     * @param sprintIds 需要删除的迭代主键集合
     * @return 结果
     */
    public int deleteSprintBySprintIds(Long[] sprintIds);

    /**
     * 删除迭代信息
     * 
     * @param sprintId 迭代主键
     * @return 结果
     */
    public int deleteSprintBySprintId(Long sprintId);
}
