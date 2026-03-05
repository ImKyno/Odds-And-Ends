local _G          = GLOBAL
local WORLD_TILES = _G.WORLD_TILES

-- A bit of bones, plants and formations.
AddRoom("BGMesa",
{
    colour = { r = 0.30, g = 0.20, b = 0.10, a = 0.30 },
    value  = WORLD_TILES.MESA_NOISE,
    tags   = { "RoadPoison", "ExitPiece" },
    level_set_piece_blocker = true,
    contents =
    {
        distributepercent = 0.15,
        distributeprefabs =
        {
            houndbone         = 0.40,
            marsh_bush        = 0.30,
            flower_withered   = 0.30,
            -- TO DO:
            -- mesa_rock      = 0.60,
            -- mesa_formation = 0.50,
            -- mesa_cactus    = 0.20,
        },
    }
})

-- Lots of rocks and fossils, formations occasionally, no trees and cacti.
AddRoom("MesaRocky", 
{
    colour   = { r = 0.30, g = 0.20, b = 0.10, a = 0.30 },
    value    = WORLD_TILES.MESA_ROCKY,
    tags     = { "RoadPoison", "Astral_1" },
    level_set_piece_blocker = true,
    contents =
    {
        countprefabs =
        {
            rock1 = function() return math.random(3, 5) end,
        },
					                
        distributepercent = 0.10,
        distributeprefabs =
        {
            rock_flintless       = 1.00,
            rock2                = 0.40,
            houndbone            = 0.30,
            -- TO DO:
            -- mesa_rock         = 0.80,
            -- mesa_fossil_beast = 0.60,
            -- mesa_formation    = 0.40,
            -- mesa_cactus       = 0.30,
        },
    }
})

-- Lots of cacti and withered plants, formations occasionally, no trees.
AddRoom("MesaPlains",
{
    colour   = { r = 0.30, g = 0.20, b = 0.10, a = 0.30 },
    value    = WORLD_TILES.MESA_SAND_ORANGE,
    tags     = { "RoadPoison" },
    level_set_piece_blocker = true,
    contents =
    {
        countprefabs =
        {
            -- mesa_cactus = function() return math.random(3, 5) end,
        },

        distributepercent = 0.10,
        distributeprefabs =
        {
            marsh_bush        = 0.50,
            sapling           = 0.40,
            flower_withered   = 0.40,
            -- TO DO:
            -- mesa_cactus    = 0.30,
            -- mesa_formation = 0.20,
        },
    }
})

-- Trees and plants on the outside, empty in the middle.
AddRoom("MesaClearing", 
{
    colour   = { r = 0.30, g = 0.20, b = 0.10, a = 0.30 },
    value    = WORLD_TILES.MESA_SAND_PEACH,
    tags     = { "RoadPoison" },
    level_set_piece_blocker = true,
    contents =
    {			                
        distributepercent = 0.10,
        distributeprefabs =
        {
            -- TO DO: Replace with mesa trees.
            evergreen         = 1.50,
            fireflies         = 1.00,
            marsh_bush        = 0.20,
            houndbone         = 0.10,
            ground_twigs      = 0.05,
            -- TO DO:
            -- mesa_cactus    = 0.30,
            -- mesa_formation = 0.20,
        },
    }
})

-- Lots of trees and plants, formation occasionally, no rocks and fossils.
AddRoom("MesaForest", 
{
    colour   = { r = 0.30, g = 0.20, b = 0.10, a = 0.30 },
    value    = WORLD_TILES.MESA_SAND_PINK,
    tags     = { "RoadPoison", "Astral_2" },
    level_set_piece_blocker = true,
    contents =
    {			                
        distributepercent = 0.20,
        distributeprefabs =
        {
            -- TO DO: Replace with mesa trees.
            trees             = { weight = 3, prefabs = { "evergreen", "evergreen_sparse" } },
            marsh_bush        = 0.40,
            houndbone         = 0.30,
            ground_twigs      = 0.25,
            fireflies         = 0.20,
            -- TO DO:
            -- mesa_cactus    = 0.40,
            -- mesa_formation = 0.20,
        },
    }
})

-- Archeologist's Dig Site Setpiece.
AddRoom("MesaDigSite", 
{
	colour   = { r = 0.30, g = 0.20, b = 0.10, a = 0.30 },
    value    = WORLD_TILES.MESA_SAND_CREAM,
    tags     = { "RoadPoison", "ExitPiece" },
    level_set_piece_blocker = true,
    contents =  
    {
        countprefabs = 
        {
            -- TO DO: Replace with static layout.
            critterlab = 1,
        },
					                
        distributepercent = 0.30,
        distributeprefabs =
        {
            sapling           = 0.70,
            houndbone         = 0.30,
            rock2             = 0.30,
            flint             = 0.20,
            fireflies         = 0.20,
            ground_twigs      = 0.05,
            -- TO DO:
            -- mesa_rock      = 0.60,
            -- mesa_cactus    = 0.30,
            -- mesa_formation = 0.20,
        },
    }
})