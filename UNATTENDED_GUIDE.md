# Claude Code Agents 无人值守自动化指南

## 目录
1. [概述](#概述)
2. [环境准备](#环境准备)
3. [自动化脚本](#自动化脚本)
4. [定时任务](#定时任务)
5. [CI/CD集成](#cicd集成)
6. [监控与告警](#监控与告警)
7. [错误处理](#错误处理)
8. [安全配置](#安全配置)
9. [实战案例](#实战案例)

## 概述

无人值守自动化允许Claude Code Agents在没有人工干预的情况下自动执行任务。适用于：
- 定时构建和部署
- 自动化测试
- 代码质量检查
- 系统监控和维护
- 批量数据处理

## 环境准备

### 1. 系统配置

```bash
# 创建专用用户
sudo useradd -m -s /bin/bash claudebot
sudo usermod -aG docker claudebot

# 设置环境变量
cat >> /home/claudebot/.bashrc << 'EOF'
export CLAUDE_HOME=/home/claudebot/claude
export CLAUDE_AGENTS_DIR=$CLAUDE_HOME/agents
export CLAUDE_LOGS_DIR=$CLAUDE_HOME/logs
export CLAUDE_WORK_DIR=$CLAUDE_HOME/workspace
export CLAUDE_CONFIG=$CLAUDE_HOME/config.json
EOF

# 创建目录结构
mkdir -p $CLAUDE_HOME/{agents,logs,workspace,scripts,config}
```

### 2. Claude Code配置

```json
// $CLAUDE_HOME/config.json
{
  "mode": "unattended",
  "log_level": "INFO",
  "max_retries": 3,
  "timeout": 3600,
  "parallel_jobs": 4,
  "auto_cleanup": true,
  "notification": {
    "email": "admin@example.com",
    "slack_webhook": "https://hooks.slack.com/services/xxx",
    "on_error": true,
    "on_success": false
  },
  "agents": {
    "auto_load": true,
    "path": "/home/claudebot/claude/agents"
  }
}
```

### 3. 认证配置

```bash
# 创建API密钥文件
cat > $CLAUDE_HOME/.credentials << EOF
CLAUDE_API_KEY=your-api-key-here
GITHUB_TOKEN=ghp_xxxxxxxxxxxxx
DOCKER_REGISTRY_PASSWORD=xxxxx
AWS_ACCESS_KEY_ID=xxxxx
AWS_SECRET_ACCESS_KEY=xxxxx
EOF

# 设置权限
chmod 600 $CLAUDE_HOME/.credentials
chown claudebot:claudebot $CLAUDE_HOME/.credentials
```

## 自动化脚本

### 1. 基础自动化框架

```python
#!/usr/bin/env python3
# unattended_runner.py

import os
import sys
import json
import logging
import subprocess
from datetime import datetime
from typing import List, Dict, Any

class ClaudeAutomation:
    def __init__(self, config_file: str):
        self.config = self.load_config(config_file)
        self.setup_logging()
        self.agents = {}
        
    def load_config(self, config_file: str) -> Dict:
        with open(config_file, 'r') as f:
            return json.load(f)
    
    def setup_logging(self):
        log_file = f"{self.config['log_dir']}/automation_{datetime.now():%Y%m%d}.log"
        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
            handlers=[
                logging.FileHandler(log_file),
                logging.StreamHandler()
            ]
        )
        self.logger = logging.getLogger(__name__)
    
    def execute_agent(self, agent: str, task: str) -> Dict[str, Any]:
        """执行代理任务"""
        self.logger.info(f"Executing {agent}: {task}")
        
        try:
            cmd = f"claude-code --agent {agent} --task '{task}' --non-interactive"
            result = subprocess.run(
                cmd,
                shell=True,
                capture_output=True,
                text=True,
                timeout=self.config.get('timeout', 3600)
            )
            
            return {
                'success': result.returncode == 0,
                'output': result.stdout,
                'error': result.stderr,
                'agent': agent,
                'task': task,
                'timestamp': datetime.now().isoformat()
            }
        except subprocess.TimeoutExpired:
            self.logger.error(f"Timeout executing {agent}")
            return {'success': False, 'error': 'Timeout'}
        except Exception as e:
            self.logger.error(f"Error executing {agent}: {e}")
            return {'success': False, 'error': str(e)}
    
    def run_workflow(self, workflow: List[Dict]) -> List[Dict]:
        """运行工作流"""
        results = []
        
        for step in workflow:
            agent = step['agent']
            task = step['task']
            
            # 检查依赖
            if 'depends_on' in step:
                dep_idx = step['depends_on']
                if not results[dep_idx]['success']:
                    self.logger.warning(f"Skipping {agent} due to failed dependency")
                    continue
            
            # 执行任务
            result = self.execute_agent(agent, task)
            results.append(result)
            
            # 检查是否继续
            if not result['success'] and step.get('critical', False):
                self.logger.error(f"Critical task failed: {agent}")
                break
        
        return results
    
    def notify(self, message: str, level: str = 'INFO'):
        """发送通知"""
        if self.config.get('notification', {}).get('enabled', False):
            # Slack通知
            if webhook := self.config['notification'].get('slack_webhook'):
                import requests
                requests.post(webhook, json={'text': message})
            
            # 邮件通知
            if email := self.config['notification'].get('email'):
                self.send_email(email, message)
    
    def send_email(self, to: str, message: str):
        """发送邮件"""
        import smtplib
        from email.mime.text import MIMEText
        
        msg = MIMEText(message)
        msg['Subject'] = 'Claude Automation Report'
        msg['From'] = 'claude@example.com'
        msg['To'] = to
        
        with smtplib.SMTP('localhost') as s:
            s.send_message(msg)

# 使用示例
if __name__ == "__main__":
    automation = ClaudeAutomation('/home/claudebot/claude/config.json')
    
    # 定义工作流
    workflow = [
        {'agent': 'code-reviewer', 'task': 'review src/', 'critical': True},
        {'agent': 'test-automator', 'task': 'run tests', 'critical': True},
        {'agent': 'security-auditor', 'task': 'scan vulnerabilities'},
        {'agent': 'deployment-engineer', 'task': 'deploy to staging', 'depends_on': 1}
    ]
    
    # 执行工作流
    results = automation.run_workflow(workflow)
    
    # 生成报告
    success_count = sum(1 for r in results if r['success'])
    automation.notify(f"Workflow completed: {success_count}/{len(results)} tasks succeeded")
```

### 2. 批处理执行器

```bash
#!/bin/bash
# batch_executor.sh

# 配置
CLAUDE_HOME="/home/claudebot/claude"
LOG_DIR="$CLAUDE_HOME/logs"
WORK_DIR="$CLAUDE_HOME/workspace"
PARALLEL_JOBS=4

# 日志函数
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_DIR/batch_$(date +%Y%m%d).log"
}

# 错误处理
on_error() {
    log "ERROR: $1"
    # 发送告警
    curl -X POST -H 'Content-type: application/json' \
        --data "{\"text\":\"Batch execution error: $1\"}" \
        "$SLACK_WEBHOOK"
    exit 1
}

# 执行单个任务
execute_task() {
    local agent=$1
    local task=$2
    local output_file="$LOG_DIR/${agent}_$(date +%Y%m%d_%H%M%S).out"
    
    log "Executing: $agent - $task"
    
    claude-code <<EOF > "$output_file" 2>&1
/use $agent
$task
/exit
EOF
    
    if [ $? -eq 0 ]; then
        log "SUCCESS: $agent completed"
        return 0
    else
        log "FAILED: $agent"
        return 1
    fi
}

# 并行执行
parallel_execute() {
    local -a pids=()
    local -a agents=("$@")
    
    for agent_task in "${agents[@]}"; do
        IFS=':' read -r agent task <<< "$agent_task"
        execute_task "$agent" "$task" &
        pids+=($!)
        
        # 限制并行数
        while [ ${#pids[@]} -ge $PARALLEL_JOBS ]; do
            for i in "${!pids[@]}"; do
                if ! kill -0 "${pids[$i]}" 2>/dev/null; then
                    unset 'pids[$i]'
                fi
            done
            pids=("${pids[@]}")  # 重新索引
            sleep 1
        done
    done
    
    # 等待所有任务完成
    for pid in "${pids[@]}"; do
        wait "$pid"
    done
}

# 主执行流程
main() {
    log "Starting batch execution"
    
    # 读取任务列表
    TASKS=(
        "python-pro:优化所有Python代码"
        "test-automator:运行完整测试套件"
        "code-reviewer:审查最近提交"
        "security-auditor:执行安全扫描"
        "performance-engineer:分析性能瓶颈"
        "api-documenter:更新API文档"
    )
    
    # 并行执行
    parallel_execute "${TASKS[@]}"
    
    log "Batch execution completed"
    
    # 生成汇总报告
    generate_report
}

# 生成报告
generate_report() {
    REPORT="$LOG_DIR/report_$(date +%Y%m%d).md"
    
    cat > "$REPORT" << EOF
# 自动化执行报告

**日期**: $(date)
**状态**: 完成

## 执行摘要

| 代理 | 状态 | 耗时 | 日志 |
|------|------|------|------|
EOF
    
    # 添加每个任务的结果
    for log_file in "$LOG_DIR"/*_$(date +%Y%m%d)*.out; do
        if [ -f "$log_file" ]; then
            agent=$(basename "$log_file" | cut -d'_' -f1)
            status=$(grep -q "SUCCESS" "$log_file" && echo "✅" || echo "❌")
            echo "| $agent | $status | - | [查看]($(basename "$log_file")) |" >> "$REPORT"
        fi
    done
    
    log "Report generated: $REPORT"
}

# 清理旧日志
cleanup_logs() {
    find "$LOG_DIR" -name "*.log" -mtime +7 -delete
    find "$LOG_DIR" -name "*.out" -mtime +7 -delete
    log "Old logs cleaned"
}

# 执行
main
cleanup_logs
```

### 3. 任务调度器

```python
#!/usr/bin/env python3
# task_scheduler.py

import schedule
import time
import threading
import queue
import json
from datetime import datetime, timedelta
from typing import Callable, Dict, Any

class TaskScheduler:
    def __init__(self, config_file: str):
        self.config = self.load_config(config_file)
        self.task_queue = queue.Queue()
        self.workers = []
        self.running = True
        
    def load_config(self, config_file: str) -> Dict:
        with open(config_file, 'r') as f:
            return json.load(f)
    
    def schedule_task(self, agent: str, task: str, schedule_time: str):
        """调度任务"""
        def job():
            self.task_queue.put({
                'agent': agent,
                'task': task,
                'scheduled_at': datetime.now().isoformat()
            })
        
        # 解析调度时间
        if schedule_time.startswith('every_'):
            interval = schedule_time.replace('every_', '')
            if 'minute' in interval:
                schedule.every(int(interval.split('_')[0])).minutes.do(job)
            elif 'hour' in interval:
                schedule.every(int(interval.split('_')[0])).hours.do(job)
            elif 'day' in interval:
                schedule.every().day.at(interval.split('_')[1]).do(job)
        else:
            # 具体时间
            schedule.every().day.at(schedule_time).do(job)
        
        print(f"Scheduled: {agent} at {schedule_time}")
    
    def worker(self):
        """工作线程"""
        while self.running:
            try:
                task = self.task_queue.get(timeout=1)
                self.execute_task(task)
                self.task_queue.task_done()
            except queue.Empty:
                continue
    
    def execute_task(self, task: Dict):
        """执行任务"""
        agent = task['agent']
        task_desc = task['task']
        
        print(f"Executing {agent}: {task_desc}")
        
        # 执行命令
        import subprocess
        cmd = f"claude-code --agent {agent} --task '{task_desc}' --non-interactive"
        
        try:
            result = subprocess.run(cmd, shell=True, capture_output=True, text=True, timeout=3600)
            
            # 记录结果
            with open(f"logs/{agent}_{datetime.now():%Y%m%d_%H%M%S}.log", 'w') as f:
                f.write(f"Task: {task_desc}\n")
                f.write(f"Output:\n{result.stdout}\n")
                if result.stderr:
                    f.write(f"Errors:\n{result.stderr}\n")
            
            print(f"Completed {agent}: {'SUCCESS' if result.returncode == 0 else 'FAILED'}")
            
        except subprocess.TimeoutExpired:
            print(f"Timeout: {agent}")
        except Exception as e:
            print(f"Error: {agent} - {e}")
    
    def start(self):
        """启动调度器"""
        # 启动工作线程
        for i in range(self.config.get('worker_threads', 4)):
            t = threading.Thread(target=self.worker)
            t.daemon = True
            t.start()
            self.workers.append(t)
        
        # 加载调度任务
        for task in self.config['scheduled_tasks']:
            self.schedule_task(task['agent'], task['task'], task['schedule'])
        
        # 运行调度器
        print("Scheduler started. Press Ctrl+C to stop.")
        try:
            while True:
                schedule.run_pending()
                time.sleep(1)
        except KeyboardInterrupt:
            print("\nShutting down...")
            self.running = False
            
            # 等待任务完成
            self.task_queue.join()
            
            # 等待工作线程结束
            for worker in self.workers:
                worker.join()
            
            print("Scheduler stopped.")

# 配置文件示例
config_example = {
    "worker_threads": 4,
    "scheduled_tasks": [
        {
            "agent": "code-reviewer",
            "task": "review all changes",
            "schedule": "every_6_hours"
        },
        {
            "agent": "test-automator",
            "task": "run full test suite",
            "schedule": "02:00"
        },
        {
            "agent": "security-auditor",
            "task": "security scan",
            "schedule": "every_day_03:00"
        },
        {
            "agent": "database-optimizer",
            "task": "optimize queries",
            "schedule": "every_sunday_04:00"
        },
        {
            "agent": "performance-engineer",
            "task": "performance analysis",
            "schedule": "every_12_hours"
        }
    ]
}

if __name__ == "__main__":
    # 保存示例配置
    with open('scheduler_config.json', 'w') as f:
        json.dump(config_example, f, indent=2)
    
    # 启动调度器
    scheduler = TaskScheduler('scheduler_config.json')
    scheduler.start()
```

## 定时任务

### 1. Linux Crontab配置

```bash
# 编辑crontab
sudo -u claudebot crontab -e

# 每日任务
# 每天凌晨2点运行代码审查
0 2 * * * /home/claudebot/claude/scripts/daily_review.sh

# 每天早上6点运行测试
0 6 * * * /home/claudebot/claude/scripts/run_tests.sh

# 每周任务
# 每周一凌晨3点优化数据库
0 3 * * 1 /home/claudebot/claude/scripts/optimize_db.sh

# 每周五下午5点生成周报
0 17 * * 5 /home/claudebot/claude/scripts/weekly_report.sh

# 每月任务
# 每月1号凌晨4点清理日志
0 4 1 * * /home/claudebot/claude/scripts/cleanup.sh

# 持续监控
# 每5分钟检查系统健康
*/5 * * * * /home/claudebot/claude/scripts/health_check.sh

# 每小时备份
0 * * * * /home/claudebot/claude/scripts/backup.sh
```

### 2. Windows任务计划

```powershell
# create_scheduled_tasks.ps1

# 创建每日代码审查任务
$action = New-ScheduledTaskAction -Execute "powershell.exe" `
    -Argument "-File C:\claude\scripts\daily_review.ps1"
    
$trigger = New-ScheduledTaskTrigger -Daily -At 2:00AM

$principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" `
    -LogonType ServiceAccount -RunLevel Highest

Register-ScheduledTask -TaskName "Claude Daily Review" `
    -Action $action -Trigger $trigger -Principal $principal

# 创建每小时测试任务
$action = New-ScheduledTaskAction -Execute "C:\claude\scripts\run_tests.bat"
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) `
    -RepetitionInterval (New-TimeSpan -Hours 1)

Register-ScheduledTask -TaskName "Claude Hourly Tests" `
    -Action $action -Trigger $trigger

# 创建系统监控任务
$action = New-ScheduledTaskAction -Execute "C:\claude\scripts\monitor.exe"
$trigger = New-ScheduledTaskTrigger -AtStartup

Register-ScheduledTask -TaskName "Claude Monitor" `
    -Action $action -Trigger $trigger -RunLevel Highest
```

### 3. systemd服务（Linux）

```ini
# /etc/systemd/system/claude-automation.service
[Unit]
Description=Claude Code Automation Service
After=network.target

[Service]
Type=simple
User=claudebot
Group=claudebot
WorkingDirectory=/home/claudebot/claude
Environment="PATH=/usr/local/bin:/usr/bin:/bin"
ExecStart=/usr/bin/python3 /home/claudebot/claude/scripts/automation_service.py
Restart=always
RestartSec=10
StandardOutput=append:/home/claudebot/claude/logs/service.log
StandardError=append:/home/claudebot/claude/logs/service_error.log

[Install]
WantedBy=multi-user.target
```

```bash
# 启用和启动服务
sudo systemctl daemon-reload
sudo systemctl enable claude-automation.service
sudo systemctl start claude-automation.service
sudo systemctl status claude-automation.service
```

## CI/CD集成

### 1. Jenkins Pipeline

```groovy
// Jenkinsfile
pipeline {
    agent any
    
    environment {
        CLAUDE_API_KEY = credentials('claude-api-key')
    }
    
    stages {
        stage('Code Review') {
            steps {
                script {
                    sh '''
                        claude-code --agent code-reviewer \
                            --task "review changes" \
                            --non-interactive \
                            --output review_report.md
                    '''
                    
                    // 发布报告
                    publishHTML([
                        reportDir: '.',
                        reportFiles: 'review_report.md',
                        reportName: 'Code Review Report'
                    ])
                }
            }
        }
        
        stage('Security Scan') {
            steps {
                script {
                    sh '''
                        claude-code --agent security-auditor \
                            --task "scan for vulnerabilities" \
                            --non-interactive
                    '''
                }
            }
        }
        
        stage('Test') {
            parallel {
                stage('Unit Tests') {
                    steps {
                        sh 'claude-code --agent test-automator --task "run unit tests"'
                    }
                }
                stage('Integration Tests') {
                    steps {
                        sh 'claude-code --agent test-automator --task "run integration tests"'
                    }
                }
            }
        }
        
        stage('Deploy') {
            when {
                branch 'main'
            }
            steps {
                sh '''
                    claude-code --agent deployment-engineer \
                        --task "deploy to production" \
                        --non-interactive
                '''
            }
        }
    }
    
    post {
        always {
            // 清理
            sh 'claude-code --cleanup'
        }
        success {
            // 成功通知
            slackSend(color: 'good', message: "Pipeline succeeded: ${env.JOB_NAME}")
        }
        failure {
            // 失败通知
            slackSend(color: 'danger', message: "Pipeline failed: ${env.JOB_NAME}")
        }
    }
}
```

### 2. GitHub Actions

```yaml
# .github/workflows/claude-automation.yml
name: Claude Automation

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]
  schedule:
    - cron: '0 2 * * *'  # 每天凌晨2点

jobs:
  code-quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Claude
        run: |
          curl -fsSL https://claude.ai/install.sh | sh
          claude-code --version
      
      - name: Code Review
        env:
          CLAUDE_API_KEY: ${{ secrets.CLAUDE_API_KEY }}
        run: |
          claude-code --agent code-reviewer \
            --task "review all files" \
            --non-interactive \
            --format json > review.json
      
      - name: Security Audit
        run: |
          claude-code --agent security-auditor \
            --task "scan vulnerabilities" \
            --non-interactive
      
      - name: Upload Reports
        uses: actions/upload-artifact@v3
        with:
          name: reports
          path: |
            review.json
            security_report.html
  
  test:
    needs: code-quality
    runs-on: ubuntu-latest
    strategy:
      matrix:
        test-type: [unit, integration, e2e]
    steps:
      - uses: actions/checkout@v3
      
      - name: Run Tests
        run: |
          claude-code --agent test-automator \
            --task "run ${{ matrix.test-type }} tests" \
            --non-interactive
      
      - name: Coverage Report
        if: matrix.test-type == 'unit'
        run: |
          claude-code --agent test-automator \
            --task "generate coverage report" \
            --non-interactive
  
  deploy:
    needs: test
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Deploy
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        run: |
          claude-code --agent deployment-engineer \
            --task "deploy to AWS" \
            --non-interactive \
            --config deploy.yaml
```

### 3. GitLab CI

```yaml
# .gitlab-ci.yml
variables:
  CLAUDE_API_KEY: ${CI_CLAUDE_API_KEY}

stages:
  - review
  - test
  - build
  - deploy

before_script:
  - apt-get update -qq
  - apt-get install -y claude-code
  - claude-code --version

code-review:
  stage: review
  script:
    - claude-code --agent code-reviewer --task "review merge request" --non-interactive
  artifacts:
    reports:
      codequality: review_report.json
  only:
    - merge_requests

security-scan:
  stage: review
  script:
    - claude-code --agent security-auditor --task "security scan" --non-interactive
  artifacts:
    reports:
      sast: security_report.json

test:unit:
  stage: test
  script:
    - claude-code --agent test-automator --task "run unit tests" --non-interactive
  coverage: '/Coverage: \d+\.\d+%/'

test:integration:
  stage: test
  script:
    - claude-code --agent test-automator --task "run integration tests" --non-interactive

build:
  stage: build
  script:
    - claude-code --agent deployment-engineer --task "build docker image" --non-interactive
    - docker push $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
  only:
    - main
    - develop

deploy:staging:
  stage: deploy
  script:
    - claude-code --agent deployment-engineer --task "deploy to staging" --non-interactive
  environment:
    name: staging
    url: https://staging.example.com
  only:
    - develop

deploy:production:
  stage: deploy
  script:
    - claude-code --agent deployment-engineer --task "deploy to production" --non-interactive
  environment:
    name: production
    url: https://example.com
  when: manual
  only:
    - main
```

## 监控与告警

### 1. 监控脚本

```python
#!/usr/bin/env python3
# monitor.py

import psutil
import time
import json
import requests
from datetime import datetime
from typing import Dict, List

class ClaudeMonitor:
    def __init__(self, config: Dict):
        self.config = config
        self.metrics = []
        self.alerts = []
        
    def collect_metrics(self) -> Dict:
        """收集系统指标"""
        metrics = {
            'timestamp': datetime.now().isoformat(),
            'cpu_percent': psutil.cpu_percent(interval=1),
            'memory_percent': psutil.virtual_memory().percent,
            'disk_usage': psutil.disk_usage('/').percent,
            'processes': len(psutil.pids()),
            'claude_processes': self.count_claude_processes()
        }
        
        # 检查Claude服务状态
        metrics['services'] = self.check_services()
        
        return metrics
    
    def count_claude_processes(self) -> int:
        """统计Claude进程数"""
        count = 0
        for proc in psutil.process_iter(['name', 'cmdline']):
            try:
                if 'claude' in str(proc.info['cmdline']).lower():
                    count += 1
            except:
                pass
        return count
    
    def check_services(self) -> Dict:
        """检查服务状态"""
        services = {}
        
        # 检查API
        try:
            resp = requests.get('http://localhost:8080/health', timeout=5)
            services['api'] = resp.status_code == 200
        except:
            services['api'] = False
        
        # 检查数据库
        try:
            import psycopg2
            conn = psycopg2.connect(self.config['database_url'])
            conn.close()
            services['database'] = True
        except:
            services['database'] = False
        
        return services
    
    def check_alerts(self, metrics: Dict):
        """检查告警条件"""
        alerts = []
        
        # CPU告警
        if metrics['cpu_percent'] > self.config['thresholds']['cpu']:
            alerts.append({
                'level': 'WARNING',
                'message': f"High CPU usage: {metrics['cpu_percent']}%"
            })
        
        # 内存告警
        if metrics['memory_percent'] > self.config['thresholds']['memory']:
            alerts.append({
                'level': 'WARNING',
                'message': f"High memory usage: {metrics['memory_percent']}%"
            })
        
        # 服务告警
        for service, status in metrics['services'].items():
            if not status:
                alerts.append({
                    'level': 'CRITICAL',
                    'message': f"Service {service} is down"
                })
        
        # 发送告警
        for alert in alerts:
            self.send_alert(alert)
    
    def send_alert(self, alert: Dict):
        """发送告警通知"""
        # Slack通知
        if webhook := self.config.get('slack_webhook'):
            color = 'danger' if alert['level'] == 'CRITICAL' else 'warning'
            requests.post(webhook, json={
                'attachments': [{
                    'color': color,
                    'title': alert['level'],
                    'text': alert['message'],
                    'timestamp': int(time.time())
                }]
            })
        
        # 邮件通知
        if email := self.config.get('alert_email'):
            # 实现邮件发送
            pass
        
        # 记录告警
        with open('alerts.log', 'a') as f:
            f.write(f"{datetime.now()}: {alert['level']} - {alert['message']}\n")
    
    def run(self):
        """运行监控"""
        print("Monitor started")
        
        while True:
            try:
                # 收集指标
                metrics = self.collect_metrics()
                self.metrics.append(metrics)
                
                # 检查告警
                self.check_alerts(metrics)
                
                # 保存指标
                if len(self.metrics) >= 100:
                    self.save_metrics()
                    self.metrics = self.metrics[-50:]  # 保留最近50条
                
                # 打印状态
                print(f"[{datetime.now():%H:%M:%S}] CPU: {metrics['cpu_percent']}% | "
                      f"Memory: {metrics['memory_percent']}% | "
                      f"Claude processes: {metrics['claude_processes']}")
                
                # 等待下次检查
                time.sleep(self.config.get('interval', 60))
                
            except KeyboardInterrupt:
                print("\nMonitor stopped")
                break
            except Exception as e:
                print(f"Error: {e}")
    
    def save_metrics(self):
        """保存指标到文件"""
        filename = f"metrics_{datetime.now():%Y%m%d}.json"
        with open(filename, 'w') as f:
            json.dump(self.metrics, f, indent=2)

# 配置
config = {
    'interval': 60,  # 检查间隔（秒）
    'thresholds': {
        'cpu': 80,
        'memory': 85,
        'disk': 90
    },
    'slack_webhook': 'https://hooks.slack.com/services/xxx',
    'alert_email': 'admin@example.com',
    'database_url': 'postgresql://user:pass@localhost/claude'
}

if __name__ == "__main__":
    monitor = ClaudeMonitor(config)
    monitor.run()
```

### 2. 健康检查

```bash
#!/bin/bash
# health_check.sh

# 配置
HEALTH_URL="http://localhost:8080/health"
LOG_FILE="/var/log/claude/health.log"
MAX_RETRIES=3
ALERT_THRESHOLD=2

# 检查函数
check_health() {
    local service=$1
    local check_cmd=$2
    local status="OK"
    
    if ! eval "$check_cmd" > /dev/null 2>&1; then
        status="FAILED"
    fi
    
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $service: $status" >> "$LOG_FILE"
    
    if [ "$status" = "FAILED" ]; then
        return 1
    fi
    return 0
}

# 主检查流程
main() {
    local failures=0
    
    # 检查Claude服务
    check_health "Claude API" "curl -f $HEALTH_URL" || ((failures++))
    
    # 检查数据库
    check_health "Database" "pg_isready -h localhost" || ((failures++))
    
    # 检查Redis
    check_health "Redis" "redis-cli ping" || ((failures++))
    
    # 检查磁盘空间
    check_health "Disk Space" "[ $(df -h / | awk 'NR==2 {print int($5)}') -lt 90 ]" || ((failures++))
    
    # 检查内存
    check_health "Memory" "[ $(free | awk 'NR==2 {print int($3/$2 * 100)}') -lt 90 ]" || ((failures++))
    
    # 发送告警
    if [ $failures -ge $ALERT_THRESHOLD ]; then
        send_alert "CRITICAL: $failures health checks failed"
    elif [ $failures -gt 0 ]; then
        send_alert "WARNING: $failures health checks failed"
    fi
    
    return $failures
}

# 发送告警
send_alert() {
    local message=$1
    
    # Slack通知
    if [ -n "$SLACK_WEBHOOK" ]; then
        curl -X POST -H 'Content-type: application/json' \
            --data "{\"text\":\"$message\"}" \
            "$SLACK_WEBHOOK"
    fi
    
    # 邮件通知
    if [ -n "$ALERT_EMAIL" ]; then
        echo "$message" | mail -s "Claude Health Alert" "$ALERT_EMAIL"
    fi
    
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ALERT: $message" >> "$LOG_FILE"
}

# 执行检查
main
exit $?
```

## 错误处理

### 1. 自动重试机制

```python
#!/usr/bin/env python3
# retry_handler.py

import time
import functools
from typing import Callable, Any, Optional

class RetryHandler:
    def __init__(self, max_retries: int = 3, delay: float = 1.0, backoff: float = 2.0):
        self.max_retries = max_retries
        self.delay = delay
        self.backoff = backoff
    
    def retry(self, exceptions=(Exception,)):
        """装饰器：自动重试"""
        def decorator(func: Callable) -> Callable:
            @functools.wraps(func)
            def wrapper(*args, **kwargs) -> Any:
                retries = 0
                delay = self.delay
                
                while retries < self.max_retries:
                    try:
                        return func(*args, **kwargs)
                    except exceptions as e:
                        retries += 1
                        if retries >= self.max_retries:
                            raise
                        
                        print(f"Retry {retries}/{self.max_retries} after {delay}s: {e}")
                        time.sleep(delay)
                        delay *= self.backoff
                
                return None
            return wrapper
        return decorator
    
    @staticmethod
    def exponential_backoff(retries: int, base_delay: float = 1.0) -> float:
        """指数退避"""
        return base_delay * (2 ** retries)
    
    @staticmethod
    def linear_backoff(retries: int, base_delay: float = 1.0) -> float:
        """线性退避"""
        return base_delay * retries

# 使用示例
retry_handler = RetryHandler(max_retries=5, delay=2.0, backoff=2.0)

@retry_handler.retry(exceptions=(ConnectionError, TimeoutError))
def execute_agent(agent: str, task: str):
    """执行代理任务（带重试）"""
    import subprocess
    
    result = subprocess.run(
        f"claude-code --agent {agent} --task '{task}'",
        shell=True,
        capture_output=True,
        text=True,
        timeout=300
    )
    
    if result.returncode != 0:
        raise RuntimeError(f"Agent execution failed: {result.stderr}")
    
    return result.stdout

# 高级重试策略
class AdvancedRetryHandler:
    def __init__(self):
        self.retry_policies = {
            'network': {'max_retries': 5, 'delay': 1.0, 'backoff': 2.0},
            'database': {'max_retries': 3, 'delay': 0.5, 'backoff': 1.5},
            'api': {'max_retries': 10, 'delay': 2.0, 'backoff': 2.0}
        }
    
    def execute_with_retry(self, task_type: str, func: Callable, *args, **kwargs):
        """根据任务类型选择重试策略"""
        policy = self.retry_policies.get(task_type, self.retry_policies['network'])
        
        retries = 0
        delay = policy['delay']
        
        while retries < policy['max_retries']:
            try:
                return func(*args, **kwargs)
            except Exception as e:
                retries += 1
                if retries >= policy['max_retries']:
                    self.handle_failure(task_type, e)
                    raise
                
                print(f"Retry {retries} for {task_type}: {e}")
                time.sleep(delay)
                delay *= policy['backoff']
    
    def handle_failure(self, task_type: str, error: Exception):
        """处理最终失败"""
        # 记录错误
        with open('errors.log', 'a') as f:
            f.write(f"{time.time()}: {task_type} failed after all retries: {error}\n")
        
        # 发送告警
        self.send_alert(f"Task {task_type} failed: {error}")
    
    def send_alert(self, message: str):
        """发送告警"""
        # 实现告警逻辑
        pass
```

### 2. 错误恢复

```bash
#!/bin/bash
# error_recovery.sh

# 错误恢复配置
RECOVERY_DIR="/home/claudebot/claude/recovery"
STATE_FILE="$RECOVERY_DIR/state.json"
CHECKPOINT_DIR="$RECOVERY_DIR/checkpoints"

# 创建检查点
create_checkpoint() {
    local name=$1
    local checkpoint_file="$CHECKPOINT_DIR/${name}_$(date +%Y%m%d_%H%M%S).tar.gz"
    
    echo "Creating checkpoint: $name"
    
    # 保存当前状态
    tar -czf "$checkpoint_file" \
        --exclude="*.log" \
        --exclude="*.tmp" \
        "$CLAUDE_WORK_DIR"
    
    # 更新状态文件
    jq ".last_checkpoint = \"$checkpoint_file\"" "$STATE_FILE" > "$STATE_FILE.tmp"
    mv "$STATE_FILE.tmp" "$STATE_FILE"
    
    echo "Checkpoint created: $checkpoint_file"
}

# 恢复到检查点
restore_checkpoint() {
    local checkpoint_file=$1
    
    if [ -z "$checkpoint_file" ]; then
        # 使用最新检查点
        checkpoint_file=$(jq -r '.last_checkpoint' "$STATE_FILE")
    fi
    
    if [ ! -f "$checkpoint_file" ]; then
        echo "Checkpoint not found: $checkpoint_file"
        return 1
    fi
    
    echo "Restoring from checkpoint: $checkpoint_file"
    
    # 备份当前状态
    mv "$CLAUDE_WORK_DIR" "${CLAUDE_WORK_DIR}.backup"
    
    # 恢复检查点
    mkdir -p "$CLAUDE_WORK_DIR"
    tar -xzf "$checkpoint_file" -C /
    
    echo "Checkpoint restored successfully"
}

# 错误处理器
error_handler() {
    local error_code=$1
    local error_msg=$2
    local recovery_action=""
    
    case $error_code in
        1)
            # 一般错误
            recovery_action="retry"
            ;;
        2)
            # 配置错误
            recovery_action="fix_config"
            ;;
        127)
            # 命令未找到
            recovery_action="install_deps"
            ;;
        *)
            # 未知错误
            recovery_action="restore_checkpoint"
            ;;
    esac
    
    echo "Error occurred: $error_msg (code: $error_code)"
    echo "Recovery action: $recovery_action"
    
    # 执行恢复动作
    case $recovery_action in
        retry)
            echo "Retrying operation..."
            return 0
            ;;
        fix_config)
            echo "Fixing configuration..."
            fix_configuration
            ;;
        install_deps)
            echo "Installing dependencies..."
            install_dependencies
            ;;
        restore_checkpoint)
            echo "Restoring from checkpoint..."
            restore_checkpoint
            ;;
    esac
}

