package com.ruoyi.project.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.project.mapper.ProjectMemberMapper;
import com.ruoyi.project.domain.ProjectMember;
import com.ruoyi.project.service.IProjectMemberService;

/**
 * 项目成员Service业务层处理
 * 
 * @author Qie_Zi
 * @date 2026-03-14
 */
@Service
public class ProjectMemberServiceImpl implements IProjectMemberService 
{
    @Autowired
    private ProjectMemberMapper projectMemberMapper;

    /**
     * 查询项目成员
     * 
     * @param id 项目成员主键
     * @return 项目成员
     */
    @Override
    public ProjectMember selectProjectMemberById(Long id)
    {
        return projectMemberMapper.selectProjectMemberById(id);
    }

    /**
     * 查询项目成员列表
     * 
     * @param projectMember 项目成员
     * @return 项目成员
     */
    @Override
    public List<ProjectMember> selectProjectMemberList(ProjectMember projectMember)
    {
        return projectMemberMapper.selectProjectMemberList(projectMember);
    }

    /**
     * 新增项目成员
     * 
     * @param projectMember 项目成员
     * @return 结果
     */
    @Override
    public int insertProjectMember(ProjectMember projectMember)
    {
        projectMember.setCreateTime(DateUtils.getNowDate());
        projectMember.setCreateBy(SecurityUtils.getUsername());
        return projectMemberMapper.insertProjectMember(projectMember);
    }

    /**
     * 修改项目成员
     * 
     * @param projectMember 项目成员
     * @return 结果
     */
    @Override
    public int updateProjectMember(ProjectMember projectMember)
    {
        projectMember.setUpdateTime(DateUtils.getNowDate());
        projectMember.setUpdateBy(SecurityUtils.getUsername());
        return projectMemberMapper.updateProjectMember(projectMember);
    }

    /**
     * 批量删除项目成员
     * 
     * @param ids 需要删除的项目成员主键
     * @return 结果
     */
    @Override
    public int deleteProjectMemberByIds(Long[] ids)
    {
        return projectMemberMapper.deleteProjectMemberByIds(ids);
    }

    /**
     * 删除项目成员信息
     * 
     * @param id 项目成员主键
     * @return 结果
     */
    @Override
    public int deleteProjectMemberById(Long id)
    {
        return projectMemberMapper.deleteProjectMemberById(id);
    }
}
