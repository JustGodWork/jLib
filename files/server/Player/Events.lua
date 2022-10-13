--[[
--Created Date: Tuesday August 23rd 2022
--Author: JustGod
--Made with ❤
-------
--Last Modified: Tuesday August 23rd 2022 9:23:49 pm
-------
--Copyright (c) 2022 JustGodWork, All Rights Reserved.
--This file is part of JustGodWork project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

jLib.Events.onNet(jLib.Events.Enum.Server.requestPlayer, function(xPlayer)
    if xPlayer then
        xPlayer.triggerEvent(jLib.Events.Enum.Client.createPlayer, xPlayer)
    else
        print("^7[^1ERROR^7]: This event is client only.")
    end
end)

jLib.Events.on(jLib.Utils.getConfig().events.PlayerLoaded, function(_, player)
    player.triggerEvent("jLib:createPlayer", player)
end)