Nginx Lua编程  
项目目录结构说明  
About_Lua  
├── README.md  
├── sh #存放OpenRest启动、停止、重启、状态检查脚本  
│   ├── openresty-restart.sh  
│   ├── openresty-start.sh  
│   ├── openresty-status.sh  
│   └── openresty-stop.sh  
└── src #项目的源代码目录  
    ├── client_body_temp #启动OpenResty后自动创建的目录，不用管  
    ├── conf  #OpenResty相关的配置目录  
    │   ├── nginx-lua-demo.conf  
    │   ├── nginx-redis-demo.conf  
    │   └── nginx.conf  
    ├── fastcgi_temp #启动OpenResty后自动创建的目录，不用管  
    ├── logs #日志目录    
    │   ├── access.log  
    │   ├── error.log  
    │   └── nginx.pid  
    ├── luaScript  
    │   ├── initial  
    │   │   └── loading_config.lua  
    │   ├── module  
    │   │   ├── common  
    │   │   │   ├── basic.lua  
    │   │   │   └── uuid.lua  
    │   │   ├── config  
    │   │   │   └── redis-config.lua  
    │   │   └── demo  
    │   │       ├── dataType.lua  
    │   │       ├── helloworld.lua  
    │   │       └── showBasicDemo.lua  
    │   └── redis  
    ├── proxy_temp #启动OpenResty后自动创建的目录，不用管  
    ├── scgi_temp  #启动OpenResty后自动创建的目录，不用管  
    └── uwsgi_temp #启动OpenResty后自动创建的目录，不用管  
