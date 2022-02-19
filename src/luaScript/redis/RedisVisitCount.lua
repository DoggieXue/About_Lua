-- Nginx+Redis实现分布式访问统计
-- 导入自定义的RedisOperator模块
local redisOpe = require("luaScript.redis.RedisOperator");

-- 创建自定义的redis操作对象
local red = redisOpe:new();

-- 打开连接
red:open();

-- 从Redis中获取访问次数
local visitCount = red:incrValue("demo:visitCount");

if visitCount == 1 then
    -- 设置10秒内过期
    red:expire("demo:visitCount", 10);
end

-- 将访问次数设置到Nginx变量中
ngx.var.count = visitCount;

-- 将连接归还连接池
red:close();