---
-- This sample demonstrates the basic usage of LuaClass library.
---

-- Append LuaClass source path so that require could locate it.
package.path = package.path .. ";src/?.lua"

local LuaClass = require "LuaClass"

local ClassA = LuaClass:create("ClassA")

ClassA.a = 0

function ClassA:incA()
	self.a = self.a + 1
	print("ClassA inc")
end


local ClassB = LuaClass:create("ClassB", ClassA)

function ClassB:incA()
	self.super:incA()
	self.a = self.a + 2
	print("ClassB inc")
end


local ClassC = LuaClass:create("ClassC", ClassB)

function ClassC:incA()
	self.super:incA()
	self.a = self.a + 3
	print("ClassC inc")
end

local objC = ClassC:new()
objC:incA()
print(objC.a)
