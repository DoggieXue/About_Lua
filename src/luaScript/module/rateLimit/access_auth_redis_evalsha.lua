---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by xuexiao.
--- DateTime: 2022/2/22 下午10:15
---
local redisOp = require("luaScript.redis.RedisOperator")
--定义出错的JSON输出对象
local errorOut = {errorCode = -1, errorMsg = "限流出错", data = {} };

--获取请求参数
local args = nil;
if "GET" == ngx.var.request_method then
    args = ngx.req.get_uri_args();
elseif "POST" == ngx.var.request_method then
    ngx.req.read_body();
    args = ngx.req.get_post_args();
end

-- 获取用户IP
local shortKey = ngx.var.remote_addr;
if not shortKey or shortKey == ngx.null then
    errorOut.errMsg = "shortKey 不能为空";
    ngx.say(cjson.encode(errorOut));
    return;
end

-- 拼接计数的Redis key
local key = "redis_count_rate_limit:ip:"..shortKey;

local rateLimitSha = "ba4f3836d3d422a2afbc9cd28e93f88715dc0c0f";

-- 创建Redis自定义操作对象
local redis = redisOp:new();
redis:open();

local connection = redis:getConnection();

local resp, err = connection:evalsha(rateLimitSha, 1, key);
-- 归还连接
redis:close();

if not resp or resp == ngx.null then
    errorOut.errorMsg = err;
    ngx.say(cjson.encode(errorOut));
    ngx.exit(ngx.HTTP_UNAUTHORIZED);
    return;
end

local count = tonumber(resp);

if count == 0 then
    errorOut.errorMsg = "您的操作太频繁了，请稍后再试.";
    ngx.say(cjson.encode(errorOut),"<br>");
    ngx.exit(ngx.HTTP_UNAUTHORIZED);
end

-- 设置返回的ngx变量
ngx.var.count = count;
-- 注意，在这里直接输出，会导致content 阶段的指令被跳过
-- ngx.say( "目前的访问总数：",count,"<br>");
return


