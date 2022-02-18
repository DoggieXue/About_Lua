#!/usr/bin/env bash

pid=$(ps -ef | grep -v 'grep' | egrep nginx | awk '{printf $2 " "}')

if [ "$pid" != "" ]; then
  echo "Shutting down OpenResty/Nginx： pid is $pid"
  #/usr/bin/su - root -c "kill -s 9 $pid"
  #当前Mac机器下的stop命令
  sudo kill -9 $pid
  echo "Shutting down succeeded!"
else
  echo "OpenResty/Nginx is not running!"
fi