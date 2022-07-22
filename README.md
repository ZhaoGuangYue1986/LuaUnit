# LuaUnit

一个使用起来超方便的LUA 单元测试（UT）框架

A very simple and Easy use LUA UT test framwork

欢迎大家到 http://www.ostack.cn 交流编程经验

# 支持特性
1.支持setUp/tearDown特性，用户可以自己定义setUp和tearDown函数，框架将在所有用例运行前可以加载调用此函数

1.Support setUp/tearDown features, users can define setUp and tearDown functions themselves, the framework will load and call this function before all use cases are run。

2.支持caseSetUp/caseTearDown特性，用户可以自己定义caseSetUp和caseTearDown函数，框架将在每个用例运行前可以加载调用此函数

2.Support caseSetUp/caseTearDown features, users can define caseSetUp and caseTearDown functions by themselves, the framework will load and call this function before each use case runs

## 使用方法（How to use）
使用前需要require 本模块，通过返回的变量来调用提供的方法。同时，我们提供了Assert类，用于参数的判断

Should require Log first, then use the return val's function, same time we provide Assert class for judge the result

## 使用示例

请参考Sample.lua

please see Sample.lua

<blockquote>

----------------use sample----------------</p>
</p>
-----1.引入luaUnit模块</p>
-----1.Require LuaUnit Model</p>
local LuaUnit = require("LuaUnit")</p>

-----2.从luaUnit派生出我们自己的测试类</p>
-----2.Derive an instance of ourselves from luaUnit）</p>
local TestUnit = LuaUnit:derive("TestUnit")</p>

-----3.如果需要测试前准备的话，可以重写setUp方法,此方法将在所有用例前调用</p>
-----3.override setUp function if needed, this function will be called before test case run</p>
function TestUnit:setUp()</p>
    ----You can use needTrace function to open lua debug trace</p>
    Assert:needTrace(false)</p>
    print("This function will be called BEFORE ALL test run,you can define you own setUp funtion")</p>
end</p>

-----4.如果需要测试前准备的话，可以重写tearDown方法,此方法将在所有用例运行完以后调用</p>
-----4. override tearDown function if needed, this function will called after all test case run</p>
function TestUnit:tearDown()</p>
    ----You can use needTrace function to open lua debug trace</p>
    Assert:needTrace(false)</p>
    print("This function will be called AFTER ALL test run,you can define you own tearDown funtion")</p>
end</p>

-----5.如果需要测试前准备的话，可以重写caseSetUp方法,此方法将每个用例运行前调用</p>
-----5.Third override tearDown function if needed, this function will called before each test case run</p>
function TestUnit:caseSetUp()</p>
    print("This function will be called BEFORE EACH test run,you can define you own setUp funtion")</p>
end</p>

-----6.如果需要测试前准备的话，可以重写caseSetUp方法,此方法将每个用例运行前调用</p>
-----6.Third override tearDown function if needed, this function will called before each test case run</p>
function TestUnit:caseTearDown()</p>
    print("This function will be called AFTER EACH test run,you can define you own caseTearDown funtion")</p>
end</p>

-----7.设计我们的用例,要求：所有用例必须以test开头</p>
-----7.design our test cases，notes:all test case should start with "test"</p>

-- Need Test function</p>
local function foo()</p>
    return 2</p>
end</p>

function TestUnit:testNotEqual()</p>
    Assert:equal(1, 2)</p>
end</p>

function TestUnit:testEqual2()</p>
    Assert:equal(1, 1)</p>
end</p>

function TestUnit:testFo()</p>
    Assert:equal(1, foo())</p>
end</p>

function TestUnit:testAssertIsTrue()</p>
    Assert:isTrue(true)</p>
    --  Assert:isTrue(false)</p>
end</p>

function TestUnit:testAssertIsFalse()</p>
    Assert:isFalse(false)</p>
    --Assert:isFalse(true)</p>
end</p>

-----8.执行所有用例</p>
-----8.run this test class</p>
TestUnit:run()</p>
</blockquote>



# 相關倉庫
https://github.com/ostack/LuaUnit

https://github.com/ostack/LuaLogger

https://github.com/ostack/LuaMock
