package com.ruoyi.project.service;

import java.util.List;
import com.ruoyi.project.domain.Project;

/**
 * 项目Service接口
 * 
 * @author Qie_Zi
 * @date 2026-03-14
 */
public interface IProjectService 
{
    /**
     * 查询项目
     * 
     * @param projectId 项目主键
     * @return 项目
     */
    public Project selectProjectByProjectId(Long projectId);

    /**
     * 查询项目列表
     * 
     * @param project 项目
     * @return 项目集合
     */
    public List<Project> selectProjectList(Project project);

    /**
     * 新增项目
     * 
     * @param project 项目
     * @return 结果
     */
    public int insertProject(Project project);

    /**
     * 修改项目
     * 
     * @param project 项目
     * @return 结果
     */
    public int updateProject(Project project);

    /**
     * 批量删除项目
     * 
     * @param projectIds 需要删除的项目主键集合
     * @return 结果
     */
    public int deleteProjectByProjectIds(Long[] projectIds);

    /**
     * 删除项目信息
     * 
     * @param projectId 项目主键
     * @return 结果
     */
    public int deleteProjectByProjectId(Long projectId);

    /**
     * 查询项目统计信息（用于仪表盘）
     * 
     * @return 项目统计列表
     */
    public List<java.util.Map<String, Object>> selectProjectStatistics();

    /**
     * 查询项目状态分布（用于仪表盘）
     * 
     * @return 状态分布数据
     */
    public List<java.util.Map<String, Object>> selectProjectStatusDistribution();

    /**
     * 查询最近项目列表（用于仪表盘）
     * 
     * @param limit 限制条数
     * @return 最近项目列表
     */
    public List<java.util.Map<String, Object>> selectRecentProjects(Integer limit);

    /**
     * 查询未关闭的项目列表（用于仪表盘）
     * 
     * @return 未关闭项目列表
     */
    public List<java.util.Map<String, Object>> selectUnclosedProjects();

    /**
     * 查询年度项目排名（用于仪表盘发布榜）
     * 
     * @return 年度项目排名列表
     */
    public List<java.util.Map<String, Object>> selectAnnualProjectRanking();

    /**
     * 查询指定项目的需求统计数据
     * 
     * @param projectId 项目ID
     * @return 项目需求统计数据
     */
    public java.util.Map<String, Object> selectProjectRequirementStats(Long projectId);

    /**
     * 查询指定项目的月度需求趋势
     * 
     * @param projectId 项目ID
     * @return 月度需求趋势列表
     */
    public List<java.util.Map<String, Object>> selectProjectMonthTrend(Long projectId);
}
