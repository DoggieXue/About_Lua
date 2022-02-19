local redis = require("resty.redis");
local config = require("luaScript.module.config.redis-config");


local red = redis:new();
-- 设置超时时长，单位为ms
red:set_timeouts(config.timeout, config.timeout, config.timeout);

local ok, err = red:connect(config.host_name, config.port);
if not ok then
    ngx.say("failed to connect: ", err);
    return;
else
    ngx.say("succeed to connect redis", "<br>");
end
-- if config.password then
--    red:auth(config.password);
--end

-- 设置值
ok, err = red:set("cat", "菠萝仔");
if not ok then
    ngx.say("failed to set cat: ", err, "<br>");
    return;
else
    ngx.say("set cat ok", "<br>")
end

-- 取值
local res, err = red:get("cat");
-- 判空演示
if not res or res == ngx.null then
    ngx.say("failed to get cat, err: ", err, "<br>");
    return;
else
    ngx.say("get cat ok: ", res, "<br>");
end

-- 批量操作，减少网络IO
red:init_pipeline()
red:set("dog", "柯基")
red:set("horse", "赤兔")

red:get("cat")
red:get("horse")
red:get("dog")

local results, err = red:commit_pipeline()
if not results then
    ngx.say("failed to commit the pipeline requests: ", err)
    return
end

for i, res in ipairs(results) do
    if type(res) == "table" then
        if res[1] == false then
            ngx.say("failed to run command ", i, ": ", res[2], "<br>");
        else
            --处理表容器
            ngx.say("succeed to run command ", i, ": ", res[i], "<br>");
        end
    else
        -- 处理变量
        ngx.say("succeed to run command ", i, ": ", res, "<br>");
    end
end

-- 简单地关闭连接
local ok, err = red:close()
if not ok then
    ngx.say("failed to close: ", err);
    return
else
    ngx.say("succeed to close redis")
end
