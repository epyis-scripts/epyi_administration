---main_server_showContentThisFrame → Function to show the main/personnal menu content
---@param playerGroup string
---@return void
function main_server_showContentThisFrame(playerGroup)
	RageUI.ButtonWithStyle(
		_U("main_server_clearall"),
		_U("main_server_clearall_desc"),
		{ RightLabel = "→" },
		Config.Groups[playerGroup].Access["submenu_server_clearall"] and not _var.menu.cooldownStatus,
		function(_h, _a, Selected)
			if Selected then
				Citizen.CreateThread(function()
					_var.menu.cooldownStatus = true
					local ped = PlayerPedId()
					local pedCoords = GetEntityCoords(ped)
					local radius = textEntry(_U("textentry_radius"), "", 5)
					if radius == nil or radius == "" then
						ESX.ShowNotification(_U("textentry_number_invalid"))
						_var.menu.cooldownStatus = false
						return
					end
					if string.find(radius, "[%c%p%s%z%a]") then
						ESX.ShowNotification(_U("textentry_number_invalid"))
						_var.menu.cooldownStatus = false
						return
					end
					radius = tonumber(radius .. ".0")
					if type(radius) ~= "number" then
						ESX.ShowNotification(_U("textentry_number_invalid"))
						_var.menu.cooldownStatus = false
						return
					end
					local vehicles = ESX.Game.GetVehiclesInArea(pedCoords, radius)
					for _k, vehicle in pairs(vehicles) do
						ESX.Game.DeleteVehicle(vehicle)
					end
					ClearAreaOfPeds(pedCoords.x, pedCoords.y, pedCoords.z, radius, 1)
					ESX.ShowNotification(_U("notif_area_clearall_success"))
					_var.menu.cooldownStatus = false
				end)
			end
		end
	)
	RageUI.ButtonWithStyle(
		_U("main_server_clearvehicle"),
		_U("main_server_clearvehicle_desc"),
		{ RightLabel = "→" },
		Config.Groups[playerGroup].Access["submenu_server_clearvehicles"] and not _var.menu.cooldownStatus,
		function(_h, _a, Selected)
			if Selected then
				Citizen.CreateThread(function()
					_var.menu.cooldownStatus = true
					local ped = PlayerPedId()
					local pedCoords = GetEntityCoords(ped)
					local radius = textEntry(_U("textentry_radius"), "", 5)
					if radius == nil or radius == "" then
						ESX.ShowNotification(_U("textentry_number_invalid"))
						_var.menu.cooldownStatus = false
						return
					end
					if string.find(radius, "[%c%p%s%z%a]") then
						ESX.ShowNotification(_U("textentry_number_invalid"))
						_var.menu.cooldownStatus = false
						return
					end
					radius = tonumber(radius .. ".0")
					if type(radius) ~= "number" then
						ESX.ShowNotification(_U("textentry_number_invalid"))
						_var.menu.cooldownStatus = false
						return
					end
					local vehicles = ESX.Game.GetVehiclesInArea(pedCoords, radius)
					for _k, vehicle in pairs(vehicles) do
						ESX.Game.DeleteVehicle(vehicle)
					end
					ESX.ShowNotification(_U("notif_area_clearvehicles_success"))
					_var.menu.cooldownStatus = false
				end)
			end
		end
	)
	RageUI.ButtonWithStyle(
		_U("main_server_clearpeds"),
		_U("main_server_clearpeds_desc"),
		{ RightLabel = "→" },
		Config.Groups[playerGroup].Access["submenu_server_clearpeds"] and not _var.menu.cooldownStatus,
		function(_h, _a, Selected)
			if Selected then
				Citizen.CreateThread(function()
					_var.menu.cooldownStatus = true
					local ped = PlayerPedId()
					local pedCoords = GetEntityCoords(ped)
					local radius = textEntry(_U("textentry_radius"), "", 5)
					if radius == nil or radius == "" then
						ESX.ShowNotification(_U("textentry_number_invalid"))
						_var.menu.cooldownStatus = false
						return
					end
					if string.find(radius, "[%c%p%s%z%a]") then
						ESX.ShowNotification(_U("textentry_number_invalid"))
						_var.menu.cooldownStatus = false
						return
					end
					radius = tonumber(radius .. ".0")
					if type(radius) ~= "number" then
						ESX.ShowNotification(_U("textentry_number_invalid"))
						_var.menu.cooldownStatus = false
						return
					end
					ClearAreaOfPeds(pedCoords.x, pedCoords.y, pedCoords.z, radius, 1)
					ESX.ShowNotification(_U("notif_area_clearpeds_success"))
					_var.menu.cooldownStatus = false
				end)
			end
		end
	)
end
