--[[
----
----Created Date: 7:27 Saturday October 8th 2022
----Author: JustGod
----Made with ❤
----
----File: [Utils]
----
----Copyright (c) 2022 JustGodWork, All Rights Reserved.
----This file is part of JustGodWork project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

--Crédits: https://github.com/nanos-world/egui (MegaThorx)

jLib.Class = {};

local classes = {
	["BaseObject"] = BaseObject
};

---@param class BaseObject
---@return BaseObject | nil
function jLib.Class.super(class)
	local metatable = getmetatable(class);
	local metasuper = metatable.__super;
	if (metasuper) then
		return metasuper;
	end
	return nil;
end

---@param class BaseObject
local function build(class)
	if (classes[class]) then
		local metatable = getmetatable(classes[class]);
		return setmetatable( {}, {
			__index = classes[class];
			__super = jLib.Class.super(classes[class]);
			__newindex = classes[class].__newindex;
			__call = metatable.__call;
			__len = classes[class].__len;
			__unm = classes[class].__unm;
			__add = classes[class].__add;
			__sub = classes[class].__sub;
			__mul = classes[class].__mul;
			__div = classes[class].__div;
			__pow = classes[class].__pow;
			__concat = classes[class].__concat;
		});
	end
end

---@param newClass BaseObject
---@param from BaseObject
---@param callback fun(class: BaseObject): BaseObject
---@return BaseObject
function jLib.Class.extends(newClass, from, callback)
	assert(newClass, "Attempt to create a nil class value");
	assert(from, "Attempt to inherit a nil class value");
	if (not classes[newClass]) then
		local meta = {};
		classes[newClass] = callback(meta);
		local metatable = getmetatable(classes[from]);
		setmetatable(classes[newClass], {
			__index = classes[from];
			__super = classes[from];
			__newindex = classes[from].__newindex;
			__call = metatable.__call;
			__len = classes[from].__len;
			__unm = classes[from].__unm;
			__add = classes[from].__add;
			__sub = classes[from].__sub;
			__mul = classes[from].__mul;
			__div = classes[from].__div;
			__pow = classes[from].__pow;
			__concat = classes[from].__concat;
		});
	end
end

---@param class BaseObject
---@param ... any
---@return BaseObject
function jLib.Class.instance(class, ...)
	if (class and classes[class]) then
		local instance = build(class);

		if (rawget(classes[class], "Constructor")) then
			rawget(classes[class], "Constructor")(instance, ...);
		end

		return instance;
	end
end

---@param class BaseObject
function jLib.Class.Delete(class, ...)
	if (not self) then error("Called delete without object"); end
	if (class.Destroy) then
		class:Destroy(...);
	end
end