#!/bin/sh

# 执行 Python 脚本（后台运行）
echo "Running update_proxies.py"
python3 /usr/local/bin/update_proxies.py 2>&1 | tee /var/log/update_proxies.log &

# 等待 proxies 配置生成
echo "Waiting for proxy configuration..."
while true
do
    if [ -f /etc/mihomo/config.yaml ] && [ $(yq '.proxies | length' /etc/mihomo/config.yaml) -gt 0 ]; then
        break
    fi
    sleep 2
    echo "Still waiting for proxies..."
done

# 启动 mihomo（后台运行）
echo "Starting mihomo..."
/usr/local/bin/mihomo -d /etc/mihomo 2>&1 | tee /var/log/mihomo.log &

# 启动 nginx（前台运行）
echo "Starting nginx in the foreground..."
nginx -g 'daemon off;'
