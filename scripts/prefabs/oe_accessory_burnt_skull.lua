local assets =
{
    -- Asset("ANIM", "anim/oe_accessory_burnt_skull.zip"),
    Asset("ANIM", "anim/torso_dragonfly.zip"),

    Asset("IMAGE", "images/oe_inventoryimages.tex"),
    Asset("ATLAS", "images/oe_inventoryimages.xml"),
    Asset("ATLAS_BUILD", "images/oe_inventoryimages.xml", 256),
}

local MODIFIER = TUNING.OE_ACCESSORIES.BURNT_SKULL.MODIFIER

local function OnEquip(inst, owner)
    if owner ~= nil and owner.components.health ~= nil then
        owner.components.health.externalfiredamagemultipliers:SetModifier(inst, 1 - MODIFIER)
    end
end

local function OnUnequip(inst, owner)
    if owner ~= nil and owner.components.health ~= nil then
        owner.components.health.externalfiredamagemultipliers:RemoveModifier(inst)
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)

    inst.AnimState:SetBank("torso_dragonfly")
    inst.AnimState:SetBuild("torso_dragonfly")
    inst.AnimState:PlayAnimation("anim")

    inst:AddTag("oe_accessory")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:ChangeImageName("baconeggs")

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.OE_ACCESSORY
    inst.components.equippable.dapperness = TUNING.DAPPERNESS_TINY
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("oe_accessory_burnt_skull", fn, assets)
