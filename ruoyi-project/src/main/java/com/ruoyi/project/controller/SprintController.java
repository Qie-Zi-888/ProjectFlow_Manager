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
import com.ruoyi.project.domain.Sprint;
import com.ruoyi.project.service.ISprintService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 迭代Controller
 * 
 * @author Qie_Zi
 * @date 2026-03-17
 */
@RestController
@RequestMapping("/project/sprint")
public class SprintController extends BaseController
{
    @Autowired
    private ISprintService sprintService;

    /**
     * 查询迭代列表
     */
    @PreAuthorize("@ss.hasPermi('project:sprint:list')")
    @GetMapping("/list")
    public TableDataInfo list(Sprint sprint)
    {
        startPage();
        List<Sprint> list = sprintService.selectSprintList(sprint);
        return getDataTable(list);
    }

    /**
     * 导出迭代列表
     */
    @PreAuthorize("@ss.hasPermi('project:sprint:export')")
    @Log(title = "迭代", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Sprint sprint)
    {
        List<Sprint> list = sprintService.selectSprintList(sprint);
        ExcelUtil<Sprint> util = new ExcelUtil<Sprint>(Sprint.class);
        util.exportExcel(response, list, "迭代数据");
    }

    /**
     * 获取迭代详细信息
     */
    @PreAuthorize("@ss.hasPermi('project:sprint:query')")
    @GetMapping(value = "/{sprintId}")
    public AjaxResult getInfo(@PathVariable("sprintId") Long sprintId)
    {
        return success(sprintService.selectSprintBySprintId(sprintId));
    }

    /**
     * 新增迭代
     */
    @PreAuthorize("@ss.hasPermi('project:sprint:add')")
    @Log(title = "迭代", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Sprint sprint)
    {
        return toAjax(sprintService.insertSprint(sprint));
    }

    /**
     * 修改迭代
     */
    @PreAuthorize("@ss.hasPermi('project:sprint:edit')")
    @Log(title = "迭代", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Sprint sprint)
    {
        return toAjax(sprintService.updateSprint(sprint));
    }

    /**
     * 删除迭代
     */
    @PreAuthorize("@ss.hasPermi('project:sprint:remove')")
    @Log(title = "迭代", businessType = BusinessType.DELETE)
	@DeleteMapping("/{sprintIds}")
    public AjaxResult remove(@PathVariable Long[] sprintIds)
    {
        return toAjax(sprintService.deleteSprintBySprintIds(sprintIds));
    }
}
