local SpDamageUtil = require("components/spdamageutil")

local assets =
{
    Asset("ANIM", "anim/oe_powder_weapon_ammo.zip"),
}

local AOE_TARGET_MUST_TAGS     = { "_combat", "_health" }
local AOE_TARGET_CANT_TAGS     = { "INLIMBO", "notarget", "noattack", "playerghost", "companion", "player" }
local AOE_TARGET_CANT_TAGS_PVP = { "INLIMBO", "notarget", "noattack", "playerghost" }
local AOE_RADIUS_PADDING       = 3

local function DoAOECallback(inst, x, z, radius, cb, attacker, target)
    local combat = attacker and attacker.components.combat or nil

    if combat == nil then
        return
    end

    for i, v in ipairs(TheSim:FindEntities(x, 0, z, radius + AOE_RADIUS_PADDING, AOE_TARGET_MUST_TAGS, TheNet:GetPVPEnabled() 
    and AOE_TARGET_CANT_TAGS_PVP or AOE_TARGET_CANT_TAGS)) do
        if v ~= target and combat:CanTarget(v) and v.components.combat:CanBeAttacked(attacker) and not combat:IsAlly(v) then
            local range = radius + v:GetPhysicsRadius(0)

            if v:GetDistanceSqToPoint(x, 0, z) < range * range then
                cb(inst, attacker, v)
            end
        end
    end
end

local function ShouldAggro(attacker, target)
    local targets_target = target.components.combat ~= nil and target.components.combat.target or nil
    
    return targets_target ~= nil
    and targets_target:IsValid()
    and targets_target ~= attacker
    and attacker ~= nil
    and attacker:IsValid()
    and (GetTime() - target.components.combat.lastwasattackedbytargettime) < 4
    and (targets_target.components.health ~= nil and not targets_target.components.health:IsDead())
end

local function ImpactFx(inst, attacker, target)
    if not inst.noimpactfx and target ~= nil and target:IsValid() then
        local impactfx = SpawnPrefab(inst.ammo_def.impactfx)
        impactfx.Transform:SetPosition(target.Transform:GetWorldPosition())
    end
end

local function OnAttack(inst, attacker, target)
    if target ~= nil and target:IsValid() and attacker ~= nil and attacker:IsValid() then
        if inst.ammo_def ~= nil and inst.ammo_def.onhit ~= nil then
            inst.ammo_def.onhit(inst, attacker, target)
        end

        ImpactFx(inst, attacker, target)
    end
end

local function OnPreHit(inst, attacker, target)
    if inst.ammo_def ~= nil and inst.ammo_def.onprehit ~= nil then
        inst.ammo_def.onprehit(inst, attacker, target)
    end

    if target ~= nil and target:IsValid() and target.components.combat ~= nil and ShouldAggro(attacker, target) then
        target.components.combat:SetShouldAvoidAggro(attacker)
    end
end

local function OnHit(inst, attacker, target)
    if target ~= nil and target:IsValid() and target.components.combat ~= nil then
        target.components.combat:RemoveShouldAvoidAggro(attacker)
    end

    inst:Remove()
end

local function NoHoles(pt)
    return not TheWorld.Map:IsPointNearHole(pt)
end

local function DoAOEDamage(inst, attacker, target, damage, radius)
    local combat = attacker ~= nil and attacker.components.combat or nil

    if combat == nil or not target:IsValid() then
        return
    end

    local x, y, z = target.Transform:GetWorldPosition()
    local _ignorehitrange = combat.ignorehitrange

    combat.ignorehitrange = true

    for i, v in ipairs(TheSim:FindEntities(x, y, z, radius + AOE_RADIUS_PADDING, AOE_TARGET_MUST_TAGS, TheNet:GetPVPEnabled()
    and AOE_TARGET_CANT_TAGS_PVP or AOE_TARGET_CANT_TAGS)) do
        if v ~= target and combat:CanTarget(v) and v.components.combat:CanBeAttacked(attacker) and not combat:IsAlly(v) then
            local range = radius + v:GetPhysicsRadius(0)

            if v:GetDistanceSqToPoint(x, y, z) < range * range then
                local spdmg = SpDamageUtil.CollectSpDamage(inst)
                v.components.combat:GetAttacked(attacker, damage, inst, inst.components.projectile.stimuli, spdmg)
            end
        end
    end

    combat.ignorehitrange = _ignorehitrange
