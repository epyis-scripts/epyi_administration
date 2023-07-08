-- Variables initialization
-- # → init some local variables
local isAdminMenuOpened = false

-- RageUI menu initialization
-- # → init the rageui menu with the config parameters
RMenu.Add("epyi_administration", "main", RageUI.CreateMenu(Title, Subtitle, X, Y, TextureDictionary, TextureName, R, G, B, A))