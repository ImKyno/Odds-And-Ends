local _G      = GLOBAL
local require = _G.require

local INIT_STRINGS =
{
    "strings",
    "strings_scrapbook",
}

for _, v in pairs(INIT_STRINGS) do
    require("strings/oe_"..v)
end

local INIT_STRINGS_CHARACTERS =
{
    "wilson",
    "willow",
    "wolfgang",
    "wendy",
    "wx78",
    "wickerbottom",
    "woodie",
    "waxwell",
    "wathgrithr",
    "webber",
    "winona",
    "wortox",
    "wormwood",
    "warly",
    "wurt",
    "walter",
    "wanda",
}

for _, v in pairs(INIT_STRINGS_CHARACTERS) do
    require("strings/characters/oe_speech_"..v)
end

local OE_LANGUAGE = GetModConfigData("LANGUAGE")

if OE_LANGUAGE then
    modimport("scripts/strings/localization_"..OE_LANGUAGE.."/oe_strings_loadingtips")

    for _, v in pairs(INIT_STRINGS) do
        require("strings/localization_"..OE_LANGUAGE.."/oe_"..v)
    end

    for _, v in pairs(INIT_STRINGS_CHARACTERS) do
        require("strings/localization_"..OE_LANGUAGE.."/characters/oe_speech_"..v)
    end
end

modimport("main/init_main")
-- Not to be confused with the above, this is game env instead of mod env.
require("oe_main") -- NEEDS TO BE LOADED AFTER STRINGS AND MAIN IMPORTS.

modimport("postinit/init_postinit")