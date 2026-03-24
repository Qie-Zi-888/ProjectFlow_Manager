package com.ruoyi.execute.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import com.ruoyi.common.utils.StringUtils;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.execute.domain.WorkLog;
import com.ruoyi.execute.mapper.TaskMapper;
import com.ruoyi.execute.domain.Task;
import com.ruoyi.execute.service.ITaskService;

/**
 * 任务Service业务层处理
 * 
 * @author Qie_Zi
 * @date 2026-03-19
 */
@Service
public class TaskServiceImpl implements ITaskService 
{
    @Autowired
    private TaskMapper taskMapper;

    /**
     * 查询任务
     * 
     * @param taskId 任务主键
     * @return 任务
     */
    @Override
    public Task selectTaskByTaskId(Long taskId)
    {
        return taskMapper.selectTaskByTaskId(taskId);
    }

    /**
     * 查询任务列表
     * 
     * @param task 任务
     * @return 任务
     */
    @Override
    public List<Task> selectTaskList(Task task)
    {
        return taskMapper.selectTaskList(task);
    }

    /**
     * 新增任务
     * 
     * @param task 任务
     * @return 结果
     */
    @Transactional
    @Override
    public int insertTask(Task task)
    {
        task.setCreateTime(DateUtils.getNowDate());
        int rows = taskMapper.insertTask(task);
        insertWorkLog(task);
        return rows;
    }

    /**
     * 修改任务
     * 
     * @param task 任务
     * @return 结果
     */
    @Transactional
    @Override
    public int updateTask(Task task)
    {
        task.setUpdateTime(DateUtils.getNowDate());
        taskMapper.deleteWorkLogByTaskId(task.getTaskId());
        insertWorkLog(task);
        return taskMapper.updateTask(task);
    }

    /**
     * 批量删除任务
     * 
     * @param taskIds 需要删除的任务主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteTaskByTaskIds(Long[] taskIds)
    {
        taskMapper.deleteWorkLogByTaskIds(taskIds);
        return taskMapper.deleteTaskByTaskIds(taskIds);
    }

    /**
     * 删除任务信息
     * 
     * @param taskId 任务主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteTaskByTaskId(Long taskId)
    {
        taskMapper.deleteWorkLogByTaskId(taskId);
        return taskMapper.deleteTaskByTaskId(taskId);
    }

    /**
     * 新增工时记录信息
     * 
     * @param task 任务对象
     */
    public void insertWorkLog(Task task)
    {
        List<WorkLog> workLogList = task.getWorkLogList();
        Long taskId = task.getTaskId();
        if (StringUtils.isNotNull(workLogList))
        {
            List<WorkLog> list = new ArrayList<WorkLog>();
            for (WorkLog workLog : workLogList)
            {
                workLog.setTaskId(taskId);
                list.add(workLog);
            }
            if (list.size() > 0)
            {
                taskMapper.batchWorkLog(list);
            }
        }
    }
}
