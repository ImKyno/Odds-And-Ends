local assets =
{
    -- Asset("ANIM", "anim/oe_accessory_boots_moose.zip"),
    Asset("ANIM", "anim/torso_dragonfly.zip"),

    Asset("IMAGE", "images/oe_inventoryimages.tex"),
    Asset("ATLAS", "images/oe_inventoryimages.xml"),
    Asset("ATLAS_BUILD", "images/oe_inventoryimages.xml", 256),
}

local THRESHOLD = TUNING.OE_ACCESSORIES.BOOTS_MOOSE.MOISTURE_THRESHOLD
local SPEEDMULT = TUNING.OE_ACCESSORIES.BOOTS_MOOSE.SPEEDMULT

local function ShouldHaveBonus(owner)
    return TheWorld.state.israining
    or (owner.components.moisture ~= nil and owner.components.moisture:GetMoisture() >= THRESHOLD)
end

local function UpdateSpeed(inst, owner)
    if owner == nil then
        return
    end

    if ShouldHaveBonus(owner) then
        inst.components.equippable.walkspeedmult = SPEEDMULT
    else
        inst.components.equippable.walkspeedmult = 1
    end
end

local function OnMoistureDelta(owner, data)
    if owner._boots ~= nil then
        UpdateSpeed(owner._boots, owner)
    end
end

local function OnRainChange(inst, israining)
    local owner = inst.components.inventoryitem.owner
    if owner ~= nil then
        UpdateSpeed(inst, owner)
    end
end

local function OnEquip(inst, owner)
    owner._boots = inst

    if owner.components.moisture ~= nil then
        inst:ListenForEvent("moisturedelta", OnMoistureDelta, owner)
    end

    inst:WatchWorldState("israining", OnRainChange)

    UpdateSpeed(inst, owner)
end

local function OnUnequip(inst, owner)
    owner._boots = nil

    inst.components.equippable.walkspeedmult = 1

    inst:RemoveEventCallback("moisturedelta", OnMoistureDelta, owner)
    inst:StopWatchingWorldState("israining", OnRainChange)
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
    inst.components.inventoryitem:ChangeImageName("bonestew")

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.OE_ACCESSORY
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
    inst.components.equippable.walkspeedmult = 1

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("oe_accessory_boots_moose", fn, assets)