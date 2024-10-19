#!/bin/sh

# 激活 Python 虚拟环境
. /opt/venv/bin/activate

# 初始化参数变量
PARAMS=

# 如果 EFB_PROFILE 变量非空，则添加到参数中
if [ -n "$EFB_PROFILE" ]; then
  PARAMS="$PARAMS -p $EFB_PROFILE"
fi

# 添加额外的 EFB 参数
PARAMS="$PARAMS $EFB_PARAMS"

# 启动 ehforwarderbot 并传入构建好的参数
eval "ehforwarderbot $PARAMS"
