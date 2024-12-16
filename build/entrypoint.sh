#!/bin/sh

# 执行 Python 脚本
echo "Running update_proxies.py"
python3 /usr/local/bin/update_proxies.py

# 启动 cron 服务（后台运行）
echo "Starting cron service in the background..."
crond

# 启动 mihomo（后台运行）
echo "Starting mihomo..."
/usr/local/bin/mihomo -d /etc/mihomo &

# 启动 nginx（前台运行）
echo "Starting nginx in the foreground..."
nginx -g 'daemon off;'
