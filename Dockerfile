FROM alpine:3.18

# 使用阿里云 OpenResty 镜像源（无签名验证问题）
RUN echo "https://mirrors.aliyun.com/openresty/alpine/v3.18/main" >> /etc/apk/repositories

# 直接安装 openresty（无需 wget 或 pubkey）
RUN apk add --no-cache \
    openresty \
    python3 py3-pip \
    bash curl vim

# 后续保持不变...
RUN ln -sf python3 /usr/bin/python && \
    ln -sf pip3 /usr/bin/pip

WORKDIR /app
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
