local playerOptionsArray = {
	_("players_actions_heal"),
	_("players_actions_feed"),
	_("players_actions_hydrate"),
	_("players_actions_shield"),
	_("players_actions_suicide"),
}
local playerOptionsArrayIndex = 1

---main_personnal_showContentThisFrame → Function to show the main/personnal menu content
---@param playerGroup string
---@return void
function main_personnal_showContentThisFrame(playerGroup)
	RageUI.Separator(
		GetPlayerName(PlayerId())
			.. " ["
			.. Config.Groups[playerGroup].Color
			.. Config.Groups[playerGroup].Label
			.. "~s~] - ID: ~r~"
			.. GetPlayerServerId(PlayerId())
	)
	RageUI.List(
		_U("main_personnal_health_management"),
		playerOptionsArray,
		playerOptionsArrayIndex,
		_U("main_personnal_health_management_desc"),
		{},
		Config.Groups[playerGroup].Access["submenu_personnal_health_management"],
		function(_h, _a, Selected, Index)
			playerOptionsArrayIndex = Index
			if Selected then
				local ped = PlayerPedId()
				if playerOptionsArrayIndex == 1 then -- if selected item is "heal"
					if not IsEntityDead(ped) then
						SetEntityHealth(ped, GetEntityMaxHealth(ped))
						ClearPedBloodDamage(ped)
						ESX.ShowNotification(_U("notif_health_management_heal_self"))
					else
						revivePed(ped)
						ESX.ShowNotification(_U("notif_health_management_heal_revive_self"))
					end
				elseif playerOptionsArrayIndex == 2 then -- if selected item is "feed"
					TriggerEvent("esx_status:set", "hunger", 1000000)
					ESX.ShowNotification(_U("notif_health_management_heal_feed_self"))
				elseif playerOptionsArrayIndex == 3 then -- if selected item is "hydrate"
					TriggerEvent("esx_status:set", "thirst", 1000000)
					ESX.ShowNotification(_U("notif_health_management_heal_hydrate_self"))
				elseif playerOptionsArrayIndex == 4 then -- if selected item is "give shield"
					SetPedArmour(ped, 100)
					ESX.ShowNotification(_U("notif_health_management_heal_shield_self"))
				elseif playerOptionsArrayIndex == 5 then -- if selected item is "suicide"
					SetEntityHealth(ped, 0)
					ESX.ShowNotification(_U("notif_health_management_heal_suicide_self"))
				end
			end
		end
	)
	RageUI.ButtonWithStyle(
		_U("main_personnal_appearance"),
		_U("main_personnal_appearance_desc"),
		{ RightLabel = "→" },
		Config.Groups[playerGroup].Access["submenu_personnal_appearance"],
		function(_h, _a, _s) end,
		_var.menus.admin.objects.mainPersonnalAppearance
	)
	RageUI.Checkbox(
		_U("main_personnal_noclip"),
		_U("main_personnal_noclip_desc"),
		_threads.noclip.isActivated,
		{ Enabled = Config.Groups[playerGroup].Access["submenu_personnal_noclip"] },
		function() end,
		function()
			if not Config.Groups[playerGroup].Access["submenu_personnal_noclip"] then
				return
			end
			_threads.noclip.enable()
			ESX.ShowNotification(_U("notif_noclip_enabled_self"))
		end,
		function()
			if not Config.Groups[playerGroup].Access["submenu_personnal_noclip"] then
				return
			end
			_threads.noclip.disable()
			ESX.ShowNotification(_U("notif_noclip_disabled_self"))
		end
	)
	RageUI.Checkbox(
		_U("main_personnal_godmode"),
		_U("main_personnal_godmode_desc"),
		_threads.godmode.isActivated,
		{ Enabled = Config.Groups[playerGroup].Access["submenu_personnal_godmode"] },
		function() end,
		function()
			if not Config.Groups[playerGroup].Access["submenu_personnal_godmode"] then
				return
			end
			_threads.godmode.enable()
			ESX.ShowNotification(_U("notif_godmode_enabled_self"))
		end,
		function()
			if not Config.Groups[playerGroup].Access["submenu_personnal_godmode"] then
				return
			end
			_threads.godmode.disable()
			ESX.ShowNotification(_U("notif_godmode_disabled_self"))
		end
	)
	RageUI.Checkbox(
		_U("main_personnal_invisibility"),
		_U("main_personnal_invisibility_desc"),
		_threads.invisibility.isActivated,
		{ Enabled = Config.Groups[playerGroup].Access["submenu_personnal_invisibility"] },
		function() end,
		function()
			if not Config.Groups[playerGroup].Access["submenu_personnal_invisibility"] then
				return
			end
			_threads.invisibility.enable()
			ESX.ShowNotification(_U("notif_invisibility_enabled_self"))
		end,
		function()
			if not Config.Groups[playerGroup].Access["submenu_personnal_invisibility"] then
				return
			end
			_threads.invisibility.disable()
			ESX.ShowNotification(_U("notif_invisibility_disabled_self"))
		end
	)
	RageUI.Checkbox(
		_U("main_personnal_fastwalk"),
		_U("main_personnal_fastwalk_desc"),
		_threads.fastwalk.isActivated,
		{ Enabled = Config.Groups[playerGroup].Access["submenu_personnal_fastwalk"] },
		function() end,
		function()
			if not Config.Groups[playerGroup].Access["submenu_personnal_fastwalk"] then
				return
			end
			_threads.fastwalk.enable()
			ESX.ShowNotification(_U("notif_fastwalk_enabled_self"))
		end,
		function()
			if not Config.Groups[playerGroup].Access["submenu_personnal_fastwalk"] then
				return
			end
			_threads.fastwalk.disable()
			ESX.ShowNotification(_U("notif_fastwalk_disabled_self"))
		end
	)
	RageUI.Checkbox(
		_U("main_personnal_fastswim"),
		_U("main_personnal_fastswim_desc"),
		_threads.fastswim.isActivated,
		{ Enabled = Config.Groups[playerGroup].Access["submenu_personnal_fastswim"] },
		function() end,
		function()
			if not Config.Groups[playerGroup].Access["submenu_personnal_fastswim"] then
				return
			end
			_threads.fastswim.enable()
			ESX.ShowNotification(_U("notif_fastswim_enabled_self"))
		end,
		function()
			if not Config.Groups[playerGroup].Access["submenu_personnal_fastswim"] then
				return
			end
			_threads.fastswim.disable()
			ESX.ShowNotification(_U("notif_fastswim_disabled_self"))
		end
	)
	RageUI.Checkbox(
		_U("main_personnal_superjump"),
		_U("main_personnal_superjump_desc"),
		_threads.superjump.isActivated,
		{ Enabled = Config.Groups[playerGroup].Access["submenu_personnal_superjump"] },
		function() end,
		function()
			if not Config.Groups[playerGroup].Access["submenu_personnal_superjump"] then
				return
			end
			_threads.superjump.enable()
			ESX.ShowNotification(_U("notif_superjump_enabled_self"))
		end,
		function()
			if not Config.Groups[playerGroup].Access["submenu_personnal_superjump"] then
				return
			end
			_threads.superjump.disable()
			ESX.ShowNotification(_U("notif_superjump_disabled_self"))
		end
	)
	RageUI.Checkbox(
		_U("main_personnal_stayinvehicle"),
		_U("main_personnal_stayinvehicle_desc"),
		_threads.stayinvehicle.isActivated,
		{ Enabled = Config.Groups[playerGroup].Access["submenu_personnal_stayinvehicle"] },
		function() end,
		function()
			if not Config.Groups[playerGroup].Access["submenu_personnal_stayinvehicle"] then
				return
			end
			_threads.stayinvehicle.enable()
			ESX.ShowNotification(_U("notif_stayinvehicle_enabled_self"))
		end,
		function()
			if not Config.Groups[playerGroup].Access["submenu_personnal_stayinvehicle"] then
				return
			end
			_threads.stayinvehicle.disable()
			ESX.ShowNotification(_U("notif_stayinvehicle_disabled_self"))
		end
	)
	RageUI.Checkbox(
		_U("main_personnal_seethrough"),
		_U("main_personnal_seethrough_desc"),
		_threads.seethrough.isActivated,
		{ Enabled = Config.Groups[playerGroup].Access["submenu_personnal_seethrough"] },
		function() end,
		function()
			if not Config.Groups[playerGroup].Access["submenu_personnal_seethrough"] then
				return
			end
			_threads.seethrough.enable()
			ESX.ShowNotification(_U("notif_seethrough_enabled_self"))
		end,
		function()
			if not Config.Groups[playerGroup].Access["submenu_personnal_seethrough"] then
				return
			end
			_threads.seethrough.disable()
			ESX.ShowNotification(_U("notif_seethrough_disabled_self"))
		end
	)
	RageUI.Checkbox(
		_U("main_personnal_shownames"),
		_U("main_personnal_shownames_desc"),
		_threads.shownames.isActivated,
		{ Enabled = Config.Groups[playerGroup].Access["submenu_personnal_shownames"] },
		function() end,
		function()
			if not Config.Groups[playerGroup].Access["submenu_personnal_shownames"] then
				return
			end
			_threads.shownames.enable()
			ESX.ShowNotification(_U("notif_shownames_enabled_self"))
		end,
		function()
			if not Config.Groups[playerGroup].Access["submenu_personnal_shownames"] then
				return
			end
			_threads.shownames.disable()
			ESX.ShowNotification(_U("notif_shownames_disabled_self"))
		end
	)
end
