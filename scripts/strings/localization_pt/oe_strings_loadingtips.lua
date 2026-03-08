-- Common Dependencies.
local _G            = GLOBAL
local require       = _G.require
local STRINGS       = _G.STRINGS
local WEIGHT_START  = _G.LOADING_SCREEN_TIP_CATEGORY_WEIGHTS_START
local WEIGHT_END    = _G.LOADING_SCREEN_TIP_CATEGORY_WEIGHTS_END
local TIPS_HOF      = STRINGS.UI.LOADING_SCREEN_OTHER_TIPS

-- New Loading Tips and Lore.
local LOADINGTIPS   =
{
    TEST            = "Henlo gloms...!",
}

for k, v in pairs(LOADINGTIPS) do
    AddLoadingTip(TIPS_OE, "TIPS_OE_"..k, v)
end

-- TO DO: Loading tips icon.
-- SetLoadingTipCategoryIcon("OTHER", "images/oe_loadingtips_icon.xml", "oe_loadingtips_icon.tex")

SetLoadingTipCategoryWeights(WEIGHT_START, {OTHER = 4, CONTROLS = 1, SURVIVAL = 1, LORE = 1, LOADING_SCREEN = 1})
SetLoadingTipCategoryWeights(WEIGHT_END,   {OTHER = 4, CONTROLS = 1, SURVIVAL = 1, LORE = 1, LOADING_SCREEN = 1})