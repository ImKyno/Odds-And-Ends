-- We have some possible routes for them:
-- Route 1: Lose durability when working and refreshes spoilage time inside Ice Box.
-- Route 2: Does not lose durability when working and halts spoilage time inside Ice Box.
-- Route 3: Does not lose durability if its Winter, spoils faster during other seasons.

local function MakeFrozenTool(data)
    local assets =
    {
        Asset("ANIM", "anim/pickaxe.zip"),
        Asset("ANIM", "anim/swap_pickaxe.zip"),

        Asset("ANIM", "anim/axe.zip"),
        Asset("ANIM", "anim/swap_axe.zip"),

        Asset("ANIM", "anim/shovel.zip"),
        Asset("ANIM", "anim/swap_shovel.zip"),

        Asset("ANIM", "anim/swap_oe_hammer.zip"),
        Asset("ANIM", "anim/oe_hammer.zip"),

        Asset("IMAGE", "images/oe_inventoryimages.tex"),
        Asset("ATLAS", "images/oe_inventoryimages.xml"),
        Asset("ATLAS_BUILD", "images/oe_inventoryimages.xml", 256),
    }

    local function OnWorking(inst, owner, data)
        local worker = owner

        -- Assume we have a worker, if not just fail silently...
        if worker == nil or not worker:IsValid() then
            return
        end

        local tool = worker.components.inventory ~= nil and worker.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)

        local act = worker:GetBufferedAction()
        local target = act ~= nil and act.target

        if tool ~= nil and target ~= nil and target:IsValid() then
            local workable = target.components.workable

            if workable ~= nil and workable:CanBeWorked() then
                -- workable:WorkedBy(worker, tool.components.tool:GetEffectiveness(act.action))
                tool:OnUsedAsItem(act.action, worker, target)
            end
        end
    end

    local function OnEquip(inst, owner)
        if owner ~= nil then
            if inst.components.heater ~= nil then
                inst.components.heater:SetThermics(false, true)
            end

            local skin_build = inst:GetSkinBuild()

            if skin_build ~= nil then
                owner:PushEvent("equipskinneditem", inst:GetSkinName())
                owner.AnimState:OverrideItemSkinSymbol("swap_object", skin_build, data.sym_build, inst.GUID, data.sym_build)
            else
                owner.AnimState:OverrideSymbol("swap_object", data.sym_build, data.sym_build)
            end

            owner.AnimState:Show("ARM_carry")
            owner.AnimState:Hide("ARM_normal")
        end

        inst:ListenForEvent("working", inst._OnWorking, owner)
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

        inst:RemoveEventCallback("working", inst._OnWorking, owner)
    end

    local function OnPerish(inst)
        local owner = inst.components.inventoryitem.owner or inst.components.inventoryitem:GetGrandOwner()

        if owner ~= nil then
            if owner.components.moisture ~= nil then
                owner.components.moisture:DoDelta(TUNING.OE_FROZEN_TOOL.MOISTURE)
            elseif owner.components.inventoryitem ~= nil then
                owner.components.inventoryitem:AddMoisture(TUNING.OE_FROZEN_TOOL.MOISTURE * 2)
            end

            -- Play breaking FX.
            if inst.components.equippable:IsEquipped() then
                owner:PushEvent("toolbroke")
            end

            inst:Remove()
        else
            if TheWorld.components.farming_manager ~= nil then
                TheWorld.components.farming_manager:AddSoilMoistureAtPoint(x, y, z, TUNING.OE_FROZEN_TOOL.MOISTURE_GROUND)
            end

            inst.persists = false
            inst.components.inventoryitem.canbepickedup = false

            inst.AnimState:PlayAnimation("melt")
            inst:ListenForEvent("animover", inst.Remove)
        end
    end

    local function OnSetDebuff(target, fx, numstacks)
        local speed = TUNING.OE_DEBUFFS.FROZEN.SLOW ^ numstacks
        local damage = TUNING.OE_DEBUFFS.FROZEN.DAMAGE ^ numstacks

        if target.components.locomotor ~= nil then
            target.components.locomotor:SetExternalSpeedMultiplier(target, "oe_debuff_frozen", speed)
        end

        if target.components.combat ~= nil then
            target.components.combat.externaldamagemultipliers:SetModifier(target, damage, "oe_debuff_frozen")
        end

        local INT = 0.5
        local R, G, B, A = (82 / 255) * INT, (115 / 255) * INT, (124 / 255) * INT, 0

        if target.components.colouradder ~= nil then
            target.components.colouradder:PushColour("freezable", R, G, B, A)
        else
            target.AnimState:SetAddColour(R, G, B, A)
        end

        if target.SoundEmitter ~= nil then
            target.SoundEmitter:PlaySound("dontstarve/winter/freeze_2nd")
        end

        fx:SetFXLevel(numstacks or 1)
    end

    local function OnRefreshDebuff(target, data)
        table.remove(data.tasks, 1)

        if #data.tasks > 0 then
            OnSetDebuff(target, data.fx, #data.tasks)
        else
            data.fx:KillFX()

            if target.components.locomotor ~= nil then
                target.components.locomotor:RemoveExternalSpeedMultiplier(target, "oe_debuff_frozen")
            end

            if target.components.combat ~= nil then
                target.components.combat.externaldamagemultipliers:RemoveModifier(target, "oe_debuff_frozen")
            end

            if target.components.colouradder ~= nil then
                target.components.colouradder:PopColour("freezable")
            else
                target.AnimState:SetAddColour(0, 0, 0, 0)
            end

            target._slow = nil
        end
    end

    local function OnAttack(inst, owner, target)
        if target ~= nil and target.components.combat ~= nil then
            local data_slow = target._slow
            local shouldrefresh

            if data_slow == nil then
                data_slow = { tasks = {}, fx = SpawnPrefab("oe_debuff_frozen") }

                data_slow.fx.entity:SetParent(target.entity)
                data_slow.fx:StartFX(target)

                target._slow = data_slow
                shouldrefresh = true
            elseif #data_slow.tasks < TUNING.OE_DEBUFFS.FROZEN.STACK then
                shouldrefresh = true
            else
                table.remove(data_slow.tasks, 1):Cancel()
            end

            table.insert(data_slow.tasks, target:DoTaskInTime(TUNING.OE_DEBUFFS.FROZEN.DURATION, OnRefreshDebuff, data_slow))

            if shouldrefresh then
                OnSetDebuff(target, data_slow.fx, #data_slow.tasks)
            end
        end
    end

    local function OnSeasonChange(inst, season)
        return TheWorld.state.season
    end

    local function OnUpdateSeason(inst, season)
        local season = OnSeasonChange(inst)

        if inst.components.perishable ~= nil then
            if season == "winter" then
                inst.components.perishable:StopPerishing()
                inst.components.perishable:SetLocalMultiplier(1)
            else
                inst.components.perishable:StartPerishing()

                if season == "summer" then
                    inst.components.perishable:SetLocalMultiplier(TUNING.OE_FROZEN_TOOL.PERISH_MULT_SUMMER)
                else
                    inst.components.perishable:SetLocalMultiplier(TUNING.OE_FROZEN_TOOL.PERISH_MULT)
                end
            end
        end
    end

    local function OnStartFireMelt(inst)
        if inst.components.perishable ~= nil then
            inst.components.perishable.frozenfiremult = true
        end
    end

    local function OnStopFireMelt(inst)
        if inst.components.perishable ~= nil then
            inst.components.perishable.frozenfiremult = false
        end
    end

    local function OnLoad(inst, data)
        OnUpdateSeason(inst, TheWorld.state.season)
    end

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)
        MakeInventoryFloatable(inst, "med", 0.05, data.float or { 0.75, 0.4, 0.75 })

        inst.AnimState:SetScale(data.scale or 1, data.scale or 1, data.scale or 1)

        inst.AnimState:SetBank(data.bank)
        inst.AnimState:SetBuild(data.build)
        inst.AnimState:PlayAnimation("idle")

        inst:AddTag("tool")
        inst:AddTag("weapon")
        inst:AddTag("frozen") -- This will update perish times automatically.
        inst:AddTag("frozen_tool")
        inst:AddTag("show_spoilage")
        inst:AddTag("icebox_valid")
        inst:AddTag("HASHEATER")

        if data.tags ~= nil then
            for i, v in pairs(data.tags) do
                inst:AddTag(v)
            end
        end

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        if inst.components.floater ~= nil then
            inst.components.floater:SetBankSwapOnFloat(true, data.sym_num or -11, { sym_build = data.sym_build })
        end

        inst:AddComponent("inspectable")
        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem:ChangeImageName("meat")

        inst:AddComponent("tool")
        inst.components.tool:SetAction(data.action, TUNING.OE_FROZEN_TOOL.EFFECTIVENESS)

        inst:AddComponent("heater")
        inst.components.heater.equippedheat = TUNING.OE_FROZEN_TOOL.HEAT

        inst:AddComponent("weapon")
        inst.components.weapon:SetDamage(data.damage or TUNING.OE_FROZEN_TOOL.DEFAULT_DAMAGE)
        if data.debuffable ~= nil then
            inst.components.weapon.onattack = OnAttack
        end

        inst:AddComponent("equippable")
        inst.components.equippable:SetOnEquip(OnEquip)
        inst.components.equippable:SetOnUnequip(OnUnequip)

        inst:AddComponent("perishable")
        inst.components.perishable:SetPerishTime(data.perishtime or TUNING.PERISH_FAST)
        inst.components.perishable:StartPerishing()
        inst.components.perishable:SetOnPerishFn(OnPerish)

        inst._OnWorking = function(owner, data)
            OnWorking(inst, owner, data)
        end

        inst:WatchWorldState("season", OnUpdateSeason)
        OnUpdateSeason(inst, TheWorld.state.season)

        inst:ListenForEvent("firemelt", OnStartFireMelt)
        inst:ListenForEvent("stopfiremelt", OnStopFireMelt)

        inst.OnLoad = OnLoad

        MakeHauntableLaunch(inst)

        return inst
    end

    return Prefab("oe_frozen_tool_"..data.name, fn, assets)
end

local tools =
{
    -- Chilled Axe
    {
        name        = "axe",
        bank        = "axe",
        build       = "axe",
        tags        = { "sharp" },
        float       = { 1.2, 0.75, 1.2 },
        sym_build   = "swap_axe",
        action      = ACTIONS.CHOP,
    },

    -- Chilled Pickaxe
    {
        name        = "pickaxe",
        bank        = "pickaxe",
        build       = "pickaxe",
        tags        = { "sharp" },
        sym_build   = "swap_pickaxe",
        action      = ACTIONS.MINE,
    },

    -- Chilled Shovel
    {
        name        = "shovel",
        bank        = "shovel",
        build       = "shovel",
        float       = { 0.8, 0.4, 0.8 },
        sym_num     = 7,
        sym_build   = "swap_shovel",
        action      = ACTIONS.DIG,
        damage      = TUNING.OE_FROZEN_TOOL_SHOVEL_DAMAGE,
    },

    -- Frozen Mallet
    {
        name        = "hammer",
        bank        = "hammer",
        build       = "swap_hammer",
        tags        = { "hammer" },
        float       = { 0.7, 0.4, 0.7 },
        sym_num     = -13,
        sym_build   = "swap_hammer",
        action      = ACTIONS.HAMMER,
        damage      = TUNING.OE_FROZEN_TOOL_HAMMER_DAMAGE,
        debuffable  = true,
    },
}

local prefabs = {}

for i, v in ipairs(tools) do
    table.insert(prefabs, MakeFrozenTool(v))
end

return unpack(prefabs)