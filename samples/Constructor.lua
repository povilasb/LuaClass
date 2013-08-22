---
-- This sample demonstrates the basic usage of LuaClass library.
---

-- Append LuaClass source path so that require could locate it.
package.path = package.path .. ";src/?.lua"

local LuaClass = require "LuaClass"

local ClassA = LuaClass:create("ClassA")

function ClassA:_init(name, param1)
	self.name = name
	self.param1 = param1
	print("Constructor of ClassA")
end

local objA = ClassA:new("ClassA", 10)

print("Class name: " .. objA.name)
print("Object field: ", objA.param1);
