# 代理配置指南

## 代理设置示例

### 1. 环境变量配置

#### Windows (CMD)
```cmd
set http_proxy=http://YOUR_PROXY_IP:YOUR_PORT
set https_proxy=http://YOUR_PROXY_IP:YOUR_PORT

# 示例
set http_proxy=http://10.0.0.1:8080
set https_proxy=http://10.0.0.1:8080
```

#### Windows (PowerShell)
```powershell
$env:http_proxy = "http://YOUR_PROXY_IP:YOUR_PORT"
$env:https_proxy = "http://YOUR_PROXY_IP:YOUR_PORT"

# 示例
$env:http_proxy = "http://10.0.0.1:8080"
$env:https_proxy = "http://10.0.0.1:8080"
```

#### Linux/macOS (Bash)
```bash
export http_proxy=http://YOUR_PROXY_IP:YOUR_PORT
export https_proxy=http://YOUR_PROXY_IP:YOUR_PORT

# 示例
export http_proxy=http://10.0.0.1:8080
export https_proxy=http://10.0.0.1:8080
```

### 2. Git代理配置

#### 全局配置
```bash
# 设置代理
git config --global http.proxy http://YOUR_PROXY_IP:YOUR_PORT
git config --global https.proxy http://YOUR_PROXY_IP:YOUR_PORT

# 示例
git config --global http.proxy http://10.0.0.1:8080
git config --global https.proxy http://10.0.0.1:8080

# 取消代理
git config --global --unset http.proxy
git config --global --unset https.proxy
```

#### 仅对GitHub配置
```bash
# 设置GitHub专用代理
git config --global http.https://github.com.proxy http://YOUR_PROXY_IP:YOUR_PORT

# 示例
git config --global http.https://github.com.proxy http://10.0.0.1:8080
```

### 3. 带认证的代理

```bash
# 格式
http://username:password@proxy_ip:port

# 示例
export http_proxy=http://user123:pass456@10.0.0.1:8080
export https_proxy=http://user123:pass456@10.0.0.1:8080
```

## 代理配置脚本

### 自动配置脚本 (proxy_setup.sh)

```bash
#!/bin/bash

# 代理配置脚本
PROXY_IP="YOUR_PROXY_IP"
PROXY_PORT="YOUR_PORT"

# 示例值（请替换为实际值）
# PROXY_IP="10.0.0.1"
# PROXY_PORT="8080"

# 函数：设置代理
set_proxy() {
    export http_proxy="http://$PROXY_IP:$PROXY_PORT"
    export https_proxy="http://$PROXY_IP:$PROXY_PORT"
    export HTTP_PROXY="http://$PROXY_IP:$PROXY_PORT"
    export HTTPS_PROXY="http://$PROXY_IP:$PROXY_PORT"
    
    # Git代理
    git config --global http.proxy "http://$PROXY_IP:$PROXY_PORT"
    git config --global https.proxy "http://$PROXY_IP:$PROXY_PORT"
    
    echo "✅ 代理已设置: $PROXY_IP:$PROXY_PORT"
}

# 函数：取消代理
unset_proxy() {
    unset http_proxy
    unset https_proxy
    unset HTTP_PROXY
    unset HTTPS_PROXY
    
    git config --global --unset http.proxy
    git config --global --unset https.proxy
    
    echo "✅ 代理已取消"
}

# 函数：显示当前代理
show_proxy() {
    echo "当前代理设置："
    echo "http_proxy: $http_proxy"
    echo "https_proxy: $https_proxy"
    echo "Git http.proxy: $(git config --global http.proxy)"
    echo "Git https.proxy: $(git config --global https.proxy)"
}

# 主菜单
case "$1" in
    set)
        set_proxy
        ;;
    unset)
        unset_proxy
        ;;
    show)
        show_proxy
        ;;
    *)
        echo "使用方法: $0 {set|unset|show}"
        echo "  set   - 设置代理"
        echo "  unset - 取消代理"
        echo "  show  - 显示当前代理"
        exit 1
        ;;
esac
```

### Windows批处理脚本 (proxy_setup.bat)

```batch
@echo off
setlocal

REM 代理配置
set PROXY_IP=YOUR_PROXY_IP
set PROXY_PORT=YOUR_PORT

REM 示例值（请替换为实际值）
REM set PROXY_IP=10.0.0.1
REM set PROXY_PORT=8080

if "%1"=="set" goto :set_proxy
if "%1"=="unset" goto :unset_proxy
if "%1"=="show" goto :show_proxy
goto :usage

:set_proxy
setx http_proxy "http://%PROXY_IP%:%PROXY_PORT%"
setx https_proxy "http://%PROXY_IP%:%PROXY_PORT%"
git config --global http.proxy http://%PROXY_IP%:%PROXY_PORT%
git config --global https.proxy http://%PROXY_IP%:%PROXY_PORT%
echo 代理已设置: %PROXY_IP%:%PROXY_PORT%
goto :end

:unset_proxy
setx http_proxy ""
setx https_proxy ""
git config --global --unset http.proxy
git config --global --unset https.proxy
echo 代理已取消
goto :end

:show_proxy
echo 当前代理设置：
echo http_proxy: %http_proxy%
echo https_proxy: %https_proxy%
git config --global http.proxy
git config --global https.proxy
goto :end

:usage
echo 使用方法: %0 {set^|unset^|show}
echo   set   - 设置代理
echo   unset - 取消代理
echo   show  - 显示当前代理

:end
endlocal
```

