package com.ruoyi.project.mapper;

import java.util.List;
import com.ruoyi.project.domain.Project;
import com.ruoyi.project.domain.ProjectModule;

/**
 * 项目Mapper接口
 * 
 * @author Qie_Zi
 * @date 2026-03-14
 */
public interface ProjectMapper 
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
     * 删除项目
     * 
     * @param projectId 项目主键
     * @return 结果
     */
    public int deleteProjectByProjectId(Long projectId);

    /**
     * 批量删除项目
     * 
     * @param projectIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteProjectByProjectIds(Long[] projectIds);

    /**
     * 批量删除项目模块
     * 
     * @param projectIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteProjectModuleByProjectIds(Long[] projectIds);
    
    /**
     * 批量新增项目模块
     * 
     * @param projectModuleList 项目模块列表
     * @return 结果
     */
    public int batchProjectModule(List<ProjectModule> projectModuleList);
    

    /**
     * 通过项目主键删除项目模块信息
     * 
     * @param projectId 项目ID
     * @return 结果
     */
    public int deleteProjectModuleByProjectId(Long projectId);
}
