# Claude Code Agents 使用说明

## 快速开始

### 1. 基本使用方法

在Claude Code中使用已安装的代理，可以通过以下方式：

```bash
# 列出所有可用代理
/agents

# 使用特定代理
/use <agent-name>

# 例如：使用Python专家
/use python-pro
```

### 2. 代理分类使用指南

## 编程语言专家代理

### Python开发
```bash
/use python-pro
```
适用场景：
- Python代码编写和优化
- Django/Flask框架开发
- 数据分析和科学计算
- 自动化脚本编写

### JavaScript/TypeScript开发
```bash
/use javascript-pro  # JavaScript专家
/use typescript-pro  # TypeScript专家
```
适用场景：
- React/Vue/Angular开发
- Node.js后端开发
- 前端性能优化
- TypeScript类型系统设计

### 系统编程语言
```bash
/use c-pro       # C语言开发
/use cpp-pro     # C++开发
/use rust-pro    # Rust开发
/use golang-pro  # Go语言开发
```

### 企业级语言
```bash
/use java-pro    # Java开发
/use csharp-pro  # C#/.NET开发
/use scala-pro   # Scala开发
```

## 架构设计代理

### 系统架构
```bash
/use architect-review    # 架构评审
/use backend-architect   # 后端架构设计
/use cloud-architect     # 云架构设计
```
使用场景：
- 系统架构设计和评审
- 微服务架构规划
- 云原生应用设计
- 技术选型建议

### API设计
```bash
/use api-documenter      # API文档编写
/use graphql-architect   # GraphQL架构
```

## 开发工具代理

### 代码质量
```bash
/use code-reviewer       # 代码审查
/use debugger           # 调试助手
/use error-detective    # 错误诊断
```
使用技巧：
- 提交代码前使用code-reviewer进行审查
- 遇到bug时使用debugger定位问题
- 出现异常时使用error-detective分析原因

### 测试自动化
```bash
/use test-automator     # 测试自动化
```
功能：
- 单元测试编写
- 集成测试设计
- E2E测试脚本
- 测试覆盖率优化

## 数据与AI代理

### 数据工程
```bash
/use data-engineer      # 数据工程
/use data-scientist     # 数据科学
/use database-admin     # 数据库管理
/use database-optimizer # 数据库优化
```

### 机器学习
```bash
/use ai-engineer        # AI工程
/use ml-engineer        # 机器学习
/use mlops-engineer     # MLOps
```

## DevOps代理

### 部署与运维
```bash
/use deployment-engineer     # 部署工程
/use devops-troubleshooter  # DevOps故障排除
/use incident-responder      # 事故响应
/use terraform-specialist    # Terraform IaC
```

### 性能优化
```bash
/use performance-engineer    # 性能优化
/use dx-optimizer           # 开发体验优化
```

## 移动开发代理

```bash
/use flutter-expert     # Flutter开发
/use ios-developer      # iOS开发
/use mobile-developer   # 通用移动开发
/use unity-developer    # Unity游戏开发
```

## SEO优化代理

### 内容优化
```bash
/use seo-content-writer     # SEO内容写作
/use seo-content-auditor    # 内容审计
/use seo-content-planner    # 内容规划
/use seo-content-refresher  # 内容更新
```

### 技术SEO
```bash
/use seo-meta-optimizer     # 元数据优化
/use seo-structure-architect # 结构优化
/use seo-keyword-strategist  # 关键词策略
```

## 业务支持代理

```bash
/use business-analyst   # 业务分析
/use customer-support   # 客户支持
/use hr-pro            # 人力资源
/use legal-advisor     # 法律咨询
/use risk-manager      # 风险管理
```

## 高级使用技巧

### 1. 组合使用代理

对于复杂项目，可以组合使用多个代理：

```bash
# 示例：全栈Web应用开发
1. /use architect-review     # 先进行架构设计
2. /use backend-architect    # 设计后端架构
3. /use python-pro          # 实现后端代码
4. /use typescript-pro      # 实现前端代码
5. /use test-automator      # 编写测试
6. /use deployment-engineer # 部署配置
```

### 2. 专业领域工作流

#### Web开发工作流
```bash
/use frontend-developer  # 前端开发
/use api-documenter     # API文档
/use code-reviewer      # 代码审查
```

#### 数据科学工作流
```bash
/use data-scientist     # 数据分析
/use python-pro        # Python实现
/use ml-engineer       # 模型开发
/use mlops-engineer    # 模型部署
```

#### DevOps工作流
```bash
/use terraform-specialist    # 基础设施
/use deployment-engineer    # 部署配置
/use incident-responder     # 监控响应
```

### 3. 问题解决模式

#### 调试模式
```bash
/use debugger           # 定位问题
/use error-detective    # 分析错误
/use code-reviewer      # 审查修复
```

#### 优化模式
```bash
/use performance-engineer   # 性能分析
/use database-optimizer    # 数据库优化
/use dx-optimizer         # 体验优化
```

## 最佳实践

### 1. 选择合适的代理
- 根据具体任务选择专业代理
- 优先使用专门代理而非通用代理
- 复杂任务可组合多个代理

### 2. 提供清晰的上下文
- 说明项目背景和技术栈
- 提供相关代码片段
- 明确期望的输出格式

### 3. 迭代式开发
- 先用架构代理设计
- 再用编程代理实现
- 最后用测试代理验证

### 4. 代码质量保证
- 始终使用code-reviewer审查
- 使用test-automator编写测试
- 使用performance-engineer优化性能

## 常见问题

### Q: 如何知道该用哪个代理？
A: 根据任务类型选择：
- 编程任务 → 语言专家代理
- 架构设计 → 架构代理
- 问题排查 → 调试代理
- 性能问题 → 优化代理

### Q: 可以同时使用多个代理吗？
A: 可以顺序使用多个代理，每次激活一个。

### Q: 代理会记住之前的对话吗？
A: 代理在同一会话中会保持上下文。

### Q: 如何更新代理？
A: 重新运行安装脚本即可更新到最新版本。

## 示例场景

### 场景1：构建REST API
```bash
/use backend-architect   # 设计API架构
/use python-pro         # 实现API（Flask/FastAPI）
/use api-documenter     # 生成API文档
/use test-automator     # 编写API测试
```

### 场景2：优化数据库性能
```bash
/use database-optimizer  # 分析性能瓶颈
/use sql-pro           # 优化SQL查询
/use performance-engineer # 整体性能评估
```

### 场景3：移动应用开发
```bash
/use mobile-developer   # 移动架构设计
/use flutter-expert    # Flutter实现
/use test-automator    # 测试用例
/use deployment-engineer # 发布配置
```

## 获取帮助

- 查看所有代理: `/agents`
- 查看代理详情: `/agent-info <name>`
- 获取帮助: `/help`
- 报告问题: https://github.com/githubstudycloud/clagen/issues

## 相关资源

- 源项目: https://github.com/wshobson/agents
- 本项目: https://github.com/githubstudycloud/clagen
- Claude Code文档: https://docs.anthropic.com/claude-code