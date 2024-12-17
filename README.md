## 适用于 QNAP NAS 的 Clash Docker 镜像 🚀
1. 自动更新订阅 🔄
2. 完善的规则集 ⚖️
3. Yacd Web UI 配置 📐

### 使用教程 📝
1. 🖥️ clone 代码到机器上
2. 🔧 修改 `docker-compose.yml` 中的环境变量 `SUBSCRIPTION_URL` 为你的订阅地址
3. ➡️ 进入 `./build` 目录，执行 `docker build -t clash:latest .` 编译镜像
4. 🚀 编译完成后进入上级目录 `clash-host` 执行 `docker compose up -d` 启动容器
5. 🌐 访问 `http://机器IP:9080/?hostname=机器IP&port=9097&secret=` 查看 yacd 界面 🎉
6. 📱 在手机或电脑上设置系统代理为 `机器IP:7897`

### 注意点 🛑
1. 使用的是 host 网络模式，机器上的端口 7897（代理端口）、9097（mihomo api 端口）、9080（yacd webui端口） 不能被占用
2. 默认程序和配置仅在 QNAP TS-466C Container Station 上测试过，其他系统需要自行下载对应架构的 mihomo 程序并重命名为 mihomo 再替换 ./build/mihomo 文件后再编译镜像！！！

### 常用命令 ⚙
```md
# 销毁容器
docker compose down
# 删除镜像
docker rmi clash:latest
# 编译镜像
docker build -t clash:latest .
# 启动容器
docker compose up -d
# 进入容器
docker exec -it clash sh
# 手动更新订阅
docker exec clash /opt/venv/bin/python3 /usr/local/bin/update_proxies.py
```

### 使用的项目和网站 🧩
1. [mihomo](https://github.com/MetaCubeX/mihomo)
2. [Yacd-meta](https://github.com/MetaCubeX/Yacd-meta)
2. [clash-rules](https://github.com/Loyalsoldier/clash-rules)
2. [ACL4SSR 订阅转换](https://acl4ssr.netlify.app/)