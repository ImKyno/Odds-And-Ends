local _G          = GLOBAL
local require     = _G.require
local WORLD_TILES = _G.WORLD_TILES

require("map/oe_lockandkey")

local INIT_WORLDGEN =
{
    "oe_static_layouts",
    "oe_worldtile_defs",
    "oe_worldtile_noise",
}

local INIT_WORLDGEN_PREINIT =
{
    "oe_task",
    "oe_taskset",
    "oe_level",
}

local INIT_WORLDGEN_MAP_TASKS =
{
    "oe_forest_tasks",
}

local INIT_WORLDGEN_MAP_ROOMS =
{
    "oe_mesa",
}

for _, v in pairs(INIT_WORLDGEN) do
    modimport("main/worldgen/"..v)
end

for _, v in pairs(INIT_WORLDGEN_PREINIT) do
    modimport("postinit/worldgen/"..v)
end

for _, v in pairs(INIT_WORLDGEN_MAP_TASKS) do
    modimport("scripts/map/tasks/"..v)
end

for _, v in pairs(INIT_WORLDGEN_MAP_ROOMS) do
    modimport("scripts/map/rooms/"..v)
end