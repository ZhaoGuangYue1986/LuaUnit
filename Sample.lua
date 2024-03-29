---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by zhaoguangyue.
--- DateTime: 2020/3/1 12:48
---

----------------use sample----------------

-----1.引入luaUnit模块
-----1.Require LuaUnit Model
local LuaUnit = require("LuaUnit")

-----2.从luaUnit派生出我们自己的测试类
-----2.Derive an instance of ourselves from luaUnit）
local TestUnit = LuaUnit:derive("TestUnit")

-----3.如果需要测试前准备的话，可以重写setUp方法,此方法将在所有用例前调用
-----3.override setUp function if needed, this function will be called before test case run
function TestUnit:setUp()
    ----You can use needTrace function to open lua debug trace
    Assert:needTrace(false)
    print("This function will be called BEFORE ALL test run,you can define you own setUp funtion")
end

-----4.如果需要测试前准备的话，可以重写tearDown方法,此方法将在所有用例运行完以后调用
-----4. override tearDown function if needed, this function will called after all test case run
function TestUnit:tearDown()
    ----You can use needTrace function to open lua debug trace
    Assert:needTrace(false)
    print("This function will be called AFTER ALL test run,you can define you own tearDown funtion")
end

-----5.如果需要测试前准备的话，可以重写caseSetUp方法,此方法将每个用例运行前调用
-----5.Third override tearDown function if needed, this function will called before each test case run
function TestUnit:caseSetUp()
    print("This function will be called BEFORE EACH test run,you can define you own setUp funtion")
end

-----6.如果需要测试前准备的话，可以重写caseSetUp方法,此方法将每个用例运行前调用
-----6.Third override tearDown function if needed, this function will called before each test case run
function TestUnit:caseTearDown()
    print("This function will be called AFTER EACH test run,you can define you own caseTearDown funtion")
end

-----7.设计我们的用例,要求：所有用例必须以test开头
-----7.design our test cases，notes:all test case should start with "test"

-- Need Test function
local function foo()
    return 2
end

function TestUnit:testNotEqual()
    Assert:equal(1, 2)
end

function TestUnit:testEqual2()
    Assert:equal(1, 1)
end

function TestUnit:testFo()
    Assert:equal(1, foo())
end

function TestUnit:testAssertIsTrue()
    Assert:isTrue(true)
    --  Assert:isTrue(false)
end

function TestUnit:testAssertIsFalse()
    Assert:isFalse(false)
    --Assert:isFalse(true)
end

-----8.执行所有用例
-----8.run this test class
TestUnit:run()