# 使用 Alpine Linux 作为基础镜像
FROM alpine:latest

# 设置环境变量
ENV LANG C.UTF-8
ENV TZ 'Asia/Shanghai'
ENV EFB_DATA_PATH /data/
ENV EFB_PARAMS ""
ENV EFB_PROFILE "default"
ENV HTTPS_PROXY ""

# 安装系统依赖和Python3
RUN apk add --no-cache tzdata ca-certificates \
       ffmpeg libmagic python3 \
       tiff libwebp freetype lcms2 openjpeg py3-olefile openblas \
       py3-numpy py3-pillow py3-cryptography py3-decorator cairo py3-pip \
       git build-base gcc python3-dev

# 创建虚拟环境并激活它
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# 升级 pip 并在虚拟环境中安装 Python 包
RUN pip install --upgrade pip \
    && pip install pysocks ehforwarderbot efb-telegram-master \
    && pip install git+https://github.com/ehForwarderBot/efb-wechat-slave.git \
    && pip install efb-voice_recog-middleware \
    && pip install efb-notice-middleware

# 设置时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone

# 复制启动脚本
COPY entrypoint.sh /entrypoint.sh

# 设置可执行的入口点脚本
ENTRYPOINT ["/entrypoint.sh"]
