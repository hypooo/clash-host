## 适用于 QNAP NAS 的 Clash Docker 镜像 🚀
1. 📐 内置双 Web UI 面板：zashboard（默认）和 metacubexd
2. ⚙ 使用 smart 内核（可在 Dockerfile 中修改使用默认内核）

### 最佳实践
配合 Sub-Store 使用，参考 https://github.com/hypooo/clash-host/issues/5#issuecomment-3635648055

### 使用教程 📝

> ⚠️ 教程中端口以示例配置为准，实际使用时请根据你的本地配置或订阅的配置调整：`9097` 对应 `external-controller` 中端口，`7897` 对应 `mixed-port` 端口

#### 方式一：使用远程订阅链接
1. 🖥️ clone 代码到机器上
2. 🔧 修改 `docker-compose.yml` 文件中的 `SUBSCRIBE_URL` 变量为订阅链接或远程 yml 配置文件链接
3. ➡️ 执行 `docker compose up -d` 运行容器
4. 🌐 访问 Web UI 界面：
   - zashboard：`http://机器IP:9080`
   - metacubexd：`http://机器IP:9080/xd`
5. 🔑 配置 Web UI 的 mihomo api 主机为 `机器IP`，端口为 `9097`
6. 📱 在手机或电脑上设置系统代理为 `机器IP:7897`

#### 方式二：使用本地配置文件
1. 🖥️ clone 代码到机器上
2. 📄 准备好本地 mihomo 配置文件（如 `config.yaml`）
   > 💡 可直接使用项目中的示例 `config.yaml`，需将 `proxy-providers.sub.url` 修改为你的订阅链接地址
3. 🔧 修改 `docker-compose.yml`，取消 `volumes` 相关注释，并将路径指向本地配置文件：
   ```yaml
   volumes:
     - ./config.yaml:/etc/mihomo/config.yaml
   ```
4. ➡️ 执行 `docker compose up -d` 运行容器
5. 🌐 访问 Web UI 界面：
   - zashboard：`http://机器IP:9080`
   - metacubexd：`http://机器IP:9080/xd`
6. 🔑 配置 Web UI 的 mihomo api 主机为 `机器IP`，端口为 `9097`
7. 📱 在手机或电脑上设置系统代理为 `机器IP:7897`

#### 本地构建选项
如果需要本地构建镜像（例如修改 Dockerfile 后）：
1. 取消注释 `docker-compose.yml` 中的第 4、5 行
2. 注释掉第 6 行的预构建镜像
3. 执行 `docker compose up -d --build` 运行容器

### 注意点 🛑
1. 使用的是 host 网络模式，机器上的端口 7897（代理端口）、9097（mihomo api 端口）、9080（webui 端口） 不能被占用
2. 默认程序和配置仅在 `QNAP TS-466C` 上测试过，其他系统需要修改 `./build/Dockerfile` 中的 `mihomo` 下载链接后再编译镜像
3. 使用远程订阅方式时，订阅链接无法访问会导致启动失败
4. 更新配置需要重启容器（远程订阅会重新拉取，本地配置需先修改文件再重启）

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
