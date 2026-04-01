local _G       = GLOBAL
local require  = _G.require
local TechTree = require("techtree")

local TOTAL_DAY_TIME = 480

TUNING.OE_DEBUG_MODE = true -- Turn this off on Workshop releases!
TUNING.OE_RETROFIT_ENABLED = true

TUNING.OE_LANGUAGE_CODE = GetModConfigData("LANGUAGE") or "en"

TUNING.OE_RESOURCES = .06
TUNING.OE_FLOATER = { "med", nil, 0.65 }

-- These are registered in oe_treasurebags.lua
TUNING.OE_TREASUREBAGSLOOT =
{
    deerclops =
    {
        guaranteed =
        {
            { prefab = "ice", min = 1, max = 10 },
            { prefab = "krampus_sack" },
        },

        chance =
        {
            { prefab = "goldnugget", chance = 0.75, min = 1, max = 5 },
            { prefab = "bluegem",    chance = 0.50, min = 1, max = 5 },
        },
    },
}