---main_personnal_showContentThisFrame → Function to show the main/personnal menu content
---@param playerGroup string
---@return void
function main_vehicles_current_showContentThisFrame(playerGroup)
	RageUI.ButtonWithStyle(
		_U("main_vehicles_current_repair"),
		_U("main_vehicles_current_repair_desc"),
		{ RightLabel = "→" },
		Config.Groups[playerGroup].Access["submenu_vehicles_repair"],
		function(_h, _a, Selected)
			if Selected then
				local ped = PlayerPedId()
				local pedVehicle = GetVehiclePedIsIn(ped, false)
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
		{ RightLabel = "→" },
		Config.Groups[playerGroup].Access["submenu_vehicles_clean"],
		function(_h, _a, Selected)
			if Selected then
				local ped = PlayerPedId()
				local pedVehicle = GetVehiclePedIsIn(ped, false)
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
		_U("main_vehicles_current_plate"),
		_U("main_vehicles_current_plate_desc"),
		{ RightLabel = "→" },
		Config.Groups[playerGroup].Access["submenu_vehicles_plate"],
		function(_h, _a, Selected)
			if Selected then
				local ped = PlayerPedId()
				local pedVehicle = GetVehiclePedIsIn(ped, false)
				if not pedVehicle or GetPedInVehicleSeat(pedVehicle, -1) ~= ped then
					ESX.ShowNotification(_U("self_not_in_vehicle"))
					return
				end
				local plate = textEntry(_U("textentry_change_vehicle_plate"), "", 8)
				if plate == nil or plate == "" then
					ESX.ShowNotification(_U("textentry_string_invalid"))
					return
				end
				SetVehicleNumberPlateText(pedVehicle, plate)
				ESX.ShowNotification(_U("notif_plate_changed_success", plate))
			end
		end
	)
	RageUI.List(
		_U("main_vehicles_current_open_door"),
		doorArray,
		doorArrayIndex,
		_U("main_vehicles_current_open_door_desc"),
		{},
		Config.Groups[playerGroup].Access["submenu_vehicles_opendoor"],
		function(_h, _a, Selected, Index)
			doorArrayIndex = Index
			if Selected then
				local ped = PlayerPedId()
				local pedVehicle = GetVehiclePedIsIn(ped, false)
				if not pedVehicle or GetPedInVehicleSeat(pedVehicle, -1) ~= ped then
					ESX.ShowNotification(_U("self_not_in_vehicle"))
					return
				end
				if doorArray[doorArrayIndex] == _("door_frontleft") then
					SetVehicleDoorOpen(pedVehicle, 0, false, false)
				elseif doorArray[doorArrayIndex] == _("door_frontright") then
					SetVehicleDoorOpen(pedVehicle, 1, false, false)
				elseif doorArray[doorArrayIndex] == _("door_backleft") then
					SetVehicleDoorOpen(pedVehicle, 2, false, false)
				elseif doorArray[doorArrayIndex] == _("door_backright") then
					SetVehicleDoorOpen(pedVehicle, 3, false, false)
				elseif doorArray[doorArrayIndex] == _("door_hood") then
					SetVehicleDoorOpen(pedVehicle, 4, false, false)
				elseif doorArray[doorArrayIndex] == _("door_trunk") then
					SetVehicleDoorOpen(pedVehicle, 5, false, false)
				elseif doorArray[doorArrayIndex] == _("door_all") then
					for i = 0, 5 do
						SetVehicleDoorOpen(pedVehicle, i, false, false)
					end
				end
			end
		end
	)
	RageUI.List(
		_U("main_vehicles_current_close_door"),
		doorArray,
		doorArrayIndex,
		_U("main_vehicles_current_close_door_desc"),
		{},
		Config.Groups[playerGroup].Access["submenu_vehicles_closedoor"],
		function(_h, _a, Selected, Index)
			doorArrayIndex = Index
			if Selected then
				local ped = PlayerPedId()
				local pedVehicle = GetVehiclePedIsIn(ped, false)
				if not pedVehicle or GetPedInVehicleSeat(pedVehicle, -1) ~= ped then
					ESX.ShowNotification(_U("self_not_in_vehicle"))
					return
				end
				if doorArray[doorArrayIndex] == _("door_frontleft") then
					SetVehicleDoorShut(pedVehicle, 0, false, false)
				elseif doorArray[doorArrayIndex] == _("door_frontright") then
					SetVehicleDoorShut(pedVehicle, 1, false, false)
				elseif doorArray[doorArrayIndex] == _("door_backleft") then
					SetVehicleDoorShut(pedVehicle, 2, false, false)
				elseif doorArray[doorArrayIndex] == _("door_backright") then
					SetVehicleDoorShut(pedVehicle, 3, false, false)
				elseif doorArray[doorArrayIndex] == _("door_hood") then
					SetVehicleDoorShut(pedVehicle, 4, false, false)
				elseif doorArray[doorArrayIndex] == _("door_trunk") then
					SetVehicleDoorShut(pedVehicle, 5, false, false)
				elseif doorArray[doorArrayIndex] == _("door_all") then
					for i = 0, 5 do
						SetVehicleDoorShut(pedVehicle, i, false, false)
					end
				end
			end
		end
	)
end
