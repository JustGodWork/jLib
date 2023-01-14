--[[
--Created Date: Tuesday August 23rd 2022
--Author: JustGod
--Made with ❤
-------
--Last Modified: Tuesday August 23rd 2022 9:12:52 pm
-------
--Copyright (c) 2022 JustGodWork, All Rights Reserved.
--This file is part of JustGodWork project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

---@param data table
---@return LocalPlayer
function jLib.LocalPlayer(data)
    ---@class LocalPlayer
    local self = {}

    self.loaded                 = false
    self.identifier             = data.identifier
    self.inventory              = data.inventory
    self.job                    = data.job
    self.job2                   = data.job2
    self.accounts               = data.accounts
    self.maxWeight              = data.maxWeight
    self.coords                 = data.coords
    self.dead                   = false
    self.name                   = data.name
    self.weight                 = 0
    self.busy                   = false

    ---@return number
    function self.getPed()
        return PlayerPedId()
    end

    ---@return string
    function self.getIdentifier()
        return self.identifier
    end

    ---@return string
    function self.getName()
        return self.name
    end

    ---@return table
    function self.getInventory()
        return self.inventory
    end

    function self.getNumberOfItems()
        local items = {}
        for _, item in pairs(self.inventory) do
            table.insert(items, item.name)
        end
        return #items
    end

    ---@param itemName string
    ---@return table
    function self.getInventoryItem(itemName)
        for _, v in pairs(self.inventory) do
            if v.name == itemName and v.count > 0 then
                return v
            end
        end
        return false
    end

    --- UPDATE PLAYER INVENTORY WEIGHT
    ---@return number
    function self.updateWeight()
        self.weight = 0
        for _, v in pairs(self.inventory) do
            if v.count > 0 then
                self.weight = self.weight + (v.weight * v.count)
            end
        end
        return self.weight
    end

    ---@return number
    function self.getWeight()
        return self.weight
    end

    ---@param itemName string
    ---@return boolean
    function self.hasItem(itemName)
        for _, v in pairs(self.inventory) do
            if v.name == itemName and v.count > 0 then
                return true
            end
        end
        return false
    end

    ---@param itemName string
    ---@param count number
    function self.addInventoryItem(itemName, count)
        for k, v in pairs(self.inventory) do
            if v.name == itemName then
                self.inventory[k].count = count
            end
        end
        self.updateWeight()
    end

    ---@param itemName string
    ---@param amount number
    ---@return boolean
    function self.removeInventoryItem(itemName, amount)
        for k, v in pairs(self.inventory) do
            if v.name == itemName then
                if v.count - amount <= 0 then
                    table.remove(self.inventory, k)
                else
                    v.count = amount
                end
            end
        end
        self.updateWeight()
    end

    ---@return table
    function self.getJob()
        return self.job
    end

    ---@param job table
    function self.setJob(job)
        self.job = job
    end

    ---@param jobName string
    ---@return boolean
    function self.hasJob(jobName)
        if self.job.name == jobName then
            return true
        end
        return false
    end

    ---@return table
    function self.getJob2()
        return self.job2
    end

    ---@param job2 table
    function self.setJob2(job2)
        self.job2 = job2
    end

    ---@param job2Name string
    ---@return boolean
    function self.hasJob2(job2Name)
        if self.job2.name == job2Name then
            return true
        end
        return false
    end

    ---@return table
    function self.getAccounts()
        return self.accounts
    end

    ---@param account table
    function self.setAccount(account)

        for k, v in ipairs(self.getAccounts()) do
            if v.name == account.name then
                self.accounts[k] = account
                break;
            end
        end

    end

    ---@return number
    function self.getMoney()
        for _, v in pairs(self.accounts) do
            if v.name == jLib.Utils.getConfig().accounts.money then
                return v.money
            end
        end
    end

    ---@return number
    function self.getBank()
        for _, v in pairs(self.accounts) do
            if v.name == jLib.Utils.getConfig().accounts.bank then
                return v.money
            end
        end
    end

    ---@return number
    function self.getBlackMoney()
        for _, v in pairs(self.accounts) do
            if v.name == jLib.Utils.getConfig().accounts.black_money then
                return v.money
            end
        end
    end

    ---@param weight number
    function self.setMaxWeight(weight)
        self.maxWeight = weight
    end

    ---@return number
    function self.getMaxWeight()
        return self.maxWeight
    end

    ---@return table
    function self.getCoords()
        local pCoords = GetEntityCoords(self.getPed())
        return {x = pCoords.x, y = pCoords.y, z = pCoords.z}
    end

    ---@param x number
    ---@param y number
    ---@param z number
    function  self.setCoords(x, y, z)
        self.coords = {x = x, y = y, z = z } or self.getCoords()
    end

    ---@return number
    function self.getVehicle()
        return GetVehiclePedIsIn(self.getPed(), false)
    end

    ---Teleport The player to the specified coords
    ---@param x number
    ---@param y number
    ---@param z number
    ---@param heading number
    function self.teleport(x, y, z, heading)
        CreateThread(function()
            DoScreenFadeOut(700)
            Wait(700)
            SetEntityCoords(self.getPed(), x, y, z)
            if heading then
                SetEntityHeading(self.getPed(), heading)
            end
            Wait(1200)
            DoScreenFadeIn(700)
        end)
    end

    ---@param seat number
    ---@return boolean
    function self.isInVehicle(seat)
        return self.getVehicle() ~= 0 and GetPedInVehicleSeat(self.getVehicle(), seat) == self.getPed() --IsPedInAnyVehicle(self.getPed(), seat)
    end

    ---@return boolean
    function self.isDead()
        return self.dead
    end

    ---@param dead boolean
    function self.setDead(dead)
        self.dead = dead
    end

    ---@param busy boolean
    function self.setBusy(busy)
        self.busy = busy
    end

    ---@return boolean
    function self.isBusy()
        return self.busy
    end
    
    self.updateWeight()

    return self
end