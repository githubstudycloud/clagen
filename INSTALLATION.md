# Claude Code Agents 安装文档

## 项目信息
- **源仓库**: https://github.com/wshobson/agents
- **目标仓库**: https://github.com/githubstudycloud/clagen
- **安装日期**: 2025-08-22
- **代理总数**: 72个

## 安装位置
- **Windows**: `%USERPROFILE%\AppData\Roaming\ClaudeCode\agents`
- **macOS/Linux**: `~/.config/ClaudeCode/agents`

## 安装过程

### 1. 环境准备
```bash
# 设置代理（如需要）
export http_proxy=http://192.168.0.254:80
export https_proxy=http://192.168.0.254:80

# 克隆源仓库
git clone https://github.com/wshobson/agents.git temp_agents_repo

# 初始化目标仓库
git init clagen
```

### 2. 自动安装脚本
使用 `install_agents.sh` 脚本自动安装所有代理：

```bash
bash install_agents.sh
```

脚本功能：
- 自动创建Claude Code agents目录
- 批量复制所有代理文件
- 跳过已存在的代理（避免重复）
- 生成详细的安装日志

### 3. 安装结果
- ✅ 成功安装: 72个代理
- ⏭️ 跳过安装: 0个（无重复）
- ❌ 安装失败: 0个

## 已安装的代理列表

### 编程语言专家 (18个)
- `c-pro` - C语言专家
- `cpp-pro` - C++专家
- `csharp-pro` - C#专家
- `elixir-pro` - Elixir专家
- `golang-pro` - Go语言专家
- `java-pro` - Java专家
- `javascript-pro` - JavaScript专家
- `php-pro` - PHP专家
- `python-pro` - Python专家
- `ruby-pro` - Ruby专家
- `rust-pro` - Rust专家
- `scala-pro` - Scala专家
- `sql-pro` - SQL专家
- `typescript-pro` - TypeScript专家

### 架构与设计 (7个)
- `architect-review` - 架构评审专家
- `backend-architect` - 后端架构师
- `cloud-architect` - 云架构师
- `docs-architect` - 文档架构师
- `graphql-architect` - GraphQL架构师
- `ui-ux-designer` - UI/UX设计师
- `seo-structure-architect` - SEO结构架构师

### 开发工具 (15个)
- `api-documenter` - API文档专家
- `code-reviewer` - 代码审查专家
- `context-manager` - 上下文管理器
- `debugger` - 调试专家
- `error-detective` - 错误侦探
- `legacy-modernizer` - 遗留代码现代化专家
- `mermaid-expert` - Mermaid图表专家
- `prompt-engineer` - 提示工程师
- `reference-builder` - 引用构建器
- `test-automator` - 测试自动化专家
- `tutorial-engineer` - 教程工程师
- `dx-optimizer` - 开发者体验优化师

### 数据与AI (6个)
- `ai-engineer` - AI工程师
- `data-engineer` - 数据工程师
- `data-scientist` - 数据科学家
- `ml-engineer` - 机器学习工程师
- `mlops-engineer` - MLOps工程师
- `quant-analyst` - 量化分析师

### 运维与部署 (8个)
- `database-admin` - 数据库管理员
- `database-optimizer` - 数据库优化专家
- `deployment-engineer` - 部署工程师
- `devops-troubleshooter` - DevOps故障排除专家
- `incident-responder` - 事故响应专家
- `network-engineer` - 网络工程师
- `performance-engineer` - 性能工程师
- `terraform-specialist` - Terraform专家

### 移动开发 (4个)
- `flutter-expert` - Flutter专家
- `ios-developer` - iOS开发者
- `mobile-developer` - 移动开发者
- `unity-developer` - Unity开发者

### SEO优化 (10个)
- `seo-authority-builder` - SEO权威构建器
- `seo-cannibalization-detector` - SEO内容冲突检测器
- `seo-content-auditor` - SEO内容审计师
- `seo-content-planner` - SEO内容规划师
- `seo-content-refresher` - SEO内容更新专家
- `seo-content-writer` - SEO内容写手
- `seo-keyword-strategist` - SEO关键词策略师
- `seo-meta-optimizer` - SEO元数据优化师
- `seo-snippet-hunter` - SEO片段猎手
- `seo-structure-architect` - SEO结构架构师

### 业务与支持 (9个)
- `business-analyst` - 业务分析师
- `content-marketer` - 内容营销专家
- `customer-support` - 客户支持专家
- `frontend-developer` - 前端开发者
- `hr-pro` - 人力资源专家
- `legal-advisor` - 法律顾问
- `payment-integration` - 支付集成专家
- `risk-manager` - 风险管理师
- `sales-automator` - 销售自动化专家

### 其他专业 (2个)
- `minecraft-bukkit-pro` - Minecraft Bukkit专家
- `search-specialist` - 搜索专家
- `security-auditor` - 安全审计师

## 文件结构
```
clagen/
├── install_agents.sh        # 自动安装脚本
├── installation.log         # 安装日志
├── INSTALLATION.md          # 安装文档（本文件）
├── USAGE.md                 # 使用说明
└── README.md                # 项目说明
```

## 验证安装
```bash
# 查看已安装的代理
ls "$HOME/AppData/Roaming/ClaudeCode/agents"

# 统计代理数量
ls "$HOME/AppData/Roaming/ClaudeCode/agents" | wc -l
```

## 故障排除

### 常见问题

1. **找不到agents目录**
   - Windows: 确保路径 `%USERPROFILE%\AppData\Roaming\ClaudeCode\agents` 存在
   - macOS/Linux: 确保路径 `~/.config/ClaudeCode/agents` 存在

2. **网络连接问题**
   - 设置代理: `export http_proxy=http://your-proxy:port`
   - 或使用VPN连接

3. **权限问题**
   - Windows: 以管理员身份运行
   - macOS/Linux: 使用 `sudo` 如需要

## 更新记录
- 2025-08-22: 初次安装，共72个代理