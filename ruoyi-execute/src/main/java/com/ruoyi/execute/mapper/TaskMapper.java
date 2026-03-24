package com.ruoyi.execute.mapper;

import java.util.List;
import com.ruoyi.execute.domain.Task;
import com.ruoyi.execute.domain.WorkLog;

/**
 * 任务Mapper接口
 * 
 * @author Qie_Zi
 * @date 2026-03-19
 */
public interface TaskMapper 
{
    /**
     * 查询任务
     * 
     * @param taskId 任务主键
     * @return 任务
     */
    public Task selectTaskByTaskId(Long taskId);

    /**
     * 查询任务列表
     * 
     * @param task 任务
     * @return 任务集合
     */
    public List<Task> selectTaskList(Task task);

    /**
     * 新增任务
     * 
     * @param task 任务
     * @return 结果
     */
    public int insertTask(Task task);

    /**
     * 修改任务
     * 
     * @param task 任务
     * @return 结果
     */
    public int updateTask(Task task);

    /**
     * 删除任务
     * 
     * @param taskId 任务主键
     * @return 结果
     */
    public int deleteTaskByTaskId(Long taskId);

    /**
     * 批量删除任务
     * 
     * @param taskIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteTaskByTaskIds(Long[] taskIds);

    /**
     * 批量删除工时记录
     * 
     * @param taskIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteWorkLogByTaskIds(Long[] taskIds);
    
    /**
     * 批量新增工时记录
     * 
     * @param workLogList 工时记录列表
     * @return 结果
     */
    public int batchWorkLog(List<WorkLog> workLogList);
    

    /**
     * 通过任务主键删除工时记录信息
     * 
     * @param taskId 任务ID
     * @return 结果
     */
    public int deleteWorkLogByTaskId(Long taskId);
}
