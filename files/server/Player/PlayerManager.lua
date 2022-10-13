--[[
----
----Created Date: 7:35 Thursday October 13th 2022
----Author: JustGod
----Made with ❤
----
----File: [PlayerManager]
----
----Copyright (c) 2022 JustGodWork, All Rights Reserved.
----This file is part of JustGodWork project.
----Unauthorized using, copying, modifying and/or distributing of this file
----via any medium is strictly prohibited. This code is confidential.
----
--]]

---@type PlayerManager
local PlayerManager = Class.new(function(class)

    ---@class PlayerManager: BaseObject
    local self = class;

    function self:Constructor()
        ---@type Player[]
        self.players = {};

        local ESXPlayer = ESX.GetPlayers()
        for _, v in pairs(ESXPlayer) do --Compatibility with old es_extended
            local xPlayer = ESX.GetPlayerFromId(v)

            if (xPlayer) then
                self.players[v] = Player(xPlayer);
            end
        end
    end

    ---@param playerId number
    ---@return Player
    function self:GetPlayer(playerId)
        return self.players[playerId];
    end

    ---@param identifier string
    ---@return Player | nil
    function self:GetPlayerFromIdentifier(identifier)
        for i = 1, #self.players do
            if (self.players[i]) then
                if (self.players[i]:GetIdentifier() == identifier) then
                    return self.players[i];
                end
            end
        end
        return nil;
    end

    return self;
end)

jLib.PlayerManager = PlayerManager();