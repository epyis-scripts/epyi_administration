-- Variables initialization
-- # → init some local variables
local isMenuOpened = false
local menuTexture = nil

-- RageUI menu initialization
-- # → init the rageui menu with the config parameters
RMenu.Add("epyi_administration", "main", RageUI.CreateMenu(Translate("menu_title"), Translate("menu_subtitle"), Config.MenuStyle.Margins.left, Config.MenuStyle.Margins.top, menuTexture, menuTexture, Config.MenuStyle.BannerStyle.Color.r, Config.MenuStyle.BannerStyle.Color.g, Config.MenuStyle.BannerStyle.Color.b, Config.MenuStyle.BannerStyle.Color.a))