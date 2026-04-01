local INIT_MAIN =
{
    "oe_assets",
    "oe_prefabs",
    "oe_tuning",
    "oe_scrapbook",
}

for _, v in pairs(INIT_MAIN) do
	modimport("main/"..v)
end