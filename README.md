# ehforwarderbot

## install

```console
$ git clone https://github.com/jiz4oh/ehforwarderbot ehforwarderbot
```

## configuration

1. in `profiles/default/blueset.telegram/config.yaml`
   1. Update `token`
   2. Update userid in `admins`
2. (optional) in `profiles/default/config.yaml`
   1. add extra slave_channels

## start

```console
$ docker build ehforwarderbot/ -t efb
$ docker rm -f efb >/dev/null 2>&1 && docker run -d --name=efb --restart=always -v $PWD/ehforwarderbot/:/data/ efb
```

# fork 修改内容
## 新增两个比较实用的插件
```console
# 语音转文字
pip3 install efb-voice_recog-middleware
# 快递消息公众号提醒
pip3 install efb-notice-middleware
```
## 采用docker-compose
```yaml
version: '3.8'
services:
  efb:
    image: ghcr.io/markwhitey/ehforwarderbot:latest
    container_name: efb
    restart: always
    volumes:
      - ./ehforwarderbot:/data
```
