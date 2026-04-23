local _G              = GLOBAL
local require         = _G.require
local AccessoriesUtil = require("oe_accessories_util")

-- Cherry Forest Mod Support for the Gnawed Wooden Totem accessory.
if TUNING.OE_CHERRY_FOREST_ENABLED then
    local function CherryTreesPostInit(inst)
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

    local CHERRY_TREES =
    {
        "cherry_tree",
        "cherry_tree_white",
    }

    for k, v in pairs(CHERRY_TREES) do
        AddPrefabPostInit(v, CherryTreesPostInit)
    end
end