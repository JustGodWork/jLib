--[[
--Created Date: Wednesday August 24th 2022
--Author: JustGod
--Made with ❤
-------
--Last Modified: Wednesday August 24th 2022 1:01:32 am
-------
--Copyright (c) 2022 JustGodWork, All Rights Reserved.
--This file is part of JustGodWork project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

---@param coords table | vector3
---@param distance number
function jLib.Game.GetVehiclesInArea(coords, distance)
    local vehiclesInPool = GetGamePool("CVehicle")
    local vehicles = {}
    for _, vehicle in pairs(vehiclesInPool) do
		local vehicleDist = #(vector3(coords.x, coords.y, coords.z) - GetEntityCoords(vehicle))

		if vehicleDist <= distance then
			vehicles[#vehicles + 1] = vehicle
		end
	end
    return vehicles
end