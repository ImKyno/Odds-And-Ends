local _G              = GLOBAL
local require         = _G.require
local AccessoriesUtil = require("oe_accessories_util")

local function PalmconeTreesPostInit(inst)
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
                local amount = 0

                if type(log_bonus) == "table" then
                    local stage = inst.components.growable ~= nil and inst.components.growable.stage or 1
                    amount = log_bonus[stage] or 0
                else
                    amount = log_bonus or 0
                end

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

local PALMCONETREES =
{
    "palmconetree",
    -- "palmconetree_short",
    -- "palmconetree_normal",
    -- "palmconetree_tall",
}

for k, v in pairs(PALMCONETREES) do
    AddPrefabPostInit(v, PalmconeTreesPostInit)
end