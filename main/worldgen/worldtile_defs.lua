local _G          = GLOBAL
local require     = _G.require
local WORLD_TILES = _G.WORLD_TILES

-- KYNO:
-- I don't know why but there's a bug when "EnableModError()" is enabled that prevents
-- you from even launching a server with the mod enabled. This seems to solve the issue (?)
if WORLD_TILES.MESA_CRACKED ~= nil then
    return
end

local WALK_DIRT = "dontstarve/movement/walk_dirt"
local RUN_DIRT  = "dontstarve/movement/run_dirt"

local WALK_SAND = "turnoftides/movement/run_pebblebeach"
local RUN_SAND  = "turnoftides/movement/run_pebblebeach"

local RUN_SNOW  = "dontstarve/movement/run_snow"

AddTile("MESA_CRACKED", "LAND",
    {
        -- Internal.
        ground_name   = "Mesa Cracked",
    },
    {
        -- World Tile.
        name          = "cave",
        noise_texture = "levels/textures/mesa_cracked_noise.tex",

        walksound     = WALK_DIRT,
        runsound      = RUN_DIRT,
        snowsound     = RUN_SNOW,

        hard          = true,
        flooring      = false,
        roadways      = false,
    },
    {
        -- Minimap.
        name          = "map_edge",
        noise_texture = "levels/textures/mesa_cracked_mini.tex",
    },
    {
        -- Inventory Item.
        name          = "mesa_cracked",
        anim          = "mesa_cracked",
        bank_build    = "cool_turfs",
        pickupsound   = "rock",
    }
)

AddTile("MESA_ROCKY", "LAND",
    {
        ground_name   = "Mesa Rocky",
    },
    {
        name          = "cave",
        noise_texture = "levels/textures/mesa_rocky_noise.tex",

        walksound     = WALK_DIRT,
        runsound      = RUN_DIRT,
        snowsound     = RUN_SNOW,

        hard          = true,
        flooring      = false,
        roadways      = false,
    },
    {
        name          = "map_edge",
        noise_texture = "levels/textures/mesa_rocky_mini.tex",
    },
    {
        name          = "mesa_rocky",
        anim          = "mesa_rocky",
        bank_build    = "cool_turfs",
        pickupsound   = "rock",
    }
)

AddTile("MESA_SAND_CREAM", "LAND",
    {
        ground_name   = "Mesa Sand Cream",
    },
    {
        name          = "cave",
        noise_texture = "levels/textures/mesa_sand_cream_noise.tex",

        walksound     = WALK_SAND,
        runsound      = RUN_SAND,
        snowsound     = RUN_SNOW,

        hard          = false,
        flooring      = false,
        roadways      = false,
    },
    {
        name          = "map_edge",
        noise_texture = "levels/textures/mesa_sand_cream_mini.tex",
    },
    {
        name          = "mesa_sand_cream",
        anim          = "mesa_sand_cream",
        bank_build    = "cool_turfs",
        pickupsound   = "grainy",
    }
)

AddTile("MESA_SAND_ORANGE", "LAND",
    {
        ground_name   = "Mesa Sand Orange",
    },
    {
        name          = "sand",
        noise_texture = "levels/textures/mesa_sand_orange_noise.tex",

        walksound     = WALK_SAND,
        runsound      = RUN_SAND,
        snowsound     = RUN_SNOW,

        hard          = false,
        flooring      = false,
        roadways      = false,
    },
    {
        name          = "map_edge",
        noise_texture = "levels/textures/mesa_sand_orange_mini.tex",
    },
    {
        name          = "mesa_sand_orange",
        anim          = "mesa_sand_orange",
        bank_build    = "cool_turfs",
        pickupsound   = "grainy",
    }
)

AddTile("MESA_SAND_PEACH", "LAND",
    {
        ground_name   = "Mesa Sand Peach",
    },
    {
        name          = "cave",
        noise_texture = "levels/textures/mesa_sand_peach_noise.tex",

        walksound     = WALK_SAND,
        runsound      = RUN_SAND,
        snowsound     = RUN_SNOW,

        hard          = false,
        flooring      = false,
        roadways      = false,
    },
    {
        name          = "map_edge",
        noise_texture = "levels/textures/mesa_sand_peach_mini.tex",
    },
    {
        name          = "mesa_sand_peach",
        anim          = "mesa_sand_peach",
        bank_build    = "cool_turfs",
        pickupsound   = "grainy",
    }
)

AddTile("MESA_SAND_PINK", "LAND",
    {
        ground_name   = "Mesa Sand Pink",
    },
    {
        name          = "sand",
        noise_texture = "levels/textures/mesa_sand_pink_noise.tex",

        walksound     = WALK_SAND,
        runsound      = RUN_SAND,
        snowsound     = RUN_SNOW,

        hard          = false,
        flooring      = false,
        roadways      = false,
    },
    {
        name          = "map_edge",
        noise_texture = "levels/textures/mesa_sand_pink_mini.tex",
    },
    {
        name          = "mesa_sand_pink",
        anim          = "mesa_sand_pink",
        bank_build    = "cool_turfs",
        pickupsound   = "grainy",
    }
)

-- Used to pick random turfs. Check worldtile_noise.lua for more details.
AddTile("MESA_NOISE", "NOISE")

ChangeTileRenderOrder(WORLD_TILES.DESERT_DIRT,      WORLD_TILES.MESA_CRACKED,     true)
ChangeTileRenderOrder(WORLD_TILES.MESA_CRACKED,     WORLD_TILES.MESA_ROCKY,       true)
ChangeTileRenderOrder(WORLD_TILES.MESA_ROCKY,       WORLD_TILES.MESA_SAND_CREAM,  true)
ChangeTileRenderOrder(WORLD_TILES.MESA_SAND_CREAM,  WORLD_TILES.MESA_SAND_ORANGE, true)
ChangeTileRenderOrder(WORLD_TILES.MESA_SAND_ORANGE, WORLD_TILES.MESA_SAND_PEACH,  true)
ChangeTileRenderOrder(WORLD_TILES.MESA_SAND_PEACH,  WORLD_TILES.MESA_SAND_PINK,   true)