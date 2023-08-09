-- Menu texture initialization
-- create the menu texture with the config parameters
if Config.MenuStyle.BannerStyle.ImageUrl ~= nil then
	local runtimeTXD = CreateRuntimeTxd("custom_menu_header")
	local Object = CreateDui(
		Config.MenuStyle.BannerStyle.ImageUrl,
		Config.MenuStyle.BannerStyle.ImageSize.Width,
		Config.MenuStyle.BannerStyle.ImageSize.Height
	)
	_G.Object = Object
	local objectTexture = GetDuiHandle(Object)
	local Texture = CreateRuntimeTextureFromDuiHandle(runtimeTXD, "custom_menu_header", objectTexture)
	_var.menus.admin.bannerTexture = "custom_menu_header"
end

---openMenu → Function to open the administration main menu
---@return void
function openMenu()
	-- Check if the menu is already opened
	if _var.menus.admin.isOpened then
		_var.menus.admin.isOpened = false
		return
	end

	-- RageUI menu initialization
	-- init the rageui menu with the config parameters
	_var.menus.admin.objects.main = RageUI.CreateMenu(
		_("menu_title"),
		_("main_subtitle"),
		Config.MenuStyle.Margins.left,
		Config.MenuStyle.Margins.top,
		_var.menus.admin.bannerTexture,
		_var.menus.admin.bannerTexture
	)

	_var.menus.admin.objects.main.Closed = function()
		_var.menus.admin.isOpened = false
	end

	_var.menus.admin.objects.mainPersonnal = RageUI.CreateSubMenu(
		_var.menus.admin.objects.main,
		_U("menu_title"),
		_U("main_personnal_subtitle"),
		Config.MenuStyle.Margins.left,
		Config.MenuStyle.Margins.top,
		_var.menus.admin.bannerTexture,
		_var.menus.admin.bannerTexture
	)
	_var.menus.admin.objects.mainPersonnalAppearance = RageUI.CreateSubMenu(
		_var.menus.admin.objects.mainPersonnal,
		_U("menu_title"),
		_U("main_personnal_appearance_subtitle"),
		Config.MenuStyle.Margins.left,
		Config.MenuStyle.Margins.top,
		_var.menus.admin.bannerTexture,
		_var.menus.admin.bannerTexture
	)
	_var.menus.admin.objects.mainPlayers = RageUI.CreateSubMenu(
		_var.menus.admin.objects.main,
		_U("menu_title"),
		_U("main_players_subtitle"),
		Config.MenuStyle.Margins.left,
		Config.MenuStyle.Margins.top,
		_var.menus.admin.bannerTexture,
		_var.menus.admin.bannerTexture
	)
	_var.menus.admin.objects.mainPlayersInteract = RageUI.CreateSubMenu(
		_var.menus.admin.objects.mainPlayers,
		_U("menu_title"),
		_U("main_players_interact_subtitle"),
		Config.MenuStyle.Margins.left,
		Config.MenuStyle.Margins.top,
		_var.menus.admin.bannerTexture,
		_var.menus.admin.bannerTexture
	)
	_var.menus.admin.objects.mainVehicles = RageUI.CreateSubMenu(
		_var.menus.admin.objects.main,
		_U("menu_title"),
		_U("main_vehicles_subtitle"),
		Config.MenuStyle.Margins.left,
		Config.MenuStyle.Margins.top,
		_var.menus.admin.bannerTexture,
		_var.menus.admin.bannerTexture
	)
	_var.menus.admin.objects.mainVehiclesCurrent = RageUI.CreateSubMenu(
		_var.menus.admin.objects.mainVehicles,
		_U("menu_title"),
		_U("main_vehicles_current_subtitle"),
		Config.MenuStyle.Margins.left,
		Config.MenuStyle.Margins.top,
		_var.menus.admin.bannerTexture,
		_var.menus.admin.bannerTexture
	)
	_var.menus.admin.objects.mainVehiclesCurrentCustom = RageUI.CreateSubMenu(
		_var.menus.admin.objects.mainVehiclesCurrent,
		_U("menu_title"),
		_U("main_vehicles_current_custom_subtitle"),
		Config.MenuStyle.Margins.left,
		Config.MenuStyle.Margins.top,
		_var.menus.admin.bannerTexture,
		_var.menus.admin.bannerTexture
	)
	_var.menus.admin.objects.mainVehiclesFavorites = RageUI.CreateSubMenu(
		_var.menus.admin.objects.mainVehicles,
		_U("menu_title"),
		_U("main_vehicles_favorites_subtitle"),
		Config.MenuStyle.Margins.left,
		Config.MenuStyle.Margins.top,
		_var.menus.admin.bannerTexture,
		_var.menus.admin.bannerTexture
	)
	_var.menus.admin.objects.mainVehiclesSpawn = RageUI.CreateSubMenu(
		_var.menus.admin.objects.mainVehicles,
		_U("menu_title"),
		_U("main_vehicles_spawn_subtitle"),
		Config.MenuStyle.Margins.left,
		Config.MenuStyle.Margins.top,
		_var.menus.admin.bannerTexture,
		_var.menus.admin.bannerTexture
	)
	_var.menus.admin.objects.mainReports = RageUI.CreateSubMenu(
		_var.menus.admin.objects.main,
		_U("menu_title"),
		_U("main_reports_subtitle"),
		Config.MenuStyle.Margins.left,
		Config.MenuStyle.Margins.top,
		_var.menus.admin.bannerTexture,
		_var.menus.admin.bannerTexture
	)
	_var.menus.admin.objects.mainReportsEdit = RageUI.CreateSubMenu(
		_var.menus.admin.objects.mainReports,
		_U("menu_title"),
		_U("main_reports_edit_subtitle"),
		Config.MenuStyle.Margins.left,
		Config.MenuStyle.Margins.top,
		_var.menus.admin.bannerTexture,
		_var.menus.admin.bannerTexture
	)
	_var.menus.admin.objects.mainReportsEditAdvanced = RageUI.CreateSubMenu(
		_var.menus.admin.objects.mainReports,
		_U("menu_title"),
		_U("main_reports_edit_advanced_subtitle"),
		Config.MenuStyle.Margins.left,
		Config.MenuStyle.Margins.top,
		_var.menus.admin.bannerTexture,
		_var.menus.admin.bannerTexture
	)
	_var.menus.admin.objects.mainServer = RageUI.CreateSubMenu(
		_var.menus.admin.objects.main,
		_U("menu_title"),
		_U("main_server_subtitle"),
		Config.MenuStyle.Margins.left,
		Config.MenuStyle.Margins.top,
		_var.menus.admin.bannerTexture,
		_var.menus.admin.bannerTexture
	)

	for _k, rageObject in pairs(_var.menus.admin.objects) do
		-- Set the offset
		rageObject:SetStyleSize(Config.MenuStyle.BannerStyle.widthOffset)

		-- Set color if no custom banner
		if Config.MenuStyle.BannerStyle.ImageUrl == nil then
			rageObject:SetRectangleBanner(
				Config.MenuStyle.BannerStyle.Color.r,
				Config.MenuStyle.BannerStyle.Color.g,
				Config.MenuStyle.BannerStyle.Color.b,
				Config.MenuStyle.BannerStyle.Color.a
			)
		end
	end

	-- Opening the menu if player have permission
	ESX.TriggerServerCallback("epyi_administration:getPlayerGroup", function(group)
		-- Save player group
		_var.client.staffGroup = group

		-- Return if player does not have the permission
		if
			not Config.Groups[_var.client.staffGroup]
			or not Config.Groups[_var.client.staffGroup].Access["mainmenu_open"]
		then
			ESX.ShowNotification(_U("insuficient_permissions"))
			return
		end

		_var.menus.admin.isOpened = true
		RageUI.Visible(_var.menus.admin.objects.main, true)

		-- Menu pools
		while _var.menus.admin.isOpened do
			RageUI.IsVisible(
				_var.menus.admin.objects.main,
				true,
				Config.MenuStyle.BannerStyle.UseGlareEffect,
				Config.MenuStyle.BannerStyle.UseInstructionalButtons,
				function()
					main_showContentThisFrame(_var.client.staffGroup)
				end
			)
			RageUI.IsVisible(
				_var.menus.admin.objects.mainPersonnal,
				true,
				Config.MenuStyle.BannerStyle.UseGlareEffect,
				Config.MenuStyle.BannerStyle.UseInstructionalButtons,
				function()
					main_personnal_showContentThisFrame(_var.client.staffGroup)
				end
			)
			RageUI.IsVisible(
				_var.menus.admin.objects.mainPersonnalAppearance,
				true,
				Config.MenuStyle.BannerStyle.UseGlareEffect,
				Config.MenuStyle.BannerStyle.UseInstructionalButtons,
				function()
					main_personnal_appearance_showContentThisFrame(_var.client.staffGroup)
				end
			)
			RageUI.IsVisible(
				_var.menus.admin.objects.mainPlayers,
				true,
				Config.MenuStyle.BannerStyle.UseGlareEffect,
				Config.MenuStyle.BannerStyle.UseInstructionalButtons,
				function()
					main_players_showContentThisFrame(_var.client.staffGroup)
				end
			)
			RageUI.IsVisible(
				_var.menus.admin.objects.mainPlayersInteract,
				true,
				Config.MenuStyle.BannerStyle.UseGlareEffect,
				Config.MenuStyle.BannerStyle.UseInstructionalButtons,
				function()
					main_players_interact_showContentThisFrame(_var.client.staffGroup)
				end
			)
			RageUI.IsVisible(
				_var.menus.admin.objects.mainVehicles,
				true,
				Config.MenuStyle.BannerStyle.UseGlareEffect,
				Config.MenuStyle.BannerStyle.UseInstructionalButtons,
				function()
					main_vehicles_showContentThisFrame(_var.client.staffGroup)
				end
			)
			RageUI.IsVisible(
				_var.menus.admin.objects.mainVehiclesCurrent,
				true,
				Config.MenuStyle.BannerStyle.UseGlareEffect,
				Config.MenuStyle.BannerStyle.UseInstructionalButtons,
				function()
					main_vehicles_current_showContentThisFrame(_var.client.staffGroup)
				end
			)
			RageUI.IsVisible(
				_var.menus.admin.objects.mainVehiclesCurrentCustom,
				true,
				Config.MenuStyle.BannerStyle.UseGlareEffect,
				Config.MenuStyle.BannerStyle.UseInstructionalButtons,
				function()
					main_vehicles_current_custom_showContentThisFrame(_var.client.staffGroup)
				end
			)
			RageUI.IsVisible(
				_var.menus.admin.objects.mainVehiclesFavorites,
				true,
				Config.MenuStyle.BannerStyle.UseGlareEffect,
				Config.MenuStyle.BannerStyle.UseInstructionalButtons,
				function()
					main_vehicles_favorites_showContentThisFrame(_var.client.staffGroup)
				end
			)
			RageUI.IsVisible(
				_var.menus.admin.objects.mainVehiclesSpawn,
				true,
				Config.MenuStyle.BannerStyle.UseGlareEffect,
				Config.MenuStyle.BannerStyle.UseInstructionalButtons,
				function()
					main_vehicles_spawn_showContentThisFrame(_var.client.staffGroup)
				end
			)
			RageUI.IsVisible(
				_var.menus.admin.objects.mainReports,
				true,
				Config.MenuStyle.BannerStyle.UseGlareEffect,
				Config.MenuStyle.BannerStyle.UseInstructionalButtons,
				function()
					main_reports_showContentThisFrame(_var.client.staffGroup)
				end
			)
			RageUI.IsVisible(
				_var.menus.admin.objects.mainReportsEdit,
				true,
				Config.MenuStyle.BannerStyle.UseGlareEffect,
				Config.MenuStyle.BannerStyle.UseInstructionalButtons,
				function()
					main_reports_edit_showContentThisFrame(_var.client.staffGroup)
				end
			)
			RageUI.IsVisible(
				_var.menus.admin.objects.mainReportsEditAdvanced,
				true,
				Config.MenuStyle.BannerStyle.UseGlareEffect,
				Config.MenuStyle.BannerStyle.UseInstructionalButtons,
				function()
					main_players_interact_showContentThisFrame(_var.client.staffGroup)
				end
			)
			RageUI.IsVisible(
				_var.menus.admin.objects.mainServer,
				true,
				Config.MenuStyle.BannerStyle.UseGlareEffect,
				Config.MenuStyle.BannerStyle.UseInstructionalButtons,
				function()
					main_server_showContentThisFrame(_var.client.staffGroup)
				end
			)
			for _k, rageObject in pairs(_var.menus.admin.objects) do
				if _var.menus.admin.cooldowns.items then
					rageObject.Controls.Back.Enabled = false
				else
					rageObject.Controls.Back.Enabled = true
				end
			end
			Citizen.Wait(0)
		end
		RageUI.CloseAll()
	end, GetPlayerServerId(PlayerId()))
end
