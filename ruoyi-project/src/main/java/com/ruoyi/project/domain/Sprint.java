package com.ruoyi.project.domain;

import java.util.List;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 迭代对象 sprint
 * 
 * @author Qie_Zi
 * @date 2026-03-17
 */
public class Sprint extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 迭代ID */
    private Long sprintId;

    /** 项目ID */
    private Long projectId;

    /** 书签标识（用于查询和分类） */
    @Excel(name = "书签标识", readConverterExp = "用=于查询和分类")
    private String bookmark;

    /** 迭代数 */
    private String sprintNumber;

    /** 迭代名称 */
    @Excel(name = "迭代名称")
    private String sprintName;

    /** 状态（0规划中 1进行中 2已完成 3已取消） */
    @Excel(name = "状态", readConverterExp = "0=规划中,1=进行中,2=已完成,3=已取消")
    private Long status;

    /** 进度 */
    @Excel(name = "进度")
    private Long progress;

    /** 迭代开始日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "迭代开始日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date startDate;

    /** 迭代结束日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "迭代结束日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date endDate;

    /** 迭代目标 */
    @Excel(name = "迭代目标")
    private String goal;

    /** 项目名称（关联查询） */
    @Excel(name = "项目名称")
    private String projectName;

    /** 删除标志 */
    private Long delFlag;

    /** 燃尽图统计信息 */
    private List<SprintBurndown> sprintBurndownList;

    public void setSprintId(Long sprintId) 
    {
        this.sprintId = sprintId;
    }

    public Long getSprintId() 
    {
        return sprintId;
    }

    public void setProjectId(Long projectId) 
    {
        this.projectId = projectId;
    }

    public Long getProjectId() 
    {
        return projectId;
    }

    public void setBookmark(String bookmark) 
    {
        this.bookmark = bookmark;
    }

    public String getBookmark() 
    {
        return bookmark;
    }

    public void setSprintNumber(String sprintNumber) 
    {
        this.sprintNumber = sprintNumber;
    }

    public String getSprintNumber() 
    {
        return sprintNumber;
    }

    public void setSprintName(String sprintName) 
    {
        this.sprintName = sprintName;
    }

    public String getSprintName() 
    {
        return sprintName;
    }

    public void setStatus(Long status) 
    {
        this.status = status;
    }

    public Long getStatus() 
    {
        return status;
    }

    public void setProgress(Long progress) 
    {
        this.progress = progress;
    }

    public Long getProgress() 
    {
        return progress;
    }

    public void setStartDate(Date startDate) 
    {
        this.startDate = startDate;
    }

    public Date getStartDate() 
    {
        return startDate;
    }

    public void setEndDate(Date endDate) 
    {
        this.endDate = endDate;
    }

    public Date getEndDate() 
    {
        return endDate;
    }

    public void setGoal(String goal) 
    {
        this.goal = goal;
    }

    public String getGoal() 
    {
        return goal;
    }

    public void setProjectName(String projectName) 
    {
        this.projectName = projectName;
    }

    public String getProjectName() 
    {
        return projectName;
    }

    public void setDelFlag(Long delFlag) 
    {
        this.delFlag = delFlag;
    }

    public Long getDelFlag() 
    {
        return delFlag;
    }

    public List<SprintBurndown> getSprintBurndownList()
    {
        return sprintBurndownList;
    }

    public void setSprintBurndownList(List<SprintBurndown> sprintBurndownList)
    {
        this.sprintBurndownList = sprintBurndownList;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("sprintId", getSprintId())
            .append("projectId", getProjectId())
            .append("bookmark", getBookmark())
            .append("sprintNumber", getSprintNumber())
            .append("sprintName", getSprintName())
            .append("status", getStatus())
            .append("progress", getProgress())
            .append("startDate", getStartDate())
            .append("endDate", getEndDate())
            .append("goal", getGoal())
            .append("projectName", getProjectName())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("delFlag", getDelFlag())
            .append("sprintBurndownList", getSprintBurndownList())
            .toString();
    }
}
