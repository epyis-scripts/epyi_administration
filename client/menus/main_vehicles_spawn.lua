---main_vehicles_spawn_showContentThisFrame → Function to show the main/personnal menu content
---@param playerGroup string
---@return void
function main_vehicles_spawn_showContentThisFrame(playerGroup)
	RageUI.ButtonWithStyle(
		_U("main_vehicles_spawn_search"),
		_U("main_vehicles_spawn_search_desc"),
		{ RightLabel = (_var.menu.searchVehicle ~= nil and _var.menu.searchVehicle or "→") },
		true,
		function(_h, _a, Selected)
			if Selected then
				local search = textEntry(_U("textentry_search_vehicle_model"), _var.menu.searchVehicle, 30)
				if search == nil or search == "" then
					_var.menu.searchVehicle = nil
					return
				end
				_var.menu.searchVehicle = search
			end
		end
	)
end
