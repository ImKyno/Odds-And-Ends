local function ChooseTranslationTable(tbl)
    return tbl[locale] or tbl[1]
end

local STRINGS = 
{
    NAME = 
    {
        "Project Everything",
        pt  = "Project Everything",
    },

    DESCRIPTION =
    {
[[
󰀏 Henlo, this mod is everything I want to add mod. Cool right?

󰀌 Mod Version: 0.0-A (Alpha)
󰀧 Update: gulp...
]],
        pt  =
[[
󰀏 Henlo, this mod is everything I want to add mod. Cool right?

󰀌 Mod Version: 0.0-A (Alpha)
󰀧 Update: gulp...
]],
    },

    SETTINGS = 
    {
        DISABLED =
        {
            "Disabled",
            zh  = "已禁用",
            pt  = "Desativado",
        },

        ENABLED =
        {
            "Enabled",
            zh  = "已启用",
            pt  = "Ativado",
        },
    },
}

name                         = ChooseTranslationTable(STRINGS.NAME)
version                      = "0.0-A (Alpha)"

description                  = ChooseTranslationTable(STRINGS.DESCRIPTION)

author                       = "Kyno and Glooms 󰀃"
api_version                  = 10
priority                     = 0 -- Above 0 = Override other mods. | Below 0 = Overriden by other mods.

dst_compatible               = true
all_clients_require_mod      = true
client_only_mod              = false

server_filter_tags           = {"Entertainment", "Kyno", "Glooms"}

icon                         = "ModiconPE.tex"
icon_atlas                   = "ModiconPE.xml"

local NONE_LABEL             = ""
local NONE_OPTIONS           = 
{
    {
        description          = "", 
        data                 = false
    }
}

local TOGGLE_OPTIONS         =
{
    {
        description          = ChooseTranslationTable(STRINGS.SETTINGS.DISABLED),
        data                 = false
    },
    {
        description          = ChooseTranslationTable(STRINGS.SETTINGS.ENABLED),
        data                 = true
    },
}

configuration_options        =
{

}