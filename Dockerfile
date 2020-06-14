FROM alpine:3.12.0

WORKDIR /root
#复制启动文件
COPY ./run.sh /usr/sbin
RUN wget https://raw.githubusercontent.com/helloxz/docker-aria2/master/aria2-install.sh && sh aria2-install.sh
VOLUME /data/download
EXPOSE 6800 51413