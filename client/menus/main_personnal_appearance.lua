---main_personnal_showContentThisFrame → Function to show the main/personnal menu content
---@param playerGroup string
---@return void
function main_personnal_appearance_showContentThisFrame(playerGroup)
	RageUI.ButtonWithStyle(
		_U("main_personnal_appearance_back"),
		_U("main_personnal_appearance_back_desc"),
		{},
		Config.Groups[playerGroup].Access["submenu_personnal_appearance_getback"],
		function(_h, _a, Selected)
			if Selected then
				ESX.TriggerServerCallback("esx_skin:getPlayerSkin", function(skin)
					TriggerEvent("skinchanger:loadDefaultModel", skin.sex, function()
						TriggerEvent("skinchanger:loadSkin", skin)
					end)
					ESX.ShowNotification(_U("notif_appearance_back_success"))
				end)
			end
		end
	)
end
