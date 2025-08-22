# Claude Code Agents 快速参考手册

## 🚀 快速开始

```bash
# 安装代理
bash install_agents.sh

# 启动Claude Code
claude-code

# 使用代理
/use python-pro

# 退出
/exit
```

## 📋 代理速查表

### 编程语言专家

| 代理 | 用途 | 常用命令 |
|------|------|----------|
| `python-pro` | Python开发 | `创建Flask API` |
| `javascript-pro` | JavaScript | `优化React组件` |
| `typescript-pro` | TypeScript | `添加类型定义` |
| `java-pro` | Java开发 | `创建Spring Boot应用` |
| `golang-pro` | Go开发 | `实现并发处理` |
| `rust-pro` | Rust开发 | `内存安全优化` |
| `cpp-pro` | C++开发 | `性能关键代码` |
| `csharp-pro` | C#/.NET | `创建ASP.NET API` |
| `ruby-pro` | Ruby/Rails | `Rails应用开发` |
| `php-pro` | PHP开发 | `Laravel应用` |
| `sql-pro` | SQL/数据库 | `优化查询性能` |

### 架构与设计

| 代理 | 用途 | 常用命令 |
|------|------|----------|
| `architect-review` | 架构评审 | `评审系统架构` |
| `backend-architect` | 后端架构 | `设计微服务架构` |
| `cloud-architect` | 云架构 | `设计AWS架构` |
| `graphql-architect` | GraphQL | `设计GraphQL schema` |
| `api-documenter` | API文档 | `生成OpenAPI文档` |

### 开发工具

| 代理 | 用途 | 常用命令 |
|------|------|----------|
| `code-reviewer` | 代码审查 | `审查代码质量` |
| `debugger` | 调试 | `定位bug原因` |
| `error-detective` | 错误分析 | `分析错误日志` |
| `test-automator` | 测试自动化 | `编写单元测试` |
| `performance-engineer` | 性能优化 | `分析性能瓶颈` |

### 数据与AI

| 代理 | 用途 | 常用命令 |
|------|------|----------|
| `data-scientist` | 数据科学 | `执行数据分析` |
| `data-engineer` | 数据工程 | `构建ETL管道` |
| `ml-engineer` | 机器学习 | `训练ML模型` |
| `mlops-engineer` | MLOps | `部署ML模型` |
| `database-admin` | 数据库管理 | `优化数据库` |
| `database-optimizer` | 查询优化 | `优化慢查询` |

### DevOps

| 代理 | 用途 | 常用命令 |
|------|------|----------|
| `deployment-engineer` | 部署 | `配置CI/CD` |
| `devops-troubleshooter` | 故障排除 | `诊断系统问题` |
| `terraform-specialist` | IaC | `编写Terraform配置` |
| `incident-responder` | 事故响应 | `处理生产事故` |
| `security-auditor` | 安全审计 | `执行安全扫描` |

## ⚡ 常用命令速查

### 基础命令

```bash
/agents              # 列出所有代理
/use <agent>         # 使用代理
/switch <agent>      # 切换代理
/current             # 当前代理
/help                # 获取帮助
/clear               # 清屏
/exit                # 退出
```

### 高级命令

```bash
/chain agent1 -> agent2   # 链式调用
/parallel [a1, a2]        # 并行执行
/save <name>              # 保存会话
/load <name>              # 加载会话
/history                  # 命令历史
/macro record <name>      # 录制宏
/macro play <name>        # 播放宏
```

### 调试命令

```bash
/debug mode on       # 开启调试
/break <file:line>   # 设置断点
/step                # 单步执行
/continue            # 继续执行
/inspect <var>       # 检查变量
/logs watch          # 监控日志
```

## 🔧 常见任务模板

### 1. 创建Web应用

```bash
# 前后端分离应用
/use architect-review
设计前后端分离架构

/use backend-architect
创建Node.js后端API

/use frontend-developer
创建React前端

/use test-automator
编写测试用例

/use deployment-engineer
配置Docker部署
```

### 2. 数据分析项目

```bash
# 数据分析流程
/use data-engineer
提取和清洗数据

/use data-scientist
执行探索性数据分析

/use ml-engineer
构建预测模型

/use mlops-engineer
部署模型到生产
```

### 3. API开发

```bash
# RESTful API
/use api-documenter
设计API规范

/use backend-architect
实现API端点

/use test-automator
编写API测试

/use deployment-engineer
部署API服务
```

### 4. 代码优化

```bash
# 性能优化
/use performance-engineer
分析性能瓶颈

/use database-optimizer
优化数据库查询

/use code-reviewer
审查优化后的代码

/use test-automator
验证优化效果
```

### 5. 安全审计

```bash
# 安全检查
/use security-auditor
执行安全扫描

/use code-reviewer
审查安全漏洞

/use deployment-engineer
实施安全加固

/use test-automator
验证安全修复
```

## 📝 自动化脚本模板

### 基础自动化脚本

```bash
#!/bin/bash
# basic_automation.sh

# 使用代理执行任务
claude-code << EOF
/use python-pro
创建Python脚本
/exit
EOF
```

### 批量处理脚本

```python
#!/usr/bin/env python3
# batch_processing.py

import subprocess

agents = ['code-reviewer', 'test-automator', 'security-auditor']
for agent in agents:
    cmd = f"claude-code --agent {agent} --task 'analyze code' --non-interactive"
    subprocess.run(cmd, shell=True)
```

### 定时任务脚本

