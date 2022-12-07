--[[
--Created Date: Wednesday August 24th 2022
--Author: JustGod
--Made with ❤
-------
--Last Modified: Wednesday August 24th 2022 1:07:12 am
-------
--Copyright (c) 2022 JustGodWork, All Rights Reserved.
--This file is part of JustGodWork project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

---@param msg string
---@param hudColorIndex number
function jLib.Notification.simple(msg, hudColorIndex)
	if type(msg) == "string" then
		local maxLen = 128 -- Maximum length of a text notification is 128 characters
		if string.len(msg) > maxLen then
			error("The length of the string is greater than 128!")
		else
			BeginTextCommandThefeedPost('STRING')
			AddTextComponentSubstringPlayerName(msg)
			if hudColorIndex and type(hudColorIndex) == "number" then ThefeedSetNextPostBackgroundColor(hudColorIndex) end
			EndTextCommandThefeedPostTicker(0,1)
		end
	else 
		error("The msg parameter must be a string!")
	end
end

---@param sender string
---@param subject string
---@param msg string
---@param textureDict string
---@param iconType number
---@param flash boolean
---@param saveToBrief boolean
---@param hudColorIndex number
function jLib.Notification.advanced(sender, subject, msg, textureDict, iconType, flash, saveToBrief, hudColorIndex)
	if type(sender) == "string" and type(subject) == "string" and type(msg) == "string" and type(textureDict) == "string" and type(iconType) == "number" and type(flash) == "boolean" and type(saveToBrief) == "boolean" then
		local maxLen = 128 -- Maximum length of a text notification is 128 characters
		if string.len(msg) > maxLen then
			error("The length of the string is greater than 128!")
		else
			if saveToBrief == nil then saveToBrief = true end
			AddTextEntry('AdvancedNotification', msg)
			BeginTextCommandThefeedPost('AdvancedNotification')
			if hudColorIndex and type(hudColorIndex) == "number" then ThefeedSetNextPostBackgroundColor(hudColorIndex) end
			EndTextCommandThefeedPostMessagetext(textureDict, textureDict, false, iconType, sender, subject)
			EndTextCommandThefeedPostTicker(flash or false, saveToBrief)
		end
	else 
		error("The parameters must be a string, a boolean or a number!")
	end 
end

---@param msg string
---@param thisFrame boolean
---@param beep boolean 
---@param duration number
function jLib.Notification.helpNotification(msg, thisFrame, beep, duration)
	if type(msg) == "string" and type(thisFrame) == "boolean" and type(beep) == "boolean" and type(duration) == "number" then 
		local maxLen = 99 -- Maximum length of a help notification is 99 characters
		if string.len(msg) > maxLen then
			error("The length of the string is greater than 99!")
		else
			AddTextEntry('HelpNotification', msg)

			if thisFrame then
				DisplayHelpTextThisFrame('HelpNotification', false)
			else
				if beep == nil then beep = true end
				BeginTextCommandDisplayHelp('HelpNotification')
				EndTextCommandDisplayHelp(0, false, beep, duration or -1)
			end
		end
	else 
		error("The parameters must be a string, a boolean or a number!")
	end
end