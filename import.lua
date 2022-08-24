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

local IS_CLIENT = not IsDuplicityVersion();
local IS_SERVER = IsDuplicityVersion();

ESX = exports['es_extended']:getSharedObject()
jLib = exports["jLib"]:getLib()

---@param path string
function jLib.loadModule(path)
    if type(path) == "table" then
        for i = 1, #path do
            jLib.loadModule(path[i])
        end
        return
    end
    local module = LoadResourceFile("jLib", string.format("files/%s", path))
    local moduleLoaded, err = load(module, string.format("files/%s", path))

    if err then 
        return error(string.format("Error loading module ^4%s^1 in ^4%s^7", path, GetCurrentResourceName()))
    else
        return moduleLoaded()
    end
end

if IS_CLIENT then
    --INIT PLAYER DATA
    jLib.Events.onNet("jLib:createPlayer", function(xPlayer)
        jLib.player = jLib.LocalPlayer(xPlayer)
    end);
    jLib.Events.toServer("jLib:requestPlayers");

    --LOADING SOME MODULE TO REFRESH PLAYER DATA
    jLib.loadModule("client/PlayerEvents.lua");
    jLib.loadModule(jLib.RageModule)
end

if IS_SERVER then
    jLib.Admins = jLib.getAdmins()
end