# 修复配置
fix_configuration() {
    # 验证配置文件
    if ! jq empty "$CLAUDE_CONFIG" 2>/dev/null; then
        echo "Invalid JSON in config file, restoring default"
        cp "$CLAUDE_HOME/config.default.json" "$CLAUDE_CONFIG"
    fi
    
    # 检查必要的配置项
    required_keys=("api_key" "agents_dir" "work_dir")
    for key in "${required_keys[@]}"; do
        if [ -z "$(jq -r ".$key" "$CLAUDE_CONFIG")" ]; then
            echo "Missing required config: $key"
            # 添加默认值
            jq ".$key = \"default_value\"" "$CLAUDE_CONFIG" > "$CLAUDE_CONFIG.tmp"
            mv "$CLAUDE_CONFIG.tmp" "$CLAUDE_CONFIG"
        fi
    done
}

# 安装依赖
install_dependencies() {
    echo "Installing missing dependencies..."
    
    # Python依赖
    if ! python3 -c "import claude_code" 2>/dev/null; then
        pip install claude-code
    fi
    
    # 系统依赖
    required_commands=("jq" "curl" "git")
    for cmd in "${required_commands[@]}"; do
        if ! command -v "$cmd" > /dev/null; then
            echo "Installing $cmd..."
            sudo apt-get install -y "$cmd" || sudo yum install -y "$cmd"
        fi
    done
}

