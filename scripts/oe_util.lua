-- Bunch of helper functions to be used elsewhere in the mod.

-- Hack for spawning loot through harvestable component with more parameters.
function SpawnLootForPicker(prefab, amount, picker, pos, inst)
    for i = 1, amount do
        local loot = SpawnPrefab(prefab)

        if loot ~= nil then
            if picker ~= nil and picker.components.inventory ~= nil then
                picker.components.inventory:GiveItem(loot, nil, pos)
            else
                LaunchAt(loot, inst, nil, 1, 1)
            end
        end
    end
end

-- Our version of weighted_chance_random.
function ChooseWeightedRandom(choices)
    local function weighted_total(choices)
        local total = 0

        for choice, weight in pairs(choices) do
            total = total + weight
        end

        return total
    end

    local threshold = math.random() * weighted_total(choices)
    local last_choice

    for choice, weight in pairs(choices) do
        threshold = threshold - weight

        if threshold <= 0 then
            return choice
        end

        last_choice = choice
    end

    return last_choice
end

-- Helper function for combat component to force creatures to give up on player.
function ForceCombatGiveUp(player)
    local x, y, z = player.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, 30, { "_combat" }, { "INLIMBO" })

    for _, ent in ipairs(ents) do
        if ent.components.combat ~= nil and ent.components.combat.target == player then
            ent.components.combat:GiveUp()
        end
    end
end