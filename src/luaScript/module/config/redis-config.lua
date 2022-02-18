-- 定义一个统一的Redis配置模块

--统一的模块对象
local _Module = {
    -- Redis服务器的地址
    host_name = "127.0.0.1";

    -- Redis服务器的端口
    port = 6379;

    -- Redis服务器的数据库
    db = "0";
    -- Redis服务器的密码
    --password = "123456";

    -- 连接超时时间
    timeout = 20000;

    --线程池的连接数
    pool_size = 100;

    -- 最大空闲时间，单位：毫秒
    pool_max_idle_time = 10000;
}

return _Module