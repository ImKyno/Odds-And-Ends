local _G              = GLOBAL
local require         = _G.require
local WORLD_TILES     = _G.WORLD_TILES

local LAYOUT          = _G.LAYOUT
local LAYOUT_POSITION = _G.LAYOUT_POSITION
local LAYOUT_ROTATION = _G.LAYOUT_ROTATION
local PLACE_MASK      = _G.PLACE_MASK
local Layouts         = require("map/layouts").Layouts
local StaticLayout    = require("map/static_layout")