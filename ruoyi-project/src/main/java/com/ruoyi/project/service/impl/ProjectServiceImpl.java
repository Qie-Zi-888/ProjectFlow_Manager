package com.ruoyi.project.service.impl;

import java.util.List;
import java.util.Map;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import com.ruoyi.common.utils.StringUtils;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.project.domain.ProjectModule;
import com.ruoyi.project.mapper.ProjectMapper;
import com.ruoyi.project.domain.Project;
import com.ruoyi.project.service.IProjectService;

/**
 * 项目Service业务层处理
 * 
 * @author Qie_Zi
 * @date 2026-03-14
 */
@Service
public class ProjectServiceImpl implements IProjectService 
{
    @Autowired
    private ProjectMapper projectMapper;

    /**
     * 查询项目
     * 
     * @param projectId 项目主键
     * @return 项目
     */
    @Override
    public Project selectProjectByProjectId(Long projectId)
    {
        return projectMapper.selectProjectByProjectId(projectId);
    }

    /**
     * 查询项目列表
     * 
     * @param project 项目
     * @return 项目
     */
    @Override
    public List<Project> selectProjectList(Project project)
    {
        return projectMapper.selectProjectList(project);
    }

    /**
     * 新增项目
     * 
     * @param project 项目
     * @return 结果
     */
    @Transactional
    @Override
    public int insertProject(Project project)
    {
        project.setCreateTime(DateUtils.getNowDate());
        int rows = projectMapper.insertProject(project);
        insertProjectModule(project);
        return rows;
    }

    /**
     * 修改项目
     * 
     * @param project 项目
     * @return 结果
     */
    @Transactional
    @Override
    public int updateProject(Project project)
    {
        project.setUpdateTime(DateUtils.getNowDate());
        projectMapper.deleteProjectModuleByProjectId(project.getProjectId());
        insertProjectModule(project);
        return projectMapper.updateProject(project);
    }

    /**
     * 批量删除项目
     * 
     * @param projectIds 需要删除的项目主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteProjectByProjectIds(Long[] projectIds)
    {
        projectMapper.deleteProjectModuleByProjectIds(projectIds);
        return projectMapper.deleteProjectByProjectIds(projectIds);
    }

    /**
     * 删除项目信息
     * 
     * @param projectId 项目主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteProjectByProjectId(Long projectId)
    {
        projectMapper.deleteProjectModuleByProjectId(projectId);
        return projectMapper.deleteProjectByProjectId(projectId);
    }

    /**
     * 新增项目模块信息
     * 
     * @param project 项目对象
     */
    public void insertProjectModule(Project project)
    {
        List<ProjectModule> projectModuleList = project.getProjectModuleList();
        Long projectId = project.getProjectId();
        if (StringUtils.isNotNull(projectModuleList))
        {
            List<ProjectModule> list = new ArrayList<ProjectModule>();
            for (ProjectModule projectModule : projectModuleList)
            {
                projectModule.setProjectId(projectId);
                list.add(projectModule);
            }
            if (list.size() > 0)
            {
                projectMapper.batchProjectModule(list);
            }
        }
    }

    /**
     * 查询项目统计信息（用于仪表盘）
     */
    @Override
    public List<Map<String, Object>> selectProjectStatistics()
    {
        return projectMapper.selectProjectStatistics();
    }

    /**
     * 查询项目状态分布（用于仪表盘）
     */
    @Override
    public List<Map<String, Object>> selectProjectStatusDistribution()
    {
        return projectMapper.selectProjectStatusDistribution();
    }

    /**
     * 查询最近项目列表（用于仪表盘）
     */
    @Override
    public List<Map<String, Object>> selectRecentProjects(Integer limit)
    {
        return projectMapper.selectRecentProjects(limit);
    }

    /**
     * 查询未关闭的项目列表（用于仪表盘）
     */
    @Override
    public List<Map<String, Object>> selectUnclosedProjects()
    {
        return projectMapper.selectUnclosedProjects();
    }

    /**
     * 查询年度项目排名（用于仪表盘发布榜）
     */
    @Override
    public List<Map<String, Object>> selectAnnualProjectRanking()
    {
        return projectMapper.selectAnnualProjectRanking();
    }

    /**
     * 查询指定项目的需求统计数据
     */
    @Override
    public Map<String, Object> selectProjectRequirementStats(Long projectId)
    {
        return projectMapper.selectProjectRequirementStats(projectId);
    }

    /**
     * 查询指定项目的月度需求趋势
     */
    @Override
    public List<Map<String, Object>> selectProjectMonthTrend(Long projectId)
    {
        return projectMapper.selectProjectMonthTrend(projectId);
    }
}
