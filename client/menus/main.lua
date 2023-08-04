---main_showContentThisFrame → Function to show the main menu content
---@param playerGroup string
---@return void
function main_showContentThisFrame(playerGroup)
	RageUI.Checkbox(
		_U("main_menu_staffmode"),
		_U("main_menu_staffmode_desc"),
		_var.client.isStaffModeActivated,
		{},
		function() end,
		function()
			_var.client.isStaffModeActivated = true
		end,
		function()
			_var.client.isStaffModeActivated = false
			stopAllThreads()
			leaveAllReports()
		end
	)
	if not _var.client.isStaffModeActivated then
		return
	end
	RageUI.Separator("")
	RageUI.ButtonWithStyle(
		_U("main_menu_access_personnal"),
		_U("main_menu_access_personnal_desc"),
		{ RightLabel = "→" },
		Config.Groups[playerGroup].Access["submenu_personnal_access"],
		function(_h, _a, _s) end,
		_var.menus.admin.objects.mainPersonnal
	)
	RageUI.ButtonWithStyle(
		_U("main_menu_access_players"),
		_U("main_menu_access_players_desc"),
		{ RightLabel = "→" },
		Config.Groups[playerGroup].Access["submenu_players_access"],
		function(_h, _a, _s) end,
		_var.menus.admin.objects.mainPlayers
	)
	RageUI.ButtonWithStyle(
		_U("main_menu_access_vehicles"),
		_U("main_menu_access_vehicles_desc"),
		{ RightLabel = "→" },
		Config.Groups[playerGroup].Access["submenu_vehicles_access"],
		function(_h, _a, _s) end,
		_var.menus.admin.objects.mainVehicles
	)
	RageUI.ButtonWithStyle(
		_U("main_menu_access_reports"),
		_U("main_menu_access_reports_desc"),
		{ RightLabel = "→" },
		Config.Groups[playerGroup].Access["submenu_reports_access"],
		function(_h, _a, _s) end,
		_var.menus.admin.objects.mainReports
	)
	RageUI.ButtonWithStyle(
		_U("main_menu_access_server"),
		_U("main_menu_access_server_desc"),
		{ RightLabel = "→" },
		Config.Groups[playerGroup].Access["submenu_server_access"],
		function(_h, _a, _s) end,
		_var.menus.admin.objects.mainServer
	)
end
