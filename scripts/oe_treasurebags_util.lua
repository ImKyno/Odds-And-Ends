local TreasureBagsUtil = {} -- Other mods can edit the tables below by importing this file.

-- These are registered in prefabs/oe_treasurebags.lua
TreasureBagsUtil.LootKey =
{
    deerclops =
    {
        guaranteed =
        {
            { prefab = "bluegem",          min = 2, max = 5 },
            { prefab = "oe_true_ice",      min = 3, max = 6 },
            { prefab = "oe_frozen_sword"                    },
         -- { prefab = "oe_trinket_token", min = 1, max = 3 },
        },

        oneof =
        {
            { prefab = "oe_frozen_tool_axe"     },
            { prefab = "oe_frozen_tool_pickaxe" },
            { prefab = "oe_frozen_tool_shovel"  },
        },

        chance =
        {
            { prefab = "oe_frozen_tool_hammer", chance = 0.65                   },
         -- { prefab = "oe_trinket_snowman",    chance = 0.33                   },
         -- { prefab = "oe_trinket_snowglobe",  chance = 0.33                   },
         -- { prefab = "oe_heatrock_cold",      chance = 0.05                   },
        },
    },
}

return TreasureBagsUtil