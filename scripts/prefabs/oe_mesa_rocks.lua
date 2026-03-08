local assets = 
{
    Asset("ANIM", "anim/mesa_rock_clay.zip"),

    Asset("IMAGE", "images/oe_minimapimages.tex"),
    Asset("ATLAS", "images/oe_minimapimages.xml"),
}

local prefabs = 
{
    "rocks",
    "rock_break_fx",

    "oe_mesa_clay",
}

SetSharedLootTable("oe_mesa_rock_clay",
{
    {"oe_mesa_clay", 1.00},
    {"oe_mesa_clay", 1.00},
    {"oe_mesa_clay", 1.00},
    {"oe_mesa_clay", 0.25},
})

local MIN_TINT = 0.8

-- KYNO:
-- I have no clue what this is.
local function Hash01(n)
    n = (n * 1103515245 + 12345) % 2147483648
    return n / 2147483648
end

local function OnHit(inst, worker, workleft)
    if workleft > 0 then
        if not inst.AnimState:IsCurrentAnimation("idle_1") then
            inst.AnimState:PlayAnimation("idle_1")
        end
    end
end

local function OnWorked(inst, worker)
    local pt = inst:GetPosition()

    local fx = SpawnPrefab("rock_break_fx")
    fx.Transform:SetPosition(pt.x, pt.y, pt.z)

    if inst.components.lootdropper ~= nil then
        inst.components.lootdropper:DropLoot(pt)
    end

    inst:Remove()
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("oe_mesa_rock_clay.tex")

    MakeObstaclePhysics(inst, 1)

    inst.AnimState:SetBank("mesa_rock_clay")
    inst.AnimState:SetBuild("mesa_rock_clay")
    inst.AnimState:PlayAnimation("idle_1", false)

    --[[
    inst:DoTaskInTime(0, function(i)
        if i.AnimState ~= nil and i.GUID ~= nil then
            local c = MIN_TINT + (1 - MIN_TINT) * Hash01(i.GUID)
            i.AnimState:SetMultColour(c, c, c, 1)
        end
    end)
    ]]--

    MakeSnowCoveredPristine(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    local color = 0.75 + math.random() * 0.25
    inst.AnimState:SetMultColour(color, color, color, 1)

    inst:AddComponent("inspectable")

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable("oe_mesa_rock_clay")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(TUNING.OE_MESA_ROCK_CLAY_WORKLEFT)
    inst.components.workable:SetOnWorkCallback(OnHit)
    inst.components.workable:SetOnFinishCallback(OnWorked)

    MakeSnowCovered(inst)
    MakeHauntableWork(inst)

    return inst
end

return Prefab("oe_mesa_rock_clay", fn, assets, prefabs)