## 常见代理服务器配置

### 1. Squid代理
```bash
# 默认端口: 3128
export http_proxy=http://proxy.example.com:3128
```

### 2. Shadowsocks代理
```bash
# 默认端口: 1080
export http_proxy=http://127.0.0.1:1080
```

### 3. V2Ray代理
```bash
# HTTP代理端口: 10809
# SOCKS5代理端口: 10808
export http_proxy=http://127.0.0.1:10809
```

### 4. Clash代理
```bash
# 默认端口: 7890
export http_proxy=http://127.0.0.1:7890
```

## 代理测试

### 测试连接
```bash
# 测试HTTP代理
curl -I http://www.google.com

# 测试HTTPS代理
curl -I https://www.github.com

# 测试Git连接
git ls-remote https://github.com/githubstudycloud/clagen.git
```

### 诊断脚本
```bash
#!/bin/bash
# proxy_test.sh

echo "=== 代理连接测试 ==="

# 测试环境变量
echo "1. 环境变量检查:"
echo "   http_proxy: ${http_proxy:-未设置}"
echo "   https_proxy: ${https_proxy:-未设置}"

# 测试Git配置
echo "2. Git代理配置:"
echo "   http.proxy: $(git config --global http.proxy || echo '未设置')"
echo "   https.proxy: $(git config --global https.proxy || echo '未设置')"

# 测试连接
echo "3. 连接测试:"
if curl -s -o /dev/null -w "%{http_code}" https://api.github.com | grep -q "200"; then
    echo "   ✅ GitHub API连接成功"
else
    echo "   ❌ GitHub API连接失败"
fi

if git ls-remote https://github.com/githubstudycloud/clagen.git &>/dev/null; then
    echo "   ✅ Git仓库连接成功"
else
    echo "   ❌ Git仓库连接失败"
fi
```

## 故障排除

### 1. 代理无法连接
```bash
# 检查代理服务器是否运行
ping YOUR_PROXY_IP
telnet YOUR_PROXY_IP YOUR_PORT

# 检查防火墙设置
# Windows
netsh advfirewall show allprofiles

# Linux
sudo iptables -L
```

### 2. Git推送失败
```bash
# 使用SSH替代HTTPS
git remote set-url origin git@github.com:githubstudycloud/clagen.git

# 增加缓冲区大小
git config --global http.postBuffer 524288000
```

### 3. SSL证书问题
```bash
# 临时禁用SSL验证（不推荐生产环境）
git config --global http.sslVerify false

# 设置证书路径
git config --global http.sslCAInfo /path/to/certificate.pem
```

## 自动切换代理

### 基于网络环境的自动切换脚本
```bash
#!/bin/bash
# auto_proxy.sh

# 检测网络环境
check_network() {
    # 检查是否在公司网络
    if ping -c 1 -W 1 company.internal.domain &>/dev/null; then
        echo "company"
    # 检查是否在家庭网络
    elif ping -c 1 -W 1 192.168.1.1 &>/dev/null; then
        echo "home"
    else
        echo "public"
    fi
}

# 根据网络设置代理
NETWORK=$(check_network)

case $NETWORK in
    company)
        export http_proxy=http://10.0.0.1:8080
        export https_proxy=http://10.0.0.1:8080
        echo "设置公司代理"
        ;;
    home)
        export http_proxy=http://192.168.1.100:7890
        export https_proxy=http://192.168.1.100:7890
        echo "设置家庭代理"
        ;;
    public)
        unset http_proxy
        unset https_proxy
        echo "不使用代理"
        ;;
esac
```

## 最佳实践

1. **安全性**
   - 不要在脚本中硬编码密码
   - 使用环境变量或密钥管理工具
   - 定期更换代理密码

2. **性能优化**
   - 选择延迟低的代理服务器
   - 使用代理池进行负载均衡
   - 设置合理的超时时间

3. **维护建议**
   - 定期检查代理可用性
   - 记录代理使用日志
   - 建立备用代理列表

## 相关命令快速参考

```bash
# 设置代理
export http_proxy=http://10.0.0.1:8080

# 取消代理
unset http_proxy

# Git设置代理
git config --global http.proxy http://10.0.0.1:8080

# Git取消代理
git config --global --unset http.proxy

# 查看Git配置
git config --global -l | grep proxy

# 测试连接
curl -I https://github.com
```