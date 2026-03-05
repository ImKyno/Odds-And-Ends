local _G          = GLOBAL
local LOCKS       = _G.LOCKS
local KEYS        = _G.KEYS
local WORLD_TILES = _G.WORLD_TILES

AddTask("Mesa", 
{
    locks           = { LOCKS.MESA },
    keys_given      = { KEYS.MESA  },
    room_choices    = 
    {
        ["MesaPlains"] = math.random(1, 3)
    },
    room_bg         = WORLD_TILES.MESA_CRACKED,
    background_room = "BGMesa",
    colour          = { r = 0, g = 0, b = 0, a = 0 }
})