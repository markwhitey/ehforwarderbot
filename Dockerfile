# 使用 Alpine Linux 作为基础镜像
FROM alpine:latest

# 设置环境变量
ENV LANG C.UTF-8
ENV TZ 'Asia/Shanghai'
ENV EFB_DATA_PATH /data/
ENV EFB_PARAMS ""
ENV EFB_PROFILE "default"
ENV HTTPS_PROXY ""

# 安装系统依赖和 Python3
RUN apk add --no-cache tzdata ca-certificates ffmpeg libmagic python3 \
    tiff libwebp freetype lcms2 openjpeg py3-olefile openblas py3-numpy \
    py3-pillow py3-cryptography py3-decorator cairo py3-pip git

# 安装构建依赖并创建虚拟环境，安装后删除构建依赖
RUN apk add --no-cache --virtual .build-deps build-base gcc python3-dev \
    && python3 -m venv /opt/venv \
    && /opt/venv/bin/pip install --upgrade pip \
    && /opt/venv/bin/pip install --no-cache-dir pysocks ehforwarderbot efb-telegram-master \
    && /opt/venv/bin/pip install --no-cache-dir git+https://github.com/ehForwarderBot/efb-wechat-slave.git \
    && /opt/venv/bin/pip install --no-cache-dir efb-voice_recog-middleware \
    && /opt/venv/bin/pip install --no-cache-dir efb-notice-middleware \
    && /opt/venv/bin/pip install --no-cache-dir python-telegram-bot==13.7 urllib3 six \
    # 删除构建依赖，减小体积
    && apk del .build-deps

# 设置时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone

# 复制启动脚本
COPY entrypoint.sh /entrypoint.sh

# 确保启动脚本可执行
RUN chmod +x /entrypoint.sh

# 设置可执行的入口点脚本
ENTRYPOINT ["/entrypoint.sh"]
