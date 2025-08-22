# Claude Code Agents 实战案例集

## 目录
1. [Web开发案例](#web开发案例)
2. [API开发案例](#api开发案例)
3. [数据科学案例](#数据科学案例)
4. [DevOps案例](#devops案例)
5. [移动开发案例](#移动开发案例)
6. [机器学习案例](#机器学习案例)
7. [安全审计案例](#安全审计案例)
8. [性能优化案例](#性能优化案例)

## Web开发案例

### 案例1: 全栈电商平台开发

**场景**: 从零开始构建一个完整的电商平台

#### 交互式开发流程

```bash
# 1. 架构设计
$ claude-code
> /use architect-review
> 设计一个电商平台，包含用户系统、商品管理、订单处理、支付集成

architect-review> 我来设计这个电商平台架构：

## 系统架构
- 前端: React + TypeScript + Redux
- 后端: Node.js + Express + GraphQL
- 数据库: PostgreSQL + Redis
- 支付: Stripe Integration
- 部署: Docker + Kubernetes

## 微服务划分
1. auth-service: 用户认证
2. product-service: 商品管理  
3. order-service: 订单处理
4. payment-service: 支付处理
5. notification-service: 通知服务

# 2. 后端开发
> /use backend-architect
> 基于上述架构创建后端服务

backend-architect> 创建后端服务结构...
[生成完整的后端代码]

# 3. 前端开发
> /use frontend-developer
> 创建React前端应用

# 4. API文档
> /use api-documenter
> 为所有API生成文档

# 5. 测试
> /use test-automator
> 编写E2E测试
```

#### 无人值守自动化脚本

```python
#!/usr/bin/env python3
# ecommerce_automation.py

import subprocess
import json
import time

class EcommerceAutomation:
    def __init__(self):
        self.project_name = "ecommerce-platform"
        self.services = [
            "auth-service",
            "product-service", 
            "order-service",
            "payment-service",
            "notification-service"
        ]
    
    def create_project_structure(self):
        """创建项目结构"""
        print("Creating project structure...")
        
        # 创建各个服务
        for service in self.services:
            self.execute_agent(
                "backend-architect",
                f"create microservice {service} with Express and PostgreSQL"
            )
        
        # 创建前端
        self.execute_agent(
            "frontend-developer",
            "create React app with TypeScript and Redux"
        )
    
    def implement_features(self):
        """实现功能"""
        features = [
            ("auth-service", "implement JWT authentication"),
            ("product-service", "implement CRUD for products"),
            ("order-service", "implement order workflow"),
            ("payment-service", "integrate Stripe payment"),
            ("frontend", "create product listing page"),
            ("frontend", "create shopping cart"),
            ("frontend", "create checkout flow")
        ]
        
        for component, feature in features:
            if "frontend" in component:
                agent = "frontend-developer"
            else:
                agent = "backend-architect"
            
            print(f"Implementing: {feature}")
            self.execute_agent(agent, feature)
    
    def setup_testing(self):
        """设置测试"""
        print("Setting up tests...")
        
        # 单元测试
        self.execute_agent(
            "test-automator",
            "create unit tests for all services"
        )
        
        # 集成测试
        self.execute_agent(
            "test-automator",
            "create integration tests for API endpoints"
        )
        
        # E2E测试
        self.execute_agent(
            "test-automator",
            "create E2E tests with Cypress"
        )
    
    def setup_deployment(self):
        """设置部署"""
        print("Setting up deployment...")
        
        # Docker化
        for service in self.services:
            self.execute_agent(
                "deployment-engineer",
                f"create Dockerfile for {service}"
            )
        
        # Kubernetes配置
        self.execute_agent(
            "deployment-engineer",
            "create Kubernetes manifests for all services"
        )
        
        # CI/CD
        self.execute_agent(
            "deployment-engineer",
            "create GitHub Actions workflow"
        )
    
    def execute_agent(self, agent, task):
        """执行代理任务"""
        cmd = f"claude-code --agent {agent} --task '{task}' --non-interactive"
        subprocess.run(cmd, shell=True)
        time.sleep(2)  # 避免过快调用
    
    def run(self):
        """运行完整流程"""
        print(f"Starting {self.project_name} automation...")
        
        self.create_project_structure()
        self.implement_features()
        self.setup_testing()
        self.setup_deployment()
        
        print("Automation completed!")

if __name__ == "__main__":
    automation = EcommerceAutomation()
    automation.run()
```

### 案例2: 实时聊天应用

**场景**: 构建支持万人在线的实时聊天应用

```bash
# 交互式开发
$ claude-code

# 1. 系统设计
> /use architect-review
> 设计一个实时聊天系统，支持群聊、私聊、文件传输、消息历史

# 2. 后端实现
> /use backend-architect
> 使用Node.js + Socket.io实现WebSocket服务器

# 3. 数据库设计
> /use database-admin
> 设计MongoDB schema存储聊天记录

# 4. 前端实现
> /use frontend-developer
> 创建React聊天界面，支持实时消息和文件上传

# 5. 性能优化
> /use performance-engineer
> 优化WebSocket连接池，支持万人在线
```

## API开发案例

### 案例3: RESTful API开发

**场景**: 为SaaS应用开发完整的RESTful API

#### 完整实现脚本

```bash
#!/bin/bash
# restful_api_development.sh

PROJECT="saas-api"
echo "Developing RESTful API for $PROJECT"

# 1. API设计
claude-code << EOF
/use api-documenter
设计RESTful API，包含以下资源：
- Users (CRUD + 认证)
- Organizations (多租户)
- Projects (项目管理)
- Tasks (任务管理)
- Files (文件上传)
遵循REST最佳实践，包含分页、过滤、排序
EOF

# 2. 实现API
claude-code << EOF
/use backend-architect
使用Express.js实现上述API设计
包含：
- JWT认证
- 角色权限控制
- 请求验证
- 错误处理
- 日志记录
EOF

# 3. 数据库层
claude-code << EOF
/use database-admin
设计PostgreSQL数据库schema
实现：
- 多租户隔离
- 索引优化
- 数据迁移脚本
EOF

# 4. API测试
claude-code << EOF
/use test-automator
编写API测试：
- 单元测试（Jest）
- 集成测试（Supertest）
- 负载测试（K6）
EOF

# 5. API文档
claude-code << EOF
/use api-documenter
生成Swagger/OpenAPI文档
包含：
- 请求/响应示例
- 错误码说明
- 认证说明
EOF

echo "API development completed"
```

### 案例4: GraphQL API开发

**场景**: 构建高性能GraphQL API

```javascript
// graphql_automation.js

const { executeAgent } = require('./claude-automation');

async function developGraphQLAPI() {
    // 1. Schema设计
    await executeAgent('graphql-architect', `
        设计GraphQL schema：
        - User type with authentication
        - Post type with comments
        - Real-time subscriptions
        - Custom scalars for dates
        - Input validation
    `);
    
    // 2. Resolver实现
    await executeAgent('backend-architect', `
        实现GraphQL resolvers：
        - 数据加载器（DataLoader）
        - N+1查询优化
        - 缓存策略
        - 错误处理
    `);
    
    // 3. 认证授权
    await executeAgent('security-auditor', `
        实现GraphQL安全：
        - JWT认证
        - 字段级权限控制
        - 查询深度限制
        - 速率限制
    `);
    
    // 4. 性能优化
    await executeAgent('performance-engineer', `
        优化GraphQL性能：
        - 查询复杂度分析
        - 批处理优化
        - 缓存策略
        - CDN集成
    `);
    
    // 5. 测试
    await executeAgent('test-automator', `
        GraphQL测试：
        - Schema测试
        - Resolver单元测试
        - 集成测试
        - 性能测试
    `);
}

developGraphQLAPI().then(() => {
    console.log('GraphQL API development completed');
});
```

## 数据科学案例

### 案例5: 数据分析管道

**场景**: 构建自动化数据分析管道

```python
#!/usr/bin/env python3
# data_pipeline_automation.py

import pandas as pd
import numpy as np
from datetime import datetime
import subprocess

class DataPipelineAutomation:
    def __init__(self, data_source):
        self.data_source = data_source
        self.timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    
    def extract_data(self):
        """数据提取"""
        print("1. Extracting data...")
        
        # 使用data-engineer代理
        self.run_agent('data-engineer', f'''
            从以下源提取数据：
            - PostgreSQL: sales_data表
            - MongoDB: user_behavior集合
            - S3: logs/{datetime.now():%Y/%m/%d}/
            - API: https://api.example.com/metrics
            合并为统一格式
        ''')
    
    def clean_data(self):
        """数据清洗"""
        print("2. Cleaning data...")
        
        self.run_agent('data-scientist', '''
            数据清洗任务：
            - 处理缺失值（智能填充）
            - 去除重复数据
            - 异常值检测和处理
            - 数据类型转换
            - 标准化/归一化
        ''')
    
    def analyze_data(self):
        """数据分析"""
        print("3. Analyzing data...")
        
        self.run_agent('data-scientist', '''
            执行数据分析：
            - 描述性统计
            - 相关性分析
            - 时间序列分析
            - 用户行为分析
            - 销售趋势分析
            生成可视化图表
        ''')
    
    def build_models(self):
        """构建模型"""
        print("4. Building ML models...")
        
        self.run_agent('ml-engineer', '''
            构建预测模型：
            - 销售预测（ARIMA/Prophet）
            - 用户流失预测（XGBoost）
            - 推荐系统（协同过滤）
            - 异常检测（Isolation Forest）
            包含模型评估和调优
        ''')
    
    def generate_insights(self):
        """生成洞察"""
        print("5. Generating insights...")
        
        self.run_agent('data-scientist', '''
            生成业务洞察报告：
            - 关键发现总结
            - 可操作建议
            - 风险提示
            - 机会识别
            - 下一步行动计划
        ''')
    
    def create_dashboard(self):
        """创建仪表板"""
        print("6. Creating dashboard...")
        
        self.run_agent('frontend-developer', '''
            创建数据仪表板：
            - 使用React + D3.js
            - 实时数据更新
            - 交互式图表
            - 自定义筛选器
            - 导出功能
        ''')
    
    def deploy_pipeline(self):
        """部署管道"""
        print("7. Deploying pipeline...")
        
        self.run_agent('deployment-engineer', '''
            部署数据管道：
            - Apache Airflow DAG配置
            - Docker容器化
            - 定时任务设置
            - 监控告警配置
            - 自动化报告发送
        ''')
    
    def run_agent(self, agent, task):
        """执行代理"""
        cmd = f"claude-code --agent {agent} --task '{task}' --non-interactive"
        subprocess.run(cmd, shell=True)
    
    def run(self):
        """运行完整管道"""
        print(f"Starting data pipeline automation at {self.timestamp}")
        
        self.extract_data()
        self.clean_data()
        self.analyze_data()
        self.build_models()
        self.generate_insights()
        self.create_dashboard()
        self.deploy_pipeline()
        
        print("Data pipeline automation completed!")

# 执行
if __name__ == "__main__":
    pipeline = DataPipelineAutomation("production_db")
    pipeline.run()
```

## DevOps案例

### 案例6: CI/CD管道搭建

**场景**: 为微服务架构搭建完整CI/CD管道

```yaml
# cicd_pipeline_setup.yaml
name: Complete CI/CD Pipeline Setup

stages:
  - name: environment_setup
    tasks:
      - agent: deployment-engineer
        task: |
          设置CI/CD环境：
          - Jenkins服务器配置
          - GitLab Runner部署
          - Docker Registry搭建
          - Kubernetes集群准备
          - 监控系统（Prometheus + Grafana）
  
  - name: pipeline_creation
    tasks:
      - agent: deployment-engineer
        task: |
          创建多阶段管道：
          1. 代码检查（SonarQube）
          2. 构建阶段（多语言支持）
          3. 测试阶段（并行执行）
          4. 安全扫描（Trivy）
          5. 制品发布
          6. 部署阶段（蓝绿部署）
          7. 烟雾测试
          8. 性能测试
          9. 回滚机制
  
  - name: infrastructure_as_code
    tasks:
      - agent: terraform-specialist
        task: |
          使用Terraform创建：
          - AWS基础设施
          - 网络配置（VPC、子网）
          - 计算资源（EC2、EKS）
          - 存储（S3、EBS）
          - 数据库（RDS、DynamoDB）
          - 负载均衡（ALB）
          - 自动扩缩容配置
  
  - name: monitoring_setup
    tasks:
      - agent: devops-troubleshooter
        task: |
          配置监控系统：
          - 应用性能监控（APM）
          - 日志聚合（ELK Stack）
          - 指标收集（Prometheus）
          - 可视化（Grafana）
          - 告警规则配置
          - PagerDuty集成
  
  - name: security_hardening
    tasks:
      - agent: security-auditor
        task: |
          安全加固：
          - 密钥管理（HashiCorp Vault）
          - 网络策略配置
          - RBAC权限设置
          - 安全扫描集成
          - 合规性检查
          - 灾难恢复计划

automation_script: |
  #!/bin/bash
  # cicd_automation.sh
  
  echo "Starting CI/CD pipeline setup..."
  
  # 执行各阶段
  for stage in environment_setup pipeline_creation infrastructure_as_code monitoring_setup security_hardening; do
    echo "Executing stage: $stage"
    claude-code --config cicd_pipeline_setup.yaml --stage $stage --non-interactive
    
    if [ $? -ne 0 ]; then
      echo "Stage $stage failed"
      exit 1
    fi
  done
  
  echo "CI/CD pipeline setup completed!"
```

### 案例7: 灾难恢复系统

**场景**: 构建自动化灾难恢复系统

```python
#!/usr/bin/env python3
# disaster_recovery_system.py

import os
import time
import subprocess
from datetime import datetime
import boto3

class DisasterRecoverySystem:
    def __init__(self):
        self.primary_region = 'us-east-1'
        self.dr_region = 'us-west-2'
        self.recovery_point_objective = 3600  # 1小时
        self.recovery_time_objective = 900    # 15分钟
    
    def setup_backup_strategy(self):
        """设置备份策略"""
        print("Setting up backup strategy...")
        
        self.run_agent('deployment-engineer', f'''
            配置多层备份策略：
            1. 数据库备份
               - 全量备份：每日凌晨2点
               - 增量备份：每小时
               - 事务日志：实时
               - 保留策略：30天
            
            2. 文件系统备份
               - 应用代码：Git仓库
               - 配置文件：S3版本控制
               - 用户数据：S3跨区域复制
            
            3. 系统镜像
               - AMI快照：每日
               - Docker镜像：每次构建
            
            RPO目标：{self.recovery_point_objective}秒
        ''')
    
    def implement_replication(self):
        """实现数据复制"""
        print("Implementing data replication...")
        
        self.run_agent('database-admin', f'''
            设置数据复制：
            1. PostgreSQL流复制
               - 主节点：{self.primary_region}
               - 备节点：{self.dr_region}
               - 同步模式：异步
               - 复制延迟监控
            
            2. Redis复制
               - 主从复制配置
               - Sentinel高可用
            
            3. S3跨区域复制
               - 源：{self.primary_region}
               - 目标：{self.dr_region}
               - 复制规则：全部对象
        ''')
    
    def create_failover_mechanism(self):
        """创建故障转移机制"""
        print("Creating failover mechanism...")
        
        self.run_agent('deployment-engineer', '''
            实现自动故障转移：
            1. 健康检查
               - 应用层：HTTP/HTTPS探测
               - 数据库：连接池监控
               - 基础设施：CloudWatch指标
            
            2. 故障检测
               - 连续失败阈值：3次
               - 检查间隔：30秒
               - 决策时间：90秒
            
            3. 切换流程
               - DNS更新（Route53）
               - 数据库主从切换
               - 缓存预热
               - 通知相关人员
        ''')
    
    def setup_monitoring(self):
        """设置监控"""
        print("Setting up DR monitoring...")
        
        self.run_agent('devops-troubleshooter', '''
            配置灾难恢复监控：
            1. 关键指标
               - 复制延迟
               - 备份完整性
               - 系统可用性
               - RTO/RPO合规性
            
            2. 告警规则
               - 复制延迟 > 5分钟
               - 备份失败
               - 主站点不可用
               - DR站点资源不足
            
            3. 仪表板
               - 实时状态显示
               - 历史趋势分析
               - 恢复时间预测
        ''')
    
    def conduct_dr_test(self):
        """执行灾难恢复测试"""
        print("Conducting DR test...")
        
        test_id = f"dr_test_{datetime.now():%Y%m%d_%H%M%S}"
        
        self.run_agent('test-automator', f'''
            执行灾难恢复测试 {test_id}：
            
            1. 准备阶段
               - 创建测试环境快照
               - 通知相关团队
               - 记录初始状态
            
            2. 模拟故障
               - 主数据库下线
               - 应用服务器故障
               - 网络中断
            
            3. 执行恢复
               - 触发自动故障转移
               - 验证数据完整性
               - 测试应用功能
               - 性能基准测试
            
            4. 结果验证
               - RTO达成：目标{self.recovery_time_objective}秒
               - RPO达成：目标{self.recovery_point_objective}秒
               - 数据一致性检查
               - 性能对比
            
            5. 恢复原始状态
               - 切换回主站点
               - 清理测试数据
               - 生成测试报告
        ''')
    
    def generate_runbook(self):
        """生成运行手册"""
        print("Generating DR runbook...")
        
        self.run_agent('docs-architect', '''
            创建灾难恢复运行手册：
            
            # 灾难恢复运行手册
            
            ## 1. 故障识别
            - 监控告警确认
            - 影响范围评估
            - 升级决策流程
            
            ## 2. 团队通知
            - 值班人员：通过PagerDuty
            - 管理层：邮件+短信
            - 客户通知：状态页更新
            
            ## 3. 恢复步骤
            ### 3.1 数据库恢复
            ```bash
            # 提升备库为主库
            ./promote_standby.sh
            
            # 验证数据完整性
            ./verify_data.sh
            ```
            
            ### 3.2 应用恢复
            ```bash
            # 切换到DR环境
            ./switch_to_dr.sh
            
            # 更新配置
            ./update_config.sh --env=dr
            ```
            
            ### 3.3 DNS切换
            ```bash
            # 更新Route53记录
            ./update_dns.sh --target=dr
            ```
            
            ## 4. 验证清单
            - [ ] 所有服务在线
            - [ ] 数据库可访问
            - [ ] 关键业务流程正常
            - [ ] 性能指标正常
            
            ## 5. 事后总结
            - 故障原因分析
            - 恢复时间统计
            - 改进建议
            - 文档更新
        ''')
    
    def run_agent(self, agent, task):
        """执行代理"""
        cmd = f"claude-code --agent {agent} --task '{task}' --non-interactive"
        subprocess.run(cmd, shell=True)
    
    def run(self):
        """运行完整设置"""
        print("Setting up Disaster Recovery System...")
        
        self.setup_backup_strategy()
        self.implement_replication()
        self.create_failover_mechanism()
        self.setup_monitoring()
        self.conduct_dr_test()
        self.generate_runbook()
        
        print("Disaster Recovery System setup completed!")

# 执行
if __name__ == "__main__":
    dr_system = DisasterRecoverySystem()
    dr_system.run()
```

## 移动开发案例

### 案例8: 跨平台移动应用

**场景**: 使用Flutter开发跨平台应用

```dart
// flutter_app_automation.dart

import 'dart:io';

class FlutterAppAutomation {
  final String appName = 'SuperApp';
  
  Future<void> createApp() async {
    print('Creating Flutter app: $appName');
    
    // 1. 项目初始化
    await runAgent('flutter-expert', '''
      创建Flutter项目：
      - 支持iOS/Android/Web
      - 状态管理：Riverpod
      - 路由：GoRouter
      - 国际化支持
      - 主题切换（暗黑模式）
    ''');
    
    // 2. UI组件开发
    await runAgent('ui-ux-designer', '''
      设计UI组件库：
      - 自定义主题系统
      - 响应式布局
      - 动画效果
      - 自定义Widgets
      - Material 3设计
    ''');
    
    // 3. 功能实现
    await runAgent('mobile-developer', '''
      实现核心功能：
      - 用户认证（Firebase Auth）
      - 实时数据同步（Firestore）
      - 推送通知（FCM）
      - 本地存储（Hive）
      - 图片上传（Firebase Storage）
      - 支付集成（Stripe/Apple Pay）
      - 地图功能（Google Maps）
      - 相机和相册
      - 生物识别认证
    ''');
    
    // 4. 性能优化
    await runAgent('performance-engineer', '''
      Flutter性能优化：
      - Widget树优化
      - 图片延迟加载
      - 列表虚拟化
      - 内存泄漏检测
      - 包大小优化
      - 启动时间优化
    ''');
    
    // 5. 测试
    await runAgent('test-automator', '''
      Flutter测试套件：
      - Widget测试
      - 集成测试
      - Golden测试（UI截图对比）
      - 性能测试
      - 平台特定测试
    ''');
    
    // 6. 发布准备
    await runAgent('deployment-engineer', '''
      应用发布准备：
      - iOS配置（证书、描述文件）
      - Android配置（签名、混淆）
      - App Store准备（截图、描述）
      - Google Play准备
      - CI/CD配置（Fastlane）
      - 版本管理
      - 崩溃报告（Crashlytics）
    ''');
  }
  
  Future<void> runAgent(String agent, String task) async {
    final result = await Process.run(
      'claude-code',
      ['--agent', agent, '--task', task, '--non-interactive'],
    );
    
    if (result.exitCode != 0) {
      print('Error: ${result.stderr}');
    }
  }
}

// 执行
void main() async {
  final automation = FlutterAppAutomation();
  await automation.createApp();
  print('Flutter app creation completed!');
}
```

## 机器学习案例

### 案例9: 端到端ML系统

**场景**: 构建完整的机器学习系统

```python
#!/usr/bin/env python3
# ml_system_automation.py

import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
import subprocess
import json

class MLSystemAutomation:
    def __init__(self, project_name):
        self.project_name = project_name
        self.models = []
        self.best_model = None
    
    def data_preparation(self):
        """数据准备"""
        print("1. Data Preparation Phase")
        
        self.run_agent('data-engineer', '''
            数据准备管道：
            1. 数据收集
               - 从数据湖提取原始数据
               - API数据同步
               - 实时流数据接入
            
            2. 数据清洗
               - 缺失值处理
               - 异常值检测
               - 重复数据删除
               - 数据类型转换
            
            3. 特征工程
               - 特征提取
               - 特征转换
               - 特征选择
               - 特征缩放
            
            4. 数据分割
               - 训练集：70%
               - 验证集：15%
               - 测试集：15%
        ''')
    
    def model_development(self):
        """模型开发"""
        print("2. Model Development Phase")
        
        self.run_agent('ml-engineer', '''
            开发多个模型：
            
            1. 基线模型
               - 逻辑回归
               - 决策树
            
            2. 集成模型
               - 随机森林
               - XGBoost
               - LightGBM
            
            3. 深度学习
               - DNN（TensorFlow）
               - CNN（图像数据）
               - RNN/LSTM（时序数据）
            
            4. AutoML
               - AutoML框架评估
               - 超参数自动调优
            
            包含：
            - 交叉验证
            - 超参数调优（Grid/Random/Bayesian）
            - 模型解释性（SHAP/LIME）
        ''')
    
    def model_evaluation(self):
        """模型评估"""
        print("3. Model Evaluation Phase")
        
        self.run_agent('data-scientist', '''
            全面模型评估：
            
            1. 性能指标
               - 准确率、精确率、召回率
               - F1分数、AUC-ROC
               - 混淆矩阵
               - 特定业务指标
            
            2. 模型对比
               - A/B测试设计
               - 统计显著性检验
               - 业务影响评估
            
            3. 公平性审计
               - 偏见检测
               - 公平性指标
               - 差异影响分析
            
            4. 鲁棒性测试
               - 对抗样本测试
               - 边界条件测试
               - 数据漂移检测
        ''')
    
    def mlops_setup(self):
        """MLOps设置"""
        print("4. MLOps Setup Phase")
        
        self.run_agent('mlops-engineer', '''
            MLOps完整配置：
            
            1. 模型注册
               - MLflow模型注册
               - 版本控制
               - 元数据管理
            
            2. 模型服务化
               - REST API（FastAPI）
               - gRPC服务
               - 批处理服务
               - 流式预测
            
            3. 容器化
               - Docker镜像构建
               - Kubernetes部署
               - 自动扩缩容配置
            
            4. 监控系统
               - 模型性能监控
               - 数据质量监控
               - 预测延迟监控
               - 资源使用监控
            
            5. CI/CD管道
               - 自动化训练
               - 模型验证
               - A/B测试部署
               - 自动回滚
        ''')
    
    def production_deployment(self):
        """生产部署"""
        print("5. Production Deployment Phase")
        
        self.run_agent('deployment-engineer', '''
            生产环境部署：
            
            1. 基础设施
               - GPU集群配置
               - 负载均衡
               - 缓存层（Redis）
               - 消息队列（Kafka）
            
            2. 部署策略
               - 蓝绿部署
               - 金丝雀发布
               - 特征开关
               - 回滚机制
            
            3. 性能优化
               - 模型量化
               - 模型蒸馏
               - 边缘部署优化
               - 批处理优化
            
            4. 安全措施
               - API认证授权
               - 数据加密
               - 访问控制
               - 审计日志
        ''')
    
    def monitoring_and_maintenance(self):
        """监控和维护"""
        print("6. Monitoring & Maintenance Phase")
        
        self.run_agent('ml-engineer', '''
            持续监控和维护：
            
            1. 模型监控
               - 预测准确性追踪
               - 特征重要性变化
               - 预测分布监控
               - 异常检测
            
            2. 数据漂移检测
               - 特征分布监控
               - 标签分布监控
               - 协变量偏移检测
               - 概念漂移检测
            
            3. 自动重训练
               - 触发条件设置
               - 增量学习
               - 在线学习
               - 模型更新策略
            
            4. 报告和分析
               - 每日性能报告
               - 周度业务影响分析
               - 月度模型审计
               - 季度优化建议
        ''')
    
    def create_documentation(self):
        """创建文档"""
        print("7. Documentation Phase")
        
        self.run_agent('docs-architect', '''
            创建完整文档：
            
            1. 技术文档
               - 模型架构说明
               - API文档
               - 部署指南
               - 故障排除手册
            
            2. 业务文档
               - 模型使用指南
               - 业务影响分析
               - ROI报告
               - 风险评估
            
            3. 合规文档
               - 数据使用政策
               - 隐私保护措施
               - 算法公平性报告
               - 审计跟踪
        ''')
    
    def run_agent(self, agent, task):
        """执行代理"""
        cmd = f"claude-code --agent {agent} --task '{task}' --non-interactive"
        subprocess.run(cmd, shell=True)
    
    def run(self):
        """运行完整ML系统构建"""
        print(f"Building ML System: {self.project_name}")
        
        self.data_preparation()
        self.model_development()
        self.model_evaluation()
        self.mlops_setup()
        self.production_deployment()
        self.monitoring_and_maintenance()
        self.create_documentation()
        
        print(f"ML System {self.project_name} completed!")

# 执行
if __name__ == "__main__":
    ml_system = MLSystemAutomation("customer_churn_prediction")
    ml_system.run()
```

## 安全审计案例

### 案例10: 全面安全审计

**场景**: 对应用进行全面安全审计

```bash
#!/bin/bash
# security_audit_automation.sh

PROJECT_PATH="/path/to/project"
REPORT_DIR="security_reports"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo "Starting comprehensive security audit..."

# 1. 代码安全扫描
claude-code << EOF
/use security-auditor
执行代码安全扫描：
1. 静态代码分析（SAST）
   - SQL注入检测
   - XSS漏洞扫描
   - CSRF保护检查
   - 路径遍历检测
   - 命令注入检查
   - XXE攻击防护
   - 不安全的反序列化

2. 依赖项扫描
   - 已知漏洞检查（CVE）
   - 许可证合规性
   - 过时依赖项
   - 供应链攻击风险

3. 密钥和凭证扫描
   - 硬编码密码
   - API密钥泄露
   - 私钥文件
   - 环境变量安全

4. 配置安全
   - 安全头部配置
   - CORS策略
   - CSP策略
   - Cookie安全属性
EOF

# 2. 基础设施安全
claude-code << EOF
/use security-auditor
基础设施安全评估：
1. 网络安全
   - 开放端口扫描
   - 防火墙规则审查
   - VPN配置检查
   - DDoS防护评估

2. 云安全（AWS/Azure/GCP）
   - IAM权限审计
   - S3桶权限检查
   - 网络ACL配置
   - 加密设置验证

3. 容器安全
   - Docker镜像扫描
   - Kubernetes RBAC
   - Pod安全策略
   - 网络策略配置

4. 数据库安全
   - 访问控制审查
   - 加密配置
   - 备份安全性
   - 审计日志启用
EOF

# 3. 应用安全测试
claude-code << EOF
/use security-auditor
动态应用安全测试（DAST）：
1. 认证和授权
   - 密码策略测试
   - 会话管理
   - 权限提升测试
   - OAuth/SAML配置

2. 输入验证
   - 表单验证测试
   - API参数测试
   - 文件上传安全
   - 边界值测试

3. 业务逻辑
   - 工作流绕过测试
   - 竞态条件检测
   - 价格操纵测试
   - 限流测试

4. API安全
   - 端点枚举
   - 速率限制测试
   - GraphQL安全
   - WebSocket安全
EOF

# 4. 渗透测试
claude-code << EOF
/use security-auditor
自动化渗透测试：
1. 信息收集
   - 子域名发现
   - 技术栈识别
   - 员工信息收集
   - 公开数据泄露检查

2. 漏洞利用
   - 自动化攻击向量测试
   - Metasploit集成
   - 自定义Payload测试
   - 提权尝试

3. 后渗透
   - 横向移动评估
   - 数据外泄测试
   - 持久化机制检查
   - 痕迹清理验证
EOF

# 5. 合规性检查
claude-code << EOF
/use legal-advisor
合规性审计：
1. GDPR合规
   - 数据处理合法性
   - 用户同意机制
   - 数据删除权
   - 数据可携带性

2. PCI DSS（支付卡行业）
   - 支付数据保护
   - 网络分段
   - 访问控制
   - 日志和监控

3. HIPAA（医疗）
   - PHI数据保护
   - 访问控制
   - 审计跟踪
   - 数据加密

4. SOC 2
   - 安全控制
   - 可用性
   - 处理完整性
   - 机密性
EOF

# 6. 生成报告
claude-code << EOF
/use docs-architect
生成安全审计报告：

# 安全审计报告 - $TIMESTAMP

## 执行摘要
- 扫描项目：$PROJECT_PATH
- 扫描时间：$(date)
- 风险等级：[计算总体风险]

## 发现的漏洞
### 严重（Critical）
[列出所有严重漏洞]

### 高危（High）
[列出所有高危漏洞]

### 中危（Medium）
[列出所有中危漏洞]

### 低危（Low）
[列出所有低危漏洞]

## 修复建议
[为每个漏洞提供具体修复建议]

## 合规性状态
[列出各项合规标准的符合情况]

## 下一步行动
1. 立即修复严重和高危漏洞
2. 制定中长期安全改进计划
3. 加强安全培训
4. 定期安全审计

## 附录
- 详细扫描日志
- 工具和方法说明
- 参考资源
EOF

echo "Security audit completed. Report saved to $REPORT_DIR/security_audit_$TIMESTAMP.md"
```

## 性能优化案例

### 案例11: 系统性能优化

**场景**: 全栈应用性能优化

```python
#!/usr/bin/env python3
# performance_optimization.py

import time
import psutil
import subprocess
from typing import Dict, List

class PerformanceOptimization:
    def __init__(self, app_name: str):
        self.app_name = app_name
        self.metrics = {}
        self.optimizations = []
    
    def analyze_current_performance(self):
        """分析当前性能"""
        print("Analyzing current performance...")
        
        self.run_agent('performance-engineer', '''
            性能基准测试：
            1. 前端性能
               - 页面加载时间（FCP, LCP, TTI）
               - JavaScript执行时间
               - 资源加载瀑布图
               - 内存使用分析
            
            2. 后端性能
               - API响应时间（P50, P95, P99）
               - 数据库查询性能
               - 缓存命中率
               - 并发处理能力
            
            3. 基础设施
               - CPU使用率
               - 内存使用率
               - 网络I/O
               - 磁盘I/O
            
            生成性能基准报告
        ''')
    
    def optimize_frontend(self):
        """前端优化"""
        print("Optimizing frontend...")
        
        self.run_agent('frontend-developer', '''
            前端性能优化：
            
            1. 资源优化
               - 代码分割（Code Splitting）
               - 懒加载实现
               - Tree Shaking
               - 压缩和混淆
               - WebP图片格式
               - 字体优化
            
            2. 缓存策略
               - Service Worker配置
               - 浏览器缓存优化
               - CDN配置
               - 预加载关键资源
            
            3. 渲染优化
               - 虚拟滚动
               - 防抖和节流
               - Web Workers使用
               - 减少重排重绘
               - CSS优化
            
            4. 网络优化
               - HTTP/2推送
               - 资源预连接
               - DNS预解析
               - 批量请求合并
        ''')
    
    def optimize_backend(self):
        """后端优化"""
        print("Optimizing backend...")
        
        self.run_agent('backend-architect', '''
            后端性能优化：
            
            1. 代码层优化
               - 算法优化
               - 并发处理
               - 异步编程
               - 连接池优化
               - 内存管理
            
            2. 数据库优化
               - 查询优化
               - 索引优化
               - 分区表
               - 读写分离
               - 连接池配置
            
            3. 缓存优化
               - Redis缓存策略
               - 多级缓存
               - 缓存预热
               - 缓存更新策略
            
            4. API优化
               - GraphQL查询优化
               - 分页优化
               - 批量操作
               - 响应压缩
        ''')
    
    def optimize_database(self):
        """数据库优化"""
        print("Optimizing database...")
        
        self.run_agent('database-optimizer', '''
            数据库深度优化：
            
            1. 查询优化
               - 慢查询分析
               - 执行计划优化
               - 查询重写
               - 避免N+1问题
            
            2. 索引策略
               - 索引分析和创建
               - 复合索引优化
               - 索引维护
               - 部分索引使用
            
            3. 架构优化
               - 表结构优化
               - 分区策略
               - 分库分表
               - 归档策略
            
            4. 配置调优
               - 内存配置
               - 缓冲池优化
               - 并发连接数
               - 查询缓存
        ''')
    
    def optimize_infrastructure(self):
        """基础设施优化"""
        print("Optimizing infrastructure...")
        
        self.run_agent('deployment-engineer', '''
            基础设施优化：
            
            1. 自动扩缩容
               - HPA配置（CPU/内存）
               - VPA配置
               - 集群自动扩缩
               - 预测性扩容
            
            2. 负载均衡
               - 算法优化
               - 会话亲和性
               - 健康检查优化
               - 故障转移配置
            
            3. 网络优化
               - CDN配置
               - 边缘计算
               - 网络路由优化
               - 带宽管理
            
            4. 存储优化
               - SSD使用
               - 存储分层
               - 数据压缩
               - I/O调度优化
        ''')
    
    def implement_monitoring(self):
        """实施监控"""
        print("Implementing performance monitoring...")
        
        self.run_agent('devops-troubleshooter', '''
            性能监控实施：
            
            1. APM集成
               - New Relic/Datadog配置
               - 自定义指标
               - 追踪配置
               - 错误追踪
            
            2. 实时监控
               - 实时仪表板
               - 告警规则
               - 异常检测
               - 趋势分析
            
            3. 日志分析
               - 结构化日志
               - 日志聚合
               - 性能日志分析
               - 慢查询日志
            
            4. 用户体验监控
               - RUM（真实用户监控）
               - 合成监控
               - 错误率追踪
               - 用户路径分析
        ''')
    
    def validate_optimizations(self):
        """验证优化效果"""
        print("Validating optimizations...")
        
        self.run_agent('test-automator', '''
            性能优化验证：
            
            1. 负载测试
               - JMeter/K6测试
               - 渐进式负载
               - 峰值测试
               - 持续性测试
            
            2. 压力测试
               - 找出系统极限
               - 资源瓶颈识别
               - 故障点测试
               - 恢复能力测试
            
            3. A/B测试
               - 性能对比
               - 用户体验对比
               - 业务指标对比
               - 统计显著性分析
            
            4. 回归测试
               - 功能完整性
               - 性能基准对比
               - 资源使用对比
               - 稳定性验证
        ''')
    
    def generate_report(self):
        """生成优化报告"""
        print("Generating optimization report...")
        
        self.run_agent('docs-architect', f'''
            生成性能优化报告：
            
            # {self.app_name} 性能优化报告
            
            ## 优化前指标
            - 页面加载时间：3.5s → 1.2s（-66%）
            - API响应时间：450ms → 120ms（-73%）
            - 数据库查询：890ms → 230ms（-74%）
            - 并发用户数：1000 → 5000（+400%）
            
            ## 实施的优化
            ### 前端优化
            - ✅ 代码分割减少包体积40%
            - ✅ 图片优化节省带宽60%
            - ✅ 缓存策略提升二次访问速度80%
            
            ### 后端优化
            - ✅ 数据库查询优化
            - ✅ Redis缓存实施
            - ✅ 异步处理实现
            
            ### 基础设施
            - ✅ 自动扩缩容配置
            - ✅ CDN全球部署
            - ✅ 负载均衡优化
            
            ## ROI分析
            - 服务器成本降低：35%
            - 用户转化率提升：18%
            - 页面跳出率降低：25%
            
            ## 持续优化建议
            1. 实施边缘计算
            2. 升级到HTTP/3
            3. 机器学习预测缓存
            4. 微服务架构迁移
        ''')
    
    def run_agent(self, agent, task):
        """执行代理"""
        cmd = f"claude-code --agent {agent} --task '{task}' --non-interactive"
        subprocess.run(cmd, shell=True)
    
    def run(self):
        """运行完整优化流程"""
        print(f"Starting performance optimization for {self.app_name}")
        
        self.analyze_current_performance()
        self.optimize_frontend()
        self.optimize_backend()
        self.optimize_database()
        self.optimize_infrastructure()
        self.implement_monitoring()
        self.validate_optimizations()
        self.generate_report()
        
        print("Performance optimization completed!")

# 执行
if __name__ == "__main__":
    optimizer = PerformanceOptimization("production_app")
    optimizer.run()
```

## 案例总结

### 成功因素

1. **合理的代理选择**
   - 根据任务选择专业代理
   - 组合使用多个代理
   - 充分利用代理专长

2. **自动化程度**
   - 交互式用于探索和调试
   - 无人值守用于重复任务
   - 混合模式用于复杂项目

3. **监控和反馈**
   - 实时监控执行状态
   - 及时处理错误
   - 持续优化流程

4. **文档和维护**
   - 详细记录所有操作
   - 定期更新脚本
   - 知识共享和传承

### 最佳实践建议

1. **开始简单**：从小任务开始，逐步增加复杂度
2. **迭代改进**：持续优化自动化脚本
3. **错误处理**：完善的错误处理和恢复机制
4. **版本控制**：所有脚本和配置纳入版本控制
5. **团队协作**：共享脚本和经验
6. **安全第一**：始终考虑安全因素
7. **性能监控**：持续监控和优化性能
8. **文档完善**：保持文档的及时更新

## 相关资源

- [交互式使用指南](./INTERACTIVE_GUIDE.md)
- [无人值守自动化指南](./UNATTENDED_GUIDE.md)
- [快速参考手册](./QUICK_REFERENCE.md)
- [GitHub仓库](https://github.com/githubstudycloud/clagen)