end

local function GunpowderStaticTimeout(target)
    target._critical_chance = nil
end

local function OnPreHit_Gunpowder(inst, attacker, target)
    inst._critical_hit = target._critical_chance ~= nil
    and TryLuckRoll(attacker, target._critical_chance.chance, OeLuckFormulas.CriticalChance)

    if not inst._critical_hit then
        return
    end

    local dmg = inst.components.weapon.damage

    -- TO DO: Make this account the crit damage modifiers provided by accesories or other items.
    if dmg and dmg > 0 then
        inst.components.weapon:SetDamage(dmg * TUNING.OE_POWDER_WEAPON_AMMO.CRIT.GUNPOWDER.MODIFIER)
    end
end

local function OnHit_Gunpowder(inst, attacker, target)
    if target._critical_chance == nil then
        target._critical_chance =
        {
            -- TO DO: Make this account the crit chance modifiers provided by accesories or other items.
            chance = TUNING.OE_POWDER_WEAPON_AMMO.CRIT.GUNPOWDER.CHANCE,
            task = target:DoTaskInTime(TUNING.OE_POWDER_WEAPON_AMMO.TIMEOUT, GunpowderStaticTimeout),
        }
    else
        target._critical_chance.chance = target._critical_chance.chance + TUNING.OE_POWDER_WEAPON_AMMO.CRIT.GUNPOWDER.CHANCE
        target._critical_chance.task:Cancel()
        target._critical_chance.task = target:DoTaskInTime(TUNING.OE_POWDER_WEAPON_AMMO.TIMEOUT, GunpowderStaticTimeout)
    end

    if inst._critical_hit then
        local fx = SpawnPrefab("slingshotammo_gunpowder_explode")

        if fx ~= nil then
            fx.Transform:SetPosition(target.Transform:GetWorldPosition())
        end

        for i, v in ipairs(AllPlayers) do
            local distSq = v:GetDistanceSqToInst(target)
            local k = math.max(0, math.min(1, distSq / 400))
            local intensity = k * 0.75 * (k - 2) + 0.75

            if intensity > 0 then
                v:ShakeCamera(CAMERASHAKE.FULL, 1.05, .03, intensity / 2)
            end
        end

        -- TO DO: I'll leave this for explosive rounds.
        -- DoAOEDamage(inst, attacker, target, inst.components.weapon.damage, TUNING.OE_POWDER_WEAPON_AMMO.AOE.GUNPOWDER)

        target._critical_chance.task:Cancel()
        target._critical_chance = nil

        inst.noimpactfx = true
    end
end

local function OnLaunch_Gunpowder(inst, owner, target, attacker)
    inst.SoundEmitter:PlaySound("meta5/walter/ammo_gunpowder_shoot")
end

local function OnMiss(inst, owner, target)
    inst:Remove()
end

local function OnUpdateSkillshot(inst)
    if not (inst.components.projectile.owner and inst:IsValid()) then
        return
    end

    local attacker = inst._attacker

    if not (attacker ~= nil and attacker.components.combat ~= nil and attacker:IsValid()) then
        return
    end

    local x, y, z = inst.Transform:GetWorldPosition()

    for i, v in ipairs(TheSim:FindEntities(x, 0, z, 4, AOE_TARGET_MUST_TAGS, TheNet:GetPVPEnabled() 
    and AOE_TARGET_CANT_TAGS_PVP or AOE_TARGET_CANT_TAGS)) do
        local range = v:GetPhysicsRadius(.5) + inst.components.projectile.hitdist

        if v:GetDistanceSqToPoint(x, y, z) < range * range 
        and attacker.components.combat:CanTarget(v)
        and v.components.combat:CanBeAttacked(attacker) 
        and not attacker.components.combat:IsAlly(v) then
            inst.components.projectile:Hit(v)
            break
        end
    end
