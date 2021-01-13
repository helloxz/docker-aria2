# Aria2 Docker版

## 构建镜像

先克隆此项目到本地：

```bash
git clone https://github.com/helloxz/docker-aria2.git
```

通过Dockerfile构建此镜像

```bash
docker build -t xxx/aria2:latest .
```

* `xxx`名字自己取，如果需要推送到Docker Hub，`xxx`则为您Docker Hub用户名



## 运行容器

```bash
docker run --name="aria2" -d -p 6800:6800 -p 51413:51413 \
    -v /data/download:/data/download \
    -e PASS="xiaoz.me" \
    helloz/aria2:latest
```

* 6080/51413：为Aria2使用端口，请注意防火墙放行

* /data/download：为下载目录，请自行设置

* xiaoz.me：为Aria2 RPC密钥，请注意修改

  

如果你比较懒不想自己构建镜像，也可以使用xiaoz已经构建好的镜像直接进行部署，命令为：

```bash
docker run --name="aria2" -d -p 6800:6800 -p 51413:51413 \
    -v /data/download:/data/download \
    -e PASS="xiaoz.me" \
    helloz/aria2
```



## 使用CCAA

如果您想在您的VPS一键安装Aria2 + AriaNG + FileBrowser等软件，请参考CCAA项目：https://github.com/helloxz/ccaa



## 其它说明

* 此镜像基于Alpine Linux制作，体积小巧
* 此镜像适用于X86/X64架构，不支持ARM
* 此镜像仅包含Aria2，请自行配合AriaNG等WEB界面使用



## 联系我

* Blog:https://www.xiaoz.me/
* QQ:337003006



## 鸣谢

此项目离不开以下项目，在此表示感谢。

* https://github.com/q3aql/aria2-static-builds
* https://www.alpinelinux.org/