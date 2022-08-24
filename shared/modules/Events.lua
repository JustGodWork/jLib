--[[
--Created Date: Tuesday August 23rd 2022
--Author: JustGod
--Made with ❤
-------
--Last Modified: Tuesday August 23rd 2022 8:51:29 pm
-------
--Copyright (c) 2022 JustGodWork, All Rights Reserved.
--This file is part of JustGodWork project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

---@param eventName string
function jLib.Events.trigger(eventName, ...)
    return TriggerEvent(eventName, ...)
end

---@param eventName string
---@param source number @NetId of player
function jLib.Events.toClient(eventName, source, ...)
    return TriggerClientEvent(eventName, source, ...)
end

---@param eventName string
function jLib.Events.toServer(eventName, ...)
    return TriggerServerEvent(eventName, ...)
end

function jLib.Events.broadcast(eventName, ...)
    if not IsDuplicityVersion() then return print("^7[^1ERROR^7]^4 jLib.Events.broadcast is server side only.^7") end
    return TriggerClientEvent(eventName, -1, ...)
end

---@param eventName string
---@param cb fun(xPlayer: xPlayer | boolean, ...)
function jLib.Events.on(eventName, cb)
    return AddEventHandler(eventName, function(...)
        cb(...)
    end)
end

---@param eventName string
---@param cb fun(xPlayer: xPlayer | boolean, ...)
function jLib.Events.onNet(eventName, cb)
    return RegisterNetEvent(eventName, function(...)
        if not IsDuplicityVersion() then
            cb(...)
        else
            local src = source
            local xPlayer = src ~= 0 and ESX.GetPlayerFromId(src) or false
            cb(xPlayer, ...)
        end
    end)
end