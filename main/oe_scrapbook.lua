local _G                 = GLOBAL
local require            = _G.require
local scrapbook_prefabs  = require("scrapbook_prefabs")
local scrapbookdata      = require("screens/redux/scrapbookdata")

-- Import our Scrapbook content.
local OE_SCRAPBOOKDATA   = require("oe_scrapbookdata")

for k, v in pairs(OE_SCRAPBOOKDATA) do
    scrapbook_prefabs[k] = true
    scrapbookdata[k]     = v
end

-- This lets players knows what kind of stuff the mod has without giving too much information about it.
AddPlayerPostInit(function(inst)
    if inst and _G.TheScrapbookPartitions then
        for k, v in pairs(OE_SCRAPBOOKDATA) do
            _G.TheScrapbookPartitions:SetViewedInScrapbook(k)
        end
    end
end)