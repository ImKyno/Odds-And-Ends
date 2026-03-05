local _G         = GLOBAL
local LOCKS      = _G.LOCKS
local KEYS       = _G.KEYS
local LOCKS_KEYS = _G.LOCKS_KEYS

-- Keys and Locks for generating biomes together.
local KEYCOUNT = 1
local LOCKCOUNT = 1

for k, v in pairs(KEYS) do
	KEYCOUNT = KEYCOUNT + 1
end

for k, v in pairs(LOCKS) do
	LOCKCOUNT = LOCKCOUNT + 1
end

KEYS["MESA"] = KEYCOUNT
LOCKS["MESA"] = LOCKCOUNT
LOCKS_KEYS[LOCKS.MESA] = { KEYS.MESA }