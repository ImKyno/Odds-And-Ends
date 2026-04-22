local _G              = GLOBAL
local require         = _G.require
local AccessoriesUtil = require("oe_accessories_util")

-- Island Adventures Mod Support for the Gnawed Wooden Totem accessory.
if TUNING.OE_ISLAND_ADVENTURES_ENABLED and TUNING.OE_ISLAND_ADVENTURES_CORE_ENABLED then
    local function IATreesPostInit(inst)
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
                    local living = inst.prefab == "livingjungletree" or inst.prefab == "livingjungletree_halloween"

                    for i = 1, amount do
                        inst.components.lootdropper:SpawnLootPrefab(living and "livinglog" or "log")
                    end
                end
            end

            if _onfinish ~= nil then
                _onfinish(inst, worker)
            end
        end)
    end

    local IA_TREES =
    {
        "palmtree",
        "jungletree",
        "mangrovetree",

        "livingjungletree_halloween",
        "livingjungletree",
    }

    for k, v in pairs(IA_TREES) do
        AddPrefabPostInit(v, IATreesPostInit)
    end
end