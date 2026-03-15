package com.ruoyi.project.controller;

import java.util.List;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.project.domain.ProjectMember;
import com.ruoyi.project.service.IProjectMemberService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 项目成员Controller
 * 
 * @author Qie_Zi
 * @date 2026-03-14
 */
@RestController
@RequestMapping("/project/member")
public class ProjectMemberController extends BaseController
{
    @Autowired
    private IProjectMemberService projectMemberService;

    /**
     * 查询项目成员列表
     */
//    @PreAuthorize("@ss.hasPermi('project:member:list')")//测试注销！！！！！3/14
    @GetMapping("/list")
    public TableDataInfo list(ProjectMember projectMember)
    {
        startPage();
        List<ProjectMember> list = projectMemberService.selectProjectMemberList(projectMember);
        return getDataTable(list);
    }

    /**
     * 导出项目成员列表
     */
    @PreAuthorize("@ss.hasPermi('project:member:export')")
    @Log(title = "项目成员", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ProjectMember projectMember)
    {
        List<ProjectMember> list = projectMemberService.selectProjectMemberList(projectMember);
        ExcelUtil<ProjectMember> util = new ExcelUtil<ProjectMember>(ProjectMember.class);
        util.exportExcel(response, list, "项目成员数据");
    }

    /**
     * 获取项目成员详细信息
     */
    @PreAuthorize("@ss.hasPermi('project:member:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(projectMemberService.selectProjectMemberById(id));
    }

    /**
     * 新增项目成员
     */
    @PreAuthorize("@ss.hasPermi('project:member:add')")
    @Log(title = "项目成员", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ProjectMember projectMember)
    {
        return toAjax(projectMemberService.insertProjectMember(projectMember));
    }

    /**
     * 修改项目成员
     */
    @PreAuthorize("@ss.hasPermi('project:member:edit')")
    @Log(title = "项目成员", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ProjectMember projectMember)
    {
        return toAjax(projectMemberService.updateProjectMember(projectMember));
    }

    /**
     * 删除项目成员
     */
    @PreAuthorize("@ss.hasPermi('project:member:remove')")
    @Log(title = "项目成员", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(projectMemberService.deleteProjectMemberByIds(ids));
    }
}
