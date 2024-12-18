FROM nginx:alpine

# 替换 APK 源，加速 apk 安装
RUN sed -i 's#https\?://dl-cdn.alpinelinux.org/alpine#https://mirrors.cernet.edu.cn/alpine#g' /etc/apk/repositories

# 安装系统依赖和 tzdata 以设置时区
RUN apk add --no-cache tzdata

# 设置时区为 "Asia/Shanghai"
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone

# 安装 Python 和必要的依赖
RUN apk add --no-cache python3 py3-pip yq

# 设置 PIP 源
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip3 install --no-cache --upgrade pip \
    && pip3 config set global.index-url https://mirrors.cernet.edu.cn/pypi/web/simple

# 安装 requests、pyyaml 库
RUN pip3 install requests pyyaml

# 设置环境变量
ENV PYTHONIOENCODING=UTF-8
ENV PYTHONUNBUFFERED=1
ENV LANG=C.UTF-8

# 设置 TZ 环境变量
ENV TZ=Asia/Shanghai
ENV SUBSCRIPTION_URL=

COPY ./nginx-default.conf /etc/nginx/conf.d/default.conf
COPY ./public /usr/share/nginx/html
COPY ./config.yaml /etc/mihomo/config.yaml
COPY ./update_proxies.py /usr/local/bin/update_proxies.py

COPY ./GeoData/Country.mmdb /etc/mihomo/Country.mmdb
COPY ./GeoData/geosite.dat /etc/mihomo/geosite.dat
COPY ./GeoData/geoip.dat /etc/mihomo/geoip.dat

# 复制二进制文件,需要 qts 兼容的程序 mihomo-linux-amd64-compatible
COPY ./mihomo /usr/local/bin/mihomo

# 确保可执行文件有执行权限
RUN chmod +x /usr/local/bin/mihomo

# 暴露 proxy 端口
EXPOSE 7897

# 暴露 api 端口
EXPOSE 9097

# 暴露 nginx 端口
EXPOSE 9080

# 配置启动脚本
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 设置容器启动时的默认命令
CMD ["/bin/sh", "/entrypoint.sh"]
