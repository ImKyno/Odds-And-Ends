local assets =
{
    Asset("ANIM", "anim/oe_accessories.zip"),

    Asset("IMAGE", "images/oe_inventoryimages.tex"),
    Asset("ATLAS", "images/oe_inventoryimages.xml"),
    Asset("ATLAS_BUILD", "images/oe_inventoryimages.xml", 256),
}

local THRESHOLD = TUNING.OE_ACCESSORIES.BOOTS_MOOSE.MOISTURE_THRESHOLD
local SPEEDMULT = TUNING.OE_ACCESSORIES.BOOTS_MOOSE.SPEEDMULT

local function OnCheckSpeed(owner)
    return TheWorld.state.israining
    or (owner.components.moisture ~= nil and owner.components.moisture:GetMoisture() >= THRESHOLD)
end

local function OnUpdateSpeed(inst, owner)
    if owner == nil then
        return
    end

    if OnCheckSpeed(owner) then
        inst.components.equippable.walkspeedmult = SPEEDMULT
    else
        inst.components.equippable.walkspeedmult = 1
    end
end

local function OnMoistureDelta(owner, data)
    if owner._boots ~= nil then
        OnUpdateSpeed(owner._boots, owner)
    end
end

local function OnRainChange(inst, israining)
    local owner = inst.components.inventoryitem.owner
    if owner ~= nil then
        OnUpdateSpeed(inst, owner)
    end
end

local function OnEquip(inst, owner)
    owner._boots = inst

    if owner.components.moisture ~= nil then
        inst:ListenForEvent("moisturedelta", OnMoistureDelta, owner)
    end

    inst:WatchWorldState("israining", OnRainChange)

    OnUpdateSpeed(inst, owner)

    inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/moose/attack", nil, 0.5)

    --[[
    if inst._owner ~= nil then
        inst:RemoveEventCallback("locomote", inst._onlocomote, inst._owner)
    end

    inst._owner = owner
    inst:ListenForEvent("locomote", inst._onlocomote, owner)
    ]]--
end

local function OnUnequip(inst, owner)
    owner._boots = nil

    inst.components.equippable.walkspeedmult = 1

    inst:RemoveEventCallback("moisturedelta", OnMoistureDelta, owner)
    inst:StopWatchingWorldState("israining", OnRainChange)

    --[[
    if inst._owner ~= nil then
        inst:RemoveEventCallback("locomote", inst._onlocomote, inst._owner)
        inst._owner = nil
    end
    ]]--
end

-- TO DO: REMEMBER ME TO ACTIVATE THIS DURING BETA SO IT CAN ANNOY PEOPLE LOL
--[[
local function OnStartFoleySound(inst, owner)
    if inst._foleytask == nil and TUNING.OE_ANNOYING_BOOTS_MOOSE_SOUND then
        inst._foleytask = inst:DoPeriodicTask(0.6, function()
            if owner ~= nil and owner.components.locomotor ~= nil then
                if owner.components.locomotor.wantstomoveforward then
                    inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/moose/attack", nil, 0.18)
                end
            end
        end)
    end
end

local function OnStopFoleySound(inst)
    if inst._foleytask ~= nil then
        inst._foleytask:Cancel()
        inst._foleytask = nil
    end
end
]]--

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddFollower()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)

    inst.AnimState:SetBank("oe_accessories")
    inst.AnimState:SetBuild("oe_accessories")
    inst.AnimState:PlayAnimation("idle")

    inst.AnimState:OverrideSymbol("accessory", "oe_accessories", "boots_moose")

    inst:AddTag("oe_accessory")
    inst:AddTag("furnituredecor")
    inst:AddTag("_named")

    inst.pickupsound = "cloth"

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:RemoveTag("_named")

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst:AddComponent("furnituredecor")

    inst:AddComponent("named")
    inst.components.named.possiblenames = STRINGS.NAMES.OE_ACCESSORY_BOOTS_MOOSE_RANDOM
    inst.components.named:PickNewName()

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.OE_ACCESSORY
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
    inst.components.equippable.walkspeedmult = 1

    --[[
    inst._onlocomote = function(owner)
        if owner ~= nil and owner.components.locomotor ~= nil then
            if owner.components.locomotor.wantstomoveforward then
                OnStartFoleySound(inst, owner)
            else
                OnStopFoleySound(inst)
            end
        end
    end
    ]]--

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("oe_accessory_boots_moose", fn, assets)