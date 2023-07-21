---main_vehicles_spawn_showContentThisFrame → Function to show the main/vehicles/spawn menu content
---@param playerGroup string
---@return void
function main_vehicles_spawn_showContentThisFrame(playerGroup)
	RageUI.ButtonWithStyle(
		_U("main_vehicles_spawn_search"),
		_U("main_vehicles_spawn_search_desc"),
		{ RightLabel = (_var.menu.searchVehicle ~= "" and "~r~" .. _var.menu.searchVehicle or "→") },
		true,
		function(_h, _a, Selected)
			if Selected then
				local search = textEntry(_U("textentry_search_vehicle_model"), _var.menu.searchVehicle, 30)
				if search == nil or search == "" then
					_var.menu.searchVehicle = ""
					return
				end
				_var.menu.searchVehicle = search
			end
		end
	)
	for _k, vehicle in pairs(_var.vehicle.list) do
		_var.menu.findedVehicle =
			string.find(vehicle.label, tostring((_var.menu.searchVehicle):gsub("^%l", string.upper)))
		if _var.menu.findedVehicle then
			RageUI.ButtonWithStyle(
				vehicle.label .. " ~c~[" .. string.upper(vehicle.type) .. "]",
				_U("main_vehicles_spawn_spawn_desc", vehicle.label, vehicle.type),
				{ RightBadge = RageUI.BadgeStyle.Car },
				true,
				function(_h, _a, Selected)
					if Selected then
						local ped = PlayerPedId()
						local pedCoords = GetEntityCoords(ped)
						local pedHeading = GetEntityHeading(ped)
						local pedVehicle = GetVehiclePedIsIn(ped, false)
						if pedVehicle then
							ESX.Game.DeleteVehicle(pedVehicle)
						end
						ESX.Game.SpawnVehicle(vehicle.model, pedCoords, pedHeading, function(callback_vehicle)
							TaskWarpPedIntoVehicle(ped, callback_vehicle, -1)
							SetVehicleEngineOn(callback_vehicle, true, true, false)
						end)
					end
				end
			)
		end
	end
end
