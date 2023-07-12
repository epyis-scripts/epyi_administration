-- Variables initialization
-- init some local variables
isStaffModeEnabled = false
isMenuOpened = false
menuTexture = nil
playerGroup = nil

-- Menu texture initialization
-- create the menu texture with the config parameters
if Config.MenuStyle.BannerStyle.ImageUrl ~= nil then
	local Object = CreateDui(
		Config.MenuStyle.BannerStyle.ImageUrl,
		Config.MenuStyle.BannerStyle.ImageSize.Width,
		Config.MenuStyle.BannerStyle.ImageSize.Height
	)
	_G.Object = Object
	menuTexture = "Custom_Menu_Head"
end

-- RageUI menu initialization
-- init the rageui menu with the config parameters
RMenu.Add(
	"epyi_administration",
	"main",
	RageUI.CreateMenu(
		Translate("menu_title"),
		Translate("main_subtitle"),
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
		TranslateCap("menu_title"),
		TranslateCap("main_personnal_subtitle"),
		Config.MenuStyle.Margins.left,
		Config.MenuStyle.Margins.top,
		menuTexture,
		menuTexture
	)
)
RMenu:Get("epyi_administration", "main").Closed = function()
	isMenuOpened = false
end
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
				ESX.ShowNotification(TranslateCap("insuficient_permissions"))
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
				Citizen.Wait(1)
			end
		end, GetPlayerServerId(PlayerId()))
	end
end
