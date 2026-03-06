local assets = {
    Asset("ANIM", "anim/mesa_rock_clay.zip"),
}

local prefabs = {
    "rocks",
    "rock_break_fx",
}

-------------------------------------------------------------------------------------------------

local MIN_TINT = 0.8

-------------------------------------------------------------------------------------------------

local function Hash01(n)
    n = (n * 1103515245 + 12345) % 2147483648
    return n / 2147483648
end

-------------------------------------------------------------------------------------------------

local function OnWork(inst, worker, workleft)
    if workleft > 0 then
        if not inst.AnimState:IsCurrentAnimation("idle_1") then
            inst.AnimState:PlayAnimation("idle_1")
        end
    end
end

local function OnFinish(inst, worker)
    local pt = inst:GetPosition()
    SpawnPrefab("rock_break_fx").Transform:SetPosition(pt.x, pt.y, pt.z)
    inst.components.lootdropper:DropLoot(pt)
    inst:Remove()
end

-------------------------------------------------------------------------------------------------

local function fn()

    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)

    inst.AnimState:SetBank("mesa_rock_clay")
    inst.AnimState:SetBuild("mesa_rock_clay")
    inst.AnimState:PlayAnimation("idle_1", false)

    inst:DoTaskInTime(0, function(i)
        if i.AnimState ~= nil and i.GUID ~= nil then
            local c = MIN_TINT + (1 - MIN_TINT) * Hash01(i.GUID)
            i.AnimState:SetMultColour(c, c, c, 1)
        end
    end)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = true

    inst:AddComponent("inspectable")

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot({"mesa_clay"})

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(5)
    inst.components.workable:SetOnWorkCallback(OnWork)
    inst.components.workable:SetOnFinishCallback(OnFinish)

    MakeHauntableWork(inst)

    return inst
end

-------------------------------------------------------------------------------------------------

return Prefab("mesa_rock_clay", fn, assets, prefabs)