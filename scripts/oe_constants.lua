require("constants")
require("componentutil")

-- New materials for repairer and repairable components.
OE_MATERIALS =
{
    OE_TRUE_ICE = "oe_true_ice",
}

for k, v in pairs(OE_MATERIALS) do
    MATERIALS[k] = v
end