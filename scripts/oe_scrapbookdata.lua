--[[
    -- Perishable References.
    TUNING.PERISH_SUPERFAST  = 1440  - 3  DAYS
    TUNING.PERISH_FAST       = 2880  - 6  DAYS
    TUNING.PERISH_FASTISH    = 3840  - 8  DAYS
    TUNING.PERISH_MED        = 4800  - 10 DAYS
    TUNING.PERISH_SLOW       = 7200  - 15 DAYS
    TUNING.PERISH_PRESERVED  = 9600  - 20 DAYS
    TUNING.PERISH_SUPERSLOW  = 19200 - 40 DAYS
    TUNING.RABBIT_PERISHTIME = 2400  - 5  DAYS

    -- Fuel References.
    TUNING.TINY_FUEL      = 7.5
    TUNING.SMALL_FUEL     = 15
    TUNING.MED_FUEL       = 45
    TUNING.MED_LARGE_FUEL = 90
    TUNING.LARGE_FUEL     = 180
    TUNING.HUGE_FUEL      = 270
]]--

local oe_scrapbookdata =
{
    -- Tools, Weapons, etc.
    oe_frozen_tool_axe =
    {
        type           = "item",
        subcat         = "tool",
        weapondamage   = TUNING.OE_FROZEN_TOOL.DAMAGE.DEFAULT,
        perishable     = TUNING.PERISH_FAST,
        toolactions    = { "CHOP" },
        bank           = "axe",
        build          = "axe",
        anim           = "idle",
        deps           = { "oe_treasurebag_deerclops" },
        specialinfo    = "OE_FROZEN_TOOL",
    },

    oe_frozen_tool_pickaxe =
    {
        type           = "item",
        subcat         = "tool",
        weapondamage   = TUNING.OE_FROZEN_TOOL.DAMAGE.DEFAULT,
        perishable     = TUNING.PERISH_FAST,
        toolactions    = { "MINE" },
        bank           = "pickaxe",
        build          = "pickaxe",
        anim           = "idle",
        deps           = { "oe_treasurebag_deerclops" },
        specialinfo    = "OE_FROZEN_TOOL",
    },

    oe_frozen_tool_shovel =
    {
        type           = "item",
        subcat         = "tool",
        weapondamage   = TUNING.OE_FROZEN_TOOL.DAMAGE.SHOVEL,
        perishable     = TUNING.PERISH_FAST,
        toolactions    = { "DIG" },
        bank           = "shovel",
        build          = "shovel",
        anim           = "idle",
        deps           = { "oe_treasurebag_deerclops" },
        specialinfo    = "OE_FROZEN_TOOL",
    },

    oe_frozen_tool_hammer =
    {
        type           = "item",
        subcat         = "tool",
        weapondamage   = TUNING.OE_FROZEN_TOOL.DAMAGE.HAMMER,
        perishable     = TUNING.PERISH_FAST,
        toolactions    = { "HAMMER" },
        bank           = "oe_hammer",
        build          = "swap_oe_hammer",
        anim           = "idle",
        deps           = { "oe_treasurebag_deerclops" },
        specialinfo    = "OE_FROZEN_HAMMER",
    },

    oe_frozen_sword =
    {
        type           = "item",
        subcat         = "weapon",
        weapondamage   = "55-75",
        finiteuses     = TUNING.OE_FROZEN_SWORD.USES,
        bank           = "oe_frozen_sword",
        build          = "oe_frozen_sword",
        anim           = "idle",
        animoffsety    = 30,
        animoffsetbgx  = -10,
        animoffsetbgy  = -60,
        deps           = { "oe_treasurebag_deerclops" },
        specialinfo    = "OE_FROZEN_SWORD",
    },

    -- Accessories.
    oe_accessory_blood_claw =
    {
        type           = "item",
        subcat         = "oe_accessory",
        dapperness     = -TUNING.DAPPERNESS_TINY,
        bank           = "oe_accessories",
        build          = "oe_accessories",
        anim           = "idle",
        overridesymbol = { "accessory", "oe_accessories", "blood_claw" },
        specialinfo    = "OE_ACCESSORY_BLOOD_CLAW",
    },

    oe_accessory_boots_moose =
    {
        type           = "item",
        subcat         = "oe_accessory",
        bank           = "oe_accessories",
        build          = "oe_accessories",
        anim           = "idle",
        overridesymbol = { "accessory", "oe_accessories", "boots_moose" },
     -- deps           = { "oe_treasurebag_moose" },
        specialinfo    = "OE_ACCESSORY_BOOTS_MOOSE",
    },

    oe_accessory_burnt_skull =
    {
        type           = "item",
        subcat         = "oe_accessory",
        dapperness     = -TUNING.DAPPERNESS_TINY,
        bank           = "oe_accessories",
        build          = "oe_accessories",
        anim           = "idle",
        overridesymbol = { "accessory", "oe_accessories", "burnt_skull" },
        specialinfo    = "OE_ACCESSORY_BURNT_SKULL",
    },

    oe_accessory_luck_clover =
    {
        type           = "item",
        subcat         = "oe_accessory",
        dapperness     = TUNING.DAPPERNESS_TINY,
        bank           = "oe_accessories",
        build          = "oe_accessories",
        anim           = "idle",
        overridesymbol = { "accessory", "oe_accessories", "luck_clover" },
        specialinfo    = "OE_ACCESSORY_LUCK_CLOVER",
    },

    oe_accessory_luck_dice =
    {
        type           = "item",
        subcat         = "oe_accessory",
        bank           = "oe_accessories",
        build          = "oe_accessories",
        anim           = "idle",
        overridesymbol = { "accessory", "oe_accessories", "luck_dice" },
        specialinfo    = "OE_ACCESSORY_LUCK_DICE",
    },

    -- Treasure Bags.
    oe_treasurebag_deerclops =
    {
        name           = "deerclops", -- Using the giant's name for better organisation.
        speechname     = "oe_treasurebag",
        type           = "item",
        subcat         = "oe_treasurebag",
        bank           = "oe_treasurebags",
        build          = "oe_treasurebags",
        anim           = "idle",
        overridesymbol = { "swap_bag", "oe_treasurebags", "deerclops" },
        deps           = { "deerclops" },
        specialinfo    = "OE_TREASUREBAG",
    },
}

for k, v in pairs(oe_scrapbookdata) do
    v.name   = v.name   or k
    v.prefab = v.prefab or k
    v.tex    = v.tex    or k..".tex"
end

return oe_scrapbookdata