end

local function OnThrown(inst, owner, target, attacker)
    if inst.ammo_def ~= nil and inst.ammo_def.onlaunch ~= nil then
        inst.ammo_def.onlaunch(inst, owner, target, attacker)
    end

    if not target:HasTag("CLASSIFIED") then
        return -- Not a fake target.
    end

    inst._attacker = attacker
    inst.components.projectile:SetHitDist(0.7)
    inst.components.updatelooper:AddOnWallUpdateFn(OnUpdateSkillshot)
end

local function SetHighProjectile(inst)
    inst.AnimState:PlayAnimation(inst.ammo_def.spinloopmounted or "spin_loop_mount")
    inst.AnimState:PushAnimation(inst.ammo_def.spinloop or "spin_loop")
end

local function projectile_fn(ammo_def)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.Transform:SetFourFaced()

    MakeProjectilePhysics(inst)

    inst.AnimState:SetBank("oe_powder_weapon_ammo")
    inst.AnimState:SetBuild("oe_powder_weapon_ammo")

    if ammo_def.spinloop ~= nil then
        inst.AnimState:PlayAnimation(ammo_def.spinloop, true)
    else
        inst.AnimState:PlayAnimation("spin_loop", true)
        
        if ammo_def.symbol ~= nil then
            inst.AnimState:OverrideSymbol("rock", "oe_powder_weapon_ammo", ammo_def.symbol)
        end
    end

    inst:AddTag("projectile")

    if ammo_def.tags ~= nil then
        for _, tag in pairs(ammo_def.tags) do
            inst:AddTag(tag)
        end
    end

    if ammo_def.proj_common_postinit ~= nil then
        ammo_def.proj_common_postinit(inst)
    end

    inst.ammo_def = ammo_def

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.SetHighProjectile = SetHighProjectile
    inst.persists = false

    if ammo_def.planar ~= nil then
        inst:AddComponent("planardamage")
        inst.components.planardamage:SetBaseDamage(ammo_def.planar)
    end

    if ammo_def.damagetypebonus ~= nil then
        inst:AddComponent("damagetypebonus")

        for k, v in pairs(ammo_def.damagetypebonus) do
            inst.components.damagetypebonus:AddBonus(k, inst, v)
        end
    end

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(ammo_def.damage)
    inst.components.weapon:SetOnAttack(OnAttack)

    inst:AddComponent("projectile")
    inst.components.projectile:SetSpeed(TUNING.OE_POWDER_WEAPON_AMMO.SPEED)
    inst.components.projectile:SetHoming(ammo_def.homing or false)
    inst.components.projectile:SetHitDist(TUNING.OE_POWDER_WEAPON_AMMO.DIST)
    inst.components.projectile:SetOnPreHitFn(OnPreHit)
    inst.components.projectile:SetOnHitFn(OnHit)
    inst.components.projectile:SetOnMissFn(OnMiss)
    inst.components.projectile:SetOnThrownFn(OnThrown)
    inst.components.projectile.range = TUNING.OE_POWDER_WEAPON_AMMO.RANGE
    inst.components.projectile.has_damage_set = true

    if ammo_def.proj_master_postinit ~= nil then
        ammo_def.proj_master_postinit(inst)
    end

    return inst
end

