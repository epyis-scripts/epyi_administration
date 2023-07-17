-- Variables initialization
-- init some local variables
isStaffModeEnabled = false
isMenuOpened = false
menuTexture = nil
playerGroup = nil

-- Menu texture initialization
-- create the menu texture with the config parameters
if Config.MenuStyle.BannerStyle.ImageUrl ~= nil then
	local runtimeTXD = CreateRuntimeTxd("Custom_Menu_Head")
	local Object = CreateDui(
		Config.MenuStyle.BannerStyle.ImageUrl,
		Config.MenuStyle.BannerStyle.ImageSize.Width,
		Config.MenuStyle.BannerStyle.ImageSize.Height
	)
	_G.Object = Object
	local objectTexture = GetDuiHandle(Object)
	local Texture = CreateRuntimeTextureFromDuiHandle(runtimeTXD, "Custom_Menu_Head", objectTexture)
	menuTexture = "Custom_Menu_Head"
end

-- RageUI menu initialization
-- init the rageui menu with the config parameters
RMenu.Add(
	"epyi_administration",
	"main",
	RageUI.CreateMenu(
		_("menu_title"),
		_("main_subtitle"),
		Config.MenuStyle.Margins.left,
		Config.MenuStyle.Margins.top,
		menuTexture,
		menuTexture
	)
)
RMenu.Add(
	"epyi_administration",
	"main_personnal",
	RageUI.CreateSubMenu(
		RMenu:Get("epyi_administration", "main"),
		_U("menu_title"),
		_U("main_personnal_subtitle"),
		Config.MenuStyle.Margins.left,
		Config.MenuStyle.Margins.top,
		menuTexture,
		menuTexture
	)
)
RMenu.Add(
	"epyi_administration",
	"main_vehicles",
	RageUI.CreateSubMenu(
		RMenu:Get("epyi_administration", "main"),
		_U("menu_title"),
		_U("main_vehicles_subtitle"),
		Config.MenuStyle.Margins.left,
		Config.MenuStyle.Margins.top,
		menuTexture,
		menuTexture
	)
)
RMenu.Add(
	"epyi_administration",
	"main_vehicles_current",
	RageUI.CreateSubMenu(
		RMenu:Get("epyi_administration", "main_vehicles"),
		_U("menu_title"),
		_U("main_vehicles_current_subtitle"),
		Config.MenuStyle.Margins.left,
		Config.MenuStyle.Margins.top,
		menuTexture,
		menuTexture
	)
)
RMenu:Get("epyi_administration", "main").Closed = function()
	isMenuOpened = false
end

if Config.MenuStyle.BannerStyle.ImageUrl == nil then
	RMenu:Get("epyi_administration", "main"):SetRectangleBanner(
		Config.MenuStyle.BannerStyle.Color.r,
		Config.MenuStyle.BannerStyle.Color.g,
		Config.MenuStyle.BannerStyle.Color.b,
		Config.MenuStyle.BannerStyle.Color.a
	)
	RMenu:Get("epyi_administration", "main_personnal"):SetRectangleBanner(
		Config.MenuStyle.BannerStyle.Color.r,
		Config.MenuStyle.BannerStyle.Color.g,
		Config.MenuStyle.BannerStyle.Color.b,
		Config.MenuStyle.BannerStyle.Color.a
	)
	RMenu:Get("epyi_administration", "main_vehicles"):SetRectangleBanner(
		Config.MenuStyle.BannerStyle.Color.r,
		Config.MenuStyle.BannerStyle.Color.g,
		Config.MenuStyle.BannerStyle.Color.b,
		Config.MenuStyle.BannerStyle.Color.a
	)
	RMenu:Get("epyi_administration", "main_vehicles_current"):SetRectangleBanner(
		Config.MenuStyle.BannerStyle.Color.r,
		Config.MenuStyle.BannerStyle.Color.g,
		Config.MenuStyle.BannerStyle.Color.b,
		Config.MenuStyle.BannerStyle.Color.a
	)
end

---openMenu → Function to open the administration main menu
---@return void
function openMenu()
	if isMenuOpened then
		RageUI.CloseAll()
		isMenuOpened = false
	else
		ESX.TriggerServerCallback("epyi_administration:getPlayerGroup", function(group)
			playerGroup = group
			if not Config.Groups[playerGroup] or not Config.Groups[playerGroup].Access["mainmenu_open"] then
				ESX.ShowNotification(_U("insuficient_permissions"))
				return
			end
			isMenuOpened = true
			RageUI.Visible(RMenu:Get("epyi_administration", "main"), true)
			while isMenuOpened do
				RageUI.IsVisible(
					RMenu:Get("epyi_administration", "main"),
					true,
					Config.MenuStyle.BannerStyle.UseGlareEffect,
					Config.MenuStyle.BannerStyle.UseInstructionalButtons,
					function()
						main_showContentThisFrame(playerGroup)
					end
				)
				RageUI.IsVisible(
					RMenu:Get("epyi_administration", "main_personnal"),
					true,
					Config.MenuStyle.BannerStyle.UseGlareEffect,
					Config.MenuStyle.BannerStyle.UseInstructionalButtons,
					function()
						main_personnal_showContentThisFrame(playerGroup)
					end
				)
				RageUI.IsVisible(
					RMenu:Get("epyi_administration", "main_vehicles"),
					true,
					Config.MenuStyle.BannerStyle.UseGlareEffect,
					Config.MenuStyle.BannerStyle.UseInstructionalButtons,
					function()
						main_vehicles_showContentThisFrame(playerGroup)
					end
				)
				RageUI.IsVisible(
					RMenu:Get("epyi_administration", "main_vehicles_current"),
					true,
					Config.MenuStyle.BannerStyle.UseGlareEffect,
					Config.MenuStyle.BannerStyle.UseInstructionalButtons,
					function()
						main_vehicles_current_showContentThisFrame(playerGroup)
					end
				)
				Citizen.Wait(1)
			end
		end, GetPlayerServerId(PlayerId()))
	end
end
