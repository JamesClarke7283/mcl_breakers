-- init.lua: Entry point for the MineClone2 Block Breaker mod
S = minetest.get_translator(minetest.get_current_modname())
local modpath = minetest.get_modpath(minetest.get_current_modname())
local srcpath = modpath .. "/src/"

-- Load required files
dofile(srcpath .. "helper.lua")
dofile(srcpath .. "breakerdef.lua")
dofile(srcpath .. "register.lua")
dofile(srcpath .. "crafting.lua")
dofile(srcpath .. "mod_compat.lua")
