#!/bin/sh
# 获取订阅文件,链接从环境变量 ${SUBSCRIBE_URL} 获取，需要添加请求体 User-Agent 为 clash.meta， 保存到 /etc/mihomo/config.yaml
echo "Downloading subscribe file..."
curl -s -H "User-Agent: clash.meta" -o /etc/mihomo/config.yaml "${SUBSCRIBE_URL}"

# 启动 mihomo（后台运行）
echo "Starting mihomo..."
/usr/local/bin/mihomo -d /etc/mihomo 2>&1 | tee /var/log/mihomo.log &

# 启动 nginx（前台运行）
echo "Starting nginx..."
nginx -g 'daemon off;'
