local _G = GLOBAL

-- Sound listeners for clients.
local function PlayerClassifiedPostInit(inst)
    local function OnRepairTrueIceEvent(inst)
        if inst._parent ~= nil and _G.TheFocalPoint.entity:GetParent() == inst._parent then
            _G.TheFocalPoint.SoundEmitter:PlaySound("dontstarve/creatures/together/antlion/sfx/sand_to_glass")
        end
    end

    local function OnRepairTrueIce(parent)
        parent.player_classified.repairtrueiceevent:push()
    end

    local function RegisterNetListeners(inst)
        if _G.TheWorld.ismastersim then
            inst:ListenForEvent("repairtrueice", OnRepairTrueIce, inst.entity:GetParent())
        end

        inst:ListenForEvent("action.repairtrueice", OnRepairTrueIceEvent)
    end

    inst.repairtrueiceevent = _G.net_event(inst.GUID, "action.repairtrueice")

    inst:DoStaticTaskInTime(0, RegisterNetListeners)
end

AddPrefabPostInit("player_classified", PlayerClassifiedPostInit)