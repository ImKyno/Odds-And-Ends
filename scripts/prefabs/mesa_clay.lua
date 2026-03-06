local assets =
{
    Asset("ANIM", "anim/mesa_clay.zip"),
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

    inst.pickupsound = "rock"

    inst:AddTag("molebait")
    inst:AddTag("quakedebris")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "mesa_clay"
    inst.components.inventoryitem.atlasname = "images/inventory_images.xml"
    inst.components.inventoryitem:SetSinks(true)

	inst:AddComponent("snowmandecor")

    MakeHauntableLaunchAndSmash(inst)

    inst:AddComponent("bait")

    return inst
end

return Prefab("mesa_clay", fn, assets)
