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
		print("cp:", k)
		retval[k] = v
	end

	return retval
end


local LuaClass = {}


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
		for _, ancestor in ipairs(t._ancestorList) do
			if ancestor[k] ~= nil then
				return ancestor[k]
			end
		end

		return nil
	end})

	-- created class is metatable for its own objects
	newClass.__index = newClass

	-- class methods
	newClass.new = function(selfClass)
		local newObj = {}
		setmetatable(newObj, selfClass)
		return newObj
	end

	return newClass
end


return LuaClass
