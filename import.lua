--[[
--Created Date: Tuesday August 23rd 2022
--Author: JustGod
--Made with ❤
-------
--Last Modified: Tuesday August 23rd 2022 10:19:33 pm
-------
--Copyright (c) 2022 JustGodWork, All Rights Reserved.
--This file is part of JustGodWork project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

jLib, ESX = exports["jLib"]:getLib();

jLib.IS_CLIENT = not IsDuplicityVersion();
jLib.IS_SERVER = IsDuplicityVersion();

---@param path string
function jLib.loadModule(path)
    if type(path) == "table" then
        for i = 1, #path do
            jLib.loadModule(path[i])
        end
        return
    end
    local moduleToLoad = LoadResourceFile("jLib", string.format("files/%s", path))
    local moduleLoaded, err = load(moduleToLoad, string.format("files/%s", path))

    if err then 
        return error(string.format("Error loading module ^4%s^1 in ^4%s^7", path, GetCurrentResourceName()))
    else
        return moduleLoaded();
    end
end

---Loading files in both sides

---Classes
jLib.loadModule("shared/Classes/BaseObject.lua");
jLib.loadModule("shared/Classes/Utils.lua");

if jLib.IS_CLIENT then
    --INIT PLAYER DATA
    jLib.Events.onNet(jLib.Events.Enum.Client.createPlayer, function(xPlayer)
        jLib.player = jLib.LocalPlayer(xPlayer)
    end);

    AddEventHandler("onResourceStart", function(resource)
        if resource == GetCurrentResourceName() then
            jLib.Events.toServer(jLib.Events.Enum.Server.requestPlayer);
        end
    end)

    --LOADING SOME MODULE TO REFRESH PLAYER DATA
    jLib.loadModule("client/PlayerEvents.lua");

    --LOADING OTHER MODULES
    jLib.loadModule("client/Zones.lua");
    jLib.loadModule(jLib.RageModule);
end