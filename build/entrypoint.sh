#!/bin/sh

# 启动 mihomo（后台运行）
echo "Starting mihomo..."
/usr/local/bin/mihomo -d /etc/mihomo 2>&1 | tee /var/log/mihomo.log &

# 启动 nginx（前台运行）
echo "Starting nginx..."
nginx -g 'daemon off;'
