package com.ruoyi.defects.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.defects.mapper.BugMapper;
import com.ruoyi.defects.domain.Bug;
import com.ruoyi.defects.service.IBugService;

/**
 * 缺陷Service业务层处理
 * 
 * @author Qie_Zi
 * @date 2026-04-23
 */
@Service
public class BugServiceImpl implements IBugService 
{
    @Autowired
    private BugMapper bugMapper;

    /**
     * 查询缺陷
     * 
     * @param bugId 缺陷主键
     * @return 缺陷
     */
    @Override
    public Bug selectBugByBugId(Long bugId)
    {
        return bugMapper.selectBugByBugId(bugId);
    }

    /**
     * 查询缺陷列表
     * 
     * @param bug 缺陷
     * @return 缺陷
     */
    @Override
    public List<Bug> selectBugList(Bug bug)
    {
        return bugMapper.selectBugList(bug);
    }

    /**
     * 新增缺陷
     * 
     * @param bug 缺陷
     * @return 结果
     */
    @Override
    public int insertBug(Bug bug)
    {
        bug.setCreateTime(DateUtils.getNowDate());
        return bugMapper.insertBug(bug);
    }

    /**
     * 修改缺陷
     * 
     * @param bug 缺陷
     * @return 结果
     */
    @Override
    public int updateBug(Bug bug)
    {
        bug.setUpdateTime(DateUtils.getNowDate());
        return bugMapper.updateBug(bug);
    }

    /**
     * 批量删除缺陷
     * 
     * @param bugIds 需要删除的缺陷主键
     * @return 结果
     */
    @Override
    public int deleteBugByBugIds(Long[] bugIds)
    {
        return bugMapper.deleteBugByBugIds(bugIds);
    }

    /**
     * 删除缺陷信息
     * 
     * @param bugId 缺陷主键
     * @return 结果
     */
    @Override
    public int deleteBugByBugId(Long bugId)
    {
        return bugMapper.deleteBugByBugId(bugId);
    }

    /**
     * 查询指定项目的Bug统计数据
     * 
     * @param projectId 项目ID
     * @return Bug统计数据
     */
    @Override
    public java.util.Map<String, Object> selectProjectBugStats(Long projectId)
    {
        return bugMapper.selectProjectBugStats(projectId);
    }

    /**
     * 查询指定项目的Bug月度趋势
     * 
     * @param projectId 项目ID
     * @return Bug月度趋势列表
     */
    @Override
    public List<java.util.Map<String, Object>> selectProjectBugMonthTrend(Long projectId)
    {
        return bugMapper.selectProjectBugMonthTrend(projectId);
    }
}
