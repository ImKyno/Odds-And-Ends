local _G              = GLOBAL
local require         = _G.require
local AccessoriesUtil = require("oe_accessories_util")

local function CaveBananaTreesPostInit(inst)
    inst:AddTag("wood_totem_valid")

    if not _G.TheWorld.ismastersim then
        return
    end

    local workable = inst.components.workable

    if workable == nil then
        return
    end

    local _onfinish = workable.onfinish

    workable:SetOnFinishCallback(function(inst, worker)
        if worker ~= nil and worker:HasTag("luckywoodcutter") then
            local log_bonus = AccessoriesUtil.WoodTotemBonusLog[inst.prefab]

            if log_bonus ~= nil then
                local amount = log_bonus[1] or log_bonus or 0

                for i = 1, amount do
                    inst.components.lootdropper:SpawnLootPrefab("log")
                end
            end

            local charcoal_bonus = AccessoriesUtil.WoodTotemBonusCharcoal[inst.prefab]

            if charcoal_bonus ~= nil then
                local amount = charcoal_bonus[1] or charcoal_bonus or 0

                for i = 1, amount do
                    inst.components.lootdropper:SpawnLootPrefab("charcoal")
                end
            end
        end

        if _onfinish ~= nil then
            _onfinish(inst, worker)
        end
    end)
end

local CAVE_BANANA_TREES =
{
    "cave_banana_tree",
    "cave_banana_burnt",
}

for k, v in pairs(CAVE_BANANA_TREES) do
    AddPrefabPostInit(v, CaveBananaTreesPostInit)
end