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
}
