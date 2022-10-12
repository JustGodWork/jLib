--[[
--Created Date: Wednesday August 24th 2022
--Author: JustGod
--Made with ❤
-------
--Last Modified: Wednesday August 24th 2022 12:50:46 am
-------
--Copyright (c) 2022 JustGodWork, All Rights Reserved.
--This file is part of JustGodWork project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

jLib.Zones = {}

jLib.Class.extends("Zone", "BaseObject", function(class)
    
    ---@class Zone: BaseObject
    local self = class;

    ---@param data table @data.job string @data.jobGrade string @data.job2 string @data.job2Grade string @data.timer number @data.coords vector3
    ---@return Zone
    function self:Constructor(id, data)
        if data == nil then data = {} end
        if not id or type(id) ~= "string" then return error("^4jLib^7: ^3Zone^7 | ^1 Id must be a string^7") end
        self.id = id
        self.data = {
            job = data.job or "not",
            jobGrade = data.jobGrade or "not",
            job2 = data.job2 or "not",
            job2Grade = data.job2Grade or "not",
            coords = data.coords or {}
        }

        self.radius = {}
        self.timer = (data and data.timer) or 0
        self.running = false

        jLib.Zones[self.id] = self
    end

    ---@param callback function
    function self:setCallBack(callback)
        self.callback = callback
    end

    ---@param callback function
    function self:start(callback)
        if callback then self.callback = callback end
        self.running = true
        CreateThread(function()
            while not jLib.player do Wait(0) end
            while self.running do
                self.callback()
                Wait(self.timer)
            end
        end)
    end

    ---@param timer number
    function self:setTimer(timer)
        self.timer = timer
    end

    ---@param timer number
    function self:addTimer(timer)
        Wait(timer)
    end

    ---@return number
    function self:getTimer()
        return self.timer
    end

    ---Resume the zone
    function self:resume()
        if not self.running then
            self:start()
        end
    end

    ---Stop the zone
    function self:stop()
        self.running = false
    end

    ---@return boolean
    function self:isRunning()
        return self.running
    end

    ---@param zAxis number
    ---@param marker number
    ---@param radius number
    ---@param rgb table<r, g, b, a1, a2>
    function self:marker(zAxis, marker, radius, rgb)
        return DrawMarker(marker or 6, self.coords.x, self.coords.y, self.coords.z + (zAxis or - 0.98), 0.0, 0.0, 0.0, -90, 0.0, 0.0, radius or 0.75, radius or 0.75, radius or 0.75, rgb.r or jLib.Utils.getConfig().MarkerRGB.r, rgb.g or jLib.Utils.getConfig().MarkerRGB.g, rgb.b or jLib.Utils.getConfig().MarkerRGB.b, rgb.a1 or jLib.Utils.getConfig().MarkerRGB.a1, false, false, nil, false, false, false, false),
        DrawMarker(1, self.coords.x, self.coords.y, self.coords.z + (zAxis or - 0.98), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, radius or 0.75, radius or 0.75, 0.3, rgb.r or jLib.Utils.getConfig().MarkerRGB.r, rgb.g or jLib.Utils.getConfig().MarkerRGB.g, rgb.b or jLib.Utils.getConfig().MarkerRGB.b, rgb.a2 or jLib.Utils.getConfig().MarkerRGB.a2, false, false, nil, false, false, false, false)
    end

    ---@param text string
    ---@param size number
    ---@param zAxis number
    function self:text(text, size, zAxis)
        return jLib.Game.DrawText3D(vector3(self.coords.x, self.coords.y, self.coords.z + (zAxis or 0.2)), text, size or 0.6)
    end

    ---@return number
    function self:getDistance()
        return #(GetEntityCoords(PlayerPedId()) - self.coords)
    end

    ---@param radius number
    ---@param callback function
    ---@param allowVehicle boolean
    function self:isPlayerInRadius(radius, callback, allowVehicle, onlyInVehicle)
        if self:getDistance() <= radius 
            and (
                    (   
                        not allowVehicle 
                        and not onlyInVehicle 
                        and not jLib.player.isInVehicle(-1)
                    )
                    or (
                            allowVehicle 
                            and not onlyInVehicle
                        )
                    or (
                        not allowVehicle 
                        and onlyInVehicle 
                        and jLib.player.isInVehicle(-1)
                    )
                )
        then
            if callback then callback() end
        end
    end

    ---@param radius number
    ---@param onEnter function
    ---@param onLeave function
    function self:radiusEvents(radius, onEnter, onLeave)
        local name = tostring(radius).. self.coords
        if not self.radius[name] then
            self.radius[name] = "N/A"
        end
        if self.radius[name] == "N/A" 
            and self:getDistance() <= radius 
        then
            self.radius[name] = "IN"
            if onEnter then onEnter() end
        elseif self:getDistance() > radius
            and self.radius[name] == "IN"
        then
            self.radius[name] = "N/A"
            if onLeave then onLeave() end
        end
    end

    ---@param key string
    ---@param value any
    function self:setData(key, value)
        self.data[key] = value
    end

    ---@param key string
    function self:getData(key)
        return self.data[key]
    end

    ---@param key string
    ---@param callback function
    function self:keyPressed(key, callback)
        if IsControlJustReleased(0, jLib.Utils.Keys[key]) then
            if callback then callback() else return end
        end
    end

    ---@param coords vector3
    function self:setCoords(coords)
        self.coords = coords
    end

    return self;
end)

local function reloadZones()
    CreateThread(function()
        while not jLib.player do Wait(0) end
        for k, _ in pairs(jLib.Zones) do
            local zone = jLib.Zones[k]
            if jLib.player.getJob().name == zone.data.job and zone.data.jobGrade == "not"
                    or (jLib.Utils.getConfig().job2) and jLib.player.getJob2().name == zone.data.job2 and zone.data.job2Grade == "not"
                    or jLib.player.getJob().name == zone.data.job and zone.data.jobGrade == jLib.player.getJob().grade_name
                    or (jLib.Utils.getConfig().job2) and jLib.player.getJob2().name == zone.data.job2 and zone.data.job2Grade == jLib.player.getJob2().grade_name
                    or zone.data.job == "not" and zone.data.jobGrade == jLib.player.getJob().grade_name
                    or (jLib.Utils.getConfig().job2) and zone.data.job2 == "not" and zone.data.job2Grade == jLib.player.getJob2().grade_name
            then
                if not zone:isRunning() and zone.callback then
                    zone:resume()
                end
            elseif zone.data.job == "not" 
                and zone.data.jobGrade == "not" 
                and zone.data.job2 == "not" 
                and zone.data.job2Grade == "not" 
            then
                if not zone:isRunning() and zone.callback then
                    zone:resume()
                end
            else
                if zone:isRunning() then
                    zone:stop()
                end
            end
        end
    end)
end

jLib.Events.on(string.format("%s:Zone:reload", GetCurrentResourceName()), function()
    reloadZones()
end)

jLib.Events.trigger(string.format("%s:Zone:reload", GetCurrentResourceName()))