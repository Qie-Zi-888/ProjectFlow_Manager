package com.ruoyi.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.project.service.IProjectService;
import com.ruoyi.defects.service.IBugService;

/**
 * 项目仪表盘Controller
 * @author ruoyi
 * @date 2026-04-17
 */
@RestController
@RequestMapping("/project/dashboard")
public class ProjectDashboardController extends BaseController
{
    @Autowired
    private IProjectService projectService;

    @Autowired
    private IBugService bugService;

    /**
     * 获取项目统计概览
     */
    @GetMapping("/statistics")
    public AjaxResult getStatistics()
    {
        Map<String, Object> statistics = new HashMap<>();
        
        // 获取所有项目列表
        List<Map<String, Object>> projectList = projectService.selectProjectStatistics();
        
        int totalProjects = 0;
        int completedProjects = 0;
        int inProgressProjects = 0;
        int delayedProjects = 0;
        
        for (Map<String, Object> project : projectList)
        {
            totalProjects++;
            Object statusObj = project.get("status");
            int status = statusObj != null ? ((Number) statusObj).intValue() : 0;
            
            if (status == 1)
            {
                completedProjects++;
            }
            else if (status == 0)
            {
                inProgressProjects++;
                
                // 判断是否延期
                Object endDateObj = project.get("endDate");
                if (endDateObj instanceof java.sql.Date)
                {
                    java.sql.Date endDate = (java.sql.Date) endDateObj;
                    if (endDate.before(new java.sql.Date(System.currentTimeMillis())))
                    {
                        delayedProjects++;
                    }
                }
            }
        }
        
        statistics.put("totalProjects", totalProjects);
        statistics.put("completedProjects", completedProjects);
        statistics.put("inProgressProjects", inProgressProjects);
        statistics.put("delayedProjects", delayedProjects);
        
        return AjaxResult.success(statistics);
    }

    /**
     * 获取项目状态分布
     */
    @GetMapping("/statusDistribution")
    public AjaxResult getStatusDistribution()
    {
        List<Map<String, Object>> distribution = projectService.selectProjectStatusDistribution();
        return AjaxResult.success(distribution);
    }

    /**
     * 获取最近项目列表
     */
    @GetMapping("/recent")
    public AjaxResult getRecentProjects()
    {
        List<Map<String, Object>> recentProjects = projectService.selectRecentProjects(10);
        return AjaxResult.success(recentProjects);
    }

    /**
     * 获取未关闭的项目列表（用于仪表盘）
     */
    @GetMapping("/unclosed")
    public AjaxResult getUnclosedProjects()
    {
        List<Map<String, Object>> unclosedProjects = projectService.selectUnclosedProjects();
        return AjaxResult.success(unclosedProjects);
    }

    /**
     * 获取年度发布榜（按项目完成需求数排名）
     */
    @GetMapping("/annualRanking")
    public AjaxResult getAnnualRanking()
    {
        List<Map<String, Object>> ranking = projectService.selectAnnualProjectRanking();
        return AjaxResult.success(ranking);
    }

    /**
     * 获取指定项目的需求统计数据
     */
    @GetMapping("/projectRequirementStats")
    public AjaxResult getProjectRequirementStats(Long projectId)
    {
        if (projectId == null)
        {
            return AjaxResult.error("项目ID不能为空");
        }
        Map<String, Object> stats = projectService.selectProjectRequirementStats(projectId);
        return AjaxResult.success(stats);
    }

    /**
     * 获取指定项目的月度需求趋势
     */
    @GetMapping("/projectMonthTrend")
    public AjaxResult getProjectMonthTrend(Long projectId)
    {
        if (projectId == null)
        {
            return AjaxResult.error("项目ID不能为空");
        }
        List<Map<String, Object>> trend = projectService.selectProjectMonthTrend(projectId);
        return AjaxResult.success(trend);
    }

    /**
     * 获取指定项目的Bug统计数据
     */
    @GetMapping("/projectBugStats")
    public AjaxResult getProjectBugStats(Long projectId)
    {
        if (projectId == null)
        {
            return AjaxResult.error("项目ID不能为空");
        }
        Map<String, Object> stats = bugService.selectProjectBugStats(projectId);
        return AjaxResult.success(stats);
    }

    /**
     * 获取指定项目的Bug月度趋势
     */
    @GetMapping("/projectBugMonthTrend")
    public AjaxResult getProjectBugMonthTrend(Long projectId)
    {
        if (projectId == null)
        {
            return AjaxResult.error("项目ID不能为空");
        }
        List<Map<String, Object>> trend = bugService.selectProjectBugMonthTrend(projectId);
        return AjaxResult.success(trend);
    }
}
