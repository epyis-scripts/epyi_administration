---main_showContentThisFrame → Function to show the main menu content
---@return void
function main_showContentThisFrame()
    RageUI.ButtonWithStyle("Gestion de mon personnage", nil, {}, true, function(_, _, _)end)
    RageUI.ButtonWithStyle("Gestion des joueurs", nil, {}, true, function(_, _, _)end)
    RageUI.ButtonWithStyle("Gestion des véhicules", nil, {}, true, function(_, _, _)end)
    RageUI.ButtonWithStyle("Gestion des reports", nil, {}, true, function(_, _, _)end)
    RageUI.ButtonWithStyle("Gestion du serveur", nil, {}, true, function(_, _, _)end)
    RageUI.ButtonWithStyle("~r~Gestion fondateur", nil, {}, true, function(_, _, _)end)
end