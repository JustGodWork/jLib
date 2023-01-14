--[[
--Created Date: Tuesday August 23rd 2022
--Author: JustGod
--Made with ❤
-------
--Last Modified: Tuesday August 23rd 2022 11:17:21 pm
-------
--Copyright (c) 2022 JustGodWork, All Rights Reserved.
--This file is part of JustGodWork project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

jLib.Events.onNet(jLib.Utils.getConfig().events.setJob, function(job)
    jLib.player.setJob(job)
    jLib.Events.trigger(string.format("%s:Zone:reload", GetCurrentResourceName()))
end)

jLib.Events.onNet(jLib.Utils.getConfig().events.setJob2, function(job2)
    jLib.player.setJob2(job2)
    jLib.Events.trigger(string.format("%s:Zone:reload", GetCurrentResourceName()))
end)

jLib.Events.onNet(jLib.Utils.getConfig().events.setAccountMoney, function(account)

    jLib.player.setAccount(account);

end)

jLib.Events.onNet(jLib.Utils.getConfig().events.addInventoryItem, function(item, count)
    jLib.player.addInventoryItem(item, count)
end)

jLib.Events.onNet(jLib.Utils.getConfig().events.removeInventoryItem, function(itemName, count)
    jLib.player.removeInventoryItem(itemName, count)
end)