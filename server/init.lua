--[[
--Created Date: Tuesday August 23rd 2022
--Author: JustGod
--Made with ❤
-------
--Last Modified: Tuesday August 23rd 2022 9:50:02 pm
-------
--Copyright (c) 2022 JustGodWork, All Rights Reserved.
--This file is part of JustGodWork project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

jLib.Events.on("onResourceStart", function(_, resource)
    if resource == GetCurrentResourceName() then
        if resource ~= "jLib" then
            print("Resource name must be ^1jLib^7 to work")
        end
        if not GetConvar("onesync", "off") or GetConvar("onesync", "off") ~= "on" then 
            return 
            print("^1OneSync^7 must be enabled in ^1server.cfg^7"), 
            print("^3OneSync example^7: ^4set onesync on^7") 
        end
    end
end)