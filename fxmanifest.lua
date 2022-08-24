--[[
--Created Date: Tuesday August 23rd 2022
--Author: JustGod
--Made with ❤
-------
--Last Modified: Tuesday August 23rd 2022 8:38:01 pm
-------
--Copyright (c) 2022 JustGodWork, All Rights Reserved.
--This file is part of JustGodWork project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

fx_version "cerulean"
game "gta5"

author "JustGod"
github "https://github.com/JustGodWork"
description "Library for Scripting created by JustGod"

shared_scripts {
    "lang.lua",
    "Config.lua",
    "dependencies/**/**",
    "shared/**/**"
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "server/**/**"
}

client_scripts {
    "client/**/**",
}

files({
    "lang.lua",
    "import.lua",
    "files/server/**/**",
    "files/client/**/**"
})

dependencies {
    "oxmysql",
    "es_extended"
}