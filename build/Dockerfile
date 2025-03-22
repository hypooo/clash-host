FROM docker.1ms.run/nginx:alpine

# 替换 APK 源，加速 apk 安装
RUN sed -i 's#https\?://dl-cdn.alpinelinux.org/alpine#https://mirrors.cernet.edu.cn/alpine#g' /etc/apk/repositories

# 安装系统依赖和 tzdata 以设置时区
RUN apk add --no-cache tzdata

# 设置时区为 "Asia/Shanghai"
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone

# 设置环境变量
ENV LANG=C.UTF-8
ENV TZ=Asia/Shanghai

# 复制前端文件
COPY ./nginx-default.conf /etc/nginx/conf.d/default.conf
COPY ./yacd /usr/share/nginx/html

# 获取 mihomo 程序最新版本，默认使用 qts 兼容的程序 mihomo-linux-amd64-compatible，其他系统需要自行更换下载链接
RUN LATEST_VERSION=$(curl -s https://api.github.com/repos/MetaCubeX/mihomo/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/') && \
    curl -L https://ghfast.top/github.com/MetaCubeX/mihomo/releases/download/${LATEST_VERSION}/mihomo-linux-amd64-compatible-${LATEST_VERSION}.gz -o mihomo.gz && \
    gzip -d mihomo.gz && \
    mv mihomo /usr/local/bin/mihomo && \
    chmod +x /usr/local/bin/mihomo

# 复制启动脚本
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 暴露 proxy 端口
EXPOSE 7897

# 暴露 api 端口
EXPOSE 9097

# 暴露 nginx 端口
EXPOSE 9080

# 设置容器启动时的默认命令
CMD ["/bin/sh", "/entrypoint.sh"]