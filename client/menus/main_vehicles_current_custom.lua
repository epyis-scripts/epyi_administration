---main_vehicles_current_custom_showContentThisFrame → Function to show the main/vehicles/current/custom menu content
---@param playerGroup string
---@return void
function main_vehicles_current_custom_showContentThisFrame(playerGroup)
    local ped = PlayerPedId()
	local pedVehicle = GetVehiclePedIsIn(ped, false)
	local liveryCount = GetVehicleLiveryCount(pedVehicle)
	local liveryList = {}
	for i = 0, liveryCount do
		local livery = GetLiveryName(pedVehicle, i)
		livery = GetLabelText(livery) ~= "NULL" and GetLabelText(livery) or "Livery #" .. i
		table.insert(liveryList, livery)
	end
	if liveryList[_var.menu.liveryArrayIndex] == nil then
		_var.menu.liveryArrayIndex = 1
	end

    RageUI.ButtonWithStyle(
		_U("main_vehicles_current_fullperf"),
		_U("main_vehicles_current_fullperf_desc"),
		{},
		Config.Groups[playerGroup].Access["submenu_vehicles_current_custom_fullperf"],
		function(_h, _a, Selected)
			if Selected then
				if not pedVehicle or GetPedInVehicleSeat(pedVehicle, -1) ~= ped then
					ESX.ShowNotification(_U("self_not_in_vehicle"))
					return
				end
				ESX.Game.SetVehicleProperties(pedVehicle, Config.others.fullPerfProperties)
				ESX.ShowNotification(_U("notif_fullperf_vehicle_success"))
			end
		end
	)
	RageUI.ButtonWithStyle(
		_U("main_vehicles_current_plate"),
		_U("main_vehicles_current_plate_desc"),
		{ RightLabel = "→" },
		Config.Groups[playerGroup].Access["submenu_vehicles_current_custom_plate"],
		function(_h, _a, Selected)
			if Selected then
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
		_U("main_vehicles_current_color_main"),
		_var.vehicle.paintColorsArray,
		_var.vehicle.paintColorsArrayIndexMain,
		_U("main_vehicles_current_color_main_desc"),
		{},
		Config.Groups[playerGroup].Access["submenu_vehicles_current_custom_color_main"],
		function(_h, Active, _s, Index)
			_var.vehicle.paintColorsArrayIndexMain = Index
			if Active then
				if not pedVehicle or GetPedInVehicleSeat(pedVehicle, -1) ~= ped then
					return
				end
				local _, colorSecondary = GetVehicleColours(pedVehicle)
				SetVehicleColours(
					pedVehicle,
					_var.vehicle.paintColors[_var.vehicle.paintColorsArrayIndexMain][2],
					colorSecondary
				)
			end
			if not Active then
				if not pedVehicle or GetPedInVehicleSeat(pedVehicle, -1) ~= ped then
					return
				end
				local colorPrimary, _ = GetVehicleColours(pedVehicle)
				for key, color in pairs(_var.vehicle.paintColors) do
					if color[2] == colorPrimary then
						_var.vehicle.paintColorsArrayIndexMain = key
					end
				end
			end
		end
	)
	RageUI.List(
		_U("main_vehicles_current_color_secondary"),
		_var.vehicle.paintColorsArray,
		_var.vehicle.paintColorsArrayIndexSecondary,
		_U("main_vehicles_current_color_secondary_desc"),
		{},
		Config.Groups[playerGroup].Access["submenu_vehicles_current_custom_color_secondary"],
		function(_h, Active, _s, Index)
			_var.vehicle.paintColorsArrayIndexSecondary = Index
			if Active then
				if not pedVehicle or GetPedInVehicleSeat(pedVehicle, -1) ~= ped then
					return
				end
				local colorPrimary, _ = GetVehicleColours(pedVehicle)
				SetVehicleColours(
					pedVehicle,
					colorPrimary,
					_var.vehicle.paintColors[_var.vehicle.paintColorsArrayIndexSecondary][2]
				)
			end
			if not Active then
				if not pedVehicle or GetPedInVehicleSeat(pedVehicle, -1) ~= ped then
					return
				end
				local _, colorSecondary = GetVehicleColours(pedVehicle)
				for key, color in pairs(_var.vehicle.paintColors) do
					if color[2] == colorSecondary then
						_var.vehicle.paintColorsArrayIndexSecondary = key
					end
				end
			end
		end
	)
	if liveryCount > 0 then
		RageUI.List(
			_U("main_vehicles_current_livery"),
			liveryList,
			_var.menu.liveryArrayIndex,
			_U("main_vehicles_current_livery_desc"),
			{},
			Config.Groups[playerGroup].Access["submenu_vehicles_current_custom_livery"],
			function(_h, _a, Selected, Index)
				_var.menu.liveryArrayIndex = Index
				if Selected then
					if not pedVehicle or GetPedInVehicleSeat(pedVehicle, -1) ~= ped then
						ESX.ShowNotification(_U("self_not_in_vehicle"))
						return
					end
					SetVehicleLivery(pedVehicle, _var.menu.liveryArrayIndex)
					ESX.ShowNotification(_U("notif_livery_success", liveryList[_var.menu.liveryArrayIndex]))
				end
			end
		)
	end
end