# Claude Code Agents Collection (clagen)

## 概述

这是一个为Claude Code CLI整理和安装的代理集合，包含72个专业领域的AI代理助手。这些代理来自[wshobson/agents](https://github.com/wshobson/agents)项目，经过整理和优化后适配Claude Code使用。

## 特性

- 🚀 **72个专业代理** - 涵盖编程、架构、DevOps、数据科学等多个领域
- 📦 **一键安装** - 自动化安装脚本，快速部署所有代理
- 📝 **完整文档** - 详细的安装和使用说明
- 🔄 **智能去重** - 自动跳过已安装的代理，避免重复
- 📊 **安装日志** - 记录完整的安装过程和结果

## 快速开始

### 安装

```bash
# 克隆仓库
git clone https://github.com/githubstudycloud/clagen.git
cd clagen

# 运行安装脚本
bash install_agents.sh
```

### 使用

在Claude Code中使用代理：

```bash
# 查看所有代理
/agents

# 使用特定代理
/use python-pro
```

## 代理分类

### 📚 编程语言专家 (18个)
- C, C++, C#, Elixir, Go, Java, JavaScript, PHP, Python, Ruby, Rust, Scala, SQL, TypeScript

### 🏗️ 架构与设计 (7个)
- 架构评审、后端架构、云架构、文档架构、GraphQL架构、UI/UX设计

### 🛠️ 开发工具 (15个)
- API文档、代码审查、调试、错误诊断、测试自动化、提示工程

### 🤖 数据与AI (6个)
- AI工程、数据工程、数据科学、机器学习、MLOps、量化分析

### ⚙️ 运维与部署 (8个)
- 数据库管理、部署工程、DevOps、事故响应、网络工程、性能优化

### 📱 移动开发 (4个)
- Flutter、iOS、移动通用、Unity游戏开发

### 🔍 SEO优化 (10个)
- 内容审计、内容规划、关键词策略、元数据优化、结构优化

### 💼 业务支持 (9个)
- 业务分析、客户支持、人力资源、法律咨询、风险管理、销售自动化

## 文档

- [安装文档](./INSTALLATION.md) - 详细的安装步骤和故障排除
- [使用说明](./USAGE.md) - 完整的使用指南和最佳实践
- [安装日志](./installation.log) - 安装过程记录

## 项目结构

```
clagen/
├── README.md               # 项目说明（本文件）
├── INSTALLATION.md         # 安装文档
├── USAGE.md               # 使用说明
├── install_agents.sh      # 自动安装脚本
├── installation.log       # 安装日志
└── agents/                # 代理文件（安装后）
```

## 系统要求

- Claude Code CLI
- Bash shell (Git Bash on Windows)
- 网络连接（用于下载代理）

## 贡献

欢迎提交Issue和Pull Request！

## 许可

本项目基于原项目[wshobson/agents](https://github.com/wshobson/agents)的许可协议。

## 致谢

- 感谢[wshobson/agents](https://github.com/wshobson/agents)项目提供的优质代理集合
- 感谢Claude Code团队提供的强大CLI工具

## 联系方式

- GitHub: https://github.com/githubstudycloud/clagen
- Issues: https://github.com/githubstudycloud/clagen/issues

---

*最后更新: 2025-08-22*