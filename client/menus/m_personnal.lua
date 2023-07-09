local playerOptionsArray = {
    Translate("players_actions_heal"),
    Translate("players_actions_feed"),
    Translate("players_actions_hydrate"),
    Translate("players_actions_shield")
}
local playerOptionsArrayIndex = 1
local playerGodmodeCheckbox = false
local playerInvisibilityCheckbox = false

---main_personnal_showContentThisFrame → Function to show the main/personnal menu content
---@return void
function main_personnal_showContentThisFrame(playerGroup)
    RageUI.Separator(GetPlayerName(PlayerId()) .. " [" .. Config.Groups[playerGroup].Color .. Config.Groups[playerGroup].Label .. "~s~] - ID: ~r~" .. GetPlayerServerId(PlayerId()))
    RageUI.List(TranslateCap("main_personnal_health_management"), playerOptionsArray, playerOptionsArrayIndex, TranslateCap("main_personnal_health_management_desc"), {}, Config.Groups[playerGroup].Access["submenu_personnal.health_management"], function(_, _, Selected, Index)
        playerOptionsArrayIndex = Index
        if Selected then
            local ped = PlayerPedId()
            if playerOptionsArrayIndex == 1 then -- if selected item is "heal"
                SetEntityHealth(ped, GetEntityMaxHealth(ped))
                ESX.ShowNotification(TranslateCap("notif_health_management_heal_self"))
            elseif playerOptionsArrayIndex == 2 then -- if selected item is "feed"
                TriggerEvent('esx_status:set', 'hunger', 1000000)
                ESX.ShowNotification(TranslateCap("notif_health_management_heal_feed"))
            elseif playerOptionsArrayIndex == 3 then -- if selected item is "hydrate"
                TriggerEvent('esx_status:set', 'thirst', 1000000)
                ESX.ShowNotification(TranslateCap("notif_health_management_heal_hydrate"))
            elseif playerOptionsArrayIndex == 4 then -- if selected item is "give shield"
                SetPedArmour(ped, 100)
                ESX.ShowNotification(TranslateCap("notif_health_management_heal_shield"))
            end 
        end
    end)
    RageUI.Checkbox(TranslateCap("main_personnal_godmode"), TranslateCap("main_personnal_godmode_desc"), playerGodmodeCheckbox, {Enabled = Config.Groups[playerGroup].Access["submenu_personnal.godmode"]}, function()end, function()
        if not Config.Groups[playerGroup].Access["submenu_personnal.godmode"] then
            return
        end
        SetEntityInvincible(PlayerPedId(), true)
        playerGodmodeCheckbox = true
        ESX.ShowNotification(TranslateCap("notif_godmode_enabled_self"))
    end, function()
        if not Config.Groups[playerGroup].Access["submenu_personnal.godmode"] then
            return
        end
        SetEntityInvincible(PlayerPedId(), false)
        playerGodmodeCheckbox = false
        ESX.ShowNotification(TranslateCap("notif_godmode_disabled_self"))
    end)
    RageUI.Checkbox(TranslateCap("main_personnal_invisibility"), TranslateCap("main_personnal_invisibility_desc"), playerInvisibilityCheckbox, {Enabled = Config.Groups[playerGroup].Access["submenu_personnal.invisibility"]}, function()end, function()
        if not Config.Groups[playerGroup].Access["submenu_personnal.invisibility"] then
            return
        end
        SetEntityVisible(PlayerPedId(), false, 0)
        playerInvisibilityCheckbox = true
        ESX.ShowNotification(TranslateCap("notif_invisibility_enabled_self"))
    end, function()
        if not Config.Groups[playerGroup].Access["submenu_personnal.invisibility"] then
            return
        end
        SetEntityVisible(PlayerPedId(), true, 0) 
        playerInvisibilityCheckbox = false
        ESX.ShowNotification(TranslateCap("notif_invisibility_disabled_self"))
    end)
end