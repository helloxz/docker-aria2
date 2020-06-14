#!/bin/sh
##########				名称：Aria2启动脚本					##########
##########				作者：xiaoz<xiaoz93@outlook.com	>	##########
##########				更新时间：2020-06-14				##########

#设置RPC密钥
sed -ir "s/rpc-secret=.*/rpc-secret=$PASS/g" /etc/aria2.conf
echo '-------------------------------------'
echo 'Password setting completed.'
echo '-------------------------------------'
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

#运行Aria2
aria2c --conf-path=/etc/aria2.conf