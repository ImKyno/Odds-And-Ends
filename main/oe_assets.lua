-- Common Dependencies.
local _G              = GLOBAL
local require         = _G.require
local resolvefilepath = _G.resolvefilepath

Assets =
{
    Asset("ANIM", "anim/oe_turfs.zip"),

    Asset("IMAGE", "images/oe_minimapimages.tex"),
    Asset("ATLAS", "images/oe_minimapimages.xml"),

    Asset("IMAGE", "images/oe_inventoryimages.tex"),
    Asset("ATLAS", "images/oe_inventoryimages.xml"),
    Asset("ATLAS_BUILD", "images/oe_inventoryimages.xml", 256),
}

-- Minimap Icons.
AddMinimapAtlas("images/oe_minimapimages.xml")

local OE_ICONS =
{
    "oe_mesa_clay",
}

for k, v in pairs(OE_ICONS) do
    RegisterInventoryItemAtlas("images/oe_inventoryimages.xml", v..".tex")
end

-- Hack for mod items not appearing in Mini Signs.
local _GetInventoryItemAtlas = _G.GetInventoryItemAtlas
_G.GetInventoryItemAtlas = function(name, ...)
    local myatlas = resolvefilepath("images/oe_inventoryimages.xml")

    if _G.TheSim:AtlasContains(myatlas, name) then
        return myatlas
    end

    return _GetInventoryItemAtlas(name, ...)
end