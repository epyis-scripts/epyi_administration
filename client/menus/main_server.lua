---main_server_showContentThisFrame → Function to show the main/server menu content
---@param playerGroup string
---@return void
function main_server_showContentThisFrame(playerGroup)
	RageUI.List(
		_U("main_server_weather"),
		_var.menu.weatherArray,
		_var.menu.weatherArrayIndex,
		_U("main_server_weather_desc"),
		{},
		Config.Groups[playerGroup].Access["submenu_server_weather"] and not _var.menus.admin.cooldowns.items,
		function(_h, _a, Selected, Index)
			_var.menu.weatherArrayIndex = Index
			if Selected then
				TriggerServerEvent(
					"epyi_administration:changeWeatherOrBlackout",
					_var.menu.weatherArray[_var.menu.weatherArrayIndex],
					_var.menu.blackoutCheckbox,
					_var.menu.timeArray[_var.menu.timeArrayIndex]
				)
			end
		end
	)
	RageUI.List(
		_U("main_server_time"),
		_var.menu.timeArray,
		_var.menu.timeArrayIndex,
		_U("main_server_time_desc"),
		{},
		Config.Groups[playerGroup].Access["submenu_server_time"] and not _var.menus.admin.cooldowns.items,
		function(_h, _a, Selected, Index)
			_var.menu.timeArrayIndex = Index
			if Selected then
				TriggerServerEvent(
					"epyi_administration:changeWeatherOrBlackout",
					_var.menu.weatherArray[_var.menu.weatherArrayIndex],
					_var.menu.blackoutCheckbox,
					_var.menu.timeArray[_var.menu.timeArrayIndex]
				)
			end
		end
	)
	RageUI.Checkbox(
		_U("main_server_blackout"),
		_U("main_server_blackout_desc"),
		_var.menu.blackoutCheckbox,
		{ Enabled = Config.Groups[playerGroup].Access["submenu_server_blackout"] },
		function() end,
		function()
			if not Config.Groups[playerGroup].Access["submenu_server_blackout"] then
				return
			end
			_var.menu.blackoutCheckbox = true
			TriggerServerEvent(
				"epyi_administration:changeWeatherOrBlackout",
				_var.menu.weatherArray[_var.menu.weatherArrayIndex],
				_var.menu.blackoutCheckbox,
				_var.menu.timeArray[_var.menu.timeArrayIndex]
			)
		end,
		function()
			if not Config.Groups[playerGroup].Access["submenu_server_blackout"] then
				return
			end
			_var.menu.blackoutCheckbox = false
			TriggerServerEvent(
				"epyi_administration:changeWeatherOrBlackout",
				_var.menu.weatherArray[_var.menu.weatherArrayIndex],
				_var.menu.blackoutCheckbox,
				_var.menu.timeArray[_var.menu.timeArrayIndex]
			)
		end
	)
	RageUI.ButtonWithStyle(
		_U("main_server_clearall"),
		_U("main_server_clearall_desc"),
		{ RightLabel = "→" },
		Config.Groups[playerGroup].Access["submenu_server_clearall"] and not _var.menus.admin.cooldowns.items,
		function(_h, _a, Selected)
			if Selected then
				Citizen.CreateThread(function()
					_var.menus.admin.cooldowns.items = true
					local ped = PlayerPedId()
					local pedCoords = GetEntityCoords(ped)
					local radius = textEntry(_U("textentry_radius"), "", 5)
					if radius == nil or radius == "" then
						ESX.ShowNotification(_U("textentry_number_invalid"))
						_var.menus.admin.cooldowns.items = false
						return
					end
					if string.find(radius, "[%c%p%s%z%a]") then
						ESX.ShowNotification(_U("textentry_number_invalid"))
						_var.menus.admin.cooldowns.items = false
						return
					end
					radius = tonumber(radius .. ".0")
					if type(radius) ~= "number" then
						ESX.ShowNotification(_U("textentry_number_invalid"))
						_var.menus.admin.cooldowns.items = false
						return
					end
					local vehicles = ESX.Game.GetVehiclesInArea(pedCoords, radius)
					for _k, vehicle in pairs(vehicles) do
						ESX.Game.DeleteVehicle(vehicle)
					end
					ClearAreaOfPeds(pedCoords.x, pedCoords.y, pedCoords.z, radius, 1)
					ESX.ShowNotification(_U("notif_area_clearall_success"))
					_var.menus.admin.cooldowns.items = false
				end)
			end
		end
	)
	RageUI.ButtonWithStyle(
		_U("main_server_clearvehicle"),
		_U("main_server_clearvehicle_desc"),
		{ RightLabel = "→" },
		Config.Groups[playerGroup].Access["submenu_server_clearvehicles"] and not _var.menus.admin.cooldowns.items,
		function(_h, _a, Selected)
			if Selected then
				Citizen.CreateThread(function()
					_var.menus.admin.cooldowns.items = true
					local ped = PlayerPedId()
					local pedCoords = GetEntityCoords(ped)
					local radius = textEntry(_U("textentry_radius"), "", 5)
					if radius == nil or radius == "" then
						ESX.ShowNotification(_U("textentry_number_invalid"))
						_var.menus.admin.cooldowns.items = false
						return
					end
					if string.find(radius, "[%c%p%s%z%a]") then
						ESX.ShowNotification(_U("textentry_number_invalid"))
						_var.menus.admin.cooldowns.items = false
						return
					end
					radius = tonumber(radius .. ".0")
					if type(radius) ~= "number" then
						ESX.ShowNotification(_U("textentry_number_invalid"))
						_var.menus.admin.cooldowns.items = false
						return
					end
					local vehicles = ESX.Game.GetVehiclesInArea(pedCoords, radius)
					for _k, vehicle in pairs(vehicles) do
						ESX.Game.DeleteVehicle(vehicle)
					end
					ESX.ShowNotification(_U("notif_area_clearvehicles_success"))
					_var.menus.admin.cooldowns.items = false
				end)
			end
		end
	)
	RageUI.ButtonWithStyle(
		_U("main_server_clearpeds"),
		_U("main_server_clearpeds_desc"),
		{ RightLabel = "→" },
		Config.Groups[playerGroup].Access["submenu_server_clearpeds"] and not _var.menus.admin.cooldowns.items,
		function(_h, _a, Selected)
			if Selected then
				Citizen.CreateThread(function()
					_var.menus.admin.cooldowns.items = true
					local ped = PlayerPedId()
					local pedCoords = GetEntityCoords(ped)
					local radius = textEntry(_U("textentry_radius"), "", 5)
					if radius == nil or radius == "" then
						ESX.ShowNotification(_U("textentry_number_invalid"))
						_var.menus.admin.cooldowns.items = false
						return
					end
					if string.find(radius, "[%c%p%s%z%a]") then
						ESX.ShowNotification(_U("textentry_number_invalid"))
						_var.menus.admin.cooldowns.items = false
						return
					end
					radius = tonumber(radius .. ".0")
					if type(radius) ~= "number" then
						ESX.ShowNotification(_U("textentry_number_invalid"))
						_var.menus.admin.cooldowns.items = false
						return
					end
					ClearAreaOfPeds(pedCoords.x, pedCoords.y, pedCoords.z, radius, 1)
					ESX.ShowNotification(_U("notif_area_clearpeds_success"))
					_var.menus.admin.cooldowns.items = false
				end)
			end
		end
	)
end
