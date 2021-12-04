#!/bin/sh
##########				名称：Aria2启动脚本					##########
##########				作者：xiaoz<xiaoz93@outlook.com	>	##########
##########				更新时间：2020-06-14				##########

#aria2配置文件
aria2_conf="/etc/ccaa/aria2.conf"
aria2_session="/etc/ccaa/aria2.session"

#判断配置文件和session文件是否存在
if [ ! -f "${aria2_conf}" ]
then
	cp /root/aria2.conf /etc/ccaa/
fi
#判断session是否存在
if [ ! -f "${aria2_session}" ]
then
	touch ${aria2_session}
fi

#处理配置文件
function dealconf(){
	#替换下载目录
	sed -i "s%dir=%dir=/data/download%g" ${aria2_conf}
	#设置RPC密钥
	sed -i "s/rpc-secret=.*/rpc-secret=$PASS/g" ${aria2_conf}
	#更改端口
	sed -i "s/listen-port=51413/listen-port=51000/g" ${aria2_conf}
	#下载最新的bt-tracker
	tracker=$(curl -s https://api.xiaoz.org/trackerslist/)
	#替换处理bt-tracker
	tracker="bt-tracker="${tracker}
	#更新aria2配置
	#先删除
	sed -i '/bt-tracker.*/'d ${aria2_conf}
	#再添加
	echo ${tracker} >> ${aria2_conf}
	echo '-------------------------------------'
	echo 'bt-tracker update completed.'
	echo '-------------------------------------'
}

dealconf
#运行Aria2
aria2c --conf-path=${aria2_conf}