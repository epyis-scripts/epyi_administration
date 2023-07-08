-- openMenu
---Function to open the administration main menu
---@return void
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