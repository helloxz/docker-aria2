FROM alpine:3.12.0

WORKDIR /root
#复制启动文件
COPY ./run.sh /usr/sbin
#复制安装脚本
COPY ./aria2-install.sh /root
RUN sh aria2-install.sh
VOLUME /data/download
EXPOSE 6800 51000
CMD ["sh","/usr/sbin/run.sh"]