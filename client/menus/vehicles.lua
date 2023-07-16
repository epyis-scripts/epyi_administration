---main_personnal_showContentThisFrame → Function to show the main/personnal menu content
---@param playerGroup string
---@return void
function main_vehicles_showContentThisFrame(playerGroup)
	RageUI.ButtonWithStyle(
		TranslateCap("main_vehicles_current"),
		TranslateCap("main_vehicles_current_desc"),
		{ RightLabel = "→" },
		Config.Groups[playerGroup].Access["submenu_vehicles_current_access"],
		function(_, _, _) end,
		RMenu:Get("epyi_administration", "main_vehicles_current")
	)
	RageUI.ButtonWithStyle(
		TranslateCap("main_vehicles_favorites"),
		TranslateCap("main_vehicles_favorites_desc"),
		{ RightLabel = "→" },
		Config.Groups[playerGroup].Access["submenu_vehicles_favorites_access"],
		function(_, _, _) end
	)
	RageUI.ButtonWithStyle(
		TranslateCap("main_vehicles_spawn"),
		TranslateCap("main_vehicles_spawn_desc"),
		{ RightLabel = "→" },
		Config.Groups[playerGroup].Access["submenu_vehicles_spawn_access"],
		function(_, _, _) end
	)
end