# 主恢复流程
main() {
    # 设置错误陷阱
    trap 'error_handler $? "$BASH_COMMAND"' ERR
    
    # 创建必要目录
    mkdir -p "$RECOVERY_DIR" "$CHECKPOINT_DIR"
    
    # 初始化状态文件
    if [ ! -f "$STATE_FILE" ]; then
        echo '{"status": "initialized", "last_checkpoint": null}' > "$STATE_FILE"
    fi
    
    # 执行任务（示例）
    echo "Starting automated tasks..."
    
    # 创建检查点
    create_checkpoint "before_execution"
    
    # 执行可能失败的操作
    claude-code --agent python-pro --task "complex operation" || {
        echo "Operation failed, attempting recovery"
        restore_checkpoint
        # 重试
        claude-code --agent python-pro --task "complex operation"
    }
    
    echo "Tasks completed successfully"
}

# 执行主流程
main
```

## 安全配置

### 1. 密钥管理

```python
#!/usr/bin/env python3
# secret_manager.py

import os
import json
import base64
from cryptography.fernet import Fernet
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2

class SecretManager:
    def __init__(self, master_password: str):
        self.key = self._derive_key(master_password)
        self.cipher = Fernet(self.key)
        self.secrets_file = os.path.expanduser('~/.claude/secrets.enc')
    
    def _derive_key(self, password: str) -> bytes:
        """从主密码派生加密密钥"""
        salt = b'claude_salt_v1'  # 在生产环境中应使用随机盐
        kdf = PBKDF2(
            algorithm=hashes.SHA256(),
            length=32,
            salt=salt,
            iterations=100000,
        )
        key = base64.urlsafe_b64encode(kdf.derive(password.encode()))
        return key
    
    def store_secret(self, name: str, value: str):
        """存储加密的密钥"""
        secrets = self._load_secrets()
        secrets[name] = self.cipher.encrypt(value.encode()).decode()
        self._save_secrets(secrets)
    
    def get_secret(self, name: str) -> str:
        """获取解密的密钥"""
        secrets = self._load_secrets()
        if name in secrets:
            return self.cipher.decrypt(secrets[name].encode()).decode()
        return None
    
    def _load_secrets(self) -> dict:
        """加载密钥文件"""
        if os.path.exists(self.secrets_file):
            with open(self.secrets_file, 'r') as f:
                return json.load(f)
        return {}
    
    def _save_secrets(self, secrets: dict):
        """保存密钥文件"""
        os.makedirs(os.path.dirname(self.secrets_file), exist_ok=True)
        with open(self.secrets_file, 'w') as f:
            json.dump(secrets, f)
        os.chmod(self.secrets_file, 0o600)

