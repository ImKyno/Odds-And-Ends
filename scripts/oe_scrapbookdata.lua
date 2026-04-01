local oe_scrapbookdata =
{
    oe_treasurebag_deerclops =
    {
        name           = "deerclops", -- Using the giant's name for better organisation.
        speechname     = "oe_treasurebag",
        type           = "item",
        subcat         = "treasurebag",
        bank           = "oe_treasurebags",
        build          = "oe_treasurebags",
        anim           = "idle",
        overridesymbol = { "swap_bag", "oe_treasurebags", "deerclops" },
        deps           = { "deerclops" },
        specialinfo    = "TREASUREBAG",
    },
}

for k, v in pairs(oe_scrapbookdata) do
    v.name   = v.name   or k
    v.prefab = v.prefab or k
    v.tex    = v.tex    or k..".tex"
end

return oe_scrapbookdata