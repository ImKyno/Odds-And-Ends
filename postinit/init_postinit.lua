local INIT_PREFABS_POSTINIT =
{
    "player_classified",
}

for _, v in pairs(INIT_PREFABS_POSTINIT) do
    modimport("postinit/prefabs/oe_"..v)
end