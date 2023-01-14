--[[
--Created Date: Tuesday August 23rd 2022
--Author: JustGod
--Made with ❤
-------
--Last Modified: Tuesday August 23rd 2022 9:08:33 pm
-------
--Copyright (c) 2022 JustGodWork, All Rights Reserved.
--This file is part of JustGodWork project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

Config = {}

Config.MarkerRGB = {
    r = 255,
    g = 255,
    b = 255,
    a1 = 200,
    a2 = 150
}

Config.job2 = true -- ENABLE JOB2 USAGE

Config.accounts = {
    bank = "bank",
    money = "money",
    black_money = "black_money"
}

Config.events = {
    esx = "esx:getSharedObject",
    PlayerLoaded = "esx:playerLoaded",
    setJob = "esx:setJob",
    setJob2 = "esx:setJob2",
    addInventoryItem = "esx:addInventoryItem",
    removeInventoryItem = "esx:removeInventoryItem",
    setAccountMoney = "esx:setAccountMoney",
    setMaxWeight = "esx:setMaxWeight",
}