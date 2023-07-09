---main_showContentThisFrame → Function to show the main menu content
---@return void
function main_showContentThisFrame(playerGroup)
    RageUI.Checkbox(TranslateCap("main_menu_staffmode"), TranslateCap("main_menu_staffmode_desc"), isStaffModeEnabled, {}, function()end, function()
        isStaffModeEnabled = true
    end, function()
        isStaffModeEnabled = false
    end)
    if isStaffModeEnabled then
        RageUI.Separator("")
        RageUI.Separator(TranslateCap("main_menu_title1") .. Config.Groups[playerGroup].Prefix .. GetPlayerName(PlayerId()))
        RageUI.Separator(TranslateCap("main_menu_title2") .. Config.Groups[playerGroup].Color .. Config.Groups[playerGroup].Label)
        RageUI.Separator("")
        RageUI.ButtonWithStyle(TranslateCap("main_menu_access_personnal"), TranslateCap("main_menu_access_personnal_desc"), {RightLabel = "→"}, Config.Groups[playerGroup].Access["submenu_personnal.access"], function(_, _, _)end)
        RageUI.ButtonWithStyle(TranslateCap("main_menu_access_players"), TranslateCap("main_menu_access_players_desc"), {RightLabel = "→"}, Config.Groups[playerGroup].Access["submenu_players.access"], function(_, _, _)end)
        RageUI.ButtonWithStyle(TranslateCap("main_menu_access_vehicles"), TranslateCap("main_menu_access_vehicles_desc"), {RightLabel = "→"}, Config.Groups[playerGroup].Access["submenu_vehicles.access"], function(_, _, _)end)
        RageUI.ButtonWithStyle(TranslateCap("main_menu_access_reports"), TranslateCap("main_menu_access_reports_desc"), {RightLabel = "→"}, Config.Groups[playerGroup].Access["submenu_reports.access"], function(_, _, _)end)
        RageUI.ButtonWithStyle(TranslateCap("main_menu_access_server"), TranslateCap("main_menu_access_server_desc"), {RightLabel = "→"}, Config.Groups[playerGroup].Access["submenu_server.access"], function(_, _, _)end)
    end
end