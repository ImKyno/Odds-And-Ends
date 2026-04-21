local _G              = GLOBAL
local require         = _G.require
local AccessoriesUtil = require("oe_accessories_util")

local function EvergreensPostInit(inst)
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

            if log_bonus ~= nil and not inst:HasTag("burnt") then
                local amount = log_bonus[1] or log_bonus or 0

                for i = 1, amount do
                    inst.components.lootdropper:SpawnLootPrefab("log")
                end
            end
        end

        if _onfinish ~= nil then
            _onfinish(inst, worker)
        end
    end)
end

local EVERGREENS =
{
    "evergreen",
    -- "evergreen_short",
    -- "evergreen_normal",
    -- "evergreen_tall",

    -- "evergreen_burnt",

    "evergreen_sparse",
    -- "evergreen_sparse_short",
    -- "evergreen_sparse_normal",
    -- "evergreen_sparse_tall",

    "twiggytree",
    -- "twiggy_short",
    -- "twiggy_normal",
    -- "twiggy_tall",
}

for k, v in pairs(EVERGREENS) do
    AddPrefabPostInit(v, EvergreensPostInit)
end