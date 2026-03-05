local _G          = GLOBAL
local LOCKS       = _G.LOCKS
local KEYS        = _G.KEYS
local WORLD_TILES = _G.WORLD_TILES

AddTask("Mesa", 
{
    locks           = { LOCKS.MESA },
    keys_given      = { KEYS.NONE },
    room_choices    = 
    {
        ["MesaDigSite"]  = 1, -- Archeologist's Dig Site Setpiece.
        ["MesaRocky"]    = function() return 1 + math.random(3) end,
        ["MesaForest"]   = function() return 1 + math.random(2) end,
        ["MesaClearing"] = function() return 1 + math.random(1) end,
    },
    room_bg         = WORLD_TILES.ROCKY,
    background_room = "BGMesa",
    colour          = { r = 0, g = 0, b = 0, a = 0 }
})