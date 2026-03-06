local assets =
{
    Asset("ANIM", "anim/mesa_cactus_small.zip"),
}

local prefabs =
{
    "cactus_meat",
    "cactus_flower",
}

-------------------------------------------------------

local function onpickedfn(inst, picker)
    inst.Physics:SetActive(false)

    inst.AnimState:PlayAnimation(inst.has_flower and "picked_flower" or "picked")
    inst.AnimState:PushAnimation("empty", true)

    if picker ~= nil then
        if picker.components.combat ~= nil
        and not (picker.components.inventory ~= nil and picker.components.inventory:EquipHasTag("bramble_resistant"))
        and not picker:HasTag("shadowminion") then
            picker.components.combat:GetAttacked(inst, TUNING.CACTUS_DAMAGE)
            picker:PushEvent("thorns")
        end

        if inst.has_flower then
            local flower = SpawnPrefab("cactus_flower")

            if picker.components.inventory ~= nil then
                picker.components.inventory:GiveItem(flower, nil, inst:GetPosition())
            else
                flower.Transform:SetPosition(inst.Transform:GetWorldPosition())
            end
        end
    end

    inst.has_flower = false
end

local function onregenfn(inst)

    if TheWorld.state.issummer then
        inst.AnimState:PlayAnimation("grow_flower")
        inst.AnimState:PushAnimation("idle_flower", true)
        inst.has_flower = true
    else
        inst.AnimState:PlayAnimation("grow")
        inst.AnimState:PushAnimation("idle", true)
        inst.has_flower = false
    end

    inst.Physics:SetActive(true)
end

local function makeemptyfn(inst)
    inst.Physics:SetActive(false)
    inst.AnimState:PlayAnimation("empty", true)
    inst.has_flower = false
end

local function OnEntityWake(inst)

    if inst.components.pickable ~= nil and inst.components.pickable.canbepicked then
        inst.has_flower = TheWorld.state.issummer
        inst.AnimState:PlayAnimation(inst.has_flower and "idle_flower" or "idle", true)
    else
        inst.AnimState:PlayAnimation("empty", true)
        inst.has_flower = false
    end

end


-------------------------------------------------------

local function fn()

    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst.MiniMapEntity:SetIcon("mesa_cactus_small.png")

    inst.AnimState:SetBank("mesa_cactus_small")
    inst.AnimState:SetBuild("mesa_cactus_small")
    inst.AnimState:PlayAnimation("idle", true)

    inst:AddTag("plant")
    inst:AddTag("thorny")

    MakeObstaclePhysics(inst, .25)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    -------------------------------------------------------

    inst:AddComponent("inspectable")

    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/harvest_sticks"
    inst.components.pickable:SetUp("cactus_meat", TUNING.CACTUS_REGROW_TIME)

    inst.components.pickable.onregenfn      = onregenfn
    inst.components.pickable.onpickedfn     = onpickedfn
    inst.components.pickable.makeemptyfn    = makeemptyfn

    -------------------------------------------------------

    MakeLargeBurnable(inst)
    MakeMediumPropagator(inst)

    AddToRegrowthManager(inst)

    inst.OnEntityWake = OnEntityWake

    MakeHauntableIgnite(inst)

    return inst
end

return Prefab("mesa_cactus_small", fn, assets, prefabs)