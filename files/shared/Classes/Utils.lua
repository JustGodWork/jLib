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

Class = {};

---@param class BaseObject
---@return BaseObject | nil
function Class.super(class)
	if type(class) ~= "table" then
 	    error("Expected a table as the first parameter, got " .. type(class));
   end
	local metatable = getmetatable(class);
	if not metatable then 
        error("No metatable found on class");
    end
	local metasuper = metatable and metatable.__super;
	if (metasuper) then
		return metasuper;
	end
	return nil;
end

---@param class BaseObject
local function build(class)
	if (class) then
		local metatable = getmetatable(class);
		if not metatable then 
            error("No metatable found on class");
        end
		return setmetatable( {}, {
			__index = class;
	        __super = Class.super(class);
			__newindex = type(class.__newindex) == "function" and class.__newindex or nil;
			__call = type(metatable.__call) == "function" and metatable.__call or nil;
			__len = type(class.__len) == "function" and class.__len or nil;
			__unm = type(class.__unm) == "function" and class.__unm or nil;
			__add = type(class.__add) == "function" and class.__add or nil;
			__sub = type(class.__sub) == "function" and class.__sub or nil;
			__mul = type(class.__mul) == "function" and class.__mul or nil;
			__div = type(class.__div) == "function" and class.__div or nil;
			__pow = type(class.__pow) == "function" and class.__pow or nil;
			__concat = type(class.__concat) == "function" and class.__concat or nil;
		});
	end
end

---@param from BaseObject
---@param callback fun(class: BaseObject): BaseObject
---@return BaseObject
function Class.extends(from, callback)
	local extend = from or BaseObject;
	if type(extend) ~= "table" then
 	    error("Expected a table as the first parameter, got " .. type(extend));
    end
	local metatable = getmetatable(extend);
	if type(callback) ~= "function" then
    	error("Parameter 'callback' must be of type 'function'");
    end
	if not metatable then 
        error("No metatable found on class");
    end
	return setmetatable(callback({}), {
		__index = extend;
		__super = extend;
		__newindex = type(extend.__newindex) == "function" and extend.__newindex or nil;
		__call = metatable.__call;
		__len = type(extend.__len) == "function" and extend.__len or nil;
		__unm = type(extend.__unm) == "function" and extend.__unm or nil;
		__add = type(extend.__add) == "function" and extend.__add or nil;
		__sub = type(extend.__sub) == "function" and extend.__sub or nil;
		__mul = type(extend.__mul) == "function" and extend.__mul or nil;
		__div = type(extend.__div) == "function" and extend.__div or nil;
		__pow = type(extend.__pow) == "function" and extend.__pow or nil;
		__concat = type(extend.__concat) == "function" and extend.__concat or nil;
	});
end

---@param class BaseObject
---@param ... any
---@return BaseObject
function Class.instance(class, ...)
	if (type(class) ~= "table") then 
        error("Expected a table as the first parameter, got " .. type(class));
    end
	if (class and type(class) == "table") then
		local instance = build(class);

		if (rawget(class, "Constructor")) then
			if type(rawget(class, "Constructor")) ~= "function" then
        		error ("The Constructor method is not a function"); 
          	end
			assert(rawget(class, "Constructor"), "Constructor does not exist");
			rawget(class, "Constructor")(instance, ...);
		end

		return instance;
	end
end

---@param class BaseObject
function Class.Delete(class, ...)
	if (not class) then error("Called delete without object"); end
	if (type(class) ~= "table") then
		error("Expected an object of type table, got " .. type(class))
	end
	if (class.Destroy and type(class.Destroy) == "function") then
		assert(class.Destroy(), "Invalid Destroy Method!");
		class:Destroy(...);
	end
end