---main_personnal_showContentThisFrame → Function to show the main/personnal menu content
---@param playerGroup string
---@return void
function main_vehicles_current_showContentThisFrame(playerGroup)
	RageUI.ButtonWithStyle(
		_U("main_vehicles_current_repair"),
		_U("main_vehicles_current_repair_desc"),
		{ RightLabel = "→" },
		Config.Groups[playerGroup].Access["submenu_vehicles_repair"],
		function(_, _, Selected)
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
				SetVehicleDirtLevel(pedVehicle, 0)
				ESX.ShowNotification(_U("notif_repair_vehicle_success"))
			end
		end
	)
end
