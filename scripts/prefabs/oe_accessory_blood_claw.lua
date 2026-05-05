local assets =
{
    Asset("ANIM", "anim/oe_accessories.zip"),

    Asset("IMAGE", "images/oe_inventoryimages.tex"),
    Asset("ATLAS", "images/oe_inventoryimages.xml"),
    Asset("ATLAS_BUILD", "images/oe_inventoryimages.xml", 256),
}

local function OnKilled(owner, data)
    local victim = data ~= nil and data.victim or nil

    if victim ~= nil and not victim:HasAnyTag(NON_LIFEFORM_TARGET_TAGS) or victim:HasTag("lifedrainable") then
        if owner ~= nil and owner.components.health ~= nil then
            owner.components.health:DoDelta(TUNING.OE_ACCESSORIES.BLOOD_CLAW.HEAL_AMOUNT, nil, "oe_accessories_blood_claw")
        end
    end
end

local function OnEquip(inst, owner)
    if owner ~= nil then
        inst:ListenForEvent("killed", OnKilled, owner)
    end
end

local function OnUnequip(inst, owner)
    if owner ~= nil then
        inst:RemoveEventCallback("killed", OnKilled, owner)
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

    inst.AnimState:OverrideSymbol("accessory", "oe_accessories", "blood_claw")

    inst:AddTag("oe_accessory")
    inst:AddTag("furnituredecor")

    inst.pickupsound = "rock"

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst:AddComponent("furnituredecor")

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.OE_ACCESSORY
    inst.components.equippable.dapperness = -TUNING.DAPPERNESS_TINY
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("oe_accessory_blood_claw", fn, assets)