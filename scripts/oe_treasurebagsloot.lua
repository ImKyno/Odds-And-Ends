require("tuning")

local TreasureBagsLoot = TUNING.OE_TREASUREBAGSLOOT or {}

local function AddLoot(items, prefab, min, max)
    min = min or 1
    max = max or min

    local amount = math.random(min, max)

    for i = 1, amount do
        table.insert(items, prefab)
    end
end

local function GenerateTreasureBagLoot(def)
    local items = {}

    if def == nil then
        return items
    end

    if def.guaranteed then
        for _, entry in ipairs(def.guaranteed) do
            if type(entry) == "string" then
                AddLoot(items, entry, 1, 1)
            else
                AddLoot(items, entry.prefab, entry.min, entry.max)
            end
        end
    end

    if def.chance then
        for _, entry in ipairs(def.chance) do
            local rolls = entry.rolls or 1

            for i = 1, rolls do
                if math.random() < (entry.chance or 1) then
                    AddLoot(items, entry.prefab, entry.min, entry.max)
                end
            end
        end
    end

    return items
end

function AddTreasureBagLoot(inst, loot_key, doer)
    local def = TUNING.OE_TREASUREBAGSLOOT[loot_key]

    if def == nil then
        print("Odds and Ends Mod - TreasureBagsLoot: Missing loot for:", loot_key)
        return
    end

    local loot = GenerateTreasureBagLoot(def)

    if #loot > 0 then
        if inst.components.unwrappable ~= nil then
            inst.components.unwrappable:WrapItems(loot, doer)
        end
    end
end

-- Support for other Mods.
function AddTreasureBag(name, data)
    TUNING.OE_TREASUREBAGSLOOT[name] = data
end

function GetTreasureBag(name)
    return TUNING.OE_TREASUREBAGSLOOT[name]
end

return TreasureBagsLoot