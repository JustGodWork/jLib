--[[
--Created Date: Wednesday August 24th 2022
--Author: JustGod
--Made with ❤
-------
--Last Modified: Wednesday August 24th 2022 2:56:17 pm
-------
--Copyright (c) 2022 JustGodWork, All Rights Reserved.
--This file is part of JustGodWork project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

---@param commandName string
---@param jLibGroup string
---@param cb fun(xPlayer: xPlayer, args: any)
function jLib.addCommand(commandName, jLibGroup, cb)
    RegisterCommand(commandName, function(source, args)
        local src = source
        local xPlayer = source ~= 0 and ESX.GetPlayerFromId(src) or false
        if jLib.getAdmins()[jLibGroup][xPlayer.identifier] then
            cb(xPlayer, args)
        else
            xPlayer.showNotification("~r~Vous n'avez pas la permission.")
        end
    end)
end