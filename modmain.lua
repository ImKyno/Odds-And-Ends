local _G      = GLOBAL
local require = _G.require

local INIT_STRINGS =
{
    "oe_strings",
    "oe_strings_scrapbook",
}

local INIT_STRINGS_CHARACTERS =
{
    "oe_speech_wilson",
    "oe_speech_willow",
    "oe_speech_wolfgang",
    "oe_speech_wendy",
    "oe_speech_wx78",
    "oe_speech_wickerbottom",
    "oe_speech_woodie",
    "oe_speech_waxwell",
    "oe_speech_wathgrithr",
    "oe_speech_webber",
    "oe_speech_winona",
    "oe_speech_wortox",
    "oe_speech_wormwood",
    "oe_speech_warly",
    "oe_speech_wurt",
    "oe_speech_walter",
    "oe_speech_wanda",
}

for _, v in pairs(INIT_STRINGS) do
    require("strings/"..v)
end

for _, v in pairs(INIT_STRINGS_CHARACTERS) do
    require("strings/characters/"..v)
end

local OE_LANGUAGE = GetModConfigData("LANGUAGE")

if OE_LANGUAGE then
    modimport("scripts/strings/localization_"..OE_LANGUAGE.."/oe_strings_loadingtips")

    for _, v in pairs(INIT_STRINGS) do
        require("strings/localization_"..OE_LANGUAGE.."/"..v)
    end

    for _, v in pairs(INIT_STRINGS_CHARACTERS) do
        require("strings/localization_"..OE_LANGUAGE.."/characters/"..v)
    end
end

modimport("main/init_main")
-- Not to be confused with the above, this is game env instead of mod env.
require("oe_main") -- NEEDS TO BE LOADED AFTER STRINGS AND MAIN IMPORTS.

modimport("postinit/init_postinit")