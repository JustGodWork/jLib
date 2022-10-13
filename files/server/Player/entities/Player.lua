--[[
----
----Created Date: 7:35 Thursday October 13th 2022
----Author: JustGod
----Made with ❤
----
----File: [Player]
----
----Copyright (c) 2022 JustGodWork, All Rights Reserved.
----This file is part of JustGodWork project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

---@type Player
Player = Class.new(function(class) 

    ---@class Player: BaseObject
    local self = class;

    ---@param xPlayer xPlayer
    function self:Constructor(xPlayer)
        self.id = xPlayer.source;
        self.name = xPlayer.getName();
        self.identifier = xPlayer.getIdentifier();
        self.inventory = xPlayer.getInventory();
        self.job = xPlayer.getJob();
        self.job2 = jLib.Utils.getConfig().job2 and xPlayer.getJob2();
        self.accounts = xPlayer.getAccounts();
        self.coords = xPlayer.getCoords(true);
        self.group = xPlayer.getGroup();
        self.loadout = xPlayer.getLoadout();
        self.weight = xPlayer.getWeight();
        self.maxWeight = xPlayer.getMaxWeight();
        self.variables = {};

        print(("^7[^3SUCCESS^7]^0 Player ^1%s ^7[^1%s^7]^0 has been loaded in %s."):format(
            self:GetName(), 
            self:GetIdentifier(), 
            GetCurrentResourceName()
        ));

    end

    ---@param eventName string
    function self:TriggerEvent(eventName, ...)
        return TriggerClientEvent(eventName, self:GetId(), ...)
    end

    ---@return number
    function self:GetId()
        return self.id;
    end

    ---@return string
    function self:GetName()
        return self.name;
    end
    
    ---@return string
    function self:GetIdentifier()
        return self.identifier;
    end

    ---@return table
    function self:GetInventory()
        return self.inventory;
    end

    ---@return table
    function self:GetJob()
        return self.job;
    end

    ---@return table
    function self:GetJob2()
        return self.job2;
    end

    ---@return table
    function self:GetAccounts()
        return self.accounts;
    end

    ---@param accountName string
    ---@return table | nil
    function self:GetAccount(accountName)
        for i = 1, #self.accounts do
            if (self.accounts[i]) then
                if (self.accounts[i].name == accountName) then
                    return self.accounts[i];
                end
            end
        end
        return nil
    end

    ---@param saved boolean Coords saved by ESX
    ---@return vector3
    function self:GetCoords(saved)
        if (saved) then
            return self.coords;
        else
            return GetEntityCoords(self:GetPed());
        end
    end

    ---@param coords table | vector3
    ---@return boolean
    function self:SetCoords(coords)
        if (coords) then
            SetEntityCoords(self:GetPed(), coords.x, coords.y, coords.z);
            return true;
        end
        return false;
    end

    ---@return string
    function self:GetGroup()
        return self.group;
    end

    ---@return table
    function self:GetLoadout()
        return self.loadout;
    end

    function self:GetWeight()
        return self.weight;
    end

    function self:GetMaxWeight()
        return self.weight;
    end

    ---@param key string
    ---@return any
    function self:GetData(key)
        return self.variables[key];
    end

    ---@param key string
    ---@param value any
    function self:SetData(key, value)
        self.variables[key] = value;
    end

    ---@param message string
    function self:ShowNotification(message, hudColorIndex)
        self:TriggerEvent(jLib.Events.Enum.Client.showNotification, message, hudColorIndex);
    end

    function self:ShowAdvancedNotification(
        sender, 
        subject, 
        message, 
        textureDict, 
        iconType, 
        flash, 
        saveToBrief, 
        hudColorIndex
    )

		self:TriggerEvent(
            jLib.Events.Enum.Client.showAdvancedNotification, 
            sender, 
            subject, 
            message, 
            textureDict, 
            iconType, 
            flash, 
            saveToBrief, 
            hudColorIndex
        );
	end

    return self;
end)