local _G = GLOBAL

local INIT_MAIN =
{
    "assets",
    "prefabs",
    "tuning",
    "cooking",
    "scrapbook",
}

for _, v in pairs(INIT_MAIN) do
	modimport("main/oe_"..v)
end

-- Accessories Equipslot.
_G.EQUIPSLOTS.OE_ACCESSORY = "oe_accessory"