package com.ruoyi.project.mapper;

import java.util.List;
import com.ruoyi.project.domain.ProjectModule;

/**
 * 项目模块Mapper接口
 * 
 * @author Qie_Zi
 * @date 2026-03-19
 */
public interface ProjectModuleMapper 
{
    /**
     * 查询项目模块
     * 
     * @param moduleId 项目模块主键
     * @return 项目模块
     */
    public ProjectModule selectProjectModuleByModuleId(Long moduleId);

    /**
     * 查询项目模块列表
     * 
     * @param projectModule 项目模块
     * @return 项目模块集合
     */
    public List<ProjectModule> selectProjectModuleList(ProjectModule projectModule);

    /**
     * 新增项目模块
     * 
     * @param projectModule 项目模块
     * @return 结果
     */
    public int insertProjectModule(ProjectModule projectModule);

    /**
     * 修改项目模块
     * 
     * @param projectModule 项目模块
     * @return 结果
     */
    public int updateProjectModule(ProjectModule projectModule);

    /**
     * 删除项目模块
     * 
     * @param moduleId 项目模块主键
     * @return 结果
     */
    public int deleteProjectModuleByModuleId(Long moduleId);

    /**
     * 批量删除项目模块
     * 
     * @param moduleIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteProjectModuleByModuleIds(Long[] moduleIds);
}
