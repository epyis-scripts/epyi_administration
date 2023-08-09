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
	local mods = {}
	local modsList = {
		[1] = { label = "spoiler", modType = 0 },
		[2] = { label = "front_bumper", modType = 1 },
		[3] = { label = "rear_bumper", modType = 2 },
		[4] = { label = "side_skirt", modType = 3 },
		[5] = { label = "exhaust", modType = 4 },
		[6] = { label = "frame", modType = 5 },
		[7] = { label = "grille", modType = 6 },
		[8] = { label = "hood", modType = 7 },
		[9] = { label = "fender", modType = 8 },
		[10] = { label = "right_fender", modType = 9 },
		[11] = { label = "roof", modType = 10 },
		[12] = { label = "engine", modType = 11 },
		[13] = { label = "brakes", modType = 12 },
		[14] = { label = "transmission", modType = 13 },
		[15] = { label = "horns", modType = 14 },
		[16] = { label = "suspension", modType = 15 },
		[17] = { label = "armor", modType = 16 },
		[18] = { label = "turbo", modType = 18 },
		[19] = { label = "xenon", modType = 22 },
		[20] = { label = "front_wheels", modType = 23 },
		[21] = { label = "back_wheels", modType = 24 },
		[22] = { label = "plate_holders", modType = 25 },
		[23] = { label = "trim_design", modType = 27 },
		[24] = { label = "ornaments", modType = 28 },
		[25] = { label = "dial_design", modType = 30 },
		[26] = { label = "steering_wheel", modType = 33 },
		[27] = { label = "shift_lever", modType = 34 },
		[28] = { label = "plaques", modType = 35 },
		[29] = { label = "hydraulics", modType = 38 },
		[30] = { label = "boost", modType = 40 },
		[31] = { label = "window_tint", modType = 55 },
		[32] = { label = "plate", modType = 53 },
	}
	for key, mod in pairs(modsList) do
		mods[key] = {
			count = GetNumVehicleMods(pedVehicle, mod.modType),
			list = {},
		}
		for i = 0, mods[key].count do
			mods[key].list[i] = "Variant #" .. i
		end
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
	RageUI.List(
		_U("main_vehicles_current_modtype"),
		_var.vehicle.mods,
		_var.menu.modArrayIndex,
		_U("main_vehicles_current_modtype_desc"),
		{},
		Config.Groups[playerGroup].Access["submenu_vehicles_current_custom_mods"],
		function(_h, Active, _s, Index)
			_var.menu.modArrayIndex = Index
			if Active then
				if not pedVehicle or GetPedInVehicleSeat(pedVehicle, -1) ~= ped then
					return
				end
				SetVehicleModKit(pedVehicle, 0)
				SetVehicleMod(pedVehicle, modsList[_var.menu.modArrayIndex].modType, _var.menu.modVariantArrayIndex)
			end
		end
	)
	if mods[_var.menu.modArrayIndex].list[1] == nil then
		return
	end
	RageUI.List(
		_U("main_vehicles_current_modvariant"),
		mods[_var.menu.modArrayIndex].list,
		_var.menu.modVariantArrayIndex,
		_U("main_vehicles_current_modvariant_desc"),
		{},
		Config.Groups[playerGroup].Access["submenu_vehicles_current_custom_mods"],
		function(_h, Active, _s, Index)
			_var.menu.modVariantArrayIndex = Index
			if Active then
				if not pedVehicle or GetPedInVehicleSeat(pedVehicle, -1) ~= ped then
					return
				end
				SetVehicleModKit(pedVehicle, 0)
				SetVehicleMod(pedVehicle, modsList[_var.menu.modArrayIndex].modType, _var.menu.modVariantArrayIndex)
			end
			if not Active then
				if not pedVehicle or GetPedInVehicleSeat(pedVehicle, -1) ~= ped then
					return
				end
				if mods[_var.menu.modArrayIndex].list[_var.menu.modVariantArrayIndex] == nil then
					_var.menu.modVariantArrayIndex = 1
				end
			end
		end
	)
end
