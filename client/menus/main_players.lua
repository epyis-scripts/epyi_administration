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
		local group = _U("invalid")
		if Config.Groups[player.group] ~= nil then
			group = Config.Groups[player.group].Color .. Config.Groups[player.group].Label
		end
		RageUI.ButtonWithStyle(
			player.name .. " - " .. GetPlayerName(GetPlayerFromServerId(player.source)) .. " ~s~[" .. group .. "~s~]",
			nil,
			{ RightLabel = "→" },
			true,
			function(_h, _a, _s)
				-- body
			end
		)
	end
end
