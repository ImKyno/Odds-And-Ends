local _G              = GLOBAL
local require         = _G.require
local AccessoriesUtil = require("oe_accessories_util")

local function LeifPostInit(inst)
    local function OnDeathWoodTotem(inst, data)
        if data ~= nil and data.afflicter ~= nil and data.afflicter:HasTag("luckywoodcutter") then
            local log_bonus = AccessoriesUtil.WoodTotemBonusLog[inst.prefab]
            local burnable = inst.components.burnable

            if log_bonus ~= nil and not burnable ~= nil and burnable:IsBurning() then
                local amount = log_bonus[1] or log_bonus or 0

                for i = 1, amount do
                    inst.components.lootdropper:SpawnLootPrefab("livinglog")
                end
            end
        end
    end

    inst:AddTag("wood_totem_valid")

    if not _G.TheWorld.ismastersim then
        return
    end

    inst:ListenForEvent("death", OnDeathWoodTotem)
end

local LEIFS =
{
    "leif",
    "leif_sparse",
}

for k, v in pairs(LEIFS) do
    AddPrefabPostInit(v, LeifPostInit)
end