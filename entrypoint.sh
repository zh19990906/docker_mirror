#!/bin/bash
set -e

# 输出欢迎信息和使用指南
echo "=============================================="
echo "🚀 Base Proxy + Python Environment Ready!"
echo "----------------------------------------------"
echo "🐍 Python version: $(python --version)"
echo "📂 Recommended working directory: /app"
echo "🌐 Proxy rule: /proxy/<PORT>/<PATH> → http://127.0.0.1:<PORT>/<PATH>"
echo "📝 Example: http://localhost:8080/proxy/2110/docs"
echo "🔒 Allowed ports: 2000-2999, 3000-3009, 5000-5009, 8080-8089"
echo "----------------------------------------------"
echo "💡 Tip: Mount your code to /app and start your service manually,"
echo "       or extend this image with your own CMD."
echo "=============================================="
echo ""

# 确保 Nginx 配置目录存在（防御性）
mkdir -p /usr/local/openresty/nginx/logs

# 启动 OpenResty（前台模式，保持容器运行）
exec openresty -g "daemon off;"
