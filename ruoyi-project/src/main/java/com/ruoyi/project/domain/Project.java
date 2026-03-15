package com.ruoyi.project.domain;

import java.util.List;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 项目对象 project
 * 
 * @author Qie_Zi
 * @date 2026-03-14
 */
public class Project extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 项目ID */
    private Long projectId;

    /** 项目名称 */
    @Excel(name = "项目名称")
    private String projectName;

    /** 项目编码（唯一） */
    private String projectCode;

    /** 项目描述 */
    private String description;

    /** 项目状态（0进行中 1已完成 2暂停 3已取消） */
    @Excel(name = "项目状态", readConverterExp = "0=进行中,1=已完成,2=暂停,3=已取消")
    private Long status;

    /** 优先级（1最高 2高 3中 4低 5最低） */
    @Excel(name = "优先级", readConverterExp = "1=最高,2=高,3=中,4=低,5=最低")
    private Long priority;

    /** 预算 */
    @Excel(name = "预算")
    private Long Budget;

    /** 需求条目数 */
    @Excel(name = "需求条目数")
    private Long requirementCount;

    /** 已投入 */
    @Excel(name = "已投入")
    private Long Investment;

    /** 计划开始日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "计划开始日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date startDate;

    /** 计划结束日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "计划结束日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date endDate;

    /** 实际开始日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "实际开始日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date realStartDate;

    /** 实际结束日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "实际结束日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date realEndDate;

    /** 项目进度（0-100） */
    @Excel(name = "项目进度", readConverterExp = "0=-100")
    private Long progress;

    /** 项目负责人ID */
    private Long ownerId;

    /** 项目负责人姓名 */
    @Excel(name = "项目负责人姓名")
    private String ownerName;

    /** 看板样式（1标准看板 2敏捷看板 3自定义） */
    private Long boardStyle;

    /** 列宽度 */
    private Long colWidth;

    /** 显示卡片数量 */
    private Long displayCards;

    /** 流体看板（0禁用 1启用） */
    private String fluidBoard;

    /** 删除标志（0存在 1删除） */
    private Long delFlag;

    /** 项目模块信息 */
    private List<ProjectModule> projectModuleList;

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

    public void setProjectCode(String projectCode) 
    {
        this.projectCode = projectCode;
    }

    public String getProjectCode() 
    {
        return projectCode;
    }

    public void setDescription(String description) 
    {
        this.description = description;
    }

    public String getDescription() 
    {
        return description;
    }

    public void setStatus(Long status) 
    {
        this.status = status;
    }

    public Long getStatus() 
    {
        return status;
    }

    public void setPriority(Long priority) 
    {
        this.priority = priority;
    }

    public Long getPriority() 
    {
        return priority;
    }

    public void setBudget(Long Budget) 
    {
        this.Budget = Budget;
    }

    public Long getBudget() 
    {
        return Budget;
    }

    public void setRequirementCount(Long requirementCount) 
    {
        this.requirementCount = requirementCount;
    }

    public Long getRequirementCount() 
    {
        return requirementCount;
    }

    public void setInvestment(Long Investment) 
    {
        this.Investment = Investment;
    }

    public Long getInvestment() 
    {
        return Investment;
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

    public void setRealStartDate(Date realStartDate) 
    {
        this.realStartDate = realStartDate;
    }

    public Date getRealStartDate() 
    {
        return realStartDate;
    }

    public void setRealEndDate(Date realEndDate) 
    {
        this.realEndDate = realEndDate;
    }

    public Date getRealEndDate() 
    {
        return realEndDate;
    }

    public void setProgress(Long progress) 
    {
        this.progress = progress;
    }

    public Long getProgress() 
    {
        return progress;
    }

    public void setOwnerId(Long ownerId) 
    {
        this.ownerId = ownerId;
    }

    public Long getOwnerId() 
    {
        return ownerId;
    }

    public void setOwnerName(String ownerName) 
    {
        this.ownerName = ownerName;
    }

    public String getOwnerName() 
    {
        return ownerName;
    }

    public void setBoardStyle(Long boardStyle) 
    {
        this.boardStyle = boardStyle;
    }

    public Long getBoardStyle() 
    {
        return boardStyle;
    }

    public void setColWidth(Long colWidth) 
    {
        this.colWidth = colWidth;
    }

    public Long getColWidth() 
    {
        return colWidth;
    }

    public void setDisplayCards(Long displayCards) 
    {
        this.displayCards = displayCards;
    }

    public Long getDisplayCards() 
    {
        return displayCards;
    }

    public void setFluidBoard(String fluidBoard) 
    {
        this.fluidBoard = fluidBoard;
    }

    public String getFluidBoard() 
    {
        return fluidBoard;
    }

    public void setDelFlag(Long delFlag) 
    {
        this.delFlag = delFlag;
    }

    public Long getDelFlag() 
    {
        return delFlag;
    }

    public List<ProjectModule> getProjectModuleList()
    {
        return projectModuleList;
    }

    public void setProjectModuleList(List<ProjectModule> projectModuleList)
    {
        this.projectModuleList = projectModuleList;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("projectId", getProjectId())
            .append("projectName", getProjectName())
            .append("projectCode", getProjectCode())
            .append("description", getDescription())
            .append("status", getStatus())
            .append("priority", getPriority())
            .append("Budget", getBudget())
            .append("requirementCount", getRequirementCount())
            .append("Investment", getInvestment())
            .append("startDate", getStartDate())
            .append("endDate", getEndDate())
            .append("realStartDate", getRealStartDate())
            .append("realEndDate", getRealEndDate())
            .append("progress", getProgress())
            .append("ownerId", getOwnerId())
            .append("ownerName", getOwnerName())
            .append("boardStyle", getBoardStyle())
            .append("colWidth", getColWidth())
            .append("displayCards", getDisplayCards())
            .append("fluidBoard", getFluidBoard())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("delFlag", getDelFlag())
            .append("projectModuleList", getProjectModuleList())
            .toString();
    }
}
