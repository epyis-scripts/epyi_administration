-- Key registering
-- register the key to open the administration menu
Keys.Register(Config.Keys.Menu, "-openAdminMenu", _("keys_menu_description"), function()
	openMenu()
end)

-- Key registering
-- register the key to use the noclip
Keys.Register(Config.Keys.NoClip.use, "-useAdminNoClip", _("keys_menu_noclip"), function()
	ESX.TriggerServerCallback("epyi_administration:getPlayerGroup", function(group)
		_var.client.staffGroup = group
		if
			not Config.Groups[_var.client.staffGroup]
			or not Config.Groups[_var.client.staffGroup].Access["submenu_personnal_noclip"]
		then
			ESX.ShowNotification(_U("insuficient_permissions"))
			return
		end
		if _threads.noclip.isActivated then
			_threads.noclip.disable()
			ESX.ShowNotification(_U("notif_noclip_disabled_self"))
		else
			_threads.noclip.enable()
			ESX.ShowNotification(_U("notif_noclip_enabled_self"))
		end
	end, GetPlayerServerId(PlayerId()))
end)
