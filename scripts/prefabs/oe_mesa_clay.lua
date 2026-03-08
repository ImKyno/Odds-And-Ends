local assets =
{
    Asset("ANIM", "anim/mesa_clay.zip"),

    Asset("IMAGE", "images/oe_inventoryimages.tex"),
    Asset("ATLAS", "images/oe_inventoryimages.xml"),
    Asset("ATLAS_BUILD", "images/oe_inventoryimages.xml", 256),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("mesa_clay")
    inst.AnimState:SetBuild("mesa_clay")
    inst.AnimState:PlayAnimation("anim")

    inst:AddTag("clay")
    inst:AddTag("molebait")
    inst:AddTag("quakedebris")

    inst.pickupsound = "rock"

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("snowmandecor")
    inst:AddComponent("bait")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:SetSinks(true)

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    MakeHauntableLaunchAndSmash(inst)

    return inst
end

return Prefab("oe_mesa_clay", fn, assets)