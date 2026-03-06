local _G            = GLOBAL
local STRINGS       = _G.STRINGS
local NAMES         = STRINGS.NAMES
local RECIPE_DESC   = STRINGS.RECIPE_DESC


STRINGS.GLOOMY_PACK = {}

local function SetItemsDescribeStrings(item_name, strings)
	for character,str in pairs(strings) do
		STRINGS.CHARACTERS[string.upper(character)].DESCRIBE[string.upper(item_name)] = str
	end
end

-- Template

--------------------------------------------------------------------------------------------------------------------------------------------------

--[[
local TODO_STRINGS =
{
    GENERIC      = "TODO",
    WAXWELL      = "TODO",
    WOLFGANG     = "TODO",
    WX78         = "TODO",
    WILLOW       = "TODO",
    WENDY        = "TODO",
    WOODIE       = "TODO",
    WICKERBOTTOM = "TODO",
    WATHGRITHR   = "TODO",
    WEBBER       = "TODO",
    WINONA       = "TODO",
    WORTOX       = "TODO",
    WORMWOOD     = "TODO",
    WALTER       = "TODO",
    WARLY        = "TODO",
    WURT         = "TODO",
    WANDA        = "TODO",
}

NAMES.TODO = "TODO"

SetItemsDescribeStrings("TODO", TODO_STRINGS)]]


--------------------------------------------------------------------------------------------------------------------------------------------------

local MESA_CLAY_STRINGS =
{
    GENERIC      = "Sunbaked clay from the mesa.",
    WAXWELL      = "The earth, hardened by relentless sun.",
    WOLFGANG     = "Wolfgang could build strong house with this!",
    WX78         = "COMPRESSED MINERAL SUBSTRATE",
    WILLOW       = "Dry dirt. Not even good for burning.",
    WENDY        = "Even the soil here feels weary.",
    WOODIE       = "Clay like this makes sturdy stuff.",
    WICKERBOTTOM = "Naturally cured clay deposits. Quite useful.",
    WATHGRITHR   = "The ground itself forged by sun and time!",
    WEBBER       = "It rhymes with play!",
    WINONA       = "Good material for bricks if you ask me.",
    WORTOX       = "The desert's own pottery clay, hyuyu!",
    WORMWOOD     = "Hard Earth",
    WALTER       = "Bet the desert heat baked it solid.",
    WARLY        = "Earth, ready for shaping.",
    WURT         = "Hard mud! Glorp!",
    WANDA        = "Time and heat did all the work here.",
}

NAMES.MESA_CLAY = "Clay"

--------------------------------------------------------------------------------------------------------------------------------------------------

local MESA_ROCK_CLAY_STRINGS =
{
    GENERIC      = "A clay-packed mesa rock.",
    WAXWELL      = "A monument to erosion and patience.",
    WOLFGANG     = "Strong rock! Wolfgang smash!",
    WX78         = "SEDIMENTARY OBSTRUCTION DETECTED",
    WILLOW       = "It's just a big dusty rock.",
    WENDY        = "Even stone crumbles with time.",
    WOODIE       = "That'd make a mess of your pickaxe.",
    WICKERBOTTOM = "A hardened clay formation shaped by the elements.",
    WATHGRITHR   = "A worthy foe for the hammer!",
    WEBBER       = "It's like a giant clay cookie!",
    WINONA       = "Looks packed full of useful material.",
    WORTOX       = "Stone and clay, stuck together forever!",
    WORMWOOD     = "Hard Earth Lump",
    WALTER       = "These mesas must've formed over ages.",
    WARLY        = "Earth compressed into stone.",
    WURT         = "Big mud rock!",
    WANDA        = "The desert had plenty of time to make this.",
}

NAMES.MESA_ROCK_CLAY = "Clay Boulder"

--------------------------------------------------------------------------------------------------------------------------------------------------

local MESA_CACTUS_SMALL_STRINGS =
{
    GENERIC      = "A tiny cactus trying its best.",
    WAXWELL      = "A stubborn life in a stubborn land.",
    WOLFGANG     = "Tiny pokey plant!",
    WX78         = "MINOR SPIKED FLORA DETECTED",
    WILLOW       = "Too small to bother burning.",
    WENDY        = "Even this little plant refuses to give up.",
    WOODIE       = "Small fella. Still prickly though.",
    WICKERBOTTOM = "A juvenile desert cactus.",
    WATHGRITHR   = "A warrior in miniature!",
    WEBBER       = "It's a baby cactus!",
    WINONA       = "Careful, those little ones still poke.",
    WORTOX       = "A prickly little desert sprite!",
    WORMWOOD     = "Tiny Poke Plant",
    WALTER       = "Even small cacti can survive out here.",
    WARLY        = "A modest desert ingredient.",
    WURT         = "Tiny pokey plant! Blort!",
    WANDA        = "Give it time. It'll grow.",
}

NAMES.MESA_CACTUS_SMALL = "Cactus"


