# Claude Code Agents 交互式使用指南

## 目录
1. [快速开始](#快速开始)
2. [交互式命令](#交互式命令)
3. [对话式开发](#对话式开发)
4. [智能助手模式](#智能助手模式)
5. [协作工作流](#协作工作流)
6. [高级交互技巧](#高级交互技巧)
7. [实时调试](#实时调试)
8. [最佳实践](#最佳实践)

## 快速开始

### 基础交互命令

```bash
# 启动Claude Code交互模式
claude-code

# 列出所有可用代理
/agents

# 激活特定代理
/use python-pro

# 查看当前代理
/current

# 切换代理
/switch typescript-pro

# 获取帮助
/help
```

### 初次使用流程

1. **启动交互会话**
```bash
$ claude-code
Claude Code v1.0.0
Type /help for commands, /agents for available agents
> 
```

2. **选择合适的代理**
```bash
> /agents
Available agents:
- python-pro: Python development expert
- javascript-pro: JavaScript specialist
- data-scientist: Data analysis expert
...

> /use python-pro
✅ Activated: python-pro
```

3. **开始交互**
```bash
> 帮我创建一个Flask API
python-pro> 我来帮您创建Flask API。首先让我了解您的需求...
```

## 交互式命令

### 基础命令集

| 命令 | 描述 | 示例 |
|------|------|------|
| `/use <agent>` | 激活代理 | `/use python-pro` |
| `/switch <agent>` | 切换代理 | `/switch java-pro` |
| `/agents` | 列出所有代理 | `/agents` |
| `/search <keyword>` | 搜索代理 | `/search database` |
| `/info <agent>` | 查看代理详情 | `/info ml-engineer` |
| `/history` | 查看命令历史 | `/history` |
| `/save <name>` | 保存会话 | `/save my-session` |
| `/load <name>` | 加载会话 | `/load my-session` |
| `/clear` | 清空屏幕 | `/clear` |
| `/exit` | 退出 | `/exit` |

### 高级命令

```bash
# 组合多个代理
/chain python-pro -> test-automator -> deployment-engineer

# 并行使用代理
/parallel [code-reviewer, security-auditor]

# 设置代理参数
/config python-pro --style=pep8 --version=3.9

# 创建代理别名
/alias py python-pro
/use py  # 使用别名

# 录制宏命令
/macro record deploy-flow
/use deployment-engineer
... (执行命令)
/macro stop

# 播放宏
/macro play deploy-flow
```

## 对话式开发

### 1. 需求分析对话

```bash
> /use business-analyst
> 我想开发一个在线教育平台

business-analyst> 让我帮您分析需求。请回答以下问题：

1. 目标用户群体是谁？
   > 主要是K12学生和教师

2. 核心功能有哪些？
   > 视频课程、作业系统、考试系统

3. 预期用户规模？
   > 初期1万用户，一年内增长到10万

business-analyst> 基于您的需求，我建议以下架构：
- 前端：React + TypeScript
- 后端：Node.js + Express
- 数据库：PostgreSQL + Redis
- 视频服务：AWS S3 + CloudFront

是否需要我详细说明每个部分？[Y/n]
```

### 2. 迭代式开发

```bash
> /use python-pro
> 创建用户认证系统

python-pro> 我来创建一个基于JWT的认证系统：

```python
# auth.py
from flask import Flask, request, jsonify
from flask_jwt_extended import JWTManager, create_access_token
import bcrypt

app = Flask(__name__)
app.config['JWT_SECRET_KEY'] = 'your-secret-key'
jwt = JWTManager(app)

@app.route('/register', methods=['POST'])
def register():
    # 实现注册逻辑
    pass
```

继续完善这个系统吗？[Y/n]
> Y

python-pro> 好的，让我添加完整的注册和登录功能：
[继续生成代码...]
```

### 3. 问题解决对话

```bash
> /use debugger
> 我的应用出现内存泄漏

debugger> 我来帮您诊断内存泄漏问题。请提供以下信息：

1. 使用的编程语言和框架？
   > Python + Django

2. 内存增长模式？
   > 缓慢增长，24小时后OOM

3. 有监控数据吗？
   > 有，内存从500MB增长到4GB

debugger> 基于这些信息，可能的原因有：
1. 查询集缓存未清理
2. 全局变量累积
3. 第三方库内存泄漏

让我们逐一检查：

```bash
# 1. 检查Django查询集
python -m memory_profiler your_app.py

# 2. 使用tracemalloc
import tracemalloc
tracemalloc.start()
```

需要我详细解释每个步骤吗？
```

## 智能助手模式

### 1. 学习模式

```bash
> /mode learning
> /use python-pro
> 教我Python装饰器

python-pro> 📚 进入学习模式。我会循序渐进地教您装饰器。

**第1课：什么是装饰器？**
装饰器是修改函数行为的函数。想象它是一个"包装器"。

```python
# 基础示例
def my_decorator(func):
    def wrapper():
        print("装饰器添加的功能")
        func()
    return wrapper

@my_decorator
def say_hello():
    print("Hello!")

say_hello()
```

理解了吗？需要更多例子吗？[继续/例子/练习]
> 练习

python-pro> 好的，来做个练习：

**练习1**: 创建一个计时装饰器
要求：测量函数执行时间

尝试写出代码，我会给您反馈。
```

### 2. 审查模式

```bash
> /mode review
> /use code-reviewer

code-reviewer> 🔍 进入代码审查模式。请粘贴或指定要审查的代码。

> 审查 src/api/user.py

code-reviewer> 正在审查 src/api/user.py...

## 审查报告

### 🔴 严重问题 (2)
1. **SQL注入风险** (Line 45)
   ```python
   query = f"SELECT * FROM users WHERE id = {user_id}"
   ```
   建议：使用参数化查询

2. **硬编码密钥** (Line 12)
   ```python
   SECRET_KEY = "my-secret-key-123"
   ```
   建议：使用环境变量

### 🟡 警告 (3)
1. **未处理异常** (Line 67)
2. **性能问题** (Line 89) - N+1查询
3. **代码重复** (Line 120-145)

### 🟢 良好实践 (2)
1. ✅ 使用类型提示
2. ✅ 有单元测试

需要自动修复这些问题吗？[Y/n]
```

### 3. 指导模式

```bash
> /mode mentor
> /use architect-review

architect-review> 👨‍🏫 进入导师模式。我会指导您做出架构决策。

> 我应该选择微服务还是单体架构？

architect-review> 让我们一起分析这个决策：

## 决策框架

### 1. 项目现状评估
- 团队规模？
  > 5人

- 项目复杂度？
  > 中等，10个主要模块

- 发布频率？
  > 每周一次

### 2. 权衡分析

**单体架构优势**：
✅ 开发简单 (适合5人团队)
✅ 部署容易 (符合每周发布)
✅ 调试方便

**微服务劣势**：
❌ 运维复杂度高
❌ 团队规模不足
❌ 过早优化

### 📊 我的建议
基于您的情况，建议：
1. **现在**：模块化单体架构
2. **6个月后**：评估是否需要拆分
3. **准备**：设计清晰的模块边界

需要我帮您设计模块化单体架构吗？
```

## 协作工作流

### 1. 团队协作模式

```bash
# 创建协作会话
> /session create team-project
Session 'team-project' created
Sharing code: ABC123

# 其他成员加入
> /session join ABC123
Joined session 'team-project'

# 分配任务
> /assign @alice frontend-developer
> /assign @bob backend-architect
> /assign @charlie test-automator

# 实时协作
@alice> /use frontend-developer
@alice> 创建用户界面...

@bob> /use backend-architect  
@bob> 设计API结构...

# 查看进度
> /status
Team Progress:
- @alice: Creating UI components (70%)
- @bob: API design (100%)
- @charlie: Writing tests (30%)
```

### 2. 代码评审工作流

```bash
> /review-mode collaborative

# 开始评审
> /review start PR-123

code-reviewer> 开始评审 PR-123

# 多个审查者
@senior> /use code-reviewer
@senior> 代码结构良好，但需要注意性能

@security> /use security-auditor
@security> 发现2个安全隐患

# 汇总意见
> /review summary
评审汇总 (PR-123):
- code-reviewer: ✅ 通过 (注意性能)
- security-auditor: ⚠️ 需要修复
- 总体: 需要改进

# 自动修复
> /review fix-all
正在修复发现的问题...
✅ 修复完成，请重新评审
```

### 3. 结对编程模式

```bash
> /pair start @partner

# 驱动者模式
> /pair driver
You are now the driver. @partner is navigator.

> /use python-pro
> 实现排序算法

python-pro> 我来实现快速排序：
```python
def quicksort(arr):
    if len(arr) <= 1:
        return arr
    # 继续实现...
```

# 导航者建议
@partner> 建议使用三路快排优化重复元素

> /pair switch  # 切换角色
@partner is now the driver.

# 查看编程统计
> /pair stats
结对编程统计:
- 时长: 2小时15分钟
- 代码行数: 450
- 切换次数: 8
- 测试通过率: 95%
```

## 高级交互技巧

### 1. 上下文管理

```bash
# 保存上下文
> /context save project-alpha
Context saved: project-alpha

# 切换上下文
> /context switch project-beta
Switched to: project-beta

# 合并上下文
> /context merge project-alpha project-beta
Contexts merged

# 清理上下文
> /context clean --keep-recent=5
Cleaned old contexts, kept 5 recent
```

### 2. 智能补全

```bash
# 启用智能补全
> /autocomplete on

# 使用Tab补全
> /use pyth<TAB>
> /use python-pro

# 命令建议
> 创建API
Suggested commands:
1. /use api-documenter
2. /use backend-architect
3. /template rest-api

# 代码片段
> /snippet
Available snippets:
- auth-jwt: JWT认证模板
- crud-api: CRUD API模板
- test-unit: 单元测试模板

> /snippet auth-jwt
[插入JWT认证代码模板]
```

### 3. 批处理命令

```bash
# 批量执行
> /batch
  /use python-pro
  创建用户模型
  /use test-automator
  为用户模型写测试
  /use api-documenter
  生成API文档
/endbatch

Executing batch commands...
✅ All commands executed

# 条件执行
> /if exists("requirements.txt")
    /use python-pro
  /else
    /use javascript-pro
  /endif
```

### 4. 模板系统

```bash
# 列出模板
> /templates
Available templates:
- web-app: Full stack web application
- rest-api: RESTful API
- microservice: Microservice
- cli-tool: Command line tool

# 使用模板
> /template web-app --name=MyApp --framework=react

Generating web-app template...
✅ Created:
- MyApp/
  ├── frontend/
  ├── backend/
  ├── database/
  └── docker-compose.yml

# 创建自定义模板
> /template create my-template
> /template add-file src/main.py
> /template add-command "npm install"
> /template save
Template 'my-template' saved
```

## 实时调试

### 1. 交互式调试

```bash
> /debug mode interactive
> /use debugger

# 设置断点
> /break app.py:45
Breakpoint set at app.py:45

# 运行到断点
> /run
Stopped at breakpoint app.py:45

# 检查变量
> /inspect user
user = {
  'id': 123,
  'name': 'Alice',
  'email': 'alice@example.com'
}

# 单步执行
> /step
Line 46: user_role = get_role(user['id'])

> /step
Line 47: if user_role == 'admin':

# 修改变量
> /set user_role = 'admin'
Variable updated

# 继续执行
> /continue
```

### 2. 实时日志分析

```bash
> /logs watch app.log

# 实时过滤
> /logs filter ERROR
[2024-01-10 10:23:45] ERROR: Database connection failed
[2024-01-10 10:24:12] ERROR: Invalid user token

# 日志分析
> /logs analyze --last=1h
Log Analysis (Last 1 hour):
- Total: 15,234 lines
- Errors: 45 (0.3%)
- Warnings: 234 (1.5%)
- Top error: "Connection timeout" (23 times)

# 智能建议
> /use error-detective
error-detective> 基于日志分析，主要问题是数据库连接池耗尽。
建议增加连接池大小或优化查询。
```

### 3. 性能分析

```bash
> /profile start
Profiling started...

# 执行操作
> /run process_data()

> /profile stop
Profiling complete

> /profile report
Performance Report:
┌─────────────────┬─────────┬─────────┐
│ Function        │ Time    │ Calls   │
├─────────────────┼─────────┼─────────┤
│ process_data    │ 2.34s   │ 1       │
│ └─ fetch_data   │ 1.89s   │ 100     │
│ └─ transform    │ 0.45s   │ 100     │
└─────────────────┴─────────┴─────────┘

Bottleneck: fetch_data (80% of time)
Suggestion: Implement batch fetching
```

## 最佳实践

### 1. 高效交互技巧

```bash
# 使用别名
> /alias pd python-pro + debugger
> /use pd  # 同时激活两个代理

# 命令历史
> /history search "create.*API"
Found:
- [10:23] create REST API
- [14:56] create GraphQL API

# 快捷键
Ctrl+R: 搜索历史
Ctrl+L: 清屏
Ctrl+D: 退出
Tab: 自动补全
```

### 2. 工作流优化

```bash
# 创建工作流
> /workflow create dev-cycle
> /workflow add-step "1. /use architect-review"
> /workflow add-step "2. Design system"
> /workflow add-step "3. /use python-pro"
> /workflow add-step "4. Implement"
> /workflow add-step "5. /use test-automator"
> /workflow add-step "6. Write tests"
> /workflow save

# 执行工作流
> /workflow run dev-cycle
Running workflow 'dev-cycle'...
Step 1/6: Activating architect-review...
```

### 3. 错误处理

```bash
# 错误时自动切换代理
> /on-error use debugger

# 设置重试
> /retry 3 times with delay 5s

# 错误日志
> /errors show --last=10
Recent errors:
1. [10:23] Command failed: /use unknown-agent
2. [10:45] Timeout: API request
...

# 错误恢复
> /recover from-checkpoint
Recovered to checkpoint: 2024-01-10 10:20:00
```

### 4. 性能优化

```bash
# 缓存响应
> /cache enable
Cache enabled for repeated queries

# 批量模式
> /batch-mode on
Commands will be batched for efficiency

# 并发执行
> /concurrent 3
Will run up to 3 operations concurrently

# 资源限制
> /limit memory=2GB cpu=50%
Resource limits set
```

## 交互式脚本示例

### 完整的交互式开发会话

```bash
#!/bin/bash
# interactive_session.sh

# 启动交互式会话
claude-code << 'SESSION'
# 初始化项目
/use architect-review
设计一个任务管理系统

# 等待设计完成
/wait

# 创建后端
/use python-pro
基于设计创建Flask后端

# 创建前端
/use frontend-developer
创建React前端

# 编写测试
/use test-automator
为所有功能编写测试

# 部署
/use deployment-engineer
创建Docker部署配置

# 生成文档
/use api-documenter
生成完整API文档

# 保存会话
/save task-manager-project

SESSION

echo "项目创建完成！"
```

## 故障排除

### 常见问题

1. **代理无响应**
```bash
> /status
Agent status: python-pro (not responding)

> /restart python-pro
Restarting agent...
✅ Agent restarted
```

2. **命令不识别**
```bash
> /diagnose
Checking system...
- Claude Code: ✅ Running
- Agents: ✅ 72 loaded
- Memory: ⚠️ 85% used
- Suggestion: Clear cache with /cache clear
```

3. **会话恢复**
```bash
> /recover last-session
Recovering session...
✅ Session restored
```

## 键盘快捷键参考

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+C` | 中断当前操作 |
| `Ctrl+D` | 退出会话 |
| `Ctrl+L` | 清屏 |
| `Ctrl+R` | 搜索历史 |
| `Ctrl+Z` | 撤销 |
| `Tab` | 自动补全 |
| `↑/↓` | 浏览历史 |
| `Ctrl+A` | 跳到行首 |
| `Ctrl+E` | 跳到行尾 |
| `Alt+B` | 后退一个词 |
| `Alt+F` | 前进一个词 |

## 相关资源

- [Claude Code文档](https://docs.anthropic.com/claude-code)
- [代理详细说明](./USAGE.md)
- [自动化指南](./AUTOMATION.md)
- [问题反馈](https://github.com/githubstudycloud/clagen/issues)