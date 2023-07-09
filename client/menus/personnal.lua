---main_showContentThisFrame → Function to show the main menu content
---@return void
function main_personnal_showContentThisFrame()
    RageUI.Separator(TranslateCap("main_menu_title1") .. Config.Groups[playerGroup].Prefix .. GetPlayerName(PlayerId()))
    RageUI.Separator(TranslateCap("main_menu_title2") .. Config.Groups[playerGroup].Color .. Config.Groups[playerGroup].Label)
    RageUI.Separator("")
end