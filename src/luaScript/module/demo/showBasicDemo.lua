
--导入自定义的基础模块
local basic = require("luaScript.module.common.basic");
--导入自定义的 dataType 模块
local dataType = require("luaScript.module.demo.dataType");

--ngx.say("下面是数据类型演示的结果输出：<br>" );
--dataType.showDataType();

ngx.say("<hr>下面是数字取整的输出：<br>");
dataType.intPart(0.01);
dataType.intPart(3.14);

ngx.say("<br><hr>下面是字符串操作的演示：<br>");
dataType.stringOperator();
ngx.say("<br><hr>下面是table操作的演示：<br>");
dataType.tableOperator();

ngx.say("<br><hr>下面是for循环操作的演示：<br>");

dataType.forOperator();

ngx.say("<br><hr>下面是面向对象操作的演示：<br>");

local Square = dataType.Square;
local square = Square:new(20);
ngx.say("正方形的面积为", square:getArea());
