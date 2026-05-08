local assets =
{
    Asset("ANIM", "anim/backpack.zip"),
    Asset("ANIM", "anim/swap_krampus_sack.zip"),
    Asset("ANIM", "anim/ui_chest_2x2.zip"),
}

local function OnOpen(inst)
    -- inst.AnimState:PlayAnimation("open")
    
    local SoundEmitter = (inst.components.inventoryitem:GetGrandOwner() or inst).SoundEmitter

    if SoundEmitter then
        SoundEmitter:PlaySound("dontstarve/creatures/together/klaus/chain_foley")
    end
end

local function OnClose(inst)
    if not inst.components.inventoryitem:IsHeld() then
        -- inst.AnimState:PlayAnimation("close")
        -- inst.AnimState:PushAnimation("closed", false)
    else
        -- inst.AnimState:PlayAnimation("closed", false)
    end

    local SoundEmitter = (inst.components.inventoryitem:GetGrandOwner() or inst).SoundEmitter

    if SoundEmitter then
        SoundEmitter:PlaySound("dontstarve/creatures/together/klaus/chain_foley")
    end
end

local function OnPutInInventory(inst)
    inst.components.container:Close()
    -- inst.AnimState:PlayAnimation("closed", false)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("krampus_sack.png")

    MakeInventoryPhysics(inst)

    local swap_data = {bank = "backpack1", anim = "anim"}
    MakeInventoryFloatable(inst, "med", 0.1, 0.65, nil, nil, swap_data)

    inst.AnimState:SetBank("backpack1")
    inst.AnimState:SetBuild("swap_krampus_sack")
    inst.AnimState:PlayAnimation("anim")

    inst:AddTag("waterproofer")
    inst:AddTag("portablestorage")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        inst.OnEntityReplicated = function(inst) 
            inst.replica.container:WidgetSetup("oe_mini_klaus_sack") 
        end

        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory)
    inst.components.inventoryitem:ChangeImageName("krampus_sack")

    inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(0)

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("oe_mini_klaus_sack")
    inst.components.container:EnableInfiniteStackSize(true)
    inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
    inst.components.container.skipclosesnd = true
    inst.components.container.skipopensnd = true
    inst.components.container.droponopen = true

    MakeHauntableLaunchAndDropFirstItem(inst)

    return inst
end

return Prefab("oe_mini_klaus_sack", fn, assets)