## 适用于 QNAP NAS 的 Clash Docker 镜像 🚀
1. 📐 Web UI 配置（默认使用 zashboard，可在 Dockerfile 中修改使用 metacubexd）
2. ⚙ 使用 smart 内核（可在 Dockerfile 中修改使用默认内核）

### 最佳实践
配合 sub-store 使用，参考 https://github.com/hypooo/clash-host/issues/5#issuecomment-3635648055

### 使用教程 📝
1. 🖥️ clone 代码到机器上
2. 🔧 修改 `docker-compose.yml` 文件中的 `SUBSCRIBE_URL` 变量为订阅链接或远程 yml 配置文件链接
3. ➡️ 执行 `docker compose up -d` 运行容器（使用预构建镜像，无需本地构建）
4. 🌐 访问 `http://机器IP:9080` 查看 Web UI 界面 🎉
5. 🔑 配置 Web UI 的 mihomo api 主机为 `机器IP`，端口为 `9097`
6. 📱 在手机或电脑上设置系统代理为 `机器IP:7897`

#### 本地构建选项
如果需要本地构建镜像（例如修改 Dockerfile 后）：
1. 取消注释 `docker-compose.yml` 中的第 4、5 行
2. 注释掉第 6 行的预构建镜像
3. 执行 `docker compose up -d --build` 运行容器

### 注意点 🛑
1. 使用的是 host 网络模式，机器上的端口 7897（代理端口）、9097（mihomo api 端口）、9080（webui 端口） 不能被占用
2. 默认程序和配置仅在 `QNAP TS-466C` 上测试过，其他系统需要修改 `./build/Dockerfile` 中的 `mihomo` 下载链接后再编译镜像
3. 订阅链接无法访问会导致启动失败
4. 更新订阅需要重启容器

### 常用命令 ⚙
```md
# 销毁容器
docker compose down
# 使用预构建镜像启动容器
docker compose up -d
# 本地编译并启动容器
docker compose up -d --build
# 删除镜像
docker rmi m.ixdev.cn/ghcr.io/hypooo/clash-host:latest
# 本地编译镜像
docker build -t clash-host:latest ./build
# 进入容器
docker exec -it clash-host sh
```
### 使用的项目和网站 🧩
1. [mihomo](https://github.com/MetaCubeX/mihomo)
2. [zashboard](https://github.com/Zephyruso/zashboard)
3. [metacubexd](https://github.com/MetaCubeX/metacubexd)
4. [mihomo wiki](https://wiki.metacubex.one/config/general)
5. [smart 内核](https://github.com/vernesong/OpenClash/releases/tag/mihomo)