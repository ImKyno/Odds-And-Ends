local TREASUREBAGS_UTIL = require("prefabs/oe_treasurebags_util")

local TreasureBag = Class(function(self, inst)
    self.inst = inst
    self.loot_key = nil
end)

local function AddLoot(items, prefab, min, max)
    min = min or 1
    max = max or min

    local amount = math.random(min, max)

    for i = 1, amount do
        table.insert(items, prefab)
    end
end

local function GenerateLoot(def)
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

    if def.oneof then
        local choice = def.oneof[math.random(#def.oneof)]

        if choice ~= nil then
            if type(choice) == "string" then
                AddLoot(items, choice, 1, 1)
            else
                AddLoot(items, choice.prefab, choice.min, choice.max)
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

local function DropLoot(inst, loot)
    local x, y, z = inst.Transform:GetWorldPosition()

    for _, prefab in ipairs(loot) do
        local item = SpawnPrefab(prefab)

        if item ~= nil then
            item.Transform:SetPosition(x, y, z)

            if item.components.inventoryitem ~= nil then
                item.components.inventoryitem:OnDropped(true)
            end
        end
    end
end

function TreasureBag:SetLootTable(key)
    self.loot_key = key
end

function TreasureBag:Open(doer)
    if self.loot_key == nil then
        print("Odds and Ends Mod - TreasureBag: Missing loot_key.")
        return
    end

    local def = TREASUREBAGS_UTIL.LootKey[self.loot_key]

    if def == nil then
        print("Odds and Ends Mod - TreasureBag: Missing loot for", self.loot_key)
        return
    end

    local loot = GenerateLoot(def)

    if #loot > 0 then
        DropLoot(self.inst, loot)
    end

    if self.inst.components.stackable ~= nil then
        local stack = self.inst.components.stackable

        if stack:StackSize() > 1 then
            stack:Get():Remove()
            return
        end
    end

    self.inst:Remove()
end

return TreasureBag