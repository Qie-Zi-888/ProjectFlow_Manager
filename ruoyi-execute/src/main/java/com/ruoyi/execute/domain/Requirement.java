package com.ruoyi.execute.domain;

import java.math.BigDecimal;
import java.util.List;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 需求对象 requirement
 * 
 * @author Qie_Zi
 * @date 2026-03-18
 */
public class Requirement extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 需求ID */
    private Long reqId;

    /** 所属项目 */
    @Excel(name = "所属项目")
    private Long projectId;

    /** 项目名称 */
    @Excel(name = "项目名称")
    private String projectName;

    /** 所属模块 */
    @Excel(name = "所属模块")
    private Long moduleId;

    /** 模块名称 */
    @Excel(name = "模块名称")
    private String moduleName;

    /** 书签标识（用于查询和分类） */
    @Excel(name = "书签标识", readConverterExp = "用=于查询和分类")
    private String bookmark;

    /** 需求标题 */
    @Excel(name = "需求标题")
    private String reqTitle;

    /** 计划发布版本 */
    @Excel(name = "计划发布版本")
    private Long versionId;

    /** 详细描述 */
    @Excel(name = "详细描述")
    private String description;

    /** 优先级（1 最高 2 高 3 中 4 低） */
    @Excel(name = "优先级", readConverterExp = "1=最高,2=高,3=中,4=低")
    private String priority;

    /** 状态（0 草稿 1 进行中 2 已解决 3 关闭） */
    @Excel(name = "状态", readConverterExp = "0=草稿,1=进行中,2=已解决,3=关闭")
    private Long status;

    /** 指派给（用户 ID） */
    @Excel(name = "指派给", readConverterExp = "用=户 ID")
    private Long assignTo;

    /** 指派给名称 */
    @Excel(name = "指派给名称")
    private String assignToName;

    /** 评审人（用户 ID） */
    @Excel(name = "评审人", readConverterExp = "用=户 ID")
    private Long reviewer;

    /** 评审人名称 */
    @Excel(name = "评审人名称")
    private String reviewerName;

    /** 预估工时（小时） */
    @Excel(name = "预估工时", readConverterExp = "小=时")
    private BigDecimal estimateTime;

    /** 删除标志 */
    private Long delFlag;

    /** 任务信息 */
    private List<Task> taskList;

    /** 临时字段：用于接收前端传来的用户名搜索条件（不参与数据库映射） */
    private transient String assignToNameSearch;

    public void setReqId(Long reqId) 
    {
        this.reqId = reqId;
    }

    public Long getReqId() 
    {
        return reqId;
    }

    public void setProjectId(Long projectId) 
    {
        this.projectId = projectId;
    }

    public Long getProjectId() 
    {
        return projectId;
    }

    public void setProjectName(String projectName) 
    {
        this.projectName = projectName;
    }

    public String getProjectName() 
    {
        return projectName;
    }

    public void setModuleId(Long moduleId) 
    {
        this.moduleId = moduleId;
    }

    public Long getModuleId() 
    {
        return moduleId;
    }

    public void setModuleName(String moduleName) 
    {
        this.moduleName = moduleName;
    }

    public String getModuleName() 
    {
        return moduleName;
    }

    public void setBookmark(String bookmark) 
    {
        this.bookmark = bookmark;
    }

    public String getBookmark() 
    {
        return bookmark;
    }

    public void setReqTitle(String reqTitle) 
    {
        this.reqTitle = reqTitle;
    }

    public String getReqTitle() 
    {
        return reqTitle;
    }

    public void setVersionId(Long versionId) 
    {
        this.versionId = versionId;
    }

    public Long getVersionId() 
    {
        return versionId;
    }

    public void setDescription(String description) 
    {
        this.description = description;
    }

    public String getDescription() 
    {
        return description;
    }

    public void setPriority(String priority) 
    {
        this.priority = priority;
    }

    public String getPriority() 
    {
        return priority;
    }

    public void setStatus(Long status) 
    {
        this.status = status;
    }

    public Long getStatus() 
    {
        return status;
    }

    public void setAssignTo(Long assignTo) 
    {
        this.assignTo = assignTo;
    }

    public Long getAssignTo() 
    {
        return assignTo;
    }

    public void setAssignToName(String assignToName) 
    {
        this.assignToName = assignToName;
    }

    public String getAssignToName() 
    {
        return assignToName;
    }

    public void setReviewer(Long reviewer) 
    {
        this.reviewer = reviewer;
    }

    public Long getReviewer() 
    {
        return reviewer;
    }

    public void setReviewerName(String reviewerName) 
    {
        this.reviewerName = reviewerName;
    }

    public String getReviewerName() 
    {
        return reviewerName;
    }

    public void setEstimateTime(BigDecimal estimateTime)
    {
        this.estimateTime = estimateTime;
    }

    public BigDecimal getEstimateTime() 
    {
        return estimateTime;
    }

    public void setDelFlag(Long delFlag) 
    {
        this.delFlag = delFlag;
    }

    public Long getDelFlag() 
    {
        return delFlag;
    }

    public List<Task> getTaskList()
    {
        return taskList;
    }

    public void setTaskList(List<Task> taskList)
    {
        this.taskList = taskList;
    }

    public void setAssignToNameSearch(String assignToNameSearch)
    {
        this.assignToNameSearch = assignToNameSearch;
    }

    public String getAssignToNameSearch()
    {
        return assignToNameSearch;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("reqId", getReqId())
            .append("projectId", getProjectId())
            .append("projectName", getProjectName())
            .append("moduleId", getModuleId())
            .append("moduleName", getModuleName())
            .append("bookmark", getBookmark())
            .append("reqTitle", getReqTitle())
            .append("versionId", getVersionId())
            .append("description", getDescription())
            .append("priority", getPriority())
            .append("status", getStatus())
            .append("assignTo", getAssignTo())
            .append("assignToName", getAssignToName())
            .append("reviewer", getReviewer())
            .append("reviewerName", getReviewerName())
            .append("estimateTime", getEstimateTime())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("delFlag", getDelFlag())
            .append("taskList", getTaskList())
            .toString();
    }
}
