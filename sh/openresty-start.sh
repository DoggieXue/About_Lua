#!/usr/bin/env bash

#设置OpenResty安装目录
OPENRESTY_PATH="/usr/local/openresty"

#设置Nginx项目的工作目录
PROJECT_PATH="/Users/xuexiao/Work/QDBank/Idea-WorkSpace/About_Lua/src"

#设置Nginx启动的配置文件
PROJECT_CONF="nginx-lua-demo.conf"

echo "OPENRESTY_PATH:$OPENRESTY_PATH"
echo "PROJECT_PATH:$PROJECT_PATH"

#查找Nginx所有的进程ID
pid=$(ps -ef | grep -v 'grep' | egrep nginx | awk '{printf $2 " "}')

if [ "$pid" != "" ]; then
    #如果已经在执行，则提示
    echo "OpenResty/Nginx is started already, and pid is $pid, operation failed!"
else
    #如果没有执行，则启动
    $OPENRESTY_PATH/nginx/sbin/nginx -p ${PROJECT_PATH} -c ${PROJECT_PATH}/conf/${PROJECT_CONF}
    pid=$(ps -ef | grep -v 'grep' | egrep nginx | awk '{printf $2 " "}')
    echo "OpenResty/Nginx starting succeeded!"
    echo "pid is $pid"
fi