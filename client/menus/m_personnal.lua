---main_personnal_showContentThisFrame → Function to show the main/personnal menu content
---@return void
function main_personnal_showContentThisFrame(playerGroup)
    RageUI.Separator(GetPlayerName(PlayerId()) .. " [" .. Config.Groups[playerGroup].Color .. Config.Groups[playerGroup].Label .. "~s~] - ID: ~r~" .. GetPlayerServerId(PlayerId()))
    RageUI.List(TranslateCap("main_personnal_health_management"), playersOptionsArray, playersOptionsArrayIndex, TranslateCap("main_personnal_health_management_desc"), {}, Config.Groups[playerGroup].Access["submenu_personnal.health_management"], function(_, _, Selected, Index)
        playersOptionsArrayIndex = Index
        if Selected then
            local ped = PlayerPedId()
            if playersOptionsArrayIndex == 1 then -- if selected item is "heal"
                SetEntityHealth(ped, GetEntityMaxHealth(ped))
            elseif playersOptionsArrayIndex == 2 then -- if selected item is "feed"
                TriggerEvent('esx_status:set', 'hunger', 1000000)
            elseif playersOptionsArrayIndex == 3 then -- if selected item is "hydrate"
                TriggerEvent('esx_status:set', 'thirst', 1000000)
            elseif playersOptionsArrayIndex == 4 then -- if selected item is "give shield"
                SetPedArmour(ped, 100)
            end 
        end
    end)
end