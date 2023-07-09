---main_showContentThisFrame → Function to show the main menu content
---@return void
function main_showContentThisFrame(playerGroup)
    RageUI.ButtonWithStyle("Gestion de mon personnage", nil, {RightLabel = "→"}, Config.Groups[playerGroup].Access["submenu_personnal.access"], function(_, _, _)end)
    RageUI.ButtonWithStyle("Gestion des joueurs", nil, {RightLabel = "→"}, Config.Groups[playerGroup].Access["submenu_players.access"], function(_, _, _)end)
    RageUI.ButtonWithStyle("Gestion des véhicules", nil, {RightLabel = "→"}, Config.Groups[playerGroup].Access["submenu_vehicles.access"], function(_, _, _)end)
    RageUI.ButtonWithStyle("Gestion des reports", nil, {RightLabel = "→"}, Config.Groups[playerGroup].Access["submenu_reports.access"], function(_, _, _)end)
    RageUI.ButtonWithStyle("Gestion du serveur", nil, {RightLabel = "→"}, Config.Groups[playerGroup].Access["submenu_server.access"], function(_, _, _)end)
    RageUI.ButtonWithStyle("~r~Gestion fondateur", nil, {RightLabel = "→"}, Config.Groups[playerGroup].Access["submenu_owner.access"], function(_, _, _)end)
end