---main_players_showContentThisFrame → Function to show the main/players menu content
---@param playerGroup string
---@return void
function main_players_showContentThisFrame(playerGroup)
	Citizen.CreateThread(function()
		if _var.activeThreads.getPlayers then
			return
		end
		_var.activeThreads.getPlayers = true
		_var.client.playerData = ESX.GetPlayerData()
		ESX.TriggerServerCallback("epyi_administration:getPlayers", function(players)
			_var.players.list = players
		end, _var.client.playerData.identifier)
		Citizen.Wait(500)
		_var.activeThreads.getPlayers = false
	end)
	for _k, player in pairs(_var.players.list) do
		local targetisLower = true
		if
			Config.Groups[playerGroup] ~= nil
			and Config.Groups[player.group] ~= nil
			and Config.Groups[player.group].Priority > Config.Groups[playerGroup].Priority
		then
			targetisLower = false
		end
		local group = _U("invalid")
		if Config.Groups[player.group] ~= nil then
			group = Config.Groups[player.group].Color .. Config.Groups[player.group].Label
		end
		RageUI.ButtonWithStyle(
			player.name .. " - " .. player.ooc_name .. " ~s~[" .. group .. "~s~]",
			_U("main_players_desc", player.ooc_name .. " ~s~[" .. group .. "~s~]"),
			{ RightLabel = "→" },
			Config.Groups[playerGroup].Access["submenu_players_interact"]
				and (
					Config.Groups[playerGroup].Access["submenu_players_interact_highergroup"] and true or targetisLower
				),
			function(_h, _a, Selected)
				if Selected then
					_var.players.selected = player
				end
			end,
			_var.menus.admin.objects.mainPlayersInteract
		)
	end
end
