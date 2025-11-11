FROM alpine:3.18

# 安装 OpenResty、Python 3.11+ 和 vim（用于容器内编辑）
RUN apk add --no-cache \
    openresty \
    python3 py3-pip \
    bash curl \
    vim

# 创建软链接
RUN ln -sf python3 /usr/bin/python && \
    ln -sf pip3 /usr/bin/pip

# 设置工作目录
WORKDIR /app

# 复制配置和启动脚本
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# 赋予执行权限
RUN chmod +x /usr/local/bin/entrypoint.sh

# 默认入口点
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

LABEL MAINTAINER=zhang19990906@gmail.com BUILDTYPE=Aliyun
