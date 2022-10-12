--[[
--Created Date: Wednesday August 24th 2022
--Author: JustGod
--Made with ❤
-------
--Last Modified: Wednesday August 24th 2022 1:28:29 pm
-------
--Copyright (c) 2022 JustGodWork, All Rights Reserved.
--This file is part of JustGodWork project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

---Shared function
---@return Config
function jLib.Utils.getConfig()
	return Config
end

---Shared function
---@param var any
---@return boolean
function jLib.Utils.isString(var)
	return type(var) == "string";
end

---Shared function
---@param var any
---@return boolean
function jLib.Utils.isTable(var)
	return type(var) == "table";
end

---Shared function
---@param var any
---@return boolean
function jLib.Utils.isNumber(var)
	return type(var) == "number";
end

---Shared function
---@param var any
---@return boolean
function jLib.Utils.isBoolean(var)
	return type(var) == "boolean";
end

---Shared function
---@param var any
---@return boolean
function jLib.Utils.isNil(var)
	return var == nil or type(var) == nil;
end

---Shared function
---@param var any
---@return boolean
function jLib.Utils.isValid(var)
	return var ~= nil and type(var) ~= nil;
end

---Shared function
---@param var any
---@param varType type
---@return boolean
function jLib.Utils.isValidAndOfType(var, varType)
	if (jLib.Utils.isValid(var) and type(var) == varType) then
		return true;
	end
	return false;
end

---@return table
function jLib.getESX()
	return ESX;
end