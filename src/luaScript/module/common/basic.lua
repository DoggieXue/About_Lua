--定义一个应用程序公共的Lua对象 app_info
local app_info = {version = "0.10"};

--增加一个path属性，保存lua的模块路径
app_info.path = package.path;

--定义局部函数，比较大小
local function max(num1, num2)
    local result = nil;
    if (num1 > num2) then
        result = num1;
    else
        result = num2;
    end
    return result;
end

local function toStringEx(value)
    if type(value)=='table' then
        return tableToStr(value)
    elseif type(value)=='string' then
        return "\'"..value.."\'"
    else
        return tostring(value)
    end
end

local function tableToStr(t, split)
    if t == nil then
        return ""
    end
    if split == nil then
        split = ",";
    end

    local retstr = "{"

    local i = 1
    for key, value in pairs(t) do

        if key == i then
            retstr = retstr  .. toStringEx(value) .. split
        else
            if type(key) == 'number' or type(key) == 'string' then
                retstr = retstr .. '[' .. toStringEx(key) .. "]=" .. toStringEx(value) .. split
            else
                if type(key) == 'userdata' then
                    retstr = retstr  .. "*s" .. tableToStr(getmetatable(key)) .. "*e" .. "=" .. toStringEx(value) .. split
                else
                    retstr = retstr .. key .. "=" .. toStringEx(value) .. split
                end
            end
        end

        i = i + 1
    end

    retstr = retstr .. "}"
    return retstr
end

--输出到日志文件
local function log(string)
    if  type(string)=="string" then
        ngx.log(ngx.DEBUG, string);
        return
    end

    if  type(string)=="table" then
        ngx.log(ngx.DEBUG, table.concat(string," "));
        return
    end
    ngx.log(ngx.DEBUG, tostring(string));
end
--输出到日志文件
local function error(string)
    if  type(string)=="string" then
        ngx.log(ngx.ERR, string);
        return
    end
    if  type(string)=="table" then
        ngx.log(ngx.ERR, table.concat(string," "));
        return
    end

    ngx.log(ngx.ERR, tostring(string));
end

--在屏幕上打印日志
local function log_screen(...)
    --这里的...和{}符号中间需要有空格号，否则会出错
    local args = { ... }
    for i, v in pairs(args) do
        print("index:", i, " value:", v)
        ngx.say(tostring(v) .. ",");
    end
    ngx.say("<br>");

end

--在屏幕上输出table元素
local function printTable(tab)
    for i,v in pairs(tab) do
        ngx.say(v .. ",");
    end
    ngx.say("<br>");
end

-- 获取客户端 IP
local function getClientIP()
    local clientIP = ngx.req.get_headers()["X-Real-IP"]
    if clientIP == nil then
        clientIP = ngx.req.get_headers()["x_forwarded_for"]
    end
    if clientIP == nil then
        clientIP = ngx.var.remote_addr
    end
    return clientIP;
end

--统一的模块对象
local _Module = {
    app_info = app_info;
    max = max;
    log = log;
    error = error;
    log_screen = log_screen;
    printTable = printTable;
    tableToStr = tableToStr;
    tableToStr = tableToStr;
    getClientIP = getClientIP;
}

return _Module
