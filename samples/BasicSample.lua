---
-- This sample demonstrates the basic usage of LuaClass library.
---

-- Append LuaClass source path so that require could locate it.
package.path = package.path .. ";src/?.lua"

local LuaClass = require "LuaClass"
local json = require "json"

local ClassA = LuaClass:create()

function ClassA.printStr(str)
	print("A:", str)
end


local ClassB = LuaClass:create(ClassA)

function ClassB.printStr(str)
	print("B:", str)
end


local objB = ClassB:new()
objB.printStr("ok")
