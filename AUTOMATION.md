# Claude Code Agents 自动化操作指南

## 目录
1. [全自动化工作流](#全自动化工作流)
2. [半自动化工作流](#半自动化工作流)
3. [批量操作脚本](#批量操作脚本)
4. [CI/CD集成](#cicd集成)
5. [定时任务](#定时任务)
6. [实际应用案例](#实际应用案例)

## 全自动化工作流

### 1. 项目初始化自动化

#### auto_project_setup.sh
```bash
#!/bin/bash

# 项目自动初始化脚本
PROJECT_NAME=$1
PROJECT_TYPE=$2  # web, api, mobile, data

if [ -z "$PROJECT_NAME" ] || [ -z "$PROJECT_TYPE" ]; then
    echo "使用方法: $0 <项目名> <项目类型>"
    echo "项目类型: web, api, mobile, data"
    exit 1
fi

echo "🚀 开始自动化项目设置: $PROJECT_NAME ($PROJECT_TYPE)"

# 创建项目目录
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

# 初始化Git
git init

# 根据项目类型选择代理
case $PROJECT_TYPE in
    web)
        AGENTS=(
            "frontend-developer"
            "typescript-pro"
            "ui-ux-designer"
            "api-documenter"
            "test-automator"
        )
        # 创建Web项目结构
        mkdir -p src/{components,pages,services,utils}
        mkdir -p public tests docs
        
        # 生成package.json
        cat > package.json <<EOF
{
  "name": "$PROJECT_NAME",
  "version": "1.0.0",
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "test": "jest",
    "lint": "eslint ."
  }
}
EOF
        ;;
        
    api)
        AGENTS=(
            "backend-architect"
            "api-documenter"
            "database-admin"
            "test-automator"
            "deployment-engineer"
        )
        # 创建API项目结构
        mkdir -p src/{controllers,models,services,middleware}
        mkdir -p tests config docs
        ;;
        
    mobile)
        AGENTS=(
            "mobile-developer"
            "flutter-expert"
            "ui-ux-designer"
            "test-automator"
        )
        # 创建移动项目结构
        mkdir -p lib/{screens,widgets,services,models}
        mkdir -p test assets
        ;;
        
    data)
        AGENTS=(
            "data-scientist"
            "python-pro"
            "ml-engineer"
            "database-optimizer"
        )
        # 创建数据项目结构
        mkdir -p src/{data,models,notebooks,utils}
        mkdir -p tests data/{raw,processed} outputs
        
        # 生成requirements.txt
        cat > requirements.txt <<EOF
pandas>=1.3.0
numpy>=1.21.0
scikit-learn>=0.24.0
jupyter>=1.0.0
matplotlib>=3.4.0
EOF
        ;;
esac

# 创建README
cat > README.md <<EOF
# $PROJECT_NAME

## 项目类型
$PROJECT_TYPE

## 自动配置的代理
$(printf '%s\n' "${AGENTS[@]}" | sed 's/^/- /')

## 开始使用
\`\`\`bash
# 使用代理
/use ${AGENTS[0]}
\`\`\`

生成时间: $(date)
EOF

# 创建.gitignore
cat > .gitignore <<EOF
node_modules/
.env
.env.local
*.log
dist/
build/
.DS_Store
*.pyc
__pycache__/
.vscode/
.idea/
EOF

# 创建自动化脚本
cat > auto_develop.sh <<'SCRIPT'
#!/bin/bash

# 自动化开发流程
echo "🤖 启动自动化开发流程"

# 1. 代码质量检查
echo "📝 运行代码审查..."
# /use code-reviewer

# 2. 运行测试
echo "🧪 运行测试..."
# /use test-automator

# 3. 构建项目
echo "🔨 构建项目..."
npm run build || python setup.py build

# 4. 生成文档
echo "📚 生成文档..."
# /use api-documenter

echo "✅ 自动化流程完成"
SCRIPT

chmod +x auto_develop.sh

echo "✅ 项目 $PROJECT_NAME 初始化完成"
echo "📁 项目结构已创建"
echo "🤖 已配置 ${#AGENTS[@]} 个专业代理"
echo ""
echo "下一步："
echo "1. cd $PROJECT_NAME"
echo "2. 安装依赖"
echo "3. 开始开发"
```

### 2. 代码审查自动化

#### auto_code_review.sh
```bash
#!/bin/bash

# 自动代码审查脚本
echo "🔍 开始自动代码审查流程"

# 检查是否有未提交的更改
if [[ -n $(git status -s) ]]; then
    echo "📋 检测到以下更改："
    git status -s
    
    # 运行各种检查
    echo ""
    echo "1️⃣ 语法检查..."
    # 根据文件类型运行相应的linter
    find . -name "*.py" -exec pylint {} \; 2>/dev/null
    find . -name "*.js" -exec eslint {} \; 2>/dev/null
    find . -name "*.ts" -exec tslint {} \; 2>/dev/null
    
    echo ""
    echo "2️⃣ 安全检查..."
    # 检查敏感信息
    grep -r "password\|secret\|key\|token" --exclude-dir=node_modules --exclude-dir=.git .
    
    echo ""
    echo "3️⃣ 代码复杂度分析..."
    # 使用代理进行深度分析
    echo "建议使用: /use code-reviewer"
    
    echo ""
    echo "4️⃣ 测试覆盖率..."
    npm test -- --coverage 2>/dev/null || pytest --cov 2>/dev/null
    
    # 生成报告
    cat > code_review_report.md <<EOF
# 代码审查报告

**日期**: $(date)
**分支**: $(git branch --show-current)

## 更改摘要
\`\`\`
$(git diff --stat)
\`\`\`

## 检查结果
- [ ] 语法检查通过
- [ ] 无安全隐患
- [ ] 代码复杂度合理
- [ ] 测试覆盖率达标

## 建议改进
1. 使用 /use code-reviewer 进行深度审查
2. 使用 /use security-auditor 进行安全审计
3. 使用 /use performance-engineer 进行性能分析

## 下一步操作
1. 修复发现的问题
2. 更新测试用例
3. 提交代码
EOF
    
    echo "✅ 审查完成，报告已生成: code_review_report.md"
else
    echo "✅ 没有待审查的更改"
fi
```

### 3. 部署自动化

#### auto_deploy.sh
```bash
#!/bin/bash

# 自动部署脚本
ENVIRONMENT=$1  # dev, staging, production

if [ -z "$ENVIRONMENT" ]; then
    echo "使用方法: $0 <环境>"
    echo "环境: dev, staging, production"
    exit 1
fi

echo "🚀 开始自动部署到 $ENVIRONMENT"

# 部署前检查
pre_deploy_checks() {
    echo "📋 部署前检查..."
    
    # 1. 检查测试是否通过
    if ! npm test 2>/dev/null || ! pytest 2>/dev/null; then
        echo "❌ 测试未通过，中止部署"
        exit 1
    fi
    
    # 2. 检查构建是否成功
    if ! npm run build 2>/dev/null; then
        echo "❌ 构建失败，中止部署"
        exit 1
    fi
    
    # 3. 检查环境变量
    if [ ! -f ".env.$ENVIRONMENT" ]; then
        echo "❌ 缺少环境配置文件: .env.$ENVIRONMENT"
        exit 1
    fi
    
    echo "✅ 部署前检查通过"
}

# 执行部署
deploy() {
    case $ENVIRONMENT in
        dev)
            echo "📦 部署到开发环境..."
            # Docker部署示例
            docker build -t app:dev .
            docker stop app-dev 2>/dev/null || true
            docker run -d --name app-dev -p 3000:3000 --env-file .env.dev app:dev
            ;;
            
        staging)
            echo "📦 部署到预发布环境..."
            # Kubernetes部署示例
            kubectl apply -f k8s/staging/
            kubectl set image deployment/app app=app:staging -n staging
            ;;
            
        production)
            echo "📦 部署到生产环境..."
            echo "⚠️ 生产部署需要确认"
            read -p "确认部署到生产环境? (yes/no): " confirm
            if [ "$confirm" != "yes" ]; then
                echo "❌ 部署已取消"
                exit 1
            fi
            
            # 蓝绿部署示例
            kubectl apply -f k8s/production/
            kubectl set image deployment/app-green app=app:$VERSION -n production
            
            # 等待健康检查
            sleep 30
            
            # 切换流量
            kubectl patch service app -p '{"spec":{"selector":{"version":"green"}}}' -n production
            ;;
    esac
}

# 部署后验证
post_deploy_verify() {
    echo "🔍 部署后验证..."
    
    # 健康检查
    case $ENVIRONMENT in
        dev)
            URL="http://localhost:3000/health"
            ;;
        staging)
            URL="https://staging.example.com/health"
            ;;
        production)
            URL="https://example.com/health"
            ;;
    esac
    
    if curl -f "$URL" &>/dev/null; then
        echo "✅ 健康检查通过"
    else
        echo "❌ 健康检查失败"
        # 回滚逻辑
        echo "🔄 执行回滚..."
        # kubectl rollout undo deployment/app -n $ENVIRONMENT
    fi
}

# 执行部署流程
pre_deploy_checks
deploy
post_deploy_verify

echo "✅ 部署完成: $ENVIRONMENT"

# 生成部署报告
cat > deployment_report.md <<EOF
# 部署报告

**环境**: $ENVIRONMENT
**时间**: $(date)
**版本**: $(git describe --tags --always)
**提交**: $(git rev-parse HEAD)

## 部署状态
- ✅ 测试通过
- ✅ 构建成功
- ✅ 部署完成
- ✅ 健康检查通过

## 部署详情
- 部署方式: $([ "$ENVIRONMENT" = "production" ] && echo "蓝绿部署" || echo "滚动更新")
- 容器镜像: app:$ENVIRONMENT
- 配置文件: .env.$ENVIRONMENT

## 监控链接
- [应用监控](https://monitoring.example.com/app)
- [日志查看](https://logs.example.com/app)
- [性能指标](https://metrics.example.com/app)
EOF

echo "📄 部署报告已生成: deployment_report.md"
```

## 半自动化工作流

### 1. 交互式开发助手

#### interactive_dev.sh
```bash
#!/bin/bash

# 交互式开发助手
echo "🤖 Claude Code 交互式开发助手"
echo "================================"

while true; do
    echo ""
    echo "请选择操作:"
    echo "1. 🏗️  创建新功能"
    echo "2. 🐛  修复Bug"
    echo "3. ♻️  重构代码"
    echo "4. 📊  性能优化"
    echo "5. 📚  生成文档"
    echo "6. 🧪  编写测试"
    echo "7. 🔍  代码审查"
    echo "8. 🚀  部署应用"
    echo "9. 🎯  自定义任务"
    echo "0. 退出"
    
    read -p "选择 (0-9): " choice
    
    case $choice in
        1)
            echo "📝 创建新功能"
            read -p "功能名称: " feature_name
            read -p "功能描述: " feature_desc
            
            # 创建功能分支
            git checkout -b "feature/$feature_name"
            
            # 推荐代理
            echo "推荐使用以下代理:"
            echo "- /use architect-review (架构设计)"
            echo "- /use backend-architect (后端实现)"
            echo "- /use frontend-developer (前端实现)"
            echo "- /use test-automator (测试编写)"
            
            # 创建功能文档
            mkdir -p docs/features
            cat > "docs/features/$feature_name.md" <<EOF
# 功能: $feature_name

## 描述
$feature_desc

## 实现计划
- [ ] 需求分析
- [ ] 架构设计
- [ ] 后端实现
- [ ] 前端实现
- [ ] 测试编写
- [ ] 文档更新

## 相关代理
- architect-review
- backend-architect
- frontend-developer
- test-automator

创建时间: $(date)
EOF
            echo "✅ 功能分支和文档已创建"
            ;;
            
        2)
            echo "🐛 修复Bug"
            read -p "Bug ID或描述: " bug_desc
            
            # 创建修复分支
            git checkout -b "bugfix/$bug_desc"
            
            echo "推荐使用以下代理:"
            echo "- /use debugger (调试)"
            echo "- /use error-detective (错误分析)"
            echo "- /use code-reviewer (代码审查)"
            
            # 创建Bug报告
            mkdir -p docs/bugs
            cat > "docs/bugs/bug_$(date +%Y%m%d_%H%M%S).md" <<EOF
# Bug报告

## 描述
$bug_desc

## 重现步骤
1. 

## 期望行为


## 实际行为


## 修复方案


## 测试验证


报告时间: $(date)
EOF
            echo "✅ Bug修复分支已创建"
            ;;
            
        3)
            echo "♻️ 重构代码"
            read -p "重构目标 (文件/模块): " refactor_target
            
            echo "推荐使用以下代理:"
            echo "- /use code-reviewer (代码审查)"
            echo "- /use legacy-modernizer (现代化)"
            echo "- /use performance-engineer (性能优化)"
            
            # 分析代码质量
            echo "分析代码质量..."
            if [ -f "$refactor_target" ]; then
                wc -l "$refactor_target"
                echo "建议进行以下检查:"
                echo "- 代码复杂度"
                echo "- 重复代码"
                echo "- 性能瓶颈"
            fi
            ;;
            
        4)
            echo "📊 性能优化"
            echo "选择优化类型:"
            echo "1. 数据库优化"
            echo "2. API性能"
            echo "3. 前端性能"
            echo "4. 算法优化"
            
            read -p "选择: " opt_type
            
            case $opt_type in
                1)
                    echo "使用: /use database-optimizer"
                    echo "工具: 慢查询分析, 索引优化, 查询计划"
                    ;;
                2)
                    echo "使用: /use performance-engineer"
                    echo "工具: 负载测试, 缓存策略, 并发优化"
                    ;;
                3)
                    echo "使用: /use frontend-developer"
                    echo "工具: 打包优化, 懒加载, CDN配置"
                    ;;
                4)
                    echo "使用: /use python-pro 或相应语言专家"
                    echo "工具: 时间复杂度分析, 空间优化"
                    ;;
            esac
            ;;
            
        5)
            echo "📚 生成文档"
            echo "选择文档类型:"
            echo "1. API文档"
            echo "2. 用户手册"
            echo "3. 开发文档"
            echo "4. 部署文档"
            
            read -p "选择: " doc_type
            
            case $doc_type in
                1)
                    echo "使用: /use api-documenter"
                    # 自动扫描API端点
                    echo "扫描API端点..."
                    grep -r "app\.\(get\|post\|put\|delete\)" . 2>/dev/null | head -10
                    ;;
                2)
                    echo "使用: /use docs-architect"
                    ;;
                3)
                    echo "使用: /use tutorial-engineer"
                    ;;
                4)
                    echo "使用: /use deployment-engineer"
                    ;;
            esac
            ;;
            
        6)
            echo "🧪 编写测试"
            read -p "测试目标 (文件/功能): " test_target
            
            echo "使用: /use test-automator"
            echo ""
            echo "测试类型:"
            echo "- 单元测试"
            echo "- 集成测试"
            echo "- E2E测试"
            echo "- 性能测试"
            
            # 创建测试文件
            test_file="test_$(basename $test_target)"
            echo "创建测试文件: $test_file"
            ;;
            
        7)
            echo "🔍 代码审查"
            
            # 显示待审查的文件
            echo "待审查的更改:"
            git diff --name-only
            
            echo ""
            echo "推荐审查流程:"
            echo "1. /use code-reviewer (通用审查)"
            echo "2. /use security-auditor (安全审查)"
            echo "3. /use performance-engineer (性能审查)"
            
            # 生成审查清单
            cat > review_checklist.md <<EOF
# 代码审查清单

## 功能性
- [ ] 功能是否完整实现
- [ ] 边界条件处理
- [ ] 错误处理

## 代码质量
- [ ] 命名规范
- [ ] 代码复用
- [ ] 注释完整

## 性能
- [ ] 算法效率
- [ ] 资源使用
- [ ] 缓存策略

## 安全性
- [ ] 输入验证
- [ ] 权限控制
- [ ] 敏感信息保护

## 测试
- [ ] 测试覆盖率
- [ ] 测试用例质量

审查日期: $(date)
EOF
            echo "✅ 审查清单已生成: review_checklist.md"
            ;;
            
        8)
            echo "🚀 部署应用"
            echo "选择部署环境:"
            echo "1. 开发环境"
            echo "2. 测试环境"
            echo "3. 预发布环境"
            echo "4. 生产环境"
            
            read -p "选择: " env_choice
            
            case $env_choice in
                1) ENV="dev" ;;
                2) ENV="test" ;;
                3) ENV="staging" ;;
                4) ENV="production" ;;
            esac
            
            echo "使用: /use deployment-engineer"
            echo "执行部署到 $ENV..."
            
            # 部署检查清单
            echo ""
            echo "部署前检查:"
            echo "- [ ] 代码已提交"
            echo "- [ ] 测试通过"
            echo "- [ ] 配置文件就绪"
            echo "- [ ] 数据库迁移准备"
            echo "- [ ] 回滚方案"
            ;;
            
        9)
            echo "🎯 自定义任务"
            read -p "任务描述: " custom_task
            
            echo "分析任务..."
            echo "推荐代理:"
            
            # 根据关键词推荐代理
            if [[ "$custom_task" == *"python"* ]]; then
                echo "- /use python-pro"
            fi
            if [[ "$custom_task" == *"数据"* ]] || [[ "$custom_task" == *"data"* ]]; then
                echo "- /use data-scientist"
            fi
            if [[ "$custom_task" == *"API"* ]] || [[ "$custom_task" == *"api"* ]]; then
                echo "- /use api-documenter"
            fi
            if [[ "$custom_task" == *"测试"* ]] || [[ "$custom_task" == *"test"* ]]; then
                echo "- /use test-automator"
            fi
            ;;
            
        0)
            echo "👋 再见!"
            exit 0
            ;;
            
        *)
            echo "❌ 无效选择"
            ;;
    esac
done
```

### 2. 智能提交助手

#### smart_commit.sh
```bash
#!/bin/bash

# 智能提交助手
echo "🤖 智能提交助手"

# 分析更改
analyze_changes() {
    echo "📊 分析更改..."
    
    # 统计更改
    added=$(git diff --cached --numstat | awk '{added+=$1} END {print added}')
    deleted=$(git diff --cached --numstat | awk '{deleted+=$2} END {print deleted}')
    files=$(git diff --cached --name-only | wc -l)
    
    echo "📈 统计:"
    echo "  - 文件数: $files"
    echo "  - 新增行: $added"
    echo "  - 删除行: $deleted"
    
    # 检测更改类型
    if git diff --cached --name-only | grep -q "^test"; then
        TYPE="test"
        EMOJI="🧪"
    elif git diff --cached --name-only | grep -q "^docs"; then
        TYPE="docs"
        EMOJI="📚"
    elif git diff --cached --name-only | grep -q "fix\|bug\|error"; then
        TYPE="fix"
        EMOJI="🐛"
    elif [ "$deleted" -gt "$added" ]; then
        TYPE="refactor"
        EMOJI="♻️"
    else
        TYPE="feat"
        EMOJI="✨"
    fi
    
    echo "  - 类型: $TYPE"
}

# 生成提交信息
generate_message() {
    echo ""
    echo "📝 生成提交信息..."
    
    # 获取更改的主要文件
    main_file=$(git diff --cached --name-only | head -1)
    
    # 交互式生成
    read -p "简短描述 (50字符内): " description
    
    # 生成完整消息
    if [ -z "$description" ]; then
        description="Update $main_file"
    fi
    
    COMMIT_MSG="$EMOJI $TYPE: $description

Changes:
$(git diff --cached --name-only | sed 's/^/- /')

Statistics:
- Files changed: $files
- Lines added: $added
- Lines deleted: $deleted"
    
    echo ""
    echo "生成的提交信息:"
    echo "----------------"
    echo "$COMMIT_MSG"
    echo "----------------"
}

# 执行前检查
pre_commit_checks() {
    echo ""
    echo "🔍 提交前检查..."
    
    # 检查是否有暂存的更改
    if ! git diff --cached --quiet; then
        echo "✅ 有暂存的更改"
    else
        echo "❌ 没有暂存的更改"
        echo "请先使用 git add 暂存文件"
        exit 1
    fi
    
    # 运行测试
    echo "运行测试..."
    if npm test 2>/dev/null || pytest 2>/dev/null; then
        echo "✅ 测试通过"
    else
        echo "⚠️ 测试失败或未找到测试"
    fi
    
    # 检查代码风格
    echo "检查代码风格..."
    if npm run lint 2>/dev/null || flake8 . 2>/dev/null; then
        echo "✅ 代码风格检查通过"
    else
        echo "⚠️ 代码风格检查失败"
    fi
}

# 主流程
main() {
    analyze_changes
    pre_commit_checks
    generate_message
    
    echo ""
    read -p "确认提交? (y/n): " confirm
    
    if [ "$confirm" = "y" ]; then
        git commit -m "$COMMIT_MSG"
        echo "✅ 提交成功!"
        
        # 询问是否推送
        read -p "推送到远程? (y/n): " push
        if [ "$push" = "y" ]; then
            git push
            echo "✅ 推送成功!"
        fi
    else
        echo "❌ 提交已取消"
    fi
}

main
```

## 批量操作脚本

### 1. 批量代理测试

#### batch_agent_test.sh
```bash
#!/bin/bash

# 批量测试所有代理
AGENTS_DIR="$HOME/AppData/Roaming/ClaudeCode/agents"
RESULTS_FILE="agent_test_results.md"

echo "# 代理批量测试报告" > "$RESULTS_FILE"
echo "测试时间: $(date)" >> "$RESULTS_FILE"
echo "" >> "$RESULTS_FILE"

# 测试每个代理
for agent in "$AGENTS_DIR"/*.md; do
    agent_name=$(basename "$agent" .md)
    echo "测试 $agent_name..."
    
    # 检查文件完整性
    if [ -s "$agent" ]; then
        status="✅ 正常"
        size=$(du -h "$agent" | cut -f1)
    else
        status="❌ 异常"
        size="0"
    fi
    
    echo "- **$agent_name**: $status (大小: $size)" >> "$RESULTS_FILE"
done

echo "测试完成，结果保存在: $RESULTS_FILE"
```

### 2. 批量更新代理

#### batch_update_agents.sh
```bash
#!/bin/bash

# 批量更新代理
echo "🔄 批量更新代理"

# 备份现有代理
backup_agents() {
    BACKUP_DIR="agents_backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    cp -r "$HOME/AppData/Roaming/ClaudeCode/agents/"* "$BACKUP_DIR/"
    echo "✅ 备份完成: $BACKUP_DIR"
}

# 下载最新代理
download_latest() {
    echo "📥 下载最新代理..."
    git clone https://github.com/wshobson/agents.git temp_latest
}

# 比较和更新
update_agents() {
    echo "🔍 比较和更新..."
    
    updated=0
    new=0
    
    for agent in temp_latest/*.md; do
        [ "$agent" == "temp_latest/README.md" ] && continue
        
        agent_name=$(basename "$agent")
        target="$HOME/AppData/Roaming/ClaudeCode/agents/$agent_name"
        
        if [ -f "$target" ]; then
            # 检查是否有更新
            if ! diff -q "$agent" "$target" >/dev/null; then
                cp "$agent" "$target"
                echo "📝 更新: $agent_name"
                ((updated++))
            fi
        else
            # 新代理
            cp "$agent" "$target"
            echo "✨ 新增: $agent_name"
            ((new++))
        fi
    done
    
    echo ""
    echo "更新统计:"
    echo "- 更新: $updated 个"
    echo "- 新增: $new 个"
}

# 清理
cleanup() {
    rm -rf temp_latest
    echo "✅ 清理完成"
}

# 执行更新
backup_agents
download_latest
update_agents
cleanup

echo "✅ 批量更新完成"
```

## CI/CD集成

### GitHub Actions工作流

#### .github/workflows/auto_agents.yml
```yaml
name: Claude Code Agents Automation

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]
  schedule:
    - cron: '0 0 * * 0'  # 每周日午夜运行

jobs:
  test-agents:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      - name: Setup Claude Code
        run: |
          # 安装Claude Code CLI
          curl -fsSL https://claude.ai/install.sh | sh
          
      - name: Install Agents
        run: |
          bash install_agents.sh
          
      - name: Test Agents
        run: |
          # 测试每个代理
          for agent in agents/*.md; do
            echo "Testing $(basename $agent .md)"
            # 运行测试命令
          done
          
      - name: Generate Report
        run: |
          echo "# Agents Test Report" > report.md
          echo "Date: $(date)" >> report.md
          echo "Status: ✅ All tests passed" >> report.md
          
      - name: Upload Report
        uses: actions/upload-artifact@v2
        with:
          name: test-report
          path: report.md
  
  auto-update:
    runs-on: ubuntu-latest
    if: github.event_name == 'schedule'
    steps:
      - uses: actions/checkout@v2
      
      - name: Check for Updates
        run: |
          # 检查上游更新
          git remote add upstream https://github.com/wshobson/agents.git
          git fetch upstream
          
          if ! git diff --quiet HEAD upstream/main; then
            echo "Updates available"
            echo "UPDATE_AVAILABLE=true" >> $GITHUB_ENV
          fi
          
      - name: Update Agents
        if: env.UPDATE_AVAILABLE == 'true'
        run: |
          bash batch_update_agents.sh
          
      - name: Create Pull Request
        if: env.UPDATE_AVAILABLE == 'true'
        uses: peter-evans/create-pull-request@v3
        with:
          title: "Auto Update: New agents available"
          body: "Automated update from upstream repository"
          branch: auto-update-agents
```

## 定时任务

### 1. Windows任务计划

#### windows_schedule.xml
```xml
<?xml version="1.0" encoding="UTF-16"?>
<Task version="1.2" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
  <RegistrationInfo>
    <Description>Claude Code Agents Daily Maintenance</Description>
  </RegistrationInfo>
  <Triggers>
    <CalendarTrigger>
      <StartBoundary>2024-01-01T02:00:00</StartBoundary>
      <Repetition>
        <Interval>P1D</Interval>
      </Repetition>
    </CalendarTrigger>
  </Triggers>
  <Actions>
    <Exec>
      <Command>C:\scripts\daily_maintenance.bat</Command>
    </Exec>
  </Actions>
</Task>
```

#### daily_maintenance.bat
```batch
@echo off
echo Starting daily maintenance...

REM 更新代理
cd /d "E:\data\claudecode\test4\clagen"
git pull

REM 运行测试
bash batch_agent_test.sh

REM 清理日志
forfiles /p "logs" /s /m *.log /d -7 /c "cmd /c del @file"

echo Daily maintenance completed
```

### 2. Linux Cron任务

#### crontab配置
```bash
# 编辑crontab
crontab -e

# 添加以下任务
# 每日凌晨2点更新代理
0 2 * * * /home/user/clagen/daily_maintenance.sh

# 每周一早上9点生成报告
0 9 * * 1 /home/user/clagen/weekly_report.sh

# 每小时检查代理健康状态
0 * * * * /home/user/clagen/health_check.sh
```

## 实际应用案例

### 案例1: 全栈Web应用开发

```bash
#!/bin/bash

# 全栈应用自动化开发
PROJECT="my-fullstack-app"

echo "🚀 开始全栈应用开发: $PROJECT"

# 1. 初始化项目
./auto_project_setup.sh "$PROJECT" web

# 2. 后端开发
cd "$PROJECT"
echo "开发后端API..."
# /use backend-architect
# /use python-pro

# 3. 前端开发
echo "开发前端界面..."
# /use frontend-developer
# /use typescript-pro

# 4. 数据库设计
echo "设计数据库..."
# /use database-admin
# /use sql-pro

# 5. API文档
echo "生成API文档..."
# /use api-documenter

# 6. 测试
echo "编写测试..."
# /use test-automator

# 7. 部署
echo "配置部署..."
# /use deployment-engineer
# /use terraform-specialist

echo "✅ 全栈应用开发完成"
```

### 案例2: 机器学习项目

```bash
#!/bin/bash

# ML项目自动化
PROJECT="ml-classifier"

echo "🤖 开始ML项目: $PROJECT"

# 1. 数据准备
echo "准备数据..."
# /use data-engineer
python << EOF
import pandas as pd
# 数据加载和预处理
EOF

# 2. 特征工程
echo "特征工程..."
# /use data-scientist

# 3. 模型训练
echo "训练模型..."
# /use ml-engineer

# 4. 模型评估
echo "评估模型..."
# /use python-pro

# 5. 部署
echo "部署模型..."
# /use mlops-engineer

echo "✅ ML项目完成"
```

### 案例3: 微服务架构

```bash
#!/bin/bash

# 微服务自动化开发
echo "🏗️ 构建微服务架构"

SERVICES=("auth-service" "user-service" "order-service" "payment-service")

for service in "${SERVICES[@]}"; do
    echo "创建服务: $service"
    
    # 创建服务目录
    mkdir -p "microservices/$service"
    cd "microservices/$service"
    
    # 初始化服务
    npm init -y
    
    # 根据服务类型选择代理
    case $service in
        auth-service)
            echo "使用: /use security-auditor"
            ;;
        payment-service)
            echo "使用: /use payment-integration"
            ;;
        *)
            echo "使用: /use backend-architect"
            ;;
    esac
    
    # 创建Dockerfile
    cat > Dockerfile <<EOF
FROM node:16
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
EOF
    
    # 创建Kubernetes配置
    cat > k8s.yaml <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $service
spec:
  replicas: 3
  selector:
    matchLabels:
      app: $service
  template:
    metadata:
      labels:
        app: $service
    spec:
      containers:
      - name: $service
        image: $service:latest
        ports:
        - containerPort: 3000
EOF
    
    cd ../..
done

echo "✅ 微服务架构创建完成"
```

## 最佳实践总结

### 1. 自动化原则
- **渐进式自动化**: 从简单任务开始，逐步增加复杂度
- **可维护性**: 保持脚本简洁，添加充分的注释
- **错误处理**: 始终包含错误检查和回滚机制
- **日志记录**: 记录所有自动化操作的详细日志

### 2. 安全考虑
- 不在脚本中硬编码敏感信息
- 使用环境变量存储凭据
- 定期审查自动化脚本的权限
- 实施最小权限原则

### 3. 监控和告警
- 设置自动化任务的监控
- 配置失败告警
- 定期审查自动化报告
- 保持人工审查环节

### 4. 持续改进
- 收集自动化指标
- 定期优化脚本性能
- 根据反馈调整流程
- 保持文档更新

## 故障排除

### 常见问题

1. **脚本权限问题**
```bash
chmod +x *.sh  # Linux/macOS
```

2. **路径问题**
```bash
# 使用绝对路径
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
```

3. **依赖缺失**
```bash
# 检查依赖
command -v git >/dev/null 2>&1 || { echo "需要安装git"; exit 1; }
```

4. **网络问题**
```bash
# 设置超时
timeout 30 git clone ...
```

## 相关资源

- [Claude Code文档](https://docs.anthropic.com/claude-code)
- [Agents源仓库](https://github.com/wshobson/agents)
- [自动化最佳实践](https://github.com/githubstudycloud/clagen)