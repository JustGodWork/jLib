--[[
--Created Date: Wednesday August 24th 2022
--Author: JustGod
--Made with ❤
-------
--Last Modified: Wednesday August 24th 2022 6:20:01 pm
-------
--Copyright (c) 2022 JustGodWork, All Rights Reserved.
--This file is part of JustGodWork project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

Lang = {}
Lang.langs = {}

---@param langName string Name of the language
---@param data table
function Lang.create(langName, data)
    Lang.langs[string.upper(langName)] = data
end

---@param str string
---@param ... any
function Lang._(str, ...)  -- Translate string

	if Lang.langs[string.upper(Config.lang)] ~= nil then
		
		if Lang.langs[string.upper(Config.lang)][str] ~= nil then
			return string.format(Lang.langs[string.upper(Config.lang)][str], ...)
		else
			return 'Missing entry for [~r~'..str..'~s~]'
		end

	else
		return 'Locale [~r~' .. string.upper(Config.lang) .. '~s~] does not exist, Please set it in the config.lua'
	end

end

---@param str string
---@param ... any
function Lang.addEntry(str, ...) -- Translate string first char uppercase
	return tostring(Lang._(str, ...):gsub("^%l", string.upper))
end