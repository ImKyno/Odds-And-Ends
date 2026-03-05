local _G          = GLOBAL
local require     = _G.require
local WORLD_TILES = _G.WORLD_TILES

local INIT_WORLDGEN =
{
    "keys_locks",
    "static_layouts",
    "worldtile_defs",
}

local INIT_WORLDGEN_PREINIT =
{
    "task",
    "taskset",
    "level",
}

local INIT_WORLDGEN_MAP_TASKS =
{
    "forest_tasks",
}

local INIT_WORLDGEN_MAP_ROOMS =
{
    "mesa",
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