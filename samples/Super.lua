---
-- This sample demonstrates the basic usage of LuaClass library.
---

-- Append LuaClass source path so that require could locate it.
package.path = package.path .. ";src/?.lua"

local LuaClass = require "LuaClass"

local ClassA = LuaClass:create("ClassA")

function ClassA:_init(param1)
	self.param1 = param1
	print("Constructor of ClassA")
end


local ClassB = LuaClass:create("ClassB", ClassA)


---
-- self refers to the object that was created.
---
function ClassB:_init(param1, param2)
	ClassB._super._init(self, param1)
	self.param2 = param2

	print("Constructor of ClassB")
end


local ClassC = LuaClass:create("ClassC", ClassB)


---
-- self refers to the object that was created.
---
function ClassC:_init(param1, param2)
	ClassC._super._init(self, param1, param2)

	print("Constructor of ClassC")
end

local objC = ClassC:new(10, 11)

print("Class name: " .. objC._name)
print("Object field: ", objC.param1);
print("Object field 2: ", objC.param2);
