local assets =
{
    -- Asset("ANIM", "anim/oe_accessory_boots_moose.zip"),
    Asset("ANIM", "anim/torso_dragonfly.zip"),

    Asset("IMAGE", "images/oe_inventoryimages.tex"),
    Asset("ATLAS", "images/oe_inventoryimages.xml"),
    Asset("ATLAS_BUILD", "images/oe_inventoryimages.xml", 256),
}

local function OnEquip(inst, owner)
    if owner ~= nil then
        owner:AddTag("luckywoodcutter")
    end
end

local function OnUnequip(inst, owner)
    if owner ~= nil then
        owner:RemoveTag("luckywoodcutter")
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddFollower()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)

    inst.AnimState:SetBank("oe_accessories")
    inst.AnimState:SetBuild("oe_accessories")
    inst.AnimState:PlayAnimation("idle")

    inst.AnimState:OverrideSymbol("accessory", "oe_accessories", "wood_totem")

    inst:AddTag("oe_accessory")
    inst:AddTag("furnituredecor")

    inst.pickupsound = "wood"

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst:AddComponent("furnituredecor")

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.OE_ACCESSORY
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("oe_accessory_wood_totem", fn, assets)