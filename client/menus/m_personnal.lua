---main_personnal_showContentThisFrame → Function to show the main/personnal menu content
---@return void
function main_personnal_showContentThisFrame(playerGroup)
    RageUI.Separator(GetPlayerName(PlayerId()) .. " [" .. Config.Groups[playerGroup].Color .. Config.Groups[playerGroup].Label .. "~s~] - ID: ~r~" .. GetPlayerServerId(PlayerId()))
    RageUI.Separator("")
end