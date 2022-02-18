#!/bin/bash

pid=$(ps -ef | grep -v 'grep' | egrep nginx| awk '{printf $2 " "}')

if [ "$pid" != "" ]; then
    echo  "OpenResty/Nginx is running!"
    echo  "pid is $pid"
else
   echo "OpenResty/Nginx is not running!"
fi