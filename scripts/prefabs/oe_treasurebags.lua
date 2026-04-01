local TreasureBagsLoot = require("oe_treasurebagsloot")

local function MakeTreasureBag(data)
    local assets =
    {
        Asset("ANIM", "anim/oe_treasurebags.zip"),

        Asset("IMAGE", "images/oe_inventoryimages.tex"),
        Asset("ATLAS", "images/oe_inventoryimages.xml"),
        Asset("ATLAS_BUILD", "images/oe_inventoryimages.xml", 256),
    }

    local function OnUnwrapped(inst, pos, doer)
        local inventoryitem = inst.components.inventoryitem
        local owner = inventoryitem:GetGrandOwner() or inventoryitem.owner

        if owner ~= nil and owner.components.inventory ~= nil then
            owner.components.inventory:DropItem(inst)
        end

        inst.components.inventoryitem.canbepickedup = false
        inst.components.unwrappable.canbeunwrapped = false

        if doer ~= nil and doer.SoundEmitter ~= nil then
            doer.SoundEmitter:PlaySound("dontstarve/common/together/packaged")
        end

        inst:Remove()
    end

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)
        MakeInventoryFloatable(inst)

        inst.AnimState:SetBank("oe_treasurebags")
        inst.AnimState:SetBuild("oe_treasurebags")
        inst.AnimState:PlayAnimation("idle")

        inst.AnimState:OverrideSymbol("swap_bag", "oe_treasurebags", data.name)

        inst:AddTag("nosteal") -- Prevents creatures from stealing it.
        inst:AddTag("treasurebag")
	
        if data.tags ~= nil then
            for i, v in pairs(data.tags) do
                inst:AddTag(v)
            end
        end

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("inventoryitem")

        inst:AddComponent("inspectable")
        inst.components.inspectable.nameoverride = "OE_TREASUREBAG" -- Generic quote for all of them, too lazy to do one by one.

        inst:AddComponent("unwrappable")
        inst.components.unwrappable:SetOnUnwrappedFn(OnUnwrapped)

        AddTreasureBagLoot(inst, data.name)

        return inst
    end
	
    return Prefab("oe_treasurebag_"..data.name, fn, assets)
end

local treasurebags =
{
    {
        name = "deerclops",
    },
}

local prefabs = {}

for i, v in ipairs(treasurebags) do
    table.insert(prefabs, MakeTreasureBag(v))
end

return unpack(prefabs)