```bash
# Crontab配置
# 每日凌晨2点运行
0 2 * * * /path/to/daily_automation.sh

# 每小时运行
0 * * * * /path/to/hourly_check.sh

# 每周一早上9点
0 9 * * 1 /path/to/weekly_report.sh
```

## 🎯 最佳实践速查

### 选择正确的代理

| 任务类型 | 推荐代理 |
|----------|----------|
| 编写代码 | 对应语言的`-pro`代理 |
| 架构设计 | `architect-review` |
| 代码审查 | `code-reviewer` |
| 调试问题 | `debugger` + `error-detective` |
| 性能优化 | `performance-engineer` |
| 安全检查 | `security-auditor` |
| 测试编写 | `test-automator` |
| 文档编写 | `api-documenter` / `docs-architect` |
| 部署配置 | `deployment-engineer` |
| 数据处理 | `data-engineer` / `data-scientist` |

### 工作流组合

```bash
# 完整开发流程
架构设计 -> 编码实现 -> 代码审查 -> 测试 -> 部署

# 问题修复流程
错误分析 -> 调试 -> 修复 -> 测试 -> 验证

# 优化流程
性能分析 -> 瓶颈定位 -> 优化实施 -> 效果验证

# 安全加固流程
安全扫描 -> 漏洞修复 -> 安全测试 -> 部署验证
```

## 🛠️ 故障排除

### 常见问题

| 问题 | 解决方案 |
|------|----------|
| 代理无响应 | 检查API密钥，重启服务 |
| 命令不识别 | 更新Claude Code版本 |
| 执行超时 | 增加超时时间，优化任务 |
| 内存不足 | 清理缓存，增加内存限制 |
| 网络错误 | 检查代理设置，网络连接 |

### 调试技巧

```bash
# 启用详细日志
export CLAUDE_LOG_LEVEL=DEBUG

# 检查代理状态
claude-code --status

# 清理缓存
claude-code --clear-cache

# 重置配置
claude-code --reset-config

# 查看版本
claude-code --version
```

## 📊 性能优化技巧

### 并行执行

```bash
# 并行运行多个代理
/parallel [code-reviewer, security-auditor, test-automator]
```

### 缓存优化

```bash
# 启用缓存
/cache enable

# 预热缓存
/cache warm

# 清理缓存
/cache clear
```

### 批处理

```bash
# 批量执行命令
/batch
  /use python-pro
  task1
  task2
  task3
/endbatch
```

## 🔐 安全配置

### 环境变量

```bash
export CLAUDE_API_KEY="your-key"
export CLAUDE_TIMEOUT=3600
export CLAUDE_MAX_RETRIES=3
export CLAUDE_LOG_LEVEL=INFO
```

### 配置文件

```json
{
  "api_key": "encrypted_key",
  "agents_dir": "~/claude/agents",
  "log_dir": "~/claude/logs",
  "cache_dir": "~/claude/cache",
  "parallel_jobs": 4,
  "timeout": 3600
}
```

## 📚 资源链接

- **文档**
  - [安装指南](./INSTALLATION.md)
  - [使用说明](./USAGE.md)
  - [交互式指南](./INTERACTIVE_GUIDE.md)
  - [自动化指南](./UNATTENDED_GUIDE.md)
  - [实战案例](./PRACTICAL_CASES.md)

- **脚本示例**
  - [自动化脚本](./AUTOMATION.md)
  - [代理配置](./PROXY_CONFIG.md)

- **外部资源**
  - [Claude Code官方文档](https://docs.anthropic.com/claude-code)
  - [GitHub仓库](https://github.com/githubstudycloud/clagen)
  - [问题反馈](https://github.com/githubstudycloud/clagen/issues)

## 💡 专业技巧

### 1. 代理别名

```bash
# 创建常用别名
alias py='claude-code --agent python-pro'
alias js='claude-code --agent javascript-pro'
alias review='claude-code --agent code-reviewer'
alias test='claude-code --agent test-automator'
```

### 2. 自定义函数

```bash
# 添加到 ~/.bashrc
function quick-review() {
  claude-code --agent code-reviewer --task "review $1" --non-interactive
}

function quick-test() {
  claude-code --agent test-automator --task "test $1" --non-interactive
}
```

### 3. 项目模板

```bash
# 创建项目模板函数
create-project() {
  local name=$1
  local type=$2
  
  claude-code << EOF
  /use architect-review
  设计${type}项目架构
  
  /use backend-architect
  创建项目结构
  
  /use test-automator
  设置测试框架
  
  /save ${name}_template
  EOF
}
```

## 🎓 学习路径

### 初级
1. 基础命令使用
2. 单个代理操作
3. 简单任务自动化

### 中级
1. 多代理协作
2. 批处理脚本
3. 错误处理

### 高级
1. 完整CI/CD
2. 性能优化
3. 安全加固
4. 自定义工作流

## 📈 效率提升指标

| 任务 | 手动耗时 | 自动化耗时 | 提升 |
|------|----------|------------|------|
| 代码审查 | 30分钟 | 5分钟 | 83% |
| API文档 | 2小时 | 15分钟 | 88% |
| 测试编写 | 1小时 | 10分钟 | 83% |
| 部署配置 | 45分钟 | 8分钟 | 82% |
| 安全扫描 | 1.5小时 | 12分钟 | 87% |

---

**版本**: 1.0.0  
**更新日期**: 2025-08-22  
**维护者**: Claude Code Agents Team