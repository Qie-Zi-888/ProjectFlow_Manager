package com.ruoyi.execute.mapper;

import java.util.List;
import com.ruoyi.execute.domain.WorkLog;

/**
 * 工时记录Mapper接口
 * 
 * @author Qie_Zi
 * @date 2026-03-19
 */
public interface WorkLogMapper 
{
    /**
     * 查询工时记录
     * 
     * @param logId 工时记录主键
     * @return 工时记录
     */
    public WorkLog selectWorkLogByLogId(Long logId);

    /**
     * 查询工时记录列表
     * 
     * @param workLog 工时记录
     * @return 工时记录集合
     */
    public List<WorkLog> selectWorkLogList(WorkLog workLog);

    /**
     * 新增工时记录
     * 
     * @param workLog 工时记录
     * @return 结果
     */
    public int insertWorkLog(WorkLog workLog);

    /**
     * 修改工时记录
     * 
     * @param workLog 工时记录
     * @return 结果
     */
    public int updateWorkLog(WorkLog workLog);

    /**
     * 删除工时记录
     * 
     * @param logId 工时记录主键
     * @return 结果
     */
    public int deleteWorkLogByLogId(Long logId);

    /**
     * 批量删除工时记录
     * 
     * @param logIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteWorkLogByLogIds(Long[] logIds);
}
