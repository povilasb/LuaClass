---
-- LuaClass implements functions to create classes in lua.
--

-- PRIVATE


---
-- Creates a new table and copies all elements from the specified table to
-- the created one.
-- NOTE: does not copy table recursively.
--
-- @param {table} t table to copy.
-- @return {table} newly created table.
---
function table.copy(t)
	local retval = {}

	for k, v in pairs(t) do
		retval[k] = v
	end

	return retval
end


local LuaClass = {}


---
-- Creates a new object of the specified class.
-- If class has defined an init function, it is called on new object
-- creation.
--
-- @param selfClass table class whose object will be created.
-- @return table created object.
---
function LuaClass.create_object(selfClass, ...)
	local newObj = {}
	setmetatable(newObj, selfClass)

	if selfClass._init then
		selfClass._init(newObj, ...)
	end

	return newObj
end


-- PUBLIC


LuaClass.version = "0.1.0"


---
-- Creates a new class.
--
-- @param {table} class that will be extended. Might be nil, in such case
--	no class is extended.
-- @return {table} table representing lua class.
---
function LuaClass:create(base)
	local newClass = {}

	-- make a copy of base class super class list
	if base and type(base._ancestorList) == "table" then
		newClass._ancestorList = table.copy(base._ancestorList)
	else
		newClass._ancestorList  = {}
	end

	if base then
		table.insert(newClass._ancestorList, base)
		newClass.super = base
	end

	-- search for method or field in ancestor classes
	setmetatable(newClass, {__index = function(t, k)
		-- must search backwards in ancestor list
		for i = #t._ancestorList, 1, -1 do
			if t._ancestorList[i][k] ~= nil then
				return t._ancestorList[i][k]
			end
		end

		return nil
	end})

	-- created class is metatable for its own objects
	newClass.__index = newClass

	-- class methods
	newClass.new = LuaClass.create_object

	return newClass
end


return LuaClass
