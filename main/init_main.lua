local INIT_MAIN =
{
    "oe_assets",
    "oe_prefabs",
    "oe_tuning",
    "oe_cooking",
    "oe_scrapbook",
}

local INIT_MAIN_MODS =
{
    "oe_shinyloots", -- This needs to load after the Scrapbook!
}

for _, v in pairs(INIT_MAIN) do
	modimport("main/"..v)
end

for _, v in pairs(INIT_MAIN_MODS) do
    modimport("main/mods/"..v)
end