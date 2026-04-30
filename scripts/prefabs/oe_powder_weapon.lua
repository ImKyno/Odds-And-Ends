local assets =
{
    Asset("ANIM", "anim/oe_powder_weapon.zip"),
    Asset("ANIM", "anim/swap_oe_powder_weapon.zip"),
    Asset("ANIM", "anim/swap_oe_powder_weapon_loaded.zip"),
}

local prefabs =
{

}

local function OnEquip(inst, owner)
    if owner ~= nil then
        owner.AnimState:OverrideSymbol("swap_object", inst.override_bank, "swap_oe_powder_weapon")

        owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")

        if inst.components.container ~= nil then
            inst.components.container:Open(owner)
        end
    end
end

local function OnUnequip(inst, owner)
    if owner ~= nil then
        owner.AnimState:ClearOverrideSymbol("swap_object")
        owner.AnimState:Hide("ARM_carry")
        owner.AnimState:Show("ARM_normal")

        if inst.components.container ~= nil then
            inst.components.container:Close()
        end
    end
end

local function OnEquipToModel(inst, owner, from_ground)
    if inst.components.container ~= nil then
        inst.components.container:Close()
    end
end

local function OnProjectileLaunched(inst, attacker, target, proj)
    if attacker ~= nil and attacker.components.rider ~= nil and attacker.components.rider:IsRiding() then
        if proj.SetHighProjectile ~= nil then
            proj:SetHighProjectile()
        end
    end

    if inst.projectilespeedmult ~= nil then
        proj.components.projectile:SetSpeed(proj.components.projectile.speed * inst.projectilespeedmult)
    end

    if inst.components.container ~= nil then
        local ammo = inst.components.container:GetItemInSlot(inst.overrideammoslot or 1)
        local item = inst.components.container:RemoveItem(ammo, false)

        if item ~= nil then
            if item == ammo then
                item:PushEvent("ammounloaded", {slingshot = inst})
            end

            item:Remove()
        end
    end
end

local function OnAmmoLoaded(inst, data)
    if data ~= nil and data.item ~= nil and data.slot == 1 then
        if inst.components.weapon ~= nil then
            inst.components.weapon:SetProjectile(data.item.prefab.."_proj")
        end

        inst.override_bank = "swap_oe_powder_weapon_loaded"

        if inst.components.equippable ~= nil and inst.components.equippable:IsEquipped() then
            local owner = inst.components.equippable.equipper
            owner.AnimState:OverrideSymbol("swap_object", inst.override_bank, "swap_oe_powder_weapon")
        end

        inst:AddTag("ammoloaded")
        data.item:PushEvent("ammoloaded", { slingshot = inst })
    end
end

local function OnAmmoUnloaded(inst, data)
    if data ~= nil and data.slot == 1 then
        if inst.components.weapon ~= nil then
            inst.components.weapon:SetProjectile(nil)
        end

        inst.override_bank = "swap_oe_powder_weapon"

        if inst.components.equippable ~= nil and inst.components.equippable:IsEquipped() then
            local owner = inst.components.equippable.equipper
            owner.AnimState:OverrideSymbol("swap_object", inst.override_bank, "swap_oe_powder_weapon")
        end

        inst:RemoveTag("ammoloaded")

        if data.prev_item ~= nil then
            data.prev_item:PushEvent("ammounloaded", { slingshot = inst })
        end
    end
end

local function OnDeconstruct(inst, caster)
    if inst.components.container ~= nil then
        inst.components.container:DropEverything()
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("oe_powder_weapon")
    inst.AnimState:SetBuild("oe_powder_weapon")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("weapon")
    inst:AddTag("rangedweapon")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        inst.OnEntityReplicated = function(inst) 
            inst.replica.container:WidgetSetup("oe_powder_weapon")
        end

        return inst
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
    inst.components.equippable:SetOnEquipToModel(OnEquipToModel)

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(0)
    inst.components.weapon:SetRange(TUNING.OE_POWDER_WEAPON.RANGE.MIN, TUNING.OE_POWDER_WEAPON.RANGE.MAX)
    inst.components.weapon:SetOnProjectileLaunched(OnProjectileLaunched)
    inst.components.weapon:SetProjectile(nil)
    inst.components.weapon:SetProjectileOffset(1)

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("oe_powder_weapon")
    inst.components.container.canbeopened = false
    inst.components.container.stay_open_on_hide = true

    inst:ListenForEvent("itemget", OnAmmoLoaded)
    inst:ListenForEvent("itemlose", OnAmmoUnloaded)
    inst:ListenForEvent("ondeconstructstructure", OnDeconstruct)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("oe_powder_weapon", fn, assets, prefabs)