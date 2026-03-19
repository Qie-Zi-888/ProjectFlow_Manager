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
import com.ruoyi.project.domain.ProjectModule;
import com.ruoyi.project.service.IProjectModuleService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 项目模块Controller
 * 
 * @author Qie_Zi
 * @date 2026-03-19
 */
@RestController
@RequestMapping("/project/module")
public class ProjectModuleController extends BaseController
{
    @Autowired
    private IProjectModuleService projectModuleService;

    /**
     * 查询项目模块列表
     */
    @PreAuthorize("@ss.hasPermi('project:module:list')")
    @GetMapping("/list")
    public TableDataInfo list(ProjectModule projectModule)
    {
        startPage();
        List<ProjectModule> list = projectModuleService.selectProjectModuleList(projectModule);
        return getDataTable(list);
    }

    /**
     * 导出项目模块列表
     */
    @PreAuthorize("@ss.hasPermi('project:module:export')")
    @Log(title = "项目模块", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ProjectModule projectModule)
    {
        List<ProjectModule> list = projectModuleService.selectProjectModuleList(projectModule);
        ExcelUtil<ProjectModule> util = new ExcelUtil<ProjectModule>(ProjectModule.class);
        util.exportExcel(response, list, "项目模块数据");
    }

    /**
     * 获取项目模块详细信息
     */
    @PreAuthorize("@ss.hasPermi('project:module:query')")
    @GetMapping(value = "/{moduleId}")
    public AjaxResult getInfo(@PathVariable("moduleId") Long moduleId)
    {
        return success(projectModuleService.selectProjectModuleByModuleId(moduleId));
    }

    /**
     * 新增项目模块
     */
    @PreAuthorize("@ss.hasPermi('project:module:add')")
    @Log(title = "项目模块", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ProjectModule projectModule)
    {
        return toAjax(projectModuleService.insertProjectModule(projectModule));
    }

    /**
     * 修改项目模块
     */
    @PreAuthorize("@ss.hasPermi('project:module:edit')")
    @Log(title = "项目模块", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ProjectModule projectModule)
    {
        return toAjax(projectModuleService.updateProjectModule(projectModule));
    }

    /**
     * 删除项目模块
     */
    @PreAuthorize("@ss.hasPermi('project:module:remove')")
    @Log(title = "项目模块", businessType = BusinessType.DELETE)
	@DeleteMapping("/{moduleIds}")
    public AjaxResult remove(@PathVariable Long[] moduleIds)
    {
        return toAjax(projectModuleService.deleteProjectModuleByModuleIds(moduleIds));
    }
}
