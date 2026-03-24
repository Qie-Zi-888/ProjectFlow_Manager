package com.ruoyi.execute.controller;

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
import com.ruoyi.execute.domain.WorkLog;
import com.ruoyi.execute.service.IWorkLogService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 工时记录Controller
 * 
 * @author Qie_Zi
 * @date 2026-03-19
 */
@RestController
@RequestMapping("/execute/log")
public class WorkLogController extends BaseController
{
    @Autowired
    private IWorkLogService workLogService;

    /**
     * 查询工时记录列表
     */
    @PreAuthorize("@ss.hasPermi('execute:log:list')")
    @GetMapping("/list")
    public TableDataInfo list(WorkLog workLog)
    {
        startPage();
        List<WorkLog> list = workLogService.selectWorkLogList(workLog);
        return getDataTable(list);
    }

    /**
     * 导出工时记录列表
     */
    @PreAuthorize("@ss.hasPermi('execute:log:export')")
    @Log(title = "工时记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, WorkLog workLog)
    {
        List<WorkLog> list = workLogService.selectWorkLogList(workLog);
        ExcelUtil<WorkLog> util = new ExcelUtil<WorkLog>(WorkLog.class);
        util.exportExcel(response, list, "工时记录数据");
    }

    /**
     * 获取工时记录详细信息
     */
    @PreAuthorize("@ss.hasPermi('execute:log:query')")
    @GetMapping(value = "/{logId}")
    public AjaxResult getInfo(@PathVariable("logId") Long logId)
    {
        return success(workLogService.selectWorkLogByLogId(logId));
    }

    /**
     * 新增工时记录
     */
    @PreAuthorize("@ss.hasPermi('execute:log:add')")
    @Log(title = "工时记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody WorkLog workLog)
    {
        return toAjax(workLogService.insertWorkLog(workLog));
    }

    /**
     * 修改工时记录
     */
    @PreAuthorize("@ss.hasPermi('execute:log:edit')")
    @Log(title = "工时记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody WorkLog workLog)
    {
        return toAjax(workLogService.updateWorkLog(workLog));
    }

    /**
     * 删除工时记录
     */
    @PreAuthorize("@ss.hasPermi('execute:log:remove')")
    @Log(title = "工时记录", businessType = BusinessType.DELETE)
	@DeleteMapping("/{logIds}")
    public AjaxResult remove(@PathVariable Long[] logIds)
    {
        return toAjax(workLogService.deleteWorkLogByLogIds(logIds));
    }
}
