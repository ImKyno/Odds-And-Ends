local AccessoriesUtil = {}

-- Wood Totem --
-- Drop more logs and charcoal based on each tree type and its current stage.
-- NOTE: The accessory does not work for Stumps, Old Stage and Festive Tree Planter.
AccessoriesUtil.WoodTotemBonusLog =
{
    -- 1 Stage.
    livingtree_halloween        = { 1 },
    livingtree                  = { 2 },
    marsh_tree                  = { 2 },
    mushtree_small              = { 2 },
    mushtree_medium             = { 2 },
    mushtree_tall               = { 2 },
    mushtree_tall_webbed        = { 2 },
    mushtree_moon               = { 2 },
    cave_banana_tree            = { 2 },
    ancienttree_nightvision     = { 2 },
    oceantree_pillar            = { 9 },
    watertree_root              = { 2 },
    driftwood_small1            = { 2 },
    driftwood_small2            = { 2 },
    driftwood_tall              = { 3 },

    -- 3 Stages.
    evergreen                   = { 1, 2, 3 },
    evergreen_sparse            = { 1, 2, 3 },
    deciduoustree               = { 1, 2, 3 },
    twiggytree                  = { 1, 2, 3 },
    moon_tree                   = { 2, 3, 4 },
    palmconetree                = { 2, 3, 4 },
    oceantree                   = { 4, 6, 8 },

    -- Treeguards
    leif                        = { 3 },
    leif_sparse                 = { 3 },

    -- Heap of Foods Mod Trees.
    kyno_sugartree_short        = { 1 },
    kyno_sugartree_normal       = { 2 },
    kyno_sugartree              = { 3 },
    kyno_meadowisland_pikotree  = { 3 },
    kyno_meadowisland_tree      = { 1, 2, 3 },
    kyno_kokonuttree            = { 1, 2, 3 },
}

return AccessoriesUtil