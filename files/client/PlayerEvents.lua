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
    if type(job) ~= 'string' then return end 

    if string.len(job) > 255 then
        print("Input length exceeded max limit of 255 characters.")
        return
    else
        jLib.player.setJob(job)
        jLib.Events.trigger(string.format("%s:Zone:reload", GetCurrentResourceName()))
    end
end)

jLib.Events.onNet(jLib.Utils.getConfig().events.setJob2, function(job2)
    if type(job2) ~= 'string' then return end 

    if string.len(job2) > 255 then
       print("Input length exceeded max limit of 255 characters.")
       return
   else
	   jLib.player.setJob2(job2)
	   jLib.Events.trigger(string.format("%s:Zone:reload", GetCurrentResourceName()))
   end
end)

jLib.Events.onNet(jLib.Utils.getConfig().events.setAccountMoney, function(account)
    if type(account) ~= 'table' or not account.name or type(account.name) ~= 'string' or not account.money or type(account.money) ~= 'number' then 
        return
    end 

    local valid = false
    for k, v in ipairs(jLib.player.getAccounts()) do
        if v.name == account.name and tonumber(v.name) then
            valid = true
            jLib.player.setAccount(k, {name = v.name, money = math.max(account.money, 0)})
            break
        end
    end
    if not valid then
        print("Invalid input detected. Please check your inputs and try again.")
        return
    end
end)

jLib.Events.onNet(jLib.Utils.getConfig().events.addInventoryItem, function(item, count)
     if type(item) ~= "table" or not item.name or not count or type(count) ~= "number" then 
         return
     end

     if count < 0 then 
         print("Negative value detected. Please enter a number equal to or larger than zero.")
         return
     else
         jLib.player.addInventoryItem(item, math.max(count, 0))
     end
end)

jLib.Events.onNet(jLib.Utils.getConfig().events.removeInventoryItem, function(itemName, count)
    if not itemName or type(itemName) ~= "string" or not count or type(count) ~= "number" then 
        return
    end

    if count < 0 then
        print("Negative value detected. Please enter a number equal to or larger than zero.")
        return
    else
        jLib.player.removeInventoryItem(itemName, math.min(count, 0))
    end
end)