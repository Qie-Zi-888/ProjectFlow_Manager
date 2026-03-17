package com.ruoyi.project.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 燃尽图统计对象 sprint_burndown
 * 
 * @author Qie_Zi
 * @date 2026-03-17
 */
public class SprintBurndown extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 记录ID */
    private Long id;

    /** 迭代ID */
    @Excel(name = "迭代ID")
    private Long sprintId;

    /** 统计日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "统计日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date statDate;

    /** 迭代总任务数 */
    @Excel(name = "迭代总任务数")
    private Long totalTasks;

    /** 已完成任务数 */
    @Excel(name = "已完成任务数")
    private Long doneTasks;

    /** 剩余任务数 */
    @Excel(name = "剩余任务数")
    private Long remainingTasks;

    /** 迭代总工时 */
    @Excel(name = "迭代总工时")
    private BigDecimal totalHours;

    /** 剩余工时 */
    @Excel(name = "剩余工时")
    private BigDecimal remainingHours;

    /** 理想剩余工时(可选) */
    @Excel(name = "理想剩余工时(可选)")
    private BigDecimal idealRemainingHours;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setSprintId(Long sprintId) 
    {
        this.sprintId = sprintId;
    }

    public Long getSprintId() 
    {
        return sprintId;
    }
    public void setStatDate(Date statDate) 
    {
        this.statDate = statDate;
    }

    public Date getStatDate() 
    {
        return statDate;
    }
    public void setTotalTasks(Long totalTasks) 
    {
        this.totalTasks = totalTasks;
    }

    public Long getTotalTasks() 
    {
        return totalTasks;
    }
    public void setDoneTasks(Long doneTasks) 
    {
        this.doneTasks = doneTasks;
    }

    public Long getDoneTasks() 
    {
        return doneTasks;
    }
    public void setRemainingTasks(Long remainingTasks) 
    {
        this.remainingTasks = remainingTasks;
    }

    public Long getRemainingTasks() 
    {
        return remainingTasks;
    }
    public void setTotalHours(BigDecimal totalHours) 
    {
        this.totalHours = totalHours;
    }

    public BigDecimal getTotalHours() 
    {
        return totalHours;
    }
    public void setRemainingHours(BigDecimal remainingHours) 
    {
        this.remainingHours = remainingHours;
    }

    public BigDecimal getRemainingHours() 
    {
        return remainingHours;
    }
    public void setIdealRemainingHours(BigDecimal idealRemainingHours) 
    {
        this.idealRemainingHours = idealRemainingHours;
    }

    public BigDecimal getIdealRemainingHours() 
    {
        return idealRemainingHours;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("sprintId", getSprintId())
            .append("statDate", getStatDate())
            .append("totalTasks", getTotalTasks())
            .append("doneTasks", getDoneTasks())
            .append("remainingTasks", getRemainingTasks())
            .append("totalHours", getTotalHours())
            .append("remainingHours", getRemainingHours())
            .append("idealRemainingHours", getIdealRemainingHours())
            .append("createTime", getCreateTime())
            .toString();
    }
}
