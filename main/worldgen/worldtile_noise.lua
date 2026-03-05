local _G                 = GLOBAL
local require            = _G.require
local WORLD_TILES        = _G.WORLD_TILES
local NoiseTileFunctions = require("noisetilefunctions")

local function GetTileForMesaNoise(noise)
	if noise < 0.25 then
		return WORLD_TILES.DESERT_DIRT
	elseif noise < 0.35 then
		return WORLD_TILES.MESA_ROCKY
	elseif noise < 0.40 then
		return WORLD_TILES.MESA_CRACKED
	elseif noise < 0.45 then
		return WORLD_TILES.MESA_SAND_CREAM
	elseif noise < 0.50 then
		return WORLD_TILES.MESA_SAND_ORANGE
	elseif noise < 0.75 then
		return WORLD_TILES.MESA_SAND_PEACH
	end

	return WORLD_TILES.MESA_SAND_PINK
end

NoiseTileFunctions[WORLD_TILES.MESA_NOISE] = GetTileForMesaNoise