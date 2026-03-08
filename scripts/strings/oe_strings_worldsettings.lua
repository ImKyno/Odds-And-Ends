--[[
    WARNING FOR LOCALIZATION:
	
    * DON'T COPY THIS FILE TO YOUR LOCALIZATION FOLDER!

    * This is separated from the other localization files 
    because it needs to load for both client and server. 
	
    * For some fucking reason LOC can't be GLOBAL server-side
    but it needs to be GLOBAL while client-side. I don't know 
    how to switch between them while initializating the world.
	
    * If we load both strings and oe_worldsettings.lua from client
    we can't apply any changes to worldgen. And if we load both
    strings and oe_worldsettings.lua from server, we will crash.
]]--

-- Common Dependencies.
local _G      = GLOBAL
local require = _G.require
local STRINGS = _G.STRINGS
local locale  = _G.LOC.GetLocaleCode()

modimport("main/oe_tuning")

local function ChooseTranslationTable(tbl)
    return tbl[locale] or tbl[1]
end

local STRINGS_CUSTOMIZATION =
{
    -- WORLDGEN.
    {

    },

    -- WORLDSETTINGS.
    {

    },
}

-- TODO: Main Menu world customization.
-- AddCustomizeGroup(_G.LEVELCATEGORY.WORLDGEN, "oe_worldgen", ChooseTranslationTable(STRINGS_CUSTOMIZATION.WORLDGEN), nil, nil, 11)
-- AddCustomizeGroup(_G.LEVELCATEGORY.SETTINGS, "oe_settings", ChooseTranslationTable(STRINGS_CUSTOMIZATION.SETTINGS), nil, nil, 11)

local function OEChooseTranslationTable()
    -- Try to load strings if we have the localization files.
    local ok, strings = _G.pcall(require, "strings/localization_" .. locale .. "/oe_strings_customizations")

    if ok and strings then
        return strings
    end

    -- Fallback to english if we don't have them.
    local ok2, fallback = _G.pcall(require, "strings/oe_strings_customizations")
	
    if ok2 and fallback then
        return fallback
    end

    -- HOW DID WE GET HERE? Fallback if even english can't be loaded.
    print("Odds and Ends Mod - Failed to load World Settings Localization!")
    return {}
end

-- OEChooseTranslationTable()