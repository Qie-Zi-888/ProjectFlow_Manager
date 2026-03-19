package com.ruoyi.project.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.project.mapper.ProjectModuleMapper;
import com.ruoyi.project.domain.ProjectModule;
import com.ruoyi.project.service.IProjectModuleService;

/**
 * 项目模块Service业务层处理
 * 
 * @author Qie_Zi
 * @date 2026-03-19
 */
@Service
public class ProjectModuleServiceImpl implements IProjectModuleService 
{
    @Autowired
    private ProjectModuleMapper projectModuleMapper;

    /**
     * 查询项目模块
     * 
     * @param moduleId 项目模块主键
     * @return 项目模块
     */
    @Override
    public ProjectModule selectProjectModuleByModuleId(Long moduleId)
    {
        return projectModuleMapper.selectProjectModuleByModuleId(moduleId);
    }

    /**
     * 查询项目模块列表
     * 
     * @param projectModule 项目模块
     * @return 项目模块
     */
    @Override
    public List<ProjectModule> selectProjectModuleList(ProjectModule projectModule)
    {
        return projectModuleMapper.selectProjectModuleList(projectModule);
    }

    /**
     * 新增项目模块
     * 
     * @param projectModule 项目模块
     * @return 结果
     */
    @Override
    public int insertProjectModule(ProjectModule projectModule)
    {
        projectModule.setCreateTime(DateUtils.getNowDate());
        return projectModuleMapper.insertProjectModule(projectModule);
    }

    /**
     * 修改项目模块
     * 
     * @param projectModule 项目模块
     * @return 结果
     */
    @Override
    public int updateProjectModule(ProjectModule projectModule)
    {
        projectModule.setUpdateTime(DateUtils.getNowDate());
        return projectModuleMapper.updateProjectModule(projectModule);
    }

    /**
     * 批量删除项目模块
     * 
     * @param moduleIds 需要删除的项目模块主键
     * @return 结果
     */
    @Override
    public int deleteProjectModuleByModuleIds(Long[] moduleIds)
    {
        return projectModuleMapper.deleteProjectModuleByModuleIds(moduleIds);
    }

    /**
     * 删除项目模块信息
     * 
     * @param moduleId 项目模块主键
     * @return 结果
     */
    @Override
    public int deleteProjectModuleByModuleId(Long moduleId)
    {
        return projectModuleMapper.deleteProjectModuleByModuleId(moduleId);
    }
}
