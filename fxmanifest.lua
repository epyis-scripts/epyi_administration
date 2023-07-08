fx_version "cerulean"
game "gta5"

name "epyi_administration"
description "A RageUI Administration for ESX Legacy 1.7.5 or newer"
author "Epyi (https://discord.gg/VyRPheG6Es)"
version "1.0.0"

shared_script "@es_extended/imports.lua"

client_scripts {
    "RageUI/RMenu.lua",
    "RageUI/menu/RageUI.lua",
    "RageUI/menu/Menu.lua",
    "RageUI/menu/MenuController.lua",
    "RageUI/components/*.lua",
    "RageUI/menu/elements/*.lua",
    "RageUI/menu/items/*.lua",
    "RageUI/menu/panels/*.lua",
    "RageUI/menu/windows/*.lua",
    "RageUI/menu/Function.lua",
    "client/*.lua"
}

dependencies {
	"es_extended"
}