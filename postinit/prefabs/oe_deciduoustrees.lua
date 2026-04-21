local _G              = GLOBAL
local require         = _G.require
local AccessoriesUtil = require("oe_accessories_util")

local function DeciduousTreesPostInit(inst)
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
                local amount = inst.monster and log_bonus[2] or log_bonus[1] or log_bonus or 0

                for i = 1, amount do
                    inst.components.lootdropper:SpawnLootPrefab(inst.monster and "livinglog" or "log")
                end
            end
        end

        if _onfinish ~= nil then
            _onfinish(inst, worker)
        end
    end)
end

local DECIDUOUSTREES =
{
    "deciduoustree",
    -- "deciduoustree_short",
    -- "deciduoustree_normal",
    -- "deciduoustree_tall",
}

for k, v in pairs(DECIDUOUSTREES) do
    AddPrefabPostInit(v, DeciduousTreesPostInit)
end