# 使用示例
if __name__ == "__main__":
    # 初始化密钥管理器
    manager = SecretManager(os.environ.get('MASTER_PASSWORD', 'default'))
    
    # 存储密钥
    manager.store_secret('claude_api_key', 'sk-xxxxx')
    manager.store_secret('github_token', 'ghp_xxxxx')
    
    # 使用密钥
    api_key = manager.get_secret('claude_api_key')
    
    # 在自动化脚本中使用
    os.environ['CLAUDE_API_KEY'] = api_key
```

### 2. 访问控制

```bash
#!/bin/bash
# access_control.sh

# 设置严格的文件权限
setup_permissions() {
    # Claude主目录
    chmod 750 "$CLAUDE_HOME"
    chown -R claudebot:claudebot "$CLAUDE_HOME"
    
    # 配置文件
    chmod 640 "$CLAUDE_HOME/config.json"
    chmod 600 "$CLAUDE_HOME/.credentials"
    
    # 脚本目录
    chmod 750 "$CLAUDE_HOME/scripts"
    find "$CLAUDE_HOME/scripts" -type f -name "*.sh" -exec chmod 750 {} \;
    
    # 日志目录
    chmod 755 "$CLAUDE_HOME/logs"
    
    # 工作目录
    chmod 750 "$CLAUDE_HOME/workspace"
}

