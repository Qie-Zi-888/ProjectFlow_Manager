package com.ruoyi.defects.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 缺陷对象 bug
 * 
 * @author Qie_Zi
 * @date 2026-04-23
 */
public class Bug extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 缺陷ID */
    private Long bugId;

    /** 所属项目 */
    private Long projectId;

    /** 关联需求ID */
    private Long reqId;

    /** 所属模块 */
    private Long moduleId;

    /** 发现版本 */
    private String foundVersion;

    /** 修复版本 */
    private String fixedVersion;

    /** 缺陷标题 */
    @Excel(name = "缺陷标题")
    private String bugTitle;

    /** 详细描述 */
    @Excel(name = "详细描述")
    private String description;

    /** 严重程度（1致命 2严重 3一般 4轻微） */
    @Excel(name = "严重程度", readConverterExp = "1=致命,2=严重,3=一般,4=轻微")
    private String severity;

    /** 优先级 */
    @Excel(name = "优先级")
    private String priority;

    /** 状态（0新建 1已分配 2处理中 3已修复 4关闭 5拒绝） */
    @Excel(name = "状态", readConverterExp = "0=新建,1=已分配,2=处理中,3=已修复,4=关闭,5=拒绝")
    private Long status;

    /** 指派给（当前处理人） */
    @Excel(name = "指派给", readConverterExp = "当=前处理人")
    private Long assignTo;

    /** 解决人 */
    private Long resolvedBy;

    /** 解决时间 */
    private Date resolvedTime;

    /** 关闭人 */
    private Long closedBy;

    /** 关闭时间 */
    private Date closedTime;

    /** 删除标志 */
    private Long delFlag;

    public void setBugId(Long bugId) 
    {
        this.bugId = bugId;
    }

    public Long getBugId() 
    {
        return bugId;
    }

    public void setProjectId(Long projectId) 
    {
        this.projectId = projectId;
    }

    public Long getProjectId() 
    {
        return projectId;
    }

    public void setReqId(Long reqId) 
    {
        this.reqId = reqId;
    }

    public Long getReqId() 
    {
        return reqId;
    }

    public void setModuleId(Long moduleId) 
    {
        this.moduleId = moduleId;
    }

    public Long getModuleId() 
    {
        return moduleId;
    }

    public void setFoundVersion(String foundVersion) 
    {
        this.foundVersion = foundVersion;
    }

    public String getFoundVersion() 
    {
        return foundVersion;
    }

    public void setFixedVersion(String fixedVersion) 
    {
        this.fixedVersion = fixedVersion;
    }

    public String getFixedVersion() 
    {
        return fixedVersion;
    }

    public void setBugTitle(String bugTitle) 
    {
        this.bugTitle = bugTitle;
    }

    public String getBugTitle() 
    {
        return bugTitle;
    }

    public void setDescription(String description) 
    {
        this.description = description;
    }

    public String getDescription() 
    {
        return description;
    }

    public void setSeverity(String severity) 
    {
        this.severity = severity;
    }

    public String getSeverity() 
    {
        return severity;
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

    public void setResolvedBy(Long resolvedBy) 
    {
        this.resolvedBy = resolvedBy;
    }

    public Long getResolvedBy() 
    {
        return resolvedBy;
    }

    public void setResolvedTime(Date resolvedTime) 
    {
        this.resolvedTime = resolvedTime;
    }

    public Date getResolvedTime() 
    {
        return resolvedTime;
    }

    public void setClosedBy(Long closedBy) 
    {
        this.closedBy = closedBy;
    }

    public Long getClosedBy() 
    {
        return closedBy;
    }

    public void setClosedTime(Date closedTime) 
    {
        this.closedTime = closedTime;
    }

    public Date getClosedTime() 
    {
        return closedTime;
    }

    public void setDelFlag(Long delFlag) 
    {
        this.delFlag = delFlag;
    }

    public Long getDelFlag() 
    {
        return delFlag;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("bugId", getBugId())
            .append("projectId", getProjectId())
            .append("reqId", getReqId())
            .append("moduleId", getModuleId())
            .append("foundVersion", getFoundVersion())
            .append("fixedVersion", getFixedVersion())
            .append("bugTitle", getBugTitle())
            .append("description", getDescription())
            .append("severity", getSeverity())
            .append("priority", getPriority())
            .append("status", getStatus())
            .append("assignTo", getAssignTo())
            .append("resolvedBy", getResolvedBy())
            .append("resolvedTime", getResolvedTime())
            .append("closedBy", getClosedBy())
            .append("closedTime", getClosedTime())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("delFlag", getDelFlag())
            .toString();
    }
}
