local _G              = GLOBAL
local require         = _G.require
local AccessoriesUtil = require("oe_accessories_util")

-- Heap of Foods Mod Support for the Gnawed Wooden Totem accessory.
if TUNING.OE_HEAP_OF_FOODS_ENABLED then
    local function HofTreesPostInit(inst)
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

                    local driftwood = inst:HasTag("meadowislandtree")

                    for i = 1, amount do
                        inst.components.lootdropper:SpawnLootPrefab(driftwood and "driftwood_log" or "log")
                    end
                end
            end

            if _onfinish ~= nil then
                _onfinish(inst, worker)
            end
        end)
    end

    local HOF_TREES =
    {
        "kyno_bananatree",

        "kyno_sugartree_short",
        "kyno_sugartree_normal",
        "kyno_sugartree_ruined2",
        "kyno_sugartree",

        "kyno_meadowisland_tree",
        "kyno_meadowisland_pikotree",

        "kyno_kokonuttree",
    }

    for k, v in pairs(HOF_TREES) do
        AddPrefabPostInit(v, HofTreesPostInit)
    end
end