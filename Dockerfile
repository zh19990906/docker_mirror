FROM alpine:3.18

# Step 1: 添加 OpenResty 官方仓库（适配 Alpine 3.18）
RUN set -eux; \
    echo "https://openresty.org/package/alpine/v3.18/main" >> /etc/apk/repositories; \
    wget -O /etc/apk/keys/almalinux-openresty.rsa.pub https://openresty.org/package/pubkey.gpg

# Step 2: 安装所有依赖（包括 openresty、python、vim 等）
RUN apk add --no-cache \
    openresty \
    python3 py3-pip \
    bash curl vim

# 创建常用软链接
RUN ln -sf python3 /usr/bin/python && \
    ln -sf pip3 /usr/bin/pip

# 设置工作目录
WORKDIR /app

# 复制配置文件和启动脚本
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# 赋予执行权限
RUN chmod +x /usr/local/bin/entrypoint.sh

# 启动入口
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

LABEL MAINTAINER=zhang19990906@gmail.com BUILDTYPE=Aliyun
