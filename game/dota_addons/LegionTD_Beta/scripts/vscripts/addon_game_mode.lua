--[[
	Basic Barebones
]]

--[[
-- Required files to be visible from anywhere
require( 'timers' )
require( 'LegionTD' )
require( 'physics' )
require( 'FlashUtil' )
require( 'buildinghelper' )
require( 'abilities' )
]]

BASE_MODULES = {
	'util',
	'timers',
	'physics',
	'FlashUtil',
	'lib.statcollection',
	'abilities',
	'buildinghelper',
	'LegionTD',
}

--MODULE LOADER STUFF
BASE_LOG_PREFIX = '[LEGION_TD]'

LOG_FILE = "log/SampleRTS.txt"

InitLogFile(LOG_FILE, "[[ LEGION_TD ]]")

function log(msg)
	print(BASE_LOG_PREFIX .. msg)
	AppendToLogFile(LOG_FILE, msg .. '\n')
end

function err(msg)
	display('[X] '..msg, COLOR_RED)
end

function warning(msg)
	display('[W] '..msg, COLOR_DYELLOW)
end

function display(text, color)
	color = color or COLOR_LGREEN

	log('> '..text)

	Say(nil, color..text, false)
end

local function load_module(mod_name)
	-- load the module in a monitored environment
	local status, err_msg = pcall(function()
		require(mod_name)
	end)

	if status then
		log(' module ' .. mod_name .. ' OK')
	else
		err(' module ' .. mod_name .. ' FAILED: '..err_msg)
	end
end
--END OF MODULE LOADER STUFF

-- Load all modules
for i, mod_name in pairs(BASE_MODULES) do
	load_module(mod_name)
end


function Precache( context )
	-- NOTE: IT IS RECOMMENDED TO USE A MINIMAL AMOUNT OF LUA PRECACHING, AND A MAXIMAL AMOUNT OF DATADRIVEN PRECACHING.
	-- Precaching guide: https://moddota.com/forums/discussion/119/precache-fixing-and-avoiding-issues

	--[[
	This function is used to precache resources/units/items/abilities that will be needed
	for sure in your game and that cannot or should not be precached asynchronously or 
	after the game loads.

	See GameMode:PostLoadPrecache() in barebones.lua for more information
	]]

	print("[LEGION_TD] Performing pre-load precache")
	PrecacheUnitByNameSync("creep_wave_1", context)
	PrecacheUnitByNameSync("creep_wave_2", context)
	PrecacheUnitByNameSync("creep_wave_3", context)
	PrecacheUnitByNameSync("creep_wave_4", context)
	PrecacheUnitByNameSync("creep_wave_5", context)
	PrecacheUnitByNameSync("creep_wave_6", context)
	PrecacheUnitByNameSync("creep_wave_7", context)
	PrecacheUnitByNameSync("creep_wave_8", context)
	PrecacheUnitByNameSync("creep_wave_9", context)
	PrecacheUnitByNameSync("creep_wave_10", context)

	--[[
	-- Particles can be precached individually or by folder
	-- It it likely that precaching a single particle system will precache all of its children, but this may not be guaranteed
	PrecacheResource("particle", "particles/econ/generic/generic_aoe_explosion_sphere_1/generic_aoe_explosion_sphere_1.vpcf", context)
	PrecacheResource("particle_folder", "particles/test_particle", context)

	-- Models can also be precached by folder or individually
	-- PrecacheModel should generally used over PrecacheResource for individual models
	PrecacheResource("model_folder", "particles/heroes/antimage", context)
	PrecacheResource("model", "particles/heroes/viper/viper.vmdl", context)
	PrecacheModel("models/heroes/viper/viper.vmdl", context)

	-- Sounds can precached here like anything else
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_gyrocopter.vsndevts", context)

	-- Entire items can be precached by name
	-- Abilities can also be precached in this way despite the name
	PrecacheItemByNameSync("example_ability", context)
	PrecacheItemByNameSync("item_example_item", context)

	-- Entire heroes (sound effects/voice/models/particles) can be precached with PrecacheUnitByNameSync
	-- Custom units from npc_units_custom.txt can also have all of their abilities and precache{} blocks precached in this way
	PrecacheUnitByNameSync("npc_dota_hero_ancient_apparition", context)
	PrecacheUnitByNameSync("npc_dota_hero_enigma", context)
	]]

	-- Particles can be precached individually or by folder
	-- It it likely that precaching a single particle system will precache all of its children, but this may not be guaranteed
	PrecacheResource("particle_folder", "particles/buildinghelper", context)

	-- Sounds can precached here like anything else
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_gyrocopter.vsndevts", context)

	-- Entire items can be precached by name
	-- Abilities can also be precached in this way despite the name
	PrecacheItemByNameSync("example_ability", context)

	-- Entire heroes (sound effects/voice/models/particles) can be precached with PrecacheUnitByNameSync
	-- Custom units from npc_units_custom.txt can also have all of their abilities and precache{} blocks precached in this way
	PrecacheUnitByNameSync("npc_dota_hero_ancient_apparition", context)
	PrecacheUnitByNameSync("npc_dota_hero_enigma", context)
	PrecacheUnitByNameSync("npc_dota_hero_antimage", context)
	PrecacheUnitByNameSync("npc_dota_hero_drow_ranger", context)
	PrecacheUnitByNameSync("npc_dota_hero_tinker", context)
	PrecacheUnitByNameSync("npc_dota_hero_jakiro", context)

	PrecacheUnitByNameSync("npc_barracks", context) -- Building that spawns units
	PrecacheUnitByNameSync("npc_peasant", context) -- Unit that builds and gathers resources
	PrecacheItemByNameSync("item_rally", context)
end

-- Create the game mode when we activate
function Activate()
	GameRules.GameMode = GameMode()
	GameRules.GameMode:InitGameMode()
	--GameRules.GameMode:OnGameInProgress()
	--GameRules.SampleRTS = SampleRTS()
	--GameRules.SampleRTS:InitSampleRTS()
end
