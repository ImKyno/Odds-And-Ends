local INIT_WIDGETS_POSTINIT =
{
    "inventorybar",
}

for _, v in pairs(INIT_WIDGETS_POSTINIT) do
    modimport("postinit/widgets/oe_"..v)
end

local INIT_PREFABS_POSTINIT =
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

for _, v in pairs(INIT_PREFABS_POSTINIT) do
    modimport("postinit/prefabs/oe_"..v)
end