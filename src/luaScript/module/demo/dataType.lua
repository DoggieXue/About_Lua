--导入自定义的模板
local basic = require("luaScript.module.common.basic");
local string = string or require "string"
local table = table or require "table"

--输出数据类型
local function _showDataType()
    local i;
    basic.log_screen("字符串的类型", type("hello world"));
    basic.log_screen("方法的类型", type(showDataType));
    basic.log_screen("true的类型", type(true));
    basic.log_screen("整数数字的类型", type(360));
    basic.log_screen("浮点数字的类型", type(360.0));
    basic.log_screen("nil值的类型", type(nil));
    basic.log_screen("未赋值变量i的类型", type(i));
end


--演示取整操作
local function _intPart(number)
    basic.log_screen("演示的整数", number)
    basic.log_screen("向下取整是", math.floor(number));
    basic.log_screen("向上取整是", math.ceil(number));
end


--演示字符串操作
local function _stringOperator()
    local here = "这里是：" .. "高性能研习社群" .. "疯狂创客圈";
    print(here);
    basic.log_screen("字符串拼接演示", here);

    basic.log_screen("获取字符串的长度", string.len(here));
    basic.log_screen("获取字符串的长度方式二", #here);

    local find = string.find;
    basic.log_screen("字符串查找", find(here, "疯狂创客圈"));

    local src = "Hello world!";
    basic.log_screen("字符串转成大写", string.upper(src));
    basic.log_screen("字符串转成小写", string.lower(src));

end

--演示table操作
local function _tableOperator()

    --定义一个普通数组
    local array1 = { "这里是：", "高性能研习社群", "疯狂创客圈" }
    --定义一个K-V数组
    local array2 = { k1 = "这里是：", k2 = "高性能研习社群", k3 = "疯狂创客圈" }
    --取得数组长度
    --lua 新的版本已经去掉了table.getn
    --basic.log_screen("使用table.getn(t)获取长度", table.getn(array1));
    basic.log_screen("使用 一元操作符# 获取长度", #array1);

    --迭代一个普通数组
    for i = 1, 3 do
        ngx.say(i .. "=" .. array1[i] .. ",");
    end
    ngx.say("<br>");
    --迭代一个K-V值的table
    for k, v in pairs(array2) do
        ngx.say(k .. "=" .. array2[k] .. ",");
    end
    ngx.say("<br><br>");

    local a = { 1, 3, 5, "hello" }
    basic.log_screen("使用concat连接数组", table.concat(a))       -- output: 135hello
    basic.log_screen("使用concat连接数组,带分隔符", table.concat(a, "|"))    -- output: 1|3|5|hello
    ngx.say("<br><br>");

    a = { 1, 2, 3, 4 }
    --删除速索引为1的元素
    table.remove(a, 1)
    basic.log_screen("删除第一个元素之后", a[1], a[2], a[3], a[4])
    --删除最后一个元素
    table.remove(a)
    basic.log_screen("删除最后一个元素之后", a[1], a[2], a[3], a[4])

    local testTab = { 1, 2, 3, 4, 5, 6, 7 }
    basic.log_screen("连接元素", table.concat(testTab))   --输出: 1234567
    basic.log_screen("带分隔符连接元素", table.concat(testTab, "*", 1, 3))   --输出: 1*2*3
    ngx.say("<br><br>");

    testTab = { 1, 2, 3, 4 }
    --插入一个元素到末尾
    table.insert(testTab, 5)
    basic.printTable(testTab)  --输出: 1  2  3  4  5
    --插入一个元素到位置索引2
    table.insert(testTab, 2, 10)
    basic.printTable(testTab)  --输出: 1  10  2  3  4  5

    ngx.say("<br><br>");

    testTab = { 1, 2, 3, 4, 5, 6, 7 }
    --删除最后一个元素
    table.remove(testTab)
    basic.printTable(testTab)   --输出: 1  2  3  4  5  6
    --删除第二个元素
    table.remove(testTab, 2)   --输出:  1  3  4  5  6
    basic.printTable(testTab)

end

--演示for操作
local function _forOperator()

    --单分支
    local x = '疯狂创客圈'
    if x == '疯狂创客圈' then
        basic.log_screen("单分支演示：", "这个是一个高性能研习社群")
    end
    ngx.say("<br>");
    --两分支
    if x == '这个是一个高性能研习社群' then
        basic.log_screen("两分支演示：", "这儿是疯狂创客圈")
    else
        basic.log_screen("两分支演示：", "这儿还是疯狂创客圈")
    end

    ngx.say("<br>");


    --多分支
    if x == '这个是一个高性能研习社群' then
        basic.log_screen("多分支演示：", "这儿是疯狂创客圈")
    elseif x == '疯狂创客圈' then
        basic.log_screen("多分支演示：", "这个是一个高性能研习社群")
    else
        basic.log_screen("多分支演示：", "这儿不是疯狂创客圈")
    end
    ngx.say("<br>");


    --for循环,步长为2
    for i = 1, 5, 2 do
        ngx.say(i .. " ")
    end
    --for循环,步长为1
    ngx.say("<br>");
    for i = 1, 5 do
        ngx.say(i .. " ")
    end
    ngx.say("<br>");

    -- foreach 循环，打印table t中所有的key和value
    local days = {
        "Sunday", "Monday", "Tuesday", "Wednesday",
        "Thursday", "Friday", "Saturday"
    }
    ngx.say("<br>");
    for key, value in pairs(days) do
        ngx.say(key .. ":" .. value .. "; ")
    end
    ngx.say("<br>");

    local days2 = {
        Sunday = 1, Monday = 2, Tuesday = 3, Wednesday = 4,
        Thursday = 5, Friday = 6, Saturday = 7
    }
    -- foreach 循环，打印table t中所有的key和value
    for key, value in pairs(days2) do
        ngx.say(key .. ":" .. value .. "; ")
    end

end



-- 正方形类
local  _Square = { side = 0 }
_Square.__index = _Square
-- 类的方法 getArea
function _Square.getArea(self)
    return self.side * self.side;
end

-- 类的方法 new
function _Square.new(self, side)
    local cls = {}
    setmetatable(cls, self)
    cls.side = side or 0
    return cls
end



--一个统一的模块对象
local _Module = {
    showDataType = _showDataType;
    intPart = _intPart;
    stringOperator = _stringOperator;
    tableOperator = _tableOperator;
    forOperator = _forOperator;
    Square = _Square;
}

return _Module