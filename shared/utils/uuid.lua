--[[
--Created Date: Wednesday August 24th 2022
--Author: JustGod
--Made with ❤
-------
--Last Modified: Wednesday August 24th 2022 1:18:43 pm
-------
--Copyright (c) 2022 JustGodWork, All Rights Reserved.
--This file is part of JustGodWork project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

---@Crédits go to https://gist.github.com/jrus
local random = math.random

---@param template string ex: '4xxx-yxxx'
function jLib.Utils.uuid(template)
    local template = template or 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
end