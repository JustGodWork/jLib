--[[
----
----Created Date: 7:23 Saturday October 8th 2022
----Author: JustGod
----Made with ❤
----
----File: [Classes]
----
----Copyright (c) 2022 JustGodWork, All Rights Reserved.
----This file is part of JustGodWork project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

--Crédits: https://github.com/nanos-world/egui (MegaThorx)

---@class BaseObject
BaseObject = {}

setmetatable(BaseObject, {
    __call = function(self, ...)
        return self:new(...);
    end
});

---@private
function BaseObject:GetCreators()
    local creators = [[
        -----------------------------------------------------
        |    Original code has been made by MegaThorx       |
        |    and rewritten by JustGod to make a code like   |
        |    JavaScript                                     |
        -----------------------------------------------------
    ]]
    print(creators);
    return creators;
end

---@private
function BaseObject:new(...)
    return Class.instance(self, ...);
end

function BaseObject:super(...)
    local metatable = getmetatable(self);
    local metasuper = metatable.__super;
    if (metasuper) then
        if (rawget(metasuper, "Constructor")) then
            rawget(metasuper, "Constructor")(self, ...)
        end
    end
end

function BaseObject:Delete(...)
	return Class.Delete(self, ...);
end

---@param key string
---@param value any
function BaseObject:SetValue(key, value)
    if (string.sub(key, 1, 2) ~= "__") then
        self[key] = value;
    end
end

---@param key string
---@return any
function BaseObject:GetValue(key)
    if (string.sub(key, 1, 2) ~= "__") then
        return self[key];
    end
end