local _G           = GLOBAL
local require      = _G.require
local InventoryBar = require("widgets/inventorybar")

AddClassPostConstruct("widgets/inventorybar", function(self, owner)
    self:AddEquipSlot(_G.EQUIPSLOTS.OE_ACCESSORY, "images/oe_hud.xml", "oe_equipslot_accessory.tex")
end)

local _Rebuild = InventoryBar.Rebuild
function InventoryBar:Rebuild(...)
    if _Rebuild then
        _Rebuild(self, ...)
    end

    local bg_w, bg_h = self.bg:GetLooseScale()

    if bg_w and self.equipslotinfo then
        local scale = TUNING.OE_EQUIPSLOTS_RESCALE - (0.02 * (#self.equipslotinfo - 4))

        self.bg:SetScale(bg_w + scale, bg_h)
        self.bgcover:SetScale(bg_w + scale, bg_h)
    end
end