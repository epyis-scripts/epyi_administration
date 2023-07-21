---main_vehicles_favorites_showContentThisFrame → Function to show the main/vehicles/favorites menu content
---@param playerGroup string
---@return void
function main_vehicles_favorites_showContentThisFrame(playerGroup)
	Citizen.CreateThread(function()
		if _var.activeThreads.getVehiclesFavorites then
			return
		end
		_var.activeThreads.getVehiclesFavorites = true
		_var.client.playerData = ESX.GetPlayerData()
		ESX.TriggerServerCallback("epyi_administration:getUserData", function(data)
			_var.client.userData.favoritesVehicles = data
		end, _var.client.playerData.identifier, "favorites_vehicles")
		Citizen.Wait(500)
		_var.activeThreads.getVehiclesFavorites = false
	end)
	RageUI.ButtonWithStyle(
		_U("main_vehicles_favorites_add"),
		_U("main_vehicles_favorites_add_desc"),
		{ RightLabel = "→" },
		true,
		function(_h, _a, Selected)
			if Selected then
				local ped = PlayerPedId()
				local pedVehicle = GetVehiclePedIsIn(ped, false)
				local vehicleData = ESX.Game.GetVehicleProperties(pedVehicle)
				if not pedVehicle or GetPedInVehicleSeat(pedVehicle, -1) ~= ped then
					ESX.ShowNotification(_U("self_not_in_vehicle"))
					return
				end
				local vehicleName = textEntry(_U("textentry_add_to_favorites_name"), "", 30)
				if vehicleName == nil or vehicleName == "" then
					ESX.ShowNotification(_U("textentry_string_invalid"))
					return
				end
				vehicleData["vehicleName"] = vehicleName
				table.insert(_var.client.userData.favoritesVehicles, vehicleData)
				_var.client.playerData = ESX.GetPlayerData()
				ESX.TriggerServerCallback("epyi_administration:setUserData", function(result)
					if not result then
						ESX.ShowNotification(_U("notif_datastore_error"))
						return
					end
					ESX.ShowNotification(_U("notif_add_vehicle_favorite_success", vehicleName))
				end, _var.client.playerData.identifier, "favorites_vehicles", _var.client.userData.favoritesVehicles)
			end
		end
	)
	RageUI.Separator("↓ Your ~r~favorites vehicles~s~ ↓")
	if _var.client.userData.favoritesVehicles == nil then
		_var.client.userData.favoritesVehicles = {}
	end
	for key, vehicle in pairs(_var.client.userData.favoritesVehicles) do
		RageUI.List(
			vehicle.vehicleName .. " (" .. GetDisplayNameFromVehicleModel(vehicle.model) .. ")",
			_var.menu.favritesActionsArray,
			_var.menu.favritesActionsArrayIndex,
			_U("main_vehicles_favorites_interact_desc", vehicle.vehicleName),
			{},
			true,
			function(_h, _a, Selected, Index)
				_var.menu.favritesActionsArrayIndex = Index
				if Selected then
					if
						_var.menu.favritesActionsArray[_var.menu.favritesActionsArrayIndex]
						== _("main_vehicles_favorites_interact_spawn")
					then
						local ped = PlayerPedId()
						local pedCoords = GetEntityCoords(ped)
						local pedHeading = GetEntityHeading(ped)
						local pedVehicle = GetVehiclePedIsIn(ped, false)
						if pedVehicle then
							ESX.Game.DeleteVehicle(pedVehicle)
						end
						ESX.Game.SpawnVehicle(vehicle.model, pedCoords, pedHeading, function(callback_vehicle)
							ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
							TaskWarpPedIntoVehicle(ped, callback_vehicle, -1)
							SetVehicleEngineOn(callback_vehicle, true, true, false)
						end)
					elseif
						_var.menu.favritesActionsArray[_var.menu.favritesActionsArrayIndex]
						== _("main_vehicles_favorites_interact_delete")
					then
						table.remove(_var.client.userData.favoritesVehicles, key)
						_var.client.playerData = ESX.GetPlayerData()
						ESX.TriggerServerCallback(
							"epyi_administration:setUserData",
							function(result)
								if not result then
									ESX.ShowNotification(_U("notif_datastore_error"))
									return
								end
								ESX.ShowNotification(_U("notif_remove_vehicle_favorite_success", vehicle.vehicleName))
							end,
							_var.client.playerData.identifier,
							"favorites_vehicles",
							_var.client.userData.favoritesVehicles
						)
					end
				end
			end
		)
	end
end
