local redis = require("resty.redis");
local basic = require("luaScript.module.common.basic");
local config = require("luaScript.module.config.redis-config");

-- 连接池大小
local pool_size = config.pool_size;

local pool_max_idle_time = config.pool_max_idle_time;
-- 一个统一的模块对象
local _Module = {}

_Module.__index = _Module;

-- 类的方法 new
function _Module.new(self)
    local object = {red = nil};
    setmetatable(object, self);
    return object;
end

function _Module.open(self)

    local red = redis:new();
    red:set_timeout(config.timeout, config.timeout, config.timeout);

    local ok, err = red:connect(config.host_name, config.port);
    if not ok then
        basic.error("连接Redis服务器失败", err);
        return false;
    end

    --if config.password then
    --    red:auth(config.password);
    --end

    if config.db then
        red:select(config.db);
    end

    basic.log("连接Redis服务器成功");
    self.red = red;
    return true;
end

--缓存值
function _Module.setValue(self, key, value)
    local ok, err = self.red:set(key, value);
    if not ok then
        basic.error("Redis缓存设置失败");
        return false;
    end
    basic.log("set result ok!");
    return true;
end

--递增值：ok表示Redis中key对应的value
function _Module.incrValue(self, key)
    local ok, err = self.red:incr(key);
    if not ok then
        basic.error("Redis缓存递增失效");
        return false;
    end
    basic.log("incr ok!");
    return ok;
end

--过期
function _Module.expire(self, key, seconds)
    local ok, err = self.red:expire(key, seconds);
    if not ok then
        basic.error("Redis设置过期失败");
        return false;
    end
    basic.log("Redis设置过期成功");
    return true;
end

--根据key获取缓存值
function _Module.getValue(self, key)
    local resp, err = self.red:get(key);
    if not resp then
        basic.error("Redis 缓存读取失败");
        return false;
    end
    basic.log("Redis 缓存读取成功");
    return resp;
end

--获取值
function _Module.getSmembers(self, key)
    local resp, err = self.red:smembers(key);
    if not resp then
        basic.error("Redis 读取缓存值失败");
    end
    basic.log("Redis 缓存读取成功");
    return resp;
end

--缓存Hash值
function _Module.hsetValue(self, key, id, value)
    local ok, err = self.red.hset(key, id, value);
    if not ok then
        basic.error("Redis hset 失败 ");
        return false;
    end
    print("set result: ", ok);
    return true;
end
--获Hash取值
function _Module.hgetValue(self, key, id)
    local resp, err = self.red:hget(key, id);
    if not resp then
        basic.error("Redis hget 失败");
        return nil;
    end
    return resp;
end
--执行脚本
function _Module.evalsha(self, sha, key1, key2)
    local resp, err = self.red:evalsha(sha, 2, key1, key2);
    if not resp then
        basic.error("Redis evalsha 执行失败");
        return nil;
    end
    return resp;
end
--执行秒杀脚本
function _Module.evalSeckillSha(self, sha,method, skuId, userId, token)
    local resp, err = self.red:evalsha(sha, 1,method, skuId, userId, token);
    if not resp then
        basic.log(" redis evalsha 秒杀 执行失败 ".. method .." " .. skuId .." ".. userId .." ".. token .." ".. err .." ")
        return nil;
    end
    return resp;
end

function _Module.getConnection(self)
    return self.red;
end

--将连接还给连接池
function _Module.close(self)
    if not self.red then
        return;
    end

    local ok, err = self.red:set_keepalive(pool_max_idle_time, pool_size);
    if not ok then
        basic.error("Redis set_keepalive执行失败 ")
    end
    basic.log("Redis 连接释放成功");
end

return _Module