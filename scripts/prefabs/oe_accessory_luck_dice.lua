local assets =
{
    Asset("ANIM", "anim/oe_accessories.zip"),

    Asset("IMAGE", "images/oe_inventoryimages.tex"),
    Asset("ATLAS", "images/oe_inventoryimages.xml"),
    Asset("ATLAS_BUILD", "images/oe_inventoryimages.xml", 256),
}

local function OnApplyLuck(inst, owner)
    if owner ~= nil and owner.components.luckuser ~= nil and inst._current_luck ~= nil then
        owner.components.luckuser:SetLuckSource(inst._current_luck, inst)
    end
end

local function OnRollLuck(inst, owner)
    if owner ~= nil and owner.components.luckuser ~= nil then
        local min = math.floor(TUNING.OE_ACCESSORIES.LUCK_DICE.MIN or 0)
        local max = math.floor(TUNING.OE_ACCESSORIES.LUCK_DICE.MAX or 10)

        local luck = math.random(min, max)

        inst._current_luck = luck
        owner.components.luckuser:SetLuckSource(luck, inst)
    end
end

local function OnTryRollLuck(inst, owner)
    local current_day = TheWorld.state.cycles or 0

    if inst._last_roll_day ~= current_day then
        inst._last_roll_day = current_day
        OnRollLuck(inst, owner)
    else
        OnApplyLuck(inst, owner)
    end
end

local function OnCyclesChanged(inst)
    local owner = inst.components.inventoryitem.owner or inst.components.inventoryitem:GetGrandOwner()

    if owner ~= nil then
        OnTryRollLuck(inst, owner)
    end
end

local function OnEquip(inst, owner)
    if owner ~= nil then
        inst:AddTag("luckysource")

        inst:WatchWorldState("cycles", OnCyclesChanged)

        OnTryRollLuck(inst, owner)
    end
end

local function OnUnequip(inst, owner)
    if owner ~= nil then
        inst:RemoveTag("luckysource")

        inst:StopWatchingWorldState("cycles", OnCyclesChanged)

        if owner.components.luckuser ~= nil then
            owner.components.luckuser:RemoveLuckSource(inst)
        end
    end
end

local function OnSave(inst, data)
    data.last_roll_day = inst._last_roll_day
    data.current_luck = inst._current_luck
end

local function OnLoad(inst, data)
    if data ~= nil then
        inst._last_roll_day = data.last_roll_day
        inst._current_luck = data.current_luck
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

    inst.AnimState:OverrideSymbol("accessory", "oe_accessories", "luck_dice")

    inst:AddTag("oe_accessory")
    inst:AddTag("furnituredecor")

    inst.pickupsound = "rock"

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst._last_roll_day = nil
    inst._current_luck = nil

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst:AddComponent("furnituredecor")

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.OE_ACCESSORY
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("oe_accessory_luck_dice", fn, assets)