local assets =
{
    Asset("ANIM", "anim/deer_ice_flakes.zip"),
}

local function GetScaleFromSize(size)
    if size == "small" then
        return 0.7
    elseif size == "large" then
        return 1.5
    end

    return 1
end

local function StartFX(inst, target, delay)
    if inst._inittask and target and target:IsValid() then
        inst._inittask:Cancel()

        if delay then
            inst._inittask = inst:DoTaskInTime(delay, StartFX, target)
        else
            inst._inittask = nil
            inst._size = (target:HasTag("smallcreature") and "small")
            or (target:HasAnyTag("largecreature") and "large")
            or "med"

            local scale = GetScaleFromSize(inst._size)
            inst.AnimState:SetScale(scale, scale, scale)

            inst.AnimState:PlayAnimation("idle")
            inst.AnimState:PushAnimation("idle")
        end
    end
end

local function SetFXLevel(inst, level)
    if not inst.killed and inst._level ~= level then
        inst._level = level

        if not inst._inittask then
            inst.AnimState:PushAnimation("idle", true)
            inst.AnimState:SetFrame(math.random(inst.AnimState:GetCurrentAnimationNumFrames()) - 1)
        end
    end
end

local function KillFX(inst)
    if inst._inittask then
        inst:Remove()
    elseif not inst.killed then
        inst.killed = true
        inst:DoTaskInTime(inst.AnimState:GetCurrentAnimationLength(), inst.Remove)
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("deer_ice_flakes")
    inst.AnimState:SetBuild("deer_ice_flakes")
    inst.AnimState:SetFinalOffset(7)

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst._level = 1
    inst._inittask = inst:DoTaskInTime(0, inst.Remove)
    inst.StartFX = StartFX
    inst.SetFXLevel = SetFXLevel
    inst.KillFX = KillFX

    inst.persists = false

    return inst
end

return Prefab("oe_debuff_frozen", fn, assets)