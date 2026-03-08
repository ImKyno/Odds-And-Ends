local function ChooseTranslationTable(tbl)
    return tbl[locale] or tbl[1]
end

local STRINGS = 
{
    NAME = 
    {
        "Odds and Ends",
        zh  = "Odds and Ends" ,
        pt  = "De Tudo um Pouco",
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

        LANGUAGE =
        {
            NAME =
            {
                "Language",
                zh  = "语言",
                pt  = "Idioma",
            },

            HOVER =
            {
                "Choose the language for the mod.\nYou can submit your translation in our Discord.",
                zh  = "选择Mod的语言。 \n您可以在我们的 Discord 中提交您的翻译。",
                pt  = "Escolha o idioma do Mod.\nVocê pode enviar sua tradução em nosso Discord.",
            },

            HOVER_OPTIONS =
            {
                en  = "English",
                zh  = "简体中文",
                pt  = "Português",

                DESCRIPTION =
                {
                    en  = "Default Localization",
                    zht = "作者： 匿名作者",
                    pt  = "Autor: Kyno",
                },
            },
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

server_filter_tags           = {"Odds and Ends", "OE", "Entertainment", "Kyno", "Glooms"}

icon                         = "ModiconOE.tex"
icon_atlas                   = "ModiconOE.xml"

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

local LANGUAGE_LABEL         = ChooseTranslationTable(STRINGS.SETTINGS.LANGUAGE.NAME)
local LANGUAGE_HOVER         = ChooseTranslationTable(STRINGS.SETTINGS.LANGUAGE.HOVER)
local LANGUAGE_OPTIONS       =
{
    {
        description          = STRINGS.SETTINGS.LANGUAGE.HOVER_OPTIONS.en,
        hover                = STRINGS.SETTINGS.LANGUAGE.HOVER_OPTIONS.DESCRIPTION.en,
        data                 = false
    },
    {
        description          = STRINGS.SETTINGS.LANGUAGE.HOVER_OPTIONS.zh,
        hover                = STRINGS.SETTINGS.LANGUAGE.HOVER_OPTIONS.DESCRIPTION.zh,
        data                 = "zh"
    },
    {
        description          = STRINGS.SETTINGS.LANGUAGE.HOVER_OPTIONS.pt,
        hover                = STRINGS.SETTINGS.LANGUAGE.HOVER_OPTIONS.DESCRIPTION.pt,
        data                 = "pt"
    },
}

configuration_options        =
{
    { name                   = "LANGUAGE", label = LANGUAGE_LABEL, hover = LANGUAGE_HOVER, options = LANGUAGE_OPTIONS, default = false },
}