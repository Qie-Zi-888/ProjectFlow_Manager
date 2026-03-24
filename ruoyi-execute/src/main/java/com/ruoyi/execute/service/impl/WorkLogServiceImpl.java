package com.ruoyi.execute.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.execute.mapper.WorkLogMapper;
import com.ruoyi.execute.domain.WorkLog;
import com.ruoyi.execute.service.IWorkLogService;

/**
 * 工时记录Service业务层处理
 * 
 * @author Qie_Zi
 * @date 2026-03-19
 */
@Service
public class WorkLogServiceImpl implements IWorkLogService 
{
    @Autowired
    private WorkLogMapper workLogMapper;

    /**
     * 查询工时记录
     * 
     * @param logId 工时记录主键
     * @return 工时记录
     */
    @Override
    public WorkLog selectWorkLogByLogId(Long logId)
    {
        return workLogMapper.selectWorkLogByLogId(logId);
    }

    /**
     * 查询工时记录列表
     * 
     * @param workLog 工时记录
     * @return 工时记录
     */
    @Override
    public List<WorkLog> selectWorkLogList(WorkLog workLog)
    {
        return workLogMapper.selectWorkLogList(workLog);
    }

    /**
     * 新增工时记录
     * 
     * @param workLog 工时记录
     * @return 结果
     */
    @Override
    public int insertWorkLog(WorkLog workLog)
    {
        workLog.setCreateTime(DateUtils.getNowDate());
        return workLogMapper.insertWorkLog(workLog);
    }

    /**
     * 修改工时记录
     * 
     * @param workLog 工时记录
     * @return 结果
     */
    @Override
    public int updateWorkLog(WorkLog workLog)
    {
        workLog.setUpdateTime(DateUtils.getNowDate());
        return workLogMapper.updateWorkLog(workLog);
    }

    /**
     * 批量删除工时记录
     * 
     * @param logIds 需要删除的工时记录主键
     * @return 结果
     */
    @Override
    public int deleteWorkLogByLogIds(Long[] logIds)
    {
        return workLogMapper.deleteWorkLogByLogIds(logIds);
    }

    /**
     * 删除工时记录信息
     * 
     * @param logId 工时记录主键
     * @return 结果
     */
    @Override
    public int deleteWorkLogByLogId(Long logId)
    {
        return workLogMapper.deleteWorkLogByLogId(logId);
    }
}
