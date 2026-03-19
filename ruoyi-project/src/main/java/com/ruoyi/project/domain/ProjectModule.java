package com.ruoyi.project.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 项目模块对象 project_module
 * 
 * @author Qie_Zi
 * @date 2026-03-19
 */
public class ProjectModule extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 模块ID */
    private Long moduleId;

    /** 项目ID */
    @Excel(name = "项目ID")
    private Long projectId;

    /** 模块名称 */
    @Excel(name = "模块名称")
    private String moduleName;

    /** 父模块ID（支持树形结构） */
    @Excel(name = "父模块ID", readConverterExp = "支=持树形结构")
    private Long parentId;

    /** 显示顺序 */
    @Excel(name = "显示顺序")
    private Long orderNum;

    /** 删除标志 */
    private Long delFlag;

    public void setModuleId(Long moduleId) 
    {
        this.moduleId = moduleId;
    }

    public Long getModuleId() 
    {
        return moduleId;
    }

    public void setProjectId(Long projectId) 
    {
        this.projectId = projectId;
    }

    public Long getProjectId() 
    {
        return projectId;
    }

    public void setModuleName(String moduleName) 
    {
        this.moduleName = moduleName;
    }

    public String getModuleName() 
    {
        return moduleName;
    }

    public void setParentId(Long parentId) 
    {
        this.parentId = parentId;
    }

    public Long getParentId() 
    {
        return parentId;
    }

    public void setOrderNum(Long orderNum) 
    {
        this.orderNum = orderNum;
    }

    public Long getOrderNum() 
    {
        return orderNum;
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
            .append("moduleId", getModuleId())
            .append("projectId", getProjectId())
            .append("moduleName", getModuleName())
            .append("parentId", getParentId())
            .append("orderNum", getOrderNum())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("delFlag", getDelFlag())
            .toString();
    }
}
