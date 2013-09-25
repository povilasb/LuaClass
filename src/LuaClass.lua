---
-- LuaClass implements functions to create classes in lua. It supports
-- multiple level inheritance, constructor.
--
-- LuaClass classes and objects have some special fields and methods. They
-- start wih a prefix '_'. E.g. _class.
--
-- _class - pointer to an object class.
-- _name - class name.
-- _init() - class constructor that is invoked every time SomeClass:new() is
--	invoked.
-- _super - if class has inherited from some other class, _super points to
--	that other class.
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
-- If class has defined an _init function, it is called on new object
-- creation. Inside init function self variable refers to the created object.
--
-- @param {table} selfClass class whose object will be created.
-- @return table created object.
---
function LuaClass.createObject(selfClass, ...)
	local newObj = {}
	setmetatable(newObj, selfClass)

	if selfClass._init then
		selfClass._init(newObj, ...)
	end

	newObj._class = selfClass

	return newObj
end


---
-- Checks if specified object inherits from the specified class. Object
-- class also counts.
--
-- @param {table} selfObj object that is checked.
-- @param {table} class class to check if specified object inherits from.
-- @return {boolean} true if specified object inherits from the specified
--	class, false otherwise.
---
function LuaClass.inheritsFrom(selfObj, class)
	local selfClass = selfObj._class

	-- check object class
	if selfClass._name == class._name then
		return true
	-- check ancestor class list
	else
		for i = #selfClass._ancestorList, 1, -1 do
			if selfClass._ancestorList[i]._name == class._name then
				return true
			end
		end
	end

	return false
end


---
-- Checks if the specified object is instance of the specified class or any
-- of it's ancestor classes.
--
-- @param {LuaClass} selfClass LuaClass created class.
-- @param {any} object object to check if it is an instance of the specified
--	class.
-- @return {boolean} true if the specified object is an instance of the
--	specified class or it's ancestors, false otherwise.
---
function LuaClass.isInstance(selfClass, object)
	local retval = false

	if object._class and object.inheritsFrom then
		retval = object:inheritsFrom(selfClass)
	end

	return retval
end


-- PUBLIC


LuaClass.VERSION = "0.2.0"


---
-- Creates a new class with the specified name.
--
-- @param {string} name class name.
-- @param {table} class that will be extended. Might be nil, in such case
--	no class is extended.
-- @return {table} table representing lua class.
---
function LuaClass:create(name, base)
	assert(name)

	local newClass = {}
	newClass._name = name

	-- make a copy of base class super class list
	if base and type(base._ancestorList) == "table" then
		newClass._ancestorList = table.copy(base._ancestorList)
	else
		newClass._ancestorList  = {}
	end

	if base then
		table.insert(newClass._ancestorList, base)
		newClass._super = base
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
	newClass.new = LuaClass.createObject
	newClass.inheritsFrom = LuaClass.inheritsFrom
	newClass.isInstance = LuaClass.isInstance

	return newClass
end


return LuaClass
