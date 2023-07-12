local playerOptionsArray = {
    Translate("players_actions_heal"),
    Translate("players_actions_feed"),
    Translate("players_actions_hydrate"),
    Translate("players_actions_shield")
}
local playerOptionsArrayIndex = 1

---main_personnal_showContentThisFrame → Function to show the main/personnal menu content
---@return void
function main_personnal_showContentThisFrame(playerGroup)
    RageUI.Separator(GetPlayerName(PlayerId()) .. " [" .. Config.Groups[playerGroup].Color .. Config.Groups[playerGroup].Label .. "~s~] - ID: ~r~" .. GetPlayerServerId(PlayerId()))
    RageUI.List(TranslateCap("main_personnal_health_management"), playerOptionsArray, playerOptionsArrayIndex, TranslateCap("main_personnal_health_management_desc"), {}, Config.Groups[playerGroup].Access["submenu_personnal_health_management"], function(_, _, Selected, Index)
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
    RageUI.Checkbox(TranslateCap("main_personnal_godmode"), TranslateCap("main_personnal_godmode_desc"), _threads.godmode.isActivated, {Enabled = Config.Groups[playerGroup].Access["submenu_personnal_godmode"]}, function()end, function()
        if not Config.Groups[playerGroup].Access["submenu_personnal_godmode"] then
            return
        end
        _threads.godmode.enable()
        ESX.ShowNotification(TranslateCap("notif_godmode_enabled_self"))
    end, function()
        if not Config.Groups[playerGroup].Access["submenu_personnal_godmode"] then
            return
        end
        _threads.godmode.disable()
        ESX.ShowNotification(TranslateCap("notif_godmode_disabled_self"))
    end)
    RageUI.Checkbox(TranslateCap("main_personnal_invisibility"), TranslateCap("main_personnal_invisibility_desc"), _threads.invisibility.isActivated, {Enabled = Config.Groups[playerGroup].Access["submenu_personnal_invisibility"]}, function()end, function()
        if not Config.Groups[playerGroup].Access["submenu_personnal_invisibility"] then
            return
        end
        _threads.invisibility.enable()
        ESX.ShowNotification(TranslateCap("notif_invisibility_enabled_self"))
    end, function()
        if not Config.Groups[playerGroup].Access["submenu_personnal_invisibility"] then
            return
        end
        _threads.invisibility.disable()
        ESX.ShowNotification(TranslateCap("notif_invisibility_disabled_self"))
    end)
    RageUI.Checkbox(TranslateCap("main_personnal_fastwalk"), TranslateCap("main_personnal_fastwalk_desc"), _threads.fastwalk.isActivated, {Enabled = Config.Groups[playerGroup].Access["submenu_personnal_fastwalk"]}, function()end, function()
        if not Config.Groups[playerGroup].Access["submenu_personnal_fastwalk"] then
            return
        end
        _threads.fastwalk.enable()
        ESX.ShowNotification(TranslateCap("notif_fastwalk_enabled_self"))
    end, function()
        if not Config.Groups[playerGroup].Access["submenu_personnal_fastwalk"] then
            return
        end
        _threads.fastwalk.disable()
        ESX.ShowNotification(TranslateCap("notif_fastwalk_disabled_self"))
    end)
    RageUI.Checkbox(TranslateCap("main_personnal_fastswim"), TranslateCap("main_personnal_fastswim_desc"), _threads.fastswim.isActivated, {Enabled = Config.Groups[playerGroup].Access["submenu_personnal_fastswim"]}, function()end, function()
        if not Config.Groups[playerGroup].Access["submenu_personnal_fastswim"] then
            return
        end
        _threads.fastswim.enable()
        ESX.ShowNotification(TranslateCap("notif_fastswim_enabled_self"))
    end, function()
        if not Config.Groups[playerGroup].Access["submenu_personnal_fastswim"] then
            return
        end
        _threads.fastswim.disable()
        ESX.ShowNotification(TranslateCap("notif_fastswim_disabled_self"))
    end)
    RageUI.Checkbox(TranslateCap("main_personnal_superjump"), TranslateCap("main_personnal_superjump_desc"), _threads.superjump.isActivated, {Enabled = Config.Groups[playerGroup].Access["submenu_personnal_superjump"]}, function()end, function()
        if not Config.Groups[playerGroup].Access["submenu_personnal_superjump"] then
            return
        end
        _threads.superjump.enable()
        ESX.ShowNotification(TranslateCap("notif_superjump_enabled_self"))
    end, function()
        if not Config.Groups[playerGroup].Access["submenu_personnal_superjump"] then
            return
        end
        _threads.superjump.disable()
        ESX.ShowNotification(TranslateCap("notif_superjump_disabled_self"))
    end)
    RageUI.Checkbox(TranslateCap("main_personnal_stayinvehicle"), TranslateCap("main_personnal_stayinvehicle_desc"), _threads.stayinvehicle.isActivated, {Enabled = Config.Groups[playerGroup].Access["submenu_personnal_stayinvehicle"]}, function()end, function()
        if not Config.Groups[playerGroup].Access["submenu_personnal_stayinvehicle"] then
            return
        end
        _threads.stayinvehicle.enable()
        ESX.ShowNotification(TranslateCap("notif_stayinvehicle_enabled_self"))
    end, function()
        if not Config.Groups[playerGroup].Access["submenu_personnal_stayinvehicle"] then
            return
        end
        _threads.stayinvehicle.disable()
        ESX.ShowNotification(TranslateCap("notif_stayinvehicle_disabled_self"))
    end)
end