# ProjectFlow Manager - 软件项目开发全流程管理系统

<p align="center">
  <img src="https://img.shields.io/badge/Spring%20Boot-3.5.11-brightgreen.svg" alt="Spring Boot">
  <img src="https://img.shields.io/badge/Vue-2.x-blue.svg" alt="Vue">
  <img src="https://img.shields.io/badge/JDK-17-orange.svg" alt="JDK">
  <img src="https://img.shields.io/badge/MySQL-8.0-blue.svg" alt="MySQL">
  <img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License">
</p>

## 📖 项目简介

ProjectFlow Manager 是一个基于 Spring Boot + Vue 前后端分离的软件项目开发全流程管理系统。系统围绕项目开发全生命周期，涵盖项目管理、任务协同与团队协作等核心环节，实现对软件项目的高效、透明与规范化管理。

**适用场景**：软件开发团队的项目管理、任务分配、进度跟踪、缺陷管理等。

## ✨ 核心功能

- **📋 项目管理**：项目的创建、编辑、删除，项目信息管理，成员分配与管理
- **📝 需求管理**：需求录入、跟踪、变更管理，需求状态流转与版本控制
- **✅ 任务管理**：任务创建、分配、进度跟踪，优先级设置与工时统计
- **🐛 缺陷管理**：缺陷提交、分配、修复、验证，缺陷统计与分析
- **📄 文档管理**：项目文档上传、分类、版本管理，在线预览与权限控制
- **📊 进度看板**：项目进度可视化，燃尽图、甘特图等报表生成
- **🔐 权限管理**：基于角色的权限控制（RBAC），菜单权限与数据权限精细化管理
- **🔔 消息通知**：站内信、通知等多元化消息提醒机制

## 🛠️ 技术栈

### 后端
- **核心框架**：Spring Boot 3.5.11
- **安全框架**：Spring Security + JWT
- **持久层**：MyBatis + MyBatis-Plus
- **数据库**：MySQL 8.0
- **缓存**：Redis
- **数据库连接池**：Druid
- **API 文档**：SpringDoc OpenAPI (Swagger)

### 前端
- **核心框架**：Vue 2.x
- **UI 组件库**：Element UI
- **构建工具**：Webpack
- **HTTP 客户端**：Axios
- **状态管理**：Vuex
- **路由管理**：Vue Router

### 部署
- **容器化**：Docker
- **反向代理**：Nginx

## 🚀 快速开始

### 环境要求

- JDK 17+
- Maven 3.6+
- MySQL 8.0+
- Redis 6.0+
- Node.js 14+

### 后端启动

