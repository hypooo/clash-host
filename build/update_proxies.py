import os
import yaml
import time
import requests
from pathlib import Path
from urllib.parse import quote

def update_proxies():
    # 获取环境变量中的订阅 URL
    subscription_url = os.getenv("SUBSCRIPTION_URL")

    if not subscription_url:
        raise ValueError("环境变量 SUBSCRIPTION_URL 未设置")

    print("正在获取节点信息 📡")

    # 构建完整的转换 URL
    base_url = "https://api.dler.io/sub"
    params = {
        "target": "clash",
        "new_name": "true",
        "url": subscription_url,
        "insert": "false",
        "config": "https://cdn.jsdelivr.net/gh/SleepyHeeead/subconverter-config@master/remote-config/special/basic.ini"
    }

    # 发送请求获取转换后的配置
    response = requests.get(base_url, params=params)
    response.raise_for_status()  # 检查请求是否成功
    remote_yaml = yaml.safe_load(response.text)

    # 读取本地 YAML 文件
    local_yaml_path = Path("/etc/mihomo/config.yaml")
    if not local_yaml_path.exists():
        raise FileNotFoundError(f"本地 YAML 文件 {local_yaml_path} 不存在")

    with open(local_yaml_path, 'r') as file:
        local_yaml = yaml.safe_load(file)

    # 替换 proxies 和 proxy-groups 节点
    local_yaml['proxies'] = remote_yaml.get('proxies', [])
    local_yaml['proxy-groups'] = remote_yaml.get('proxy-groups', [])

    # 打印节点数量
    print(f"加载到 {len(local_yaml['proxies'])} 个节点 🌍")

    # 将更新后的 YAML 写回本地文件
    with open(local_yaml_path, 'w') as file:
        yaml.safe_dump(local_yaml, file, default_flow_style=False)

    print("节点已更新 🎉")

def main():
    while True:
        try:
            update_proxies()
        except Exception as e:
            print(f"更新失败: {str(e)}")
        
        # 打印下次更新时间
        next_update = time.strftime('%Y-%m-%d %H:%M:%S', 
                                  time.localtime(time.time() + 6 * 3600))
        print(f"下次更新时间: {next_update}")
        
        # 休眠6小时
        time.sleep(6 * 3600)

if __name__ == "__main__":
    main()
