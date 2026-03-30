package com.ruoyi.project.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 项目成员对象 project_member
 * 
 * @author Qie_Zi
 * @date 2026-03-14
 */
public class ProjectMember extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 关联ID */
    private Long id;

    /** 团队 ID */
    @Excel(name = "团队 ID")
    private Long teamId;

    /** 团队名称 */
    @Excel(name = "团队名称")
    private String teamName;

    /** 项目 ID */
    @Excel(name = "项目 ID")
    private Long projectId;

    /** 用户 ID（关联 sys_user） */
    @Excel(name = "用户 ID", readConverterExp = "关=联 sys_user")
    private Long userId;

    /** 项目名称（来自 project 表） */
    @Excel(name = "项目名称")
    private String projectName;

    /** 用户名称（来自 sys_user） */
    @Excel(name = "用户名称")
    private String userName;

    /** 用户昵称（来自 sys_user） */
    @Excel(name = "用户昵称")
    private String nickName;

    /** 用户邮箱（来自 sys_user） */
    @Excel(name = "用户邮箱")
    private String email;

    /** 用户手机号（来自 sys_user） */
    @Excel(name = "用户手机号")
    private String phonenumber;

    /** 项目角色（0:系统管理员，1:项目经理，2:开发人员，3:测试人员） */
    @Excel(name = "项目角色", readConverterExp = "0=系统管理员，1=项目经理，2=开发人员，3=测试人员")
    private String projectRole;

    /** 加入时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "加入时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date joinTime;

    /** 已用工时 */
    @Excel(name = "已用工时")
    private Long investment;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setTeamId(Long teamId) 
    {
        this.teamId = teamId;
    }

    public Long getTeamId() 
    {
        return teamId;
    }

    public void setTeamName(String teamName) 
    {
        this.teamName = teamName;
    }

    public String getTeamName() 
    {
        return teamName;
    }

    public void setProjectId(Long projectId) 
    {
        this.projectId = projectId;
    }

    public Long getProjectId() 
    {
        return projectId;
    }

    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }

    public void setProjectName(String projectName) 
    {
        this.projectName = projectName;
    }

    public String getProjectName() 
    {
        return projectName;
    }

    public void setUserName(String userName) 
    {
        this.userName = userName;
    }

    public String getUserName() 
    {
        return userName;
    }

    public void setNickName(String nickName) 
    {
        this.nickName = nickName;
    }

    public String getNickName() 
    {
        return nickName;
    }

    public void setEmail(String email) 
    {
        this.email = email;
    }

    public String getEmail() 
    {
        return email;
    }

    public void setPhonenumber(String phonenumber) 
    {
        this.phonenumber = phonenumber;
    }

    public String getPhonenumber() 
    {
        return phonenumber;
    }

    public void setProjectRole(String projectRole) 
    {
        this.projectRole = projectRole;
    }

    public String getProjectRole() 
    {
        return projectRole;
    }

    public void setJoinTime(Date joinTime) 
    {
        this.joinTime = joinTime;
    }

    public Date getJoinTime() 
    {
        return joinTime;
    }

    public void setInvestment(Long investment)
    {
        this.investment = investment;
    }

    public Long getInvestment() 
    {
        return investment;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("teamId", getTeamId())
            .append("teamName", getTeamName())
            .append("projectId", getProjectId())
            .append("userId", getUserId())
            .append("projectName", getProjectName())
            .append("userName", getUserName())
            .append("nickName", getNickName())
            .append("projectRole", getProjectRole())
            .append("joinTime", getJoinTime())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("investment", getInvestment())
            .toString();
    }
}
