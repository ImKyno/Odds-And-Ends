local _G       = GLOBAL
local require  = _G.require
local TechTree = require("techtree")

local TOTAL_DAY_TIME = 480

TUNING.OE_DEBUG_MODE = true -- Turn this off on Workshop releases!
TUNING.OE_RETROFIT_ENABLED = true

TUNING.OE_LANGUAGE_CODE = GetModConfigData("LANGUAGE") or "en"

TUNING.OE_RESOURCES = .06
TUNING.OE_FLOATER = { "med", nil, 0.65 }

TUNING.OE_MESA_CACTUS_DAMAGE = 3
TUNING.OE_MESA_CACTUS_SMALL_REGROW_TIME = TOTAL_DAY_TIME * 3

TUNING.OE_MESA_ROCK_CLAY_WORKLEFT = 6