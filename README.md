## 适用于 QNAP NAS 的 Clash Docker 镜像 🚀
1. 自动更新订阅 🔄
2. 完善的规则集 ⚖️
3. Yacd Web UI 配置 📐

### 使用教程 📝
1. 🖥️ clone 代码到机器上
2. 🔧 修改 `config.yaml` 中的 `proxy-provider-1` 节点下的 `url` 为你的订阅地址，可以添加多个订阅地址例如 `proxy-provider-2` 等等
3. ➡️ 执行 `docker compose up -d --build` 运行容器
4. 🌐 访问 `http://机器IP:9080/?hostname=机器IP&port=9097&secret=` 查看 yacd 界面 🎉
5. 📱 在手机或电脑上设置系统代理为 `机器IP:7897`

### 注意点 🛑
1. 使用的是 host 网络模式，机器上的端口 7897（代理端口）、9097（mihomo api 端口）、9080（yacd webui端口） 不能被占用
2. 默认程序和配置仅在 `QNAP TS-466C Container Station` 上测试过，其他系统需要修改 `./build/Dockerfile` 中的 `mihomo` 下载链接后再编译镜像！！！

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
```
### 使用的项目和网站 🧩
1. [mihomo](https://github.com/MetaCubeX/mihomo)
2. [Yacd-meta](https://github.com/MetaCubeX/Yacd-meta)
3. [geoip](https://github.com/Loyalsoldier/geoip)
4. [meta-rules-dat](https://github.com/MetaCubeX/meta-rules-dat)
5. [clash-rules](https://github.com/Loyalsoldier/clash-rules)
6. [mihomo wiki](https://wiki.metacubex.one/config/general/)