# 创建受限用户
create_restricted_user() {
    # 创建用户
    useradd -m -s /bin/bash -d /home/claudebot claudebot
    
    # 限制sudo权限
    cat > /etc/sudoers.d/claudebot << EOF
# Claude bot restricted sudo access
claudebot ALL=(ALL) NOPASSWD: /usr/bin/claude-code
claudebot ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart claude-automation
claudebot ALL=(ALL) NOPASSWD: /usr/bin/systemctl status claude-automation
EOF
    
    # 设置资源限制
    cat >> /etc/security/limits.conf << EOF
# Claude bot resource limits
claudebot soft nproc 100
claudebot hard nproc 200
claudebot soft nofile 1024
claudebot hard nofile 2048
claudebot soft memlock 1048576
claudebot hard memlock 2097152
EOF
}

# 审计日志
setup_audit_logging() {
    # 配置auditd规则
    cat > /etc/audit/rules.d/claude.rules << EOF
# Monitor Claude execution
-w /home/claudebot/claude -p rwxa -k claude_activity
-w /usr/bin/claude-code -p x -k claude_execution
-w /home/claudebot/.ssh -p rwa -k claude_ssh
EOF
    
    # 重启auditd
    systemctl restart auditd
    
    # 设置日志轮转
    cat > /etc/logrotate.d/claude << EOF
/home/claudebot/claude/logs/*.log {
    daily
    missingok
    rotate 30
    compress
    delaycompress
    notifempty
    create 640 claudebot claudebot
    sharedscripts
    postrotate
        systemctl reload claude-automation > /dev/null 2>&1 || true
    endscript
}
EOF
}

# 网络安全
setup_network_security() {
    # 防火墙规则
    iptables -A INPUT -p tcp --dport 8080 -s 127.0.0.1 -j ACCEPT
    iptables -A INPUT -p tcp --dport 8080 -j DROP
    
    # 保存规则
    iptables-save > /etc/iptables/rules.v4
}

# 主设置
main() {
    setup_permissions
    create_restricted_user
    setup_audit_logging
    setup_network_security
    
    echo "Security configuration completed"
}

main
```

## 实战案例

### 案例1: 24/7代码质量监控

```python
#!/usr/bin/env python3
# code_quality_monitor.py

import os
import git
import time
import subprocess
from datetime import datetime, timedelta

class CodeQualityMonitor:
    def __init__(self, repo_path: str):
        self.repo = git.Repo(repo_path)
        self.last_check = datetime.now()
        
    def monitor_commits(self):
        """监控新提交"""
        while True:
            try:
                # 拉取最新代码
                self.repo.remotes.origin.pull()
                
                # 获取新提交
                new_commits = list(self.repo.iter_commits(
                    since=self.last_check.isoformat()
                ))
                
                if new_commits:
                    print(f"Found {len(new_commits)} new commits")
                    
                    for commit in new_commits:
                        self.analyze_commit(commit)
                
                self.last_check = datetime.now()
                
            except Exception as e:
                print(f"Error: {e}")
            
            # 等待下次检查
            time.sleep(300)  # 5分钟
    
    def analyze_commit(self, commit):
        """分析提交"""
        print(f"Analyzing commit: {commit.hexsha[:8]} by {commit.author}")
        
        # 代码审查
        self.run_agent('code-reviewer', f'review commit {commit.hexsha}')
        
        # 安全扫描
        self.run_agent('security-auditor', f'scan commit {commit.hexsha}')
        
        # 性能分析
        if self.has_performance_impact(commit):
            self.run_agent('performance-engineer', f'analyze commit {commit.hexsha}')
        
        # 生成报告
        self.generate_report(commit)
    
    def has_performance_impact(self, commit) -> bool:
        """检查是否有性能影响"""
        critical_files = ['database.py', 'api.py', 'cache.py']
        
        for file in commit.stats.files:
            if any(cf in file for cf in critical_files):
                return True
        return False
    
    def run_agent(self, agent: str, task: str):
        """运行代理"""
        cmd = f"claude-code --agent {agent} --task '{task}' --non-interactive"
        subprocess.run(cmd, shell=True, capture_output=True)
    
    def generate_report(self, commit):
        """生成报告"""
        report = f"""
# Commit Analysis Report

**Commit**: {commit.hexsha}
**Author**: {commit.author}
**Date**: {commit.committed_datetime}
**Message**: {commit.message}

## Analysis Results
- Code Review: ✅ Completed
- Security Scan: ✅ Completed
- Performance Analysis: {'✅ Completed' if self.has_performance_impact(commit) else 'N/A'}

## Files Changed
"""
        for file, stats in commit.stats.files.items():
            report += f"- {file}: +{stats['insertions']} -{stats['deletions']}\n"
        
        # 保存报告
        report_file = f"reports/commit_{commit.hexsha[:8]}_{datetime.now():%Y%m%d}.md"
        os.makedirs('reports', exist_ok=True)
        
        with open(report_file, 'w') as f:
            f.write(report)
        
        print(f"Report saved: {report_file}")

if __name__ == "__main__":
    monitor = CodeQualityMonitor('/path/to/repo')
    monitor.monitor_commits()
```

### 案例2: 自动化部署管道

```yaml
# deployment_pipeline.yaml
name: Automated Deployment Pipeline

triggers:
  - type: git_push
    branch: main
  - type: schedule
    cron: "0 2 * * *"
  - type: manual

stages:
  - name: validate
    parallel: true
    tasks:
      - agent: code-reviewer
        task: "review all changes"
        critical: true
      - agent: security-auditor
        task: "security scan"
        critical: true
      - agent: test-automator
        task: "run unit tests"
        critical: true
  
  - name: build
    tasks:
      - agent: deployment-engineer
        task: "build docker image"
        critical: true
      - agent: deployment-engineer
        task: "push to registry"
  
  - name: test
    parallel: true
    tasks:
      - agent: test-automator
        task: "run integration tests"
      - agent: performance-engineer
        task: "run load tests"
  
  - name: deploy_staging
    tasks:
      - agent: deployment-engineer
        task: "deploy to staging"
      - agent: test-automator
        task: "run smoke tests"
        critical: true
  
  - name: deploy_production
    approval_required: true
    tasks:
      - agent: deployment-engineer
        task: "blue-green deployment"
      - agent: test-automator
        task: "verify deployment"
      - agent: deployment-engineer
        task: "switch traffic"

notifications:
  on_success:
    - type: slack
      channel: "#deployments"
      message: "Deployment successful"
  on_failure:
    - type: email
      to: "team@example.com"
      subject: "Deployment failed"
    - type: slack
      channel: "#alerts"
      message: "@here Deployment failed"

rollback:
  automatic: true
  on_failure_rate: 5  # 5% error rate triggers rollback
  strategy: "previous_version"
```

### 案例3: 数据处理自动化

```python
#!/usr/bin/env python3
# data_automation.py

import schedule
import pandas as pd
from datetime import datetime

class DataAutomation:
    def __init__(self):
        self.setup_schedule()
    
    def setup_schedule(self):
        """设置调度任务"""
        # 每日数据处理
        schedule.every().day.at("01:00").do(self.daily_processing)
        
        # 每小时数据同步
        schedule.every().hour.do(self.sync_data)
        
        # 每周数据分析
        schedule.every().monday.at("03:00").do(self.weekly_analysis)
    
    def daily_processing(self):
        """每日数据处理"""
        print(f"Starting daily processing at {datetime.now()}")
        
        # 数据清洗
        self.run_agent('data-engineer', 'clean daily data')
        
        # 数据转换
        self.run_agent('data-engineer', 'transform data')
        
        # 数据验证
        self.run_agent('data-scientist', 'validate data quality')
        
        # 生成报告
        self.run_agent('data-scientist', 'generate daily report')
    
    def sync_data(self):
        """数据同步"""
        print(f"Syncing data at {datetime.now()}")
        
        # 从多个源同步数据
        sources = ['database', 'api', 's3']
        
        for source in sources:
            self.run_agent('data-engineer', f'sync from {source}')
    
    def weekly_analysis(self):
        """每周分析"""
        print(f"Starting weekly analysis at {datetime.now()}")
        
        # 数据分析
        self.run_agent('data-scientist', 'perform weekly analysis')
        
        # 机器学习模型更新
        self.run_agent('ml-engineer', 'retrain models')
        
        # 性能优化
        self.run_agent('database-optimizer', 'optimize queries')
    
    def run_agent(self, agent: str, task: str):
        """运行代理"""
        import subprocess
        
        cmd = f"claude-code --agent {agent} --task '{task}' --non-interactive"
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
        
        if result.returncode != 0:
            self.handle_error(agent, task, result.stderr)
        else:
            print(f"✅ {agent}: {task}")
    
    def handle_error(self, agent: str, task: str, error: str):
        """错误处理"""
        print(f"❌ Error in {agent}: {task}")
        print(f"Error: {error}")
        
        # 发送告警
        self.send_alert(f"Task failed: {agent} - {task}\nError: {error}")
        
        # 尝试恢复
        self.attempt_recovery(agent, task)
    
    def attempt_recovery(self, agent: str, task: str):
        """尝试恢复"""
        # 重试逻辑
        pass
    
    def send_alert(self, message: str):
        """发送告警"""
        # 实现告警逻辑
        pass
    
    def run(self):
        """运行调度器"""
        print("Data automation started")
        
        while True:
            schedule.run_pending()
            time.sleep(60)

if __name__ == "__main__":
    automation = DataAutomation()
    automation.run()
```

## 最佳实践

### 1. 日志管理
- 使用结构化日志（JSON格式）
- 实现日志轮转和归档
- 设置适当的日志级别
- 集中日志管理

### 2. 错误处理
- 实现重试机制
- 设置超时限制
- 创建恢复检查点
- 自动回滚功能

### 3. 安全措施
- 使用密钥管理系统
- 实施最小权限原则
- 审计所有操作
- 加密敏感数据

### 4. 监控告警
- 设置关键指标监控
- 实时告警通知
- 性能指标追踪
- 健康检查端点

### 5. 可维护性
- 模块化设计
- 配置外部化
- 文档完善
- 版本控制

## 故障排除

### 常见问题

1. **代理无响应**
   - 检查API密钥
   - 验证网络连接
   - 查看日志文件

2. **任务超时**
   - 增加超时时间
   - 优化任务逻辑
   - 考虑并行执行

3. **内存不足**
   - 设置资源限制
   - 实现内存清理
   - 优化数据处理

4. **权限错误**
   - 检查文件权限
   - 验证用户权限
   - 审查安全策略

## 相关资源

- [交互式使用指南](./INTERACTIVE_GUIDE.md)
- [自动化脚本集](./AUTOMATION.md)
- [Claude Code文档](https://docs.anthropic.com/claude-code)
- [示例代码库](https://github.com/githubstudycloud/clagen)