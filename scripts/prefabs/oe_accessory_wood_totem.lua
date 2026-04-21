local assets =
{
    -- Asset("ANIM", "anim/oe_accessory_boots_moose.zip"),
    Asset("ANIM", "anim/torso_dragonfly.zip"),

    Asset("IMAGE", "images/oe_inventoryimages.tex"),
    Asset("ATLAS", "images/oe_inventoryimages.xml"),
    Asset("ATLAS_BUILD", "images/oe_inventoryimages.xml", 256),
}

local function OnEquip(inst, owner)
    if owner ~= nil then
        owner:AddTag("luckywoodcutter")
    end
end

local function OnUnequip(inst, owner)
    if owner ~= nil then
        owner:RemoveTag("luckywoodcutter")
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)

    inst.AnimState:SetBank("torso_dragonfly")
    inst.AnimState:SetBuild("torso_dragonfly")
    inst.AnimState:PlayAnimation("anim")

    inst:AddTag("oe_accessory")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:ChangeImageName("fishsticks")

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.OE_ACCESSORY
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("oe_accessory_wood_totem", fn, assets)

-- Wood Totem logs by tree type and stage.
--[[
* Evergreen (3 Stages) = 2 Logs, 4 Logs, 6 Logs
* Evergreen Sparse (3 Stages) = 2 Logs, 4 Logs, 6 Logs
* Deciduous Tree (3 Stages) = 2 Logs, 4 Logs, 6 Logs
* Twiggy Tree (3 Stages) = 2 Logs, 4 Logs, 6 Logs
* Totally Living Tree (2 Stages) = 2 Logs, 4 Logs
* Spiky Tree (1 Stage) = 3 Logs
* Lune Tree (3 Stages) = 4 Logs, 6 Logs, 8 Logs
* Palmcone Tree (3 Stages) = 4 Logs, 6 Logs, 8 Logs
* Driftwood (1 Stage) - 3 Driftwood Logs
* Cave Banana Tree (1 Stage) = 3 Logs
* Mushtree (1 Stage) = 3 Logs
* Lunar Mushtree (1 Stage) = 3 Logs
* Knobbly Tree (4 Stages) = 4 Logs, 6 Logs, 8 Logs, 16 Logs
]]--