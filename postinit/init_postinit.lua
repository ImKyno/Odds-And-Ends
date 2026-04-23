local INIT_POSTINIT_WIDGETS =
{
    "inventorybar",
}

for _, v in pairs(INIT_POSTINIT_WIDGETS) do
    modimport("postinit/widgets/oe_"..v)
end

local INIT_POSTINIT_PREFABS =
{
    "ancienttrees",
    "cave_banana_tree",
    "deciduoustrees",
    "driftwood_trees",
    "evergreens",
    "leif",
    "livingtree",
    "marsh_tree",
    "moontree",
    "mushtree",
    "oceantree_pillar",
    "oceantree",
    "palmconetree",
    "watertree_root",

    "player_classified",
}

for _, v in pairs(INIT_POSTINIT_PREFABS) do
    modimport("postinit/prefabs/oe_"..v)
end

-- Mod Support.
local INIT_POSTINIT_MODS =
{
    cherryforest     = TUNING.OE_CHERRY_FOREST_ENABLED,
    heapoffoods      = TUNING.OE_HEAP_OF_FOODS_ENABLED,
    islandadventures = TUNING.OE_ISLAND_ADVENTURES_ENABLED and TUNING.OE_ISLAND_ADVENTURES_CORE_ENABLED,
}

for mod, isenabled in pairs(INIT_POSTINIT_MODS) do
    if isenabled then
        modimport("postinit/mods/oe_"..mod)
    end
end

-- Load independently if people have it or not.
local INIT_POSTINIT_MODS_ALWAYS =
{
    "shinyloots", -- This needs to load after the Scrapbook!
}

for _, v in pairs(INIT_POSTINIT_MODS_ALWAYS) do
    modimport("postinit/mods/oe_"..v)
end