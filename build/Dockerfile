FROM nginx:alpine

# 替换 APK 源，加速 apk 安装
# RUN sed -i 's#https\?://dl-cdn.alpinelinux.org/alpine#https://mirrors.cernet.edu.cn/alpine#g' /etc/apk/repositories

# 安装系统依赖和 tzdata 以设置时区
RUN apk add --no-cache tzdata unzip

# 设置时区为 "Asia/Shanghai"
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone

# 设置环境变量
ENV LANG=C.UTF-8
ENV TZ=Asia/Shanghai

# 复制 nginx 配置文件
COPY ./nginx-default.conf /etc/nginx/conf.d/default.conf

# 获取 https://github.com/Zephyruso/zashboard 的最新版本，下载 https://github.com/Zephyruso/zashboard/releases/download/${LATEST_VERSION}/dist.zip 解压到 /usr/share/nginx/html 目录
RUN LATEST_VERSION=$(curl -sL https://api.github.com/repos/Zephyruso/zashboard/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/') && \
    # 下载最新版本的 dist.zip 文件
    curl -L https://github.com/Zephyruso/zashboard/releases/download/${LATEST_VERSION}/dist.zip -o dist.zip && \
    # 删除目标目录下的所有文件
    rm -rf /usr/share/nginx/html/* && \
    # 解压文件到目标目录
    unzip dist.zip -d /usr/share/nginx/html && \
    mv /usr/share/nginx/html/dist/* /usr/share/nginx/html/ && \
    rm -rf /usr/share/nginx/html/dist && \
    # 删除下载的压缩包
    rm dist.zip

# 获取 https://github.com/MetaCubeX/metacubexd 的最新版本，下载 https://github.com/MetaCubeX/metacubexd/releases/download/${LATEST_VERSION}/compressed-dist.tgz 解压到 /usr/share/nginx/html 目录
RUN LATEST_VERSION=$(curl -sL https://api.github.com/repos/MetaCubeX/metacubexd/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/') && \
    # 下载最新版本的 compressed-dist.tgz 文件
    curl -L https://github.com/MetaCubeX/metacubexd/releases/download/${LATEST_VERSION}/compressed-dist.tgz -o compressed-dist.tgz && \
    # 解压文件到目标目录
    tar -xzf compressed-dist.tgz -C /usr/share/nginx/html/xd && \
    # 删除下载的压缩包
    rm compressed-dist.tgz

# 获取 mihomo 程序最新版本，默认使用 qts 兼容的程序 mihomo-linux-amd64-compatible，其他系统需要自行更换下载链接
# RUN LATEST_VERSION=$(curl -sL https://api.github.com/repos/MetaCubeX/mihomo/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/') && \
#     curl -L https://github.com/MetaCubeX/mihomo/releases/download/${LATEST_VERSION}/mihomo-linux-amd64-compatible-${LATEST_VERSION}.gz -o mihomo.gz && \
#     gzip -d mihomo.gz && \
#     mv mihomo /usr/local/bin/mihomo && \
#     chmod +x /usr/local/bin/mihomo

# 获取 mihomo 程序 smart 内核最新版本
RUN VERSION=$(curl -sL https://github.com/vernesong/mihomo/releases/download/Prerelease-Alpha/version.txt) && \
    curl -L https://github.com/vernesong/mihomo/releases/download/Prerelease-Alpha/mihomo-linux-amd64-compatible-${VERSION}.gz -o mihomo.gz && \
    gzip -d mihomo.gz && \
    mv mihomo /usr/local/bin/mihomo && \
    chmod +x /usr/local/bin/mihomo

# 创建配置文件目录
RUN mkdir -p /etc/mihomo

# 复制启动脚本
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 暴露 nginx 端口
EXPOSE 9080

# 设置容器启动时的默认命令
CMD ["/bin/sh", "/entrypoint.sh"]