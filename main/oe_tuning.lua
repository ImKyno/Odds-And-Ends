local _G       = GLOBAL
local require  = _G.require
local TechTree = require("techtree")

local TOTAL_DAY_TIME = 480
local TOTAL_MAX_HEALTH = 150

TUNING.OE_DEBUG_MODE = true -- Turn this off on Workshop releases!
TUNING.OE_RETROFIT_ENABLED = true

TUNING.OE_LANGUAGE_CODE = GetModConfigData("LANGUAGE") or "en"

TUNING.OE_RESOURCES = 0.06
TUNING.OE_DEFAULT_FLOATER = { "med", nil, 0.65 }

TUNING.OE_DEBUFFS =
{
    FROZEN =
    {
        STACK = 1,
        SLOW = 0.7, -- 30%
        DAMAGE = 0.8, -- 20%
        DURATION = 20,
    },
}

TUNING.OE_FROZEN_TOOL =
{
    HEAT = -10,
    MOISTURE = 6,
    MOISTURE_GROUND = 75,
    PERISH_MULT = 1.25,
    PERISH_MULT_SUMMER = 2.5,
    REFRESH_TICK = 60,
    REFRESH_AMOUNT = 0.05,
    EFFECTIVENESS = 2.5, -- Same as Moon Glass Axe.
    CONSUMPTION = 1.25 / 100,
    DEFAULT_DAMAGE = 27.2,
}

TUNING.OE_FROZEN_TOOL_SHOVEL_DAMAGE = 17
TUNING.OE_FROZEN_TOOL_HAMMER_DAMAGE = 34

TUNING.OE_FROZEN_SWORD =
{
    USES = 100,
    HEAT = -10,
    DAMAGE = 51,
    DAMAGE_WINTER = 75,
    COOLDOWN = 5,
}

TUNING.OE_TRUE_ICE =
{
    HEALTH = 0.5,
    HUNGER = 2.3,
    SANITY = 0,
    REPAIR_AMOUNT = 50,
}