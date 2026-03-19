package com.ruoyi.execute.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 任务对象 task
 * 
 * @author Qie_Zi
 * @date 2026-03-18
 */
public class Task extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 任务ID */
    private Long taskId;

    /** 所属项目 */
    @Excel(name = "所属项目")
    private Long projectId;

    /** 关联需求ID */
    @Excel(name = "关联需求ID")
    private Long reqId;

    /** 所属模块 */
    @Excel(name = "所属模块")
    private Long moduleId;

    /** 任务名称 */
    @Excel(name = "任务名称")
    private String taskName;

    /** 详细描述 */
    @Excel(name = "详细描述")
    private String description;

    /** 任务类型（development:开发，test:测试，design:设计，meeting:会议等） */
    @Excel(name = "任务类型", readConverterExp = "d=evelopment:开发，test:测试，design:设计，meeting:会议等")
    private String taskType;

    /** 优先级 */
    @Excel(name = "优先级")
    private String priority;

    /** 状态（0待办 1进行中 2已完成 3暂停） */
    @Excel(name = "状态", readConverterExp = "0=待办,1=进行中,2=已完成,3=暂停")
    private Long status;

    /** 指派给 */
    @Excel(name = "指派给")
    private Long assignTo;

    /** 预估工时 */
    @Excel(name = "预估工时")
    private BigDecimal estimateTime;

    /** 已消耗工时 */
    @Excel(name = "已消耗工时")
    private BigDecimal consumedTime;

    /** 计划开始日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "计划开始日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date planStartDate;

    /** 计划结束日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "计划结束日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date planEndDate;

    /** 截止日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "截止日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date deadline;

    /** 删除标志 */
    private Long delFlag;

    public void setTaskId(Long taskId) 
    {
        this.taskId = taskId;
    }

    public Long getTaskId() 
    {
        return taskId;
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
    public void setTaskName(String taskName) 
    {
        this.taskName = taskName;
    }

    public String getTaskName() 
    {
        return taskName;
    }
    public void setDescription(String description) 
    {
        this.description = description;
    }

    public String getDescription() 
    {
        return description;
    }
    public void setTaskType(String taskType) 
    {
        this.taskType = taskType;
    }

    public String getTaskType() 
    {
        return taskType;
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
    public void setEstimateTime(BigDecimal estimateTime) 
    {
        this.estimateTime = estimateTime;
    }

    public BigDecimal getEstimateTime() 
    {
        return estimateTime;
    }
    public void setConsumedTime(BigDecimal consumedTime) 
    {
        this.consumedTime = consumedTime;
    }

    public BigDecimal getConsumedTime() 
    {
        return consumedTime;
    }
    public void setPlanStartDate(Date planStartDate) 
    {
        this.planStartDate = planStartDate;
    }

    public Date getPlanStartDate() 
    {
        return planStartDate;
    }
    public void setPlanEndDate(Date planEndDate) 
    {
        this.planEndDate = planEndDate;
    }

    public Date getPlanEndDate() 
    {
        return planEndDate;
    }
    public void setDeadline(Date deadline) 
    {
        this.deadline = deadline;
    }

    public Date getDeadline() 
    {
        return deadline;
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
            .append("taskId", getTaskId())
            .append("projectId", getProjectId())
            .append("reqId", getReqId())
            .append("moduleId", getModuleId())
            .append("taskName", getTaskName())
            .append("description", getDescription())
            .append("taskType", getTaskType())
            .append("priority", getPriority())
            .append("status", getStatus())
            .append("assignTo", getAssignTo())
            .append("estimateTime", getEstimateTime())
            .append("consumedTime", getConsumedTime())
            .append("planStartDate", getPlanStartDate())
            .append("planEndDate", getPlanEndDate())
            .append("deadline", getDeadline())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("delFlag", getDelFlag())
            .toString();
    }
}
