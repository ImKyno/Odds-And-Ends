local assets =
{
    Asset("ANIM", "anim/oe_frozen_sword.zip"),
    Asset("ANIM", "anim/oe_swap_frozen_sword.zip"),

    Asset("IMAGE", "images/oe_inventoryimages.tex"),
    Asset("ATLAS", "images/oe_inventoryimages.xml"),
    Asset("ATLAS_BUILD", "images/oe_inventoryimages.xml", 256),
}

local prefabs = {}

local function OnEquip(inst, owner)
    if owner ~= nil then
        if inst.components.heater ~= nil then
            inst.components.heater:SetThermics(false, true)
        end

        local skin_build = inst:GetSkinBuild()

        if skin_build ~= nil then
            owner:PushEvent("equipskinneditem", inst:GetSkinName())
            owner.AnimState:OverrideItemSkinSymbol("swap_object", skin_build, "oe_swap_frozen_sword", inst.GUID, "oe_swap_frozen_sword")
        else
            owner.AnimState:OverrideSymbol("swap_object", "oe_swap_frozen_sword", "oe_swap_frozen_sword")
        end

        owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")
    end

    if inst.components.rechargeable ~= nil and inst.components.rechargeable:GetTimeToCharge() < inst._cooldown then
        inst.components.rechargeable:Discharge(inst._cooldown)
    end
end

local function OnUnequip(inst, owner)
    if owner ~= nil then
        if inst.components.heater ~= nil then
            inst.components.heater:SetThermics(false, false)
        end

        local skin_build = inst:GetSkinBuild()

        if skin_build ~= nil then
            owner:PushEvent("unequipskinneditem", inst:GetSkinName())
        end

        owner.AnimState:Hide("ARM_carry")
        owner.AnimState:Show("ARM_normal")
    end
end

local function OnAttack(inst, owner, target)
    if target ~= nil and target:IsValid() then
        inst.SoundEmitter:PlaySound("dontstarve/characters/walter/slingshot/freeze")

        if target.components.freezable ~= nil and inst.components.rechargeable ~= nil 
        and inst.components.rechargeable:IsCharged() then
            target.components.freezable:Freeze()
            target.components.freezable:SpawnShatterFX()

            if target.components.burnable ~= nil then
                if target.components.burnable:IsBurning() then
                    target.components.burnable:Extinguish()
                elseif target.components.burnable:IsSmoldering() then
                    target.components.burnable:SmotherSmolder()
                end
            end

            inst.components.rechargeable:Discharge(inst._cooldown)
        end
    end
end

local function OnGetDamage(inst)
    local season = TheWorld.state.season
    return season == "winter" and TUNING.OE_FROZEN_SWORD.DAMAGE.WINTER or TUNING.OE_FROZEN_SWORD.DAMAGE.NORMAL
end

local function OnRepaired(inst, doer)
    if doer ~= nil then
        doer:PushEvent("repairtrueice")
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "med", 0.05, { 1.1, 0.5, 1.1 }, true, -9)

    inst.AnimState:SetBank("oe_frozen_sword")
    inst.AnimState:SetBuild("oe_frozen_sword")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("sharp")
    inst:AddTag("weapon")
    inst:AddTag("rechargeable")
    inst:AddTag("HASHEATER")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst._cooldown = TUNING.OE_FROZEN_SWORD.COOLDOWN

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(OnGetDamage)
    inst.components.weapon.onattack = OnAttack

    inst:AddComponent("heater")
    inst.components.heater.equippedheat = TUNING.OE_FROZEN_SWORD.HEAT

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)

    inst:AddComponent("rechargeable")
    inst.components.rechargeable:Discharge(inst._cooldown)
    inst.components.rechargeable:SetPercent(inst.components.rechargeable:GetPercent())

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(TUNING.OE_FROZEN_SWORD.USES)
    inst.components.finiteuses:SetUses(TUNING.OE_FROZEN_SWORD.USES)
    inst.components.finiteuses:SetOnFinished(inst.Remove)

    -- Needs to be added after finiteuses component.
    inst:AddComponent("repairable")
    inst.components.repairable.repairmaterial = MATERIALS.OE_TRUE_ICE
    inst.components.repairable.noannounce = true
    inst.components.repairable.finiteusesrepairable = true
    inst.components.repairable.onrepaired = OnRepaired

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("oe_frozen_sword", fn, assets, prefabs)