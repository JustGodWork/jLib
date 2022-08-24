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
function jLib.Notification.simple(msg)
	BeginTextCommandThefeedPost('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandThefeedPostTicker(0,1)
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
	if saveToBrief == nil then saveToBrief = true end
	AddTextEntry('AdvancedNotification', msg)
	BeginTextCommandThefeedPost('AdvancedNotification')
	if hudColorIndex then ThefeedSetNextPostBackgroundColor(hudColorIndex) end
	EndTextCommandThefeedPostMessagetext(textureDict, textureDict, false, iconType, sender, subject)
	EndTextCommandThefeedPostTicker(flash or false, saveToBrief)
end

---@param msg string
---@param thisFrame boolean
---@param beep boolean 
---@param duration number
function jLib.Notification.helpNotification(msg, thisFrame, beep, duration)
	AddTextEntry('HelpNotification', msg)

	if thisFrame then
		DisplayHelpTextThisFrame('HelpNotification', false)
	else
		if beep == nil then beep = true end
		BeginTextCommandDisplayHelp('HelpNotification')
		EndTextCommandDisplayHelp(0, false, beep, duration or -1)
	end
end