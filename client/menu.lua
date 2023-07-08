-- Variables initialization
-- # → init some local variables
local isMenuOpened = false
local menuTexture = nil

-- Menu texture initialization
-- # → create the menu texture with the config parameters
if Config.MenuStyle.BannerStyle.ImageUrl ~= nil then
    local Object = CreateDui(Config.MenuStyle.BannerStyle.ImageUrl, Config.MenuStyle.BannerStyle.ImageSize.Width, Config.MenuStyle.BannerStyle.ImageSize.Height)
    _G.Object = Object
    menuTexture = "Custom_Menu_Head"
end

-- RageUI menu initialization
-- # → init the rageui menu with the config parameters
RMenu.Add("epyi_administration", "main", RageUI.CreateMenu(Translate("menu_title"), Translate("menu_subtitle"), Config.MenuStyle.Margins.left, Config.MenuStyle.Margins.top, menuTexture, menuTexture))
RMenu:Get("epyi_administration", "main").Closed = function()
    isMenuOpened = false
end
RMenu:Get("epyi_administration", "main"):SetRectangleBanner(Config.MenuStyle.BannerStyle.Color.r, Config.MenuStyle.BannerStyle.Color.g, Config.MenuStyle.BannerStyle.Color.b, Config.MenuStyle.BannerStyle.Color.a)

RegisterCommand("testmenu", function()
    openMenu()
end, false)

function openMenu()
    if isMenuOpened then
        RageUI.CloseAll()
        isMenuOpened = false
    else
        isMenuOpened = true
        RageUI.Visible(RMenu:Get("epyi_administration", "main"), true)
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("epyi_administration", "main"), true, Config.MenuStyle.BannerStyle.UseGlareEffect, Config.MenuStyle.BannerStyle.UseInstructionalButtons, function()
                RageUI.Separator("")
            end)
            Citizen.Wait(1)
        end
    end
end