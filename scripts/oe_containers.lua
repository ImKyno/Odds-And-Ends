
-- Custom containers.
local containers = require("containers")
local params     = {}

local containers_widgetsetup_base = containers.widgetsetup
function containers.widgetsetup(container, prefab, data, ...)
    local t = params[prefab or container.inst.prefab]

    if t ~= nil then
        for k, v in pairs(t) do
            container[k]	= v
        end

        container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
    else
        containers_widgetsetup_base(container, prefab, data, ...)
    end
end

params.oe_mini_klaus_sack =
{
    widget =
    {
        slotpos =
        {
            Vector3(-37.5, 32 + 4, 0),
            Vector3(37.5, 32 + 4, 0),
            Vector3(-37.5, -(32 + 4), 0),
            Vector3(37.5, -(32 + 4), 0),
        },

        animbank = "ui_chest_2x2",
        animbuild = "ui_chest_2x2",

        pos = Vector3(0, 160, 0),
        side_align_tip = 190,
    },

    type = "chest",
}

function params.oe_mini_klaus_sack.itemtestfn(container, item, slot)
    return not (item:HasTag("irreplaceable")
    or item:HasTag("_container")
    or item:HasTag("bundle")
    or item:HasTag("nobundling"))
end