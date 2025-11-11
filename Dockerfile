FROM alpine:3.17

# 1. 添加 OpenResty 官方仓库（v3.17）
RUN echo "https://openresty.org/package/alpine/v3.17/main" >> /etc/apk/repositories

# 2. 下载并安装正确的 RSA 公钥（注意：是 .rsa.pub，不是 .gpg！）
RUN wget -O /etc/apk/keys/openresty.org.rsa.pub \
    https://openresty.org/package/almalinux-openresty.rsa.pub

# 3. 安装 openresty 和其他工具
RUN apk add --no-cache \
    openresty \
    python3 py3-pip \
    bash curl vim

# 软链接
RUN ln -sf python3 /usr/bin/python && \
    ln -sf pip3 /usr/bin/pip

WORKDIR /app
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
