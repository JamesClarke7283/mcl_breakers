-- setup.lua: Contains the setup_breaker function for MineClone2 Block Breaker mod

function setup_breaker(pos, placer)
    -- Set formspec and inventory
    local S = minetest.get_translator(minetest.get_current_modname())
    local form = "size[9,8.75]" ..
        "label[0,4.0;" .. minetest.formspec_escape(minetest.colorize("#313131", S("Inventory"))) .. "]" ..
        "list[current_player;main;0,4.5;9,3;9]" ..
        mcl_formspec.get_itemslot_bg(0, 4.5, 9, 3) ..
        "list[current_player;main;0,7.74;9,1;]" ..
        mcl_formspec.get_itemslot_bg(0, 7.74, 9, 1) ..
        "label[3,0;" .. minetest.formspec_escape(minetest.colorize("#313131", S("Breaker"))) .. "]" ..
        "list[context;main;3,0.5;2,2;]" ..
        mcl_formspec.get_itemslot_bg(3, 0.5, 2, 2) ..
        "listring[context;main]" ..
        "listring[current_player;main]"

    local meta = minetest.get_meta(pos)
    meta:set_string("formspec", form)
    local inv = meta:get_inventory()
    inv:set_size("main", 4)

    -- Store the owner's name if placer is a player
    if placer and placer:is_player() then
        meta:set_string("owner", placer:get_player_name())
    end
end

-- orientation.lua: Contains the orientate_breaker function for MineClone2 Block Breaker mod

function orientate_breaker(pos, placer)
    -- Not placed by a player
    if not placer then return end

    -- Pitch in degrees
    local pitch = placer:get_look_vertical() * (180 / math.pi)

    local node = minetest.get_node(pos)
    if pitch > 55 then
        -- Upwards-facing
        minetest.swap_node(pos, { name = "mcl_breakers:breaker_up", param2 = node.param2 })
    elseif pitch < -55 then
        -- Downwards-facing
        minetest.swap_node(pos, { name = "mcl_breakers:breaker_down", param2 = node.param2 })
    end
    -- Otherwise, the node remains in its default horizontal orientation
end
