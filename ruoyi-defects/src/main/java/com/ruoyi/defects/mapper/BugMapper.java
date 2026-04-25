package com.ruoyi.defects.mapper;

import java.util.List;
import com.ruoyi.defects.domain.Bug;

/**
 * 缺陷Mapper接口
 * 
 * @author Qie_Zi
 * @date 2026-04-23
 */
public interface BugMapper 
{
    /**
     * 查询缺陷
     * 
     * @param bugId 缺陷主键
     * @return 缺陷
     */
    public Bug selectBugByBugId(Long bugId);

    /**
     * 查询缺陷列表
     * 
     * @param bug 缺陷
     * @return 缺陷集合
     */
    public List<Bug> selectBugList(Bug bug);

    /**
     * 新增缺陷
     * 
     * @param bug 缺陷
     * @return 结果
     */
    public int insertBug(Bug bug);

    /**
     * 修改缺陷
     * 
     * @param bug 缺陷
     * @return 结果
     */
    public int updateBug(Bug bug);

    /**
     * 删除缺陷
     * 
     * @param bugId 缺陷主键
     * @return 结果
     */
    public int deleteBugByBugId(Long bugId);

    /**
     * 批量删除缺陷
     * 
     * @param bugIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteBugByBugIds(Long[] bugIds);

    /**
     * 查询指定项目的Bug统计数据
     * 
     * @param projectId 项目ID
     * @return Bug统计数据（有效bug数、已解决数、未关闭数等）
     */
    public java.util.Map<String, Object> selectProjectBugStats(Long projectId);

    /**
     * 查询指定项目的Bug月度趋势
     * 
     * @param projectId 项目ID
     * @return Bug月度趋势列表
     */
    public List<java.util.Map<String, Object>> selectProjectBugMonthTrend(Long projectId);
}
