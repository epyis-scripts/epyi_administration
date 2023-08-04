---main_vehicles_showContentThisFrame → Function to show the main/vehicles menu content
---@param _var.client.staffGroup string
---@return void
function main_vehicles_showContentThisFrame(playerGroup)
	RageUI.ButtonWithStyle(
		_U("main_vehicles_current"),
		_U("main_vehicles_current_desc"),
		{ RightLabel = "→" },
		Config.Groups[playerGroup].Access["submenu_vehicles_current_access"],
		function(_h, _a, _s) end,
		_var.menus.admin.objects.mainVehiclesCurrent
	)
	RageUI.ButtonWithStyle(
		_U("main_vehicles_favorites"),
		_U("main_vehicles_favorites_desc"),
		{ RightLabel = "→" },
		Config.Groups[playerGroup].Access["submenu_vehicles_favorites_access"],
		function(_h, _a, _s) end,
		_var.menus.admin.objects.mainVehiclesFavorites
	)
	RageUI.ButtonWithStyle(
		_U("main_vehicles_spawn"),
		_U("main_vehicles_spawn_desc"),
		{ RightLabel = "→" },
		Config.Groups[playerGroup].Access["submenu_vehicles_spawn_access"],
		function(_h, _a, _s) end,
		_var.menus.admin.objects.mainVehiclesSpawn
	)
end
