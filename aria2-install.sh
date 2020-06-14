#!/bin/sh
#####		Docker for aria2一键安装脚本		#####
#####		Update:2020-06-14				#####
#####		Author:xiaoz					#####

#导入环境变量
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/bin:/sbin
export PATH

#路径设置
aria2_url='http://soft.xiaoz.org/linux/aria2-1.35.0-linux-gnu-64bit-build1.tar.bz2'
#临时目录
aria2_temp='/root/aria2_temp'
#下载目录
downpath='/data/download'

#安装之前的准备
function setout(){
	#安装需要的软件
	apk add wget tar make bzip2
	#创建临时目录
	cd
	mkdir -p ${aria2_temp}
	#赋予启动脚本权限
	chmod +x /usr/sbin/run.sh
}

#安装Aria2
function install_aria2(){
	#进入临时目录
	cd ${aria2_temp}
	#yum -y update
	#安装aria2静态编译版本，来源于https://github.com/q3aql/aria2-static-builds/
	wget -O aria2.tar.bz2 ${aria2_url}
	tar jxvf aria2.tar.bz2
	mv aria2-* aria2
	cd aria2
	make install
	cd
	#创建下载目录
	mkdir -p ${downpath}
}
#处理配置文件
function dealconf(){
	cd ${aria2_temp}
	#使用-P参数下载到指定文件夹
	wget -P /etc/ https://raw.githubusercontent.com/helloxz/ccaa/master/ccaa_dir/aria2.conf
	#替换下载目录
	sed -i "s%dir=%dir=${downpath}%g" /etc/aria2.conf
	#设置RPC密钥
	#sed -ir "s/rpc-secret=.*/rpc-secret=$PASS/g" /etc/aria2.conf
}
#更新BTtracker
function up_tracker(){
	#下载最新的bt-tracker
	wget -O /tmp/trackers_best.txt https://api.xiaoz.org/trackerslist/
	tracker=$(cat /tmp/trackers_best.txt)
	#替换处理bt-tracker
	tracker="bt-tracker="${tracker}
	#更新aria2配置
	sed -i '/bt-tracker.*/'d /etc/aria2.conf
	echo ${tracker} >> /etc/aria2.conf
	echo '-------------------------------------'
	echo 'bt-tracker update completed.'
	echo '-------------------------------------'
}
#最后的清理
function clean_temp(){
	#移除不再需要的软件
	apk del tar make bzip2
	#删除临时文件
	rm -rf /tmp/*
	cd
	#删除临时目录
	rm -rf ${aria2_temp}
	echo '-------------------------------------'
	echo 'All work has been completed.'
	echo '-------------------------------------'
}
setout && install_aria2 && dealconf && up_tracker && clean_temp