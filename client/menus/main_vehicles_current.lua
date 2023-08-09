---main_vehicles_current_showContentThisFrame → Function to show the main/vehicles/current menu content
---@param playerGroup string
---@return void
function main_vehicles_current_showContentThisFrame(playerGroup)
	local ped = PlayerPedId()
	local pedVehicle = GetVehiclePedIsIn(ped, false)

	RageUI.ButtonWithStyle(
		_U("main_vehicles_current_repair"),
		_U("main_vehicles_current_repair_desc"),
		{},
		Config.Groups[playerGroup].Access["submenu_vehicles_current_repair"],
		function(_h, _a, Selected)
			if Selected then
				if not pedVehicle or GetPedInVehicleSeat(pedVehicle, -1) ~= ped then
					ESX.ShowNotification(_U("self_not_in_vehicle"))
					return
				end
				SetVehicleEngineHealth(pedVehicle, 1000)
				SetVehicleEngineOn(pedVehicle, true, true)
				SetVehicleFixed(pedVehicle)
				ESX.ShowNotification(_U("notif_repair_vehicle_success"))
			end
		end
	)
	RageUI.ButtonWithStyle(
		_U("main_vehicles_current_clean"),
		_U("main_vehicles_current_clean_desc"),
		{},
		Config.Groups[playerGroup].Access["submenu_vehicles_current_clean"],
		function(_h, _a, Selected)
			if Selected then
				if not pedVehicle or GetPedInVehicleSeat(pedVehicle, -1) ~= ped then
					ESX.ShowNotification(_U("self_not_in_vehicle"))
					return
				end
				SetVehicleDirtLevel(pedVehicle, 0)
				ESX.ShowNotification(_U("notif_clean_vehicle_success"))
			end
		end
	)
	RageUI.ButtonWithStyle(
		_U("main_vehicles_current_flip"),
		_U("main_vehicles_current_flip_desc"),
		{},
		Config.Groups[playerGroup].Access["submenu_vehicles_current_flip"],
		function(_h, _a, Selected)
			if Selected then
				if not pedVehicle or GetPedInVehicleSeat(pedVehicle, -1) ~= ped then
					ESX.ShowNotification(_U("self_not_in_vehicle"))
					return
				end
				SetVehicleOnGroundProperly(pedVehicle)
				ESX.ShowNotification(_U("notif_flip_vehicle_success"))
			end
		end
	)
	RageUI.ButtonWithStyle(
		_U("main_vehicles_current_fuel"),
		_U("main_vehicles_current_fuel_desc"),
		{},
		Config.Groups[playerGroup].Access["submenu_vehicles_current_fuel"],
		function(_h, _a, Selected)
			if Selected then
				if not pedVehicle or GetPedInVehicleSeat(pedVehicle, -1) ~= ped then
					ESX.ShowNotification(_U("self_not_in_vehicle"))
					return
				end
				SetVehicleFuelLevel(pedVehicle, 100.0)
				ESX.ShowNotification(_U("notif_fuel_vehicle_success"))
			end
		end
	)
	RageUI.Checkbox(
		_U("main_vehicles_current_engine"),
		_U("main_vehicles_current_engine_desc"),
		GetIsVehicleEngineRunning(pedVehicle),
		{ Enabled = Config.Groups[playerGroup].Access["submenu_vehicles_current_engine"] },
		function() end,
		function()
			if not pedVehicle or GetPedInVehicleSeat(pedVehicle, -1) ~= ped then
				ESX.ShowNotification(_U("self_not_in_vehicle"))
				return
			end
			SetVehicleEngineOn(pedVehicle, true, true, true)
			ESX.ShowNotification(_U("notif_engine_enabled"))
		end,
		function()
			if not pedVehicle or GetPedInVehicleSeat(pedVehicle, -1) ~= ped then
				ESX.ShowNotification(_U("self_not_in_vehicle"))
				return
			end
			SetVehicleEngineOn(pedVehicle, false, true, true)
			ESX.ShowNotification(_U("notif_engine_disabled"))
		end
	)
	RageUI.Checkbox(
		_U("main_vehicles_current_freeze"),
		_U("main_vehicles_current_freeze_desc"),
		IsEntityPositionFrozen(pedVehicle),
		{ Enabled = Config.Groups[playerGroup].Access["submenu_vehicles_current_freeze"] },
		function() end,
		function()
			if not pedVehicle or GetPedInVehicleSeat(pedVehicle, -1) ~= ped then
				ESX.ShowNotification(_U("self_not_in_vehicle"))
				return
			end
			FreezeEntityPosition(pedVehicle, true)
			ESX.ShowNotification(_U("notif_freeze_vehicle_enabled"))
		end,
		function()
			if not pedVehicle or GetPedInVehicleSeat(pedVehicle, -1) ~= ped then
				ESX.ShowNotification(_U("self_not_in_vehicle"))
				return
			end
			FreezeEntityPosition(pedVehicle, false)
			ESX.ShowNotification(_U("notif_freeze_vehicle_disabled"))
		end
	)
	RageUI.List(
		_U("main_vehicles_current_open_door"),
		_var.vehicle.doorArray,
		_var.vehicle.doorArrayIndex,
		_U("main_vehicles_current_open_door_desc"),
		{},
		Config.Groups[playerGroup].Access["submenu_vehicles_current_opendoor"],
		function(_h, _a, Selected, Index)
			_var.vehicle.doorArrayIndex = Index
			if Selected then
				if not pedVehicle or GetPedInVehicleSeat(pedVehicle, -1) ~= ped then
					ESX.ShowNotification(_U("self_not_in_vehicle"))
					return
				end
				if _var.vehicle.doorArray[_var.vehicle.doorArrayIndex] == _("door_frontleft") then
					local doorState = GetVehicleDoorAngleRatio(pedVehicle, 0) < 0.1
					if not doorState then
						SetVehicleDoorShut(pedVehicle, 0, false, false)
						return
					end
					SetVehicleDoorOpen(pedVehicle, 0, false, false)
				elseif _var.vehicle.doorArray[_var.vehicle.doorArrayIndex] == _("door_frontright") then
					local doorState = GetVehicleDoorAngleRatio(pedVehicle, 1) < 0.1
					if not doorState then
						SetVehicleDoorShut(pedVehicle, 1, false, false)
						return
					end
					SetVehicleDoorOpen(pedVehicle, 1, false, false)
				elseif _var.vehicle.doorArray[_var.vehicle.doorArrayIndex] == _("door_backleft") then
					local doorState = GetVehicleDoorAngleRatio(pedVehicle, 2) < 0.1
					if not doorState then
						SetVehicleDoorShut(pedVehicle, 2, false, false)
						return
					end
					SetVehicleDoorOpen(pedVehicle, 2, false, false)
				elseif _var.vehicle.doorArray[_var.vehicle.doorArrayIndex] == _("door_backright") then
					local doorState = GetVehicleDoorAngleRatio(pedVehicle, 3) < 0.1
					if not doorState then
						SetVehicleDoorShut(pedVehicle, 3, false, false)
						return
					end
					SetVehicleDoorOpen(pedVehicle, 3, false, false)
				elseif _var.vehicle.doorArray[_var.vehicle.doorArrayIndex] == _("door_hood") then
					local doorState = GetVehicleDoorAngleRatio(pedVehicle, 4) < 0.1
					if not doorState then
						SetVehicleDoorShut(pedVehicle, 4, false, false)
						return
					end
					SetVehicleDoorOpen(pedVehicle, 4, false, false)
				elseif _var.vehicle.doorArray[_var.vehicle.doorArrayIndex] == _("door_trunk") then
					local doorState = GetVehicleDoorAngleRatio(pedVehicle, 5) < 0.1
					if not doorState then
						SetVehicleDoorShut(pedVehicle, 5, false, false)
						return
					end
					SetVehicleDoorOpen(pedVehicle, 5, false, false)
				elseif _var.vehicle.doorArray[_var.vehicle.doorArrayIndex] == _("door_all") then
					local doorState = GetVehicleDoorAngleRatio(pedVehicle, 0) < 0.1
						and GetVehicleDoorAngleRatio(pedVehicle, 1) < 0.1
						and GetVehicleDoorAngleRatio(pedVehicle, 2) < 0.1
						and GetVehicleDoorAngleRatio(pedVehicle, 3) < 0.1
						and GetVehicleDoorAngleRatio(pedVehicle, 4) < 0.1
						and GetVehicleDoorAngleRatio(pedVehicle, 5) < 0.1
					for i = 0, 5 do
						if not doorState then
							SetVehicleDoorShut(pedVehicle, i, false, false)
						else
							SetVehicleDoorOpen(pedVehicle, i, false, false)
						end
					end
				end
			end
		end
	)
	RageUI.List(
		_U("main_vehicles_current_boost"),
		_var.vehicle.boostArray,
		_var.vehicle.boostArrayIndex,
		_U("main_vehicles_current_boost_desc"),
		{},
		Config.Groups[playerGroup].Access["submenu_vehicles_current_boost"],
		function(_h, _a, Selected, Index)
			_var.vehicle.boostArrayIndex = Index
			if Selected then
				if not pedVehicle or GetPedInVehicleSeat(pedVehicle, -1) ~= ped then
					ESX.ShowNotification(_U("self_not_in_vehicle"))
					return
				end
				_threads.vehicleboost.enable(pedVehicle, _var.vehicle.boostArrayIndex)
				ESX.ShowNotification(
					_U("notif_vehicleboost_success", _var.vehicle.boostArray[_var.vehicle.boostArrayIndex])
				)
			end
		end
	)
	RageUI.ButtonWithStyle(
		_U("main_vehicles_current_custom"),
		_U("main_vehicles_current_custom_desc"),
		{ RightLabel = "→" },
		Config.Groups[playerGroup].Access["submenu_vehicles_current_custom_color_main"]
			or Config.Groups[playerGroup].Access["submenu_vehicles_current_custom_color_secondary"]
			or Config.Groups[playerGroup].Access["submenu_vehicles_current_custom_fullperf"]
			or Config.Groups[playerGroup].Access["submenu_vehicles_current_custom_livery"]
			or Config.Groups[playerGroup].Access["submenu_vehicles_current_custom_plate"]
			or Config.Groups[playerGroup].Access["submenu_vehicles_current_custom_mods"],
		function(_h, _a, _s) end,
		_var.menus.admin.objects.mainVehiclesCurrentCustom
	)
end
