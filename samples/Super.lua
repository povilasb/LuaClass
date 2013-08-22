---
-- This sample demonstrates the basic usage of LuaClass library.
---

-- Append LuaClass source path so that require could locate it.
package.path = package.path .. ";src/?.lua"

local LuaClass = require "LuaClass"

local ClassA = LuaClass:create()

function ClassA:_init(name, param1)
	self.name = name
	self.param1 = param1
	print("Constructor of ClassA")
end


local ClassB = LuaClass:create(ClassA)


---
-- self refers to the object that was created.
---
function ClassB:_init(name, param1, param2)
	ClassB.super._init(self, name, param1)
	self.param2 = param2

	print("Constructor of ClassB")
end


local ClassC = LuaClass:create(ClassB)


---
-- self refers to the object that was created.
---
function ClassC:_init(name, param1, param2)
	ClassC.super._init(self, name, param1, param2)

	print("Constructor of ClassC")
end

local objC = ClassC:new("ClassC", 10, 11)

print("Class name: " .. objC.name)
print("Object field: ", objC.param1);
print("Object field 2: ", objC.param2);
