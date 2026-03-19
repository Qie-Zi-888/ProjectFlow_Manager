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
import org.springframework.web.bind.annotation.RequestParam;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.execute.domain.Requirement;
import com.ruoyi.execute.service.IRequirementService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 需求Controller
 * 
 * @author Qie_Zi
 * @date 2026-03-18
 */
@RestController
@RequestMapping("/execute/requirement")
public class RequirementController extends BaseController
{
    @Autowired
    private IRequirementService requirementService;

    /**
     * 查询需求列表
     */
    @PreAuthorize("@ss.hasPermi('execute:requirement:list')")
    @GetMapping("/list")
    public TableDataInfo list(Requirement requirement, 
                              @RequestParam(required = false) String assignToUserName)
    {
        // 将前端传来的用户名搜索条件赋值给临时字段
        if (assignToUserName != null && !assignToUserName.isEmpty()) {
            requirement.setAssignToNameSearch(assignToUserName);
        }
        startPage();
        List<Requirement> list = requirementService.selectRequirementList(requirement);
        return getDataTable(list);
    }

    /**
     * 导出需求列表
     */
    @PreAuthorize("@ss.hasPermi('execute:requirement:export')")
    @Log(title = "需求", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Requirement requirement)
    {
        List<Requirement> list = requirementService.selectRequirementList(requirement);
        ExcelUtil<Requirement> util = new ExcelUtil<Requirement>(Requirement.class);
        util.exportExcel(response, list, "需求数据");
    }

    /**
     * 获取需求详细信息
     */
    @PreAuthorize("@ss.hasPermi('execute:requirement:query')")
    @GetMapping(value = "/{reqId}")
    public AjaxResult getInfo(@PathVariable("reqId") Long reqId)
    {
        return success(requirementService.selectRequirementByReqId(reqId));
    }

    /**
     * 新增需求
     */
    @PreAuthorize("@ss.hasPermi('execute:requirement:add')")
    @Log(title = "需求", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Requirement requirement)
    {
        return toAjax(requirementService.insertRequirement(requirement));
    }

    /**
     * 修改需求
     */
    @PreAuthorize("@ss.hasPermi('execute:requirement:edit')")
    @Log(title = "需求", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Requirement requirement)
    {
        return toAjax(requirementService.updateRequirement(requirement));
    }

    /**
     * 删除需求
     */
    @PreAuthorize("@ss.hasPermi('execute:requirement:remove')")
    @Log(title = "需求", businessType = BusinessType.DELETE)
	@DeleteMapping("/{reqIds}")
    public AjaxResult remove(@PathVariable Long[] reqIds)
    {
        return toAjax(requirementService.deleteRequirementByReqIds(reqIds));
    }
}
