local _G          = GLOBAL
local WORLD_TILES = _G.WORLD_TILES

AddRoom("BGMesa",
{
    colour   = { r = 0.3, g = 0.2, b = 0.1, a= 0.3 },
    value    = WORLD_TILES.MESA_CRACKED,
    tags     = { "RoadPoison", "CharlieStage_Spawner" },
    contents =
    {
        distributepercent = 0.07,
        distributeprefabs =
        {
            marsh_bush        = 0.05,
            marsh_tree        = 0.20,
            rock_flintless    = 1.00,
            grass             = 0.10,
            houndbone         = 0.20,
            tumbleweedspawner = 0.05,
        },
    }
})

AddRoom("MesaPlains",
{
    colour   = { r = 0.3, g = 0.2, b = 0.1, a = 0.3 },
    value    = WORLD_TILES.MESA_CRACKED,
    tags     = { "RoadPoison" },
    contents =
    {
        distributepercent = 0.05,
        distributeprefabs =
        {
            marsh_bush        = 0.80,
            sapling           = 0.50,
            succulent_plant   = 0.30,
            tumbleweedspawner = 0.10,
        },
    }
})