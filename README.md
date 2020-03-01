# LuaUnit
一个超简单的LUA 单元测试（UT）框架（A very simple LUA UT test framwork）
## 使用方法（How to use）
使用前需要require 本模块，通过返回的变量来调用提供的方法。同时，我们提供了Assert类，用于参数的判断
Should require Log first, then use the return val's function

##使用示例

-----1.引入luaUnit模块

-----1.Require LuaUnit Model

local LuaUnit = require("LuaUnit")


-----2.从luaUnit派生出我们自己的测试类

-----2.Derive an instance of ourselves from luaUnit）

TestUnit = LuaUnit:derive("TestUnit")


-----3.如果需要测试前准备的话，可以重新setUp方法,此方法将在所有用例前调用

-----3.Third override setUp function if needed, this function will be called before all test case run

function TestUnit:setUp()

    ----You can use needTrace function to open lua debug trace
    
    Assert:needTrace(true)
    
    print("Test Unit set up func")
    
end


-----4.如果需要测试前准备的话，可以重新tearDown方法,此方法将在所有用例运行完以后调用

-----4.Third override tearDown function if needed, this function will called after all test case run

function TestUnit:tearDown()

    ----You can use needTrace function to open lua debug trace
    
    Assert:needTrace(false)
    
    print("Test Unit set up func")
    
end


-----5.设计我们的用例,要求：所有用例必须以test开头

-----5.design our test cases，notes:all test case should start with "test"

function TestUnit:testNotEqual()

    Assert:equal(1, 2)
    
end


function TestUnit:testEqual2()

    Assert:equal(1, 1)
    
end


local function foo()

    return 2
    
end


function TestUnit:testFo()

    Assert:equal(1, foo())
    
end


-----6.执行所有用例

-----6.run this test class

TestUnit:run()
