---
-- Created by zhao guangyue (jeky_zhao@qq.com)
-- DateTime: 2020/3/1 9:45
-- Copyright (c) 2015 ostack. http://www.ostack.cn
-- This source code is licensed under BSD 3-Clause License (the "License").
-- You may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     https://opensource.org/licenses/BSD-3-Clause
--

------------------------class for Test Error-----------------
local Error = {}
function Error:new(msg, code)
    local err = { _l_err_code_ = code or 65535, _l_err_msg_ = msg or "" }
    setmetatable(err, self)
    self.__index = self;
    return err
end

function Error:throw()
    error(self._l_err_msg_, 0)
end

function Error:show()
    print(self._l_err_msg_)
end
------------------------class for Test Assert-----------------
Assert = { _l_assert_need_trace_ = false }
function Assert:equal(expect, actual)
    if expect ~= nil and actual ~= nil and type(expect) == type(actual)
            and expect == actual then
    else
        local errMsg = "       Value not equal.Expect:" .. expect .. ",Actual:" .. actual;
        if self._l_assert_need_trace_ then
            errMsg = errMsg .. "\n" .. debug.traceback()
        end
        Error:new(errMsg, debug.traceback()):throw()
    end

end
function Assert:needTrace(isNeedTrace)
    self._l_assert_need_trace_ = isNeedTrace;
end
------------------------class for Test Result-----------------
local TestResult = {}
function TestResult:new(testClassName)
    local testResult = { _l_unit_case_result_ = {},
                         _l_total_case_num_ = 0,
                         _l_succ_case_num_ = 0,
                         _l_unit_class_name_ = testClassName or "TestClassNotKnown",
                         new = self.new,
                         record = self.record,
                         display = self. display
    }
    setmetatable(testResult, self)
    self.__index = self
    return testResult
end

function TestResult:record(testCaseName, isSucc, error)
    self:updateTotalNum();
    self:updateSuccNum(isSucc);
    self:recordRlt(testCaseName, isSucc, error);
end

function TestResult:display()
    local caseRlt = self._l_unit_case_result_;
    for key, val in pairs(caseRlt) do
        self:printRlt(val)
        self:printErrMsg(val)
    end
    self:printStat()
end

function TestResult:updateSuccNum(isSucc)
    if self:isSucc(isSucc) then
        self._l_succ_case_num_ = self._l_succ_case_num_ + 1
    end
end

function TestResult:updateTotalNum(isSucc)
    self._l_total_case_num_ = self._l_total_case_num_ + 1
end

function TestResult:recordRlt(testCaseName, isSucc, errMsg)
    table.insert(self._l_unit_case_result_, { testCaseName, isSucc, errMsg })
end

function TestResult:isSucc(isSuccess)
    return nil ~= isSuccess and isSuccess == true
end

function TestResult:getCaseRltStr(isSuccess)
    if self:isSucc(isSuccess) then
        return "[SUCC] "
    else
        return "[FAIL] "
    end
end

function TestResult:printRlt(val)
    local testCaseNameName = val[1];
    local testResult = val[2];
    print(self:getCaseRltStr(testResult) .. self._l_unit_class_name_ .. "." .. testCaseNameName);
end

function TestResult:printErrMsg(val)
    local errMsg = val[3];
    if errMsg then
        errMsg:show();
    end
end

function TestResult:printStat()
    local succPercent = 100 * self._l_succ_case_num_ / self._l_total_case_num_;
    print("=========Succ:" .. self._l_succ_case_num_ .. ", Total:" .. self._l_total_case_num_ .. ", Percent:" .. succPercent .. "%=========")
end

-------------------------------------------------------------

local LuaUnit = {}
function LuaUnit:derive(classNames)
    local luaUnit = { _l_unit_class_name_ = classNames,
                      run = run
    }
    setmetatable(luaUnit, LuaUnit)
    self.__index = self;
    return luaUnit;
end

function LuaUnit:run(...)
    self:init()
    self:runSetUp()
    self:runTestCase()--todo filter test case by input paras
    self:runTearDown()
    self:finish()
end

function LuaUnit:init()
    self._l_unit_result_ = TestResult:new(self._l_unit_class_name_)
end

function LuaUnit:finish()
    self._l_unit_result_:display()
end

function LuaUnit:runSetUp()
    if self:isFunction(self.setUp) then
        self:setUp()
    end
end

function LuaUnit:runTestCase()
    for key, val in pairs(self) do
        if string.find(key, "test") then
            local methodName = self._l_unit_class_name_ .. "." .. key .. "()";
            local methodInst = load(methodName)
            local function err_handler(e)
                return Error:new(e, debug.traceback())
            end
            local isSucc, errMsg = xpcall(methodInst, err_handler)
            if (not isSucc or errMsg ~= nil) then
                self:recordTestCaseResult(key, false, errMsg)
            else
                self:recordTestCaseResult(key, true, nil)
            end

        end
    end
end

function LuaUnit:runTearDown()
    if self:isFunction(self.tearDown) then
        self:tearDown()
    end
end

function LuaUnit:isFunction(key)
    return key ~= nil and type(key) == 'function'
end

function LuaUnit:recordTestCaseResult(testCaseName, isSucc, error)
    self._l_unit_result_:record(testCaseName, isSucc, error)
end

return LuaUnit