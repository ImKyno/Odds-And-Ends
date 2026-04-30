local _G       = GLOBAL
local require  = _G.require
local TechTree = require("techtree")

local TOTAL_DAY_TIME = 480
local TOTAL_MAX_HEALTH = 150

TUNING.OE_DEBUG_MODE = true -- Turn this off on Workshop releases!
TUNING.OE_RETROFIT_ENABLED = true

TUNING.OE_LANGUAGE_CODE = GetModConfigData("LANGUAGE") or "en"

TUNING.OE_HEAP_OF_FOODS_ENABLED = _G.KnownModIndex:IsModEnabled("workshop-2334209327")
TUNING.OE_CHERRY_FOREST_ENABLED = _G.KnownModIndex:IsModEnabled("workshop-1289779251")
TUNING.OE_ISLAND_ADVENTURES_ENABLED = _G.KnownModIndex:IsModEnabled("workshop-1467214795")
TUNING.OE_ISLAND_ADVENTURES_CORE_ENABLED = _G.KnownModIndex:IsModEnabled("workshop-3435352667")

TUNING.OE_RESOURCES = 0.06
TUNING.OE_DEFAULT_FLOATER = { "med", nil, 0.65 }
TUNING.OE_EQUIPSLOTS_RESCALE = 0.06

TUNING.OE_DEBUFFS =
{
    FROZEN =
    {
        STACK = 1,
        SLOW = 0.7, -- 30%
        DAMAGE = 0.7,
        DURATION = 20,
    },
}

TUNING.OE_ACCESSORIES =
{
    BOOTS_MOOSE =
    {
        MOISTURE_THRESHOLD = 50,
        SPEEDMULT = 1.25, -- Same as Walking Cane.
    },

    BURNT_SKULL =
    {
        MODIFIER = 1,
    },

    -- Unused.
    WOOD_TOTEM =
    {
        LOG_AMOUNT = 6,
        CHARCOAL_AMOUNT = 3,
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
    DAMAGE =
    {
        DEFAULT = 27.2,
        HAMMER = 34,
        SHOVEL = 17,
    }
}

TUNING.OE_FROZEN_SWORD =
{
    USES = 100,
    HEAT = -10,
    COOLDOWN = 5,
    DAMAGE =
    {
        NORMAL = 55,
        WINTER = 75,
    },
}

TUNING.OE_TRUE_ICE =
{
    HEALTH = 0.5,
    HUNGER = 2.3,
    SANITY = 0,
    REPAIR_AMOUNT =
    {
        FINITEUSES = 50,
        PERISH = 0.25,
    },
}

TUNING.OE_POWDER_WEAPON =
{
    RANGE =
    {
        MIN = 10,
        MAX = 20,
    },
}

TUNING.OE_POWDER_WEAPON_AMMO =
{
    HUNGER = 5,
    SPEED = 50,
    RANGE = 50,
    DIST = 1.5,
    COOLDOWN = 5,
    TIMEOUT = 20,

    DAMAGE =
    {
        GUNPOWDER = 300,
        INFINITE = 100,
    },

    CRIT =
    {
        GUNPOWDER = 
        {
            CHANCE = 0.30,
            MODIFIER = 1.5,
        },
        
        INFINITE =
        {
            CHANCE = 0.10,
            MODIFIER = 1,
        },
    },
}