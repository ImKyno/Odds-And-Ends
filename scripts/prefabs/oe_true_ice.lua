local assets =
{
    Asset("ANIM", "anim/ice.zip"),
}

local names = { "f1","f2","f3" }

local function OnPerish(inst)
    local owner = inst.components.inventoryitem.owner
    local stacksize = inst.components.stackable:StackSize()

    if owner ~= nil then
        if owner.components.moisture ~= nil then
            owner.components.moisture:DoDelta(2 * stacksize)
        elseif owner.components.inventoryitem ~= nil then
            owner.components.inventoryitem:AddMoisture(4 * stacksize)
        end

        inst:Remove()
    else
        local x, y, z = inst.Transform:GetWorldPosition()
        
        if TheWorld.components.farming_manager ~= nil then
            TheWorld.components.farming_manager:AddSoilMoistureAtPoint(x, y, z, stacksize * TUNING.ICE_MELT_GROUND_MOISTURE_AMOUNT * 2)
        end

        inst.persists = false
        inst.components.inventoryitem.canbepickedup = false

        inst.AnimState:PlayAnimation("melt")
        inst:ListenForEvent("animover", inst.Remove)
    end
end

local function OnSave(inst, data)
    data.anim = inst.animname
end

local function OnLoad(inst, data)
    if data ~= nil and data.anim then
        inst.animname = data.anim
        inst.AnimState:PlayAnimation(inst.animname)
    end
end

local function OnUseAsWaterSource(inst)
    if inst.components.stackable:IsStack() then
        inst.components.stackable:Get():Remove()
    else
        inst:Remove()
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "med", 0.05, { 0.65, 0.5, 0.65 })

    inst.AnimState:SetBank("ice")
    inst.AnimState:SetBuild("ice")

    inst:AddTag("frozen")
    inst:AddTag("molebait")
    inst:AddTag("watersource")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.animname = names[math.random(#names)]
    inst.AnimState:PlayAnimation(inst.animname)

    inst:AddComponent("inspectable")
    inst:AddComponent("snowmandecor")
    inst:AddComponent("smotherer")
    inst:AddComponent("tradable")
    inst:AddComponent("bait")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "ice"

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_MEDITEM

    inst:AddComponent("watersource")
    inst.components.watersource.onusefn = OnUseAsWaterSource
    inst.components.watersource.override_fill_uses = 1

    inst:AddComponent("repairer")
    inst.components.repairer.repairmaterial = MATERIALS.OE_TRUE_ICE
    inst.components.repairer.finiteusesrepairvalue = TUNING.OE_TRUE_ICE.REPAIR_AMOUNT

    --[[
    inst:AddComponent("edible")
    inst.components.edible.healthvalue = TUNING.OE_TRUE_ICE.HEALTH
    inst.components.edible.hungervalue = TUNING.OE_TRUE_ICE.HUNGER
    inst.components.edible.sanityvalue = TUNING.OE_TRUE_ICE.SANITY
    inst.components.edible.temperaturedelta = TUNING.COLD_FOOD_BONUS_TEMP
    inst.components.edible.temperatureduration = TUNING.FOOD_TEMP_BRIEF * 1.5
    inst.components.edible.foodtype = FOODTYPE.GENERIC
    inst.components.edible.degrades_with_spoilage = false
    ]]--

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    MakeHauntableLaunchAndSmash(inst)

    return inst
end

return Prefab("oe_true_ice", fn, assets)