local function inv_fn(ammo_def)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("oe_powder_weapon_ammo")
    inst.AnimState:SetBuild("oe_powder_weapon_ammo")
    inst.AnimState:SetRayTestOnBB(true)

    if ammo_def.idleanim ~= nil then
        inst.AnimState:PlayAnimation(ammo_def.idleanim, ammo_def.idlelooping)
    else
        inst.AnimState:PlayAnimation("idle")

        if ammo_def.symbol ~= nil then
            inst.AnimState:OverrideSymbol("rock", "oe_powder_weapon_ammo", ammo_def.symbol)
        end
    end

    inst:AddTag("powderweapon_ammo")
    inst:AddTag("reloaditem_ammo")

    if ammo_def.elemental ~= nil then
        inst:AddTag("molebait")
    else
        MakeInventoryFloatable(inst, "small", 0.2, { 0.85, 0.9, 0.85 })
    end

    if ammo_def.inv_common_postinit ~= nil then
        ammo_def.inv_common_postinit(inst)
    end

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.ammo_def = ammo_def

    if ammo_def.idlelooping ~= nil then
        inst.AnimState:SetFrame(math.random(inst.AnimState:GetCurrentAnimationNumFrames()) - 1)
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("reloaditem")
    inst:AddComponent("tradable")

    if ammo_def.elemental ~= nil then
        inst:AddComponent("bait")
    end

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_PELLET

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:SetSinks(ammo_def.elemental)

    if ammo_def.fuelvalue ~= nil then
        inst:AddComponent("fuel")
        inst.components.fuel.fuelvalue = ammo_def.fuelvalue
    end

    if ammo_def.elemental ~= nil then
        inst:AddComponent("edible")
        inst.components.edible.foodtype = FOODTYPE.ELEMENTAL
        inst.components.edible.hungervalue = TUNING.OE_POWDER_WEAPON_AMMO.HUNGER
    end

    if ammo_def.inv_master_postinit ~= nil then
        ammo_def.inv_master_postinit(inst, ammo_def)
    end

    if ammo_def.onloadammo ~= nil and ammo_def.onunloadammo ~= nil then
        inst:ListenForEvent("ammoloaded", ammo_def.onloadammo)
        inst:ListenForEvent("ammounloaded", ammo_def.onunloadammo)
        inst:ListenForEvent("onremove", ammo_def.onunloadammo)
    end

    MakeHauntableLaunch(inst)

    return inst
end

local ammo =
{
    -- Gunpowder Rounds.
    {
        name      = "oe_powder_weapon_ammo_gunpowder",
        symbol    = "gunpowder",
        onlaunch  = OnLaunch_Gunpowder,
        onprehit  = OnPreHit_Gunpowder,
        onhit     = OnHit_Gunpowder,
        damage    = TUNING.OE_POWDER_WEAPON_AMMO.DAMAGE.GUNPOWDER,
        elemental = true,
        prefabs   = { "slingshotammo_gunpowder_explode" },
    },

    -- Endless Ammo Pouch
    {
        name      = "oe_powder_weapon_ammo_infinite",
        symbol    = "gunpowder",
        onlaunch  = OnLaunch_Gunpowder,
        onprehit  = OnPreHit_Gunpowder,
        onhit     = OnHit_Gunpowder,
        damage    = TUNING.OE_POWDER_WEAPON_AMMO.DAMAGE.INFINITE,
        elemental = true,
        prefabs   = { "slingshotammo_gunpowder_explode" },
    },
}

local ammo_prefabs = {}

local function AddAmmoPrefab(name, data, fn, prefabs)
    table.insert(ammo_prefabs, Prefab(name, function() return fn(data) end, assets, prefabs))
end

for _, data in ipairs(ammo) do
    data.impactfx = "slingshotammo_hitfx_" .. (data.symbol or "rock")

    if not data.no_inv_item ~= nil then
        AddAmmoPrefab(data.name, data, inv_fn, { data.name.."_proj" })
    end

    local prefabs = { data.impactfx }

    if data.prefabs ~= nil then
        ConcatArrays(prefabs, data.prefabs)
    end

    AddAmmoPrefab(data.name.."_proj", data, projectile_fn, prefabs)
end

return unpack(ammo_prefabs)