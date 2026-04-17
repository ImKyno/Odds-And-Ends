local TreasureBagsUtil = {}

-- These are registered in prefabs/oe_treasurebags.lua
TreasureBagsUtil.LootKey =
{
    deerclops =
    {
        guaranteed =
        {
            { prefab = "ice", min = 1, max = 10 },
            { prefab = "krampus_sack" },
        },

        chance =
        {
            { prefab = "goldnugget", chance = 0.75, min = 1, max = 5 },
            { prefab = "bluegem",    chance = 0.50, min = 1, max = 5 },
        },
    },
}

return TreasureBagsUtil