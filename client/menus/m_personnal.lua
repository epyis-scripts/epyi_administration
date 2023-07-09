---main_personnal_showContentThisFrame → Function to show the main/personnal menu content
---@return void
function main_personnal_showContentThisFrame(playerGroup)
    RageUI.Separator(GetPlayerName(PlayerId()) .. " [" .. Config.Groups[playerGroup].Color .. Config.Groups[playerGroup].Label .. "~s~] - ID: ~r~" .. GetPlayerServerId(PlayerId()))
    RageUI.List(TranslateCap("main_personnal_health_management"), playersOptionsArray, playersOptionsArrayIndex, TranslateCap("main_personnal_health_management_desc"), {}, Config.Groups[playerGroup].Access["submenu_personnal.health_management"], function(_, _, _, Index)
        playersOptionsArrayIndex = Index
    end)
end