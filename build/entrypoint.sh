#!/bin/sh
# 检查本地配置文件是否存在，若存在则优先使用本地配置，否则从 SUBSCRIBE_URL 下载
if [ -f /etc/mihomo/config.yaml ]; then
    echo "Using local config file..."
else
    echo "Downloading subscribe file..."
    curl -s -H "User-Agent: clash.meta" -o /etc/mihomo/config.yaml "${SUBSCRIBE_URL}"
fi

# 启动 mihomo（后台运行）
echo "Starting mihomo..."
/usr/local/bin/mihomo -d /etc/mihomo 2>&1 | tee /var/log/mihomo.log &

# 启动 nginx（前台运行）
echo "Starting nginx..."
nginx -g 'daemon off;'
