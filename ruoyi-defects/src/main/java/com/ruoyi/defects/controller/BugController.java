package com.ruoyi.defects.controller;

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
import com.ruoyi.defects.domain.Bug;
import com.ruoyi.defects.service.IBugService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 缺陷Controller
 * 
 * @author Qie_Zi
 * @date 2026-04-23
 */
@RestController
@RequestMapping("/defects/bugs")
public class BugController extends BaseController
{
    @Autowired
    private IBugService bugService;

    /**
     * 查询缺陷列表
     */
    @PreAuthorize("@ss.hasPermi('defects:bugs:list')")
    @GetMapping("/list")
    public TableDataInfo list(Bug bug)
    {
        startPage();
        List<Bug> list = bugService.selectBugList(bug);
        return getDataTable(list);
    }

    /**
     * 导出缺陷列表
     */
    @PreAuthorize("@ss.hasPermi('defects:bugs:export')")
    @Log(title = "缺陷", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Bug bug)
    {
        List<Bug> list = bugService.selectBugList(bug);
        ExcelUtil<Bug> util = new ExcelUtil<Bug>(Bug.class);
        util.exportExcel(response, list, "缺陷数据");
    }

    /**
     * 获取缺陷详细信息
     */
    @PreAuthorize("@ss.hasPermi('defects:bugs:query')")
    @GetMapping(value = "/{bugId}")
    public AjaxResult getInfo(@PathVariable("bugId") Long bugId)
    {
        return success(bugService.selectBugByBugId(bugId));
    }

    /**
     * 新增缺陷
     */
    @PreAuthorize("@ss.hasPermi('defects:bugs:add')")
    @Log(title = "缺陷", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Bug bug)
    {
        return toAjax(bugService.insertBug(bug));
    }

    /**
     * 修改缺陷
     */
    @PreAuthorize("@ss.hasPermi('defects:bugs:edit')")
    @Log(title = "缺陷", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Bug bug)
    {
        return toAjax(bugService.updateBug(bug));
    }

    /**
     * 删除缺陷
     */
    @PreAuthorize("@ss.hasPermi('defects:bugs:remove')")
    @Log(title = "缺陷", businessType = BusinessType.DELETE)
	@DeleteMapping("/{bugIds}")
    public AjaxResult remove(@PathVariable Long[] bugIds)
    {
        return toAjax(bugService.deleteBugByBugIds(bugIds));
    }
}
