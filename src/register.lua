local horizontal_def = table.copy(breakerdef)
horizontal_def.description = S("Breaker")
horizontal_def._tt_help = S("4 inventory slots") .. "\n" .. S("Breaks a block with available tools.")
horizontal_def._doc_items_longdesc = S("A breaker is a block which acts as a redstone component which, when powered with redstone power, breaks a block. It has a container with 4 inventory slots.")
horizontal_def._doc_items_usagehelp = S("Place the breaker in one of 6 possible directions. The “hole” is where the breaker will break from. Use the breaker to access its inventory. Insert the tools you wish to use. Supply the breaker with redstone energy to use the tools on a block.")

function horizontal_def.after_place_node(pos, placer, itemstack, pointed_thing)
	setup_breaker(pos)
	orientate_breaker(pos, placer)
end

horizontal_def.tiles = {
	"mcl_breakers_breaker_top.png", "mcl_breakers_breaker_bottom.png",
	"mcl_breakers_breaker_side.png", "mcl_breakers_breaker_side.png",
	"mcl_breakers_breaker_side.png", "mcl_breakers_breaker_front_horizontal.png"
}
horizontal_def.paramtype2 = "facedir"
horizontal_def.groups = { pickaxey = 1, container = 2, material_stone = 1 }

minetest.register_node("mcl_breakers:breaker", horizontal_def)

-- Down breaker
local down_def = table.copy(breakerdef)
down_def.description = S("Downwards-Facing Breaker")
down_def.after_place_node = setup_breaker
down_def.tiles = {
	"mcl_breakers_breaker_top.png", "mcl_breakers_breaker_front_vertical.png",
	"mcl_breakers_breaker_side.png", "mcl_breakers_breaker_side.png",
	"mcl_breakers_breaker_side.png", "mcl_breakers_breaker_side.png"
}
down_def.groups = { pickaxey = 1, container = 2, not_in_creative_inventory = 1, material_stone = 1 }
down_def._doc_items_create_entry = false
down_def.drop = "mcl_breakers:breaker"
minetest.register_node("mcl_breakers:breaker_down", down_def)

-- Up breaker
-- The up breaker is almost identical to the down breaker , it only differs in textures
local up_def = table.copy(down_def)
up_def.description = S("Upwards-Facing Breaker")
up_def.tiles = {
	"mcl_breakers_breaker_front_vertical.png", "mcl_breakers_breaker_bottom.png",
	"mcl_breakers_breaker_side.png", "mcl_breakers_breaker_side.png",
	"mcl_breakers_breaker_side.png", "mcl_breakers_breaker_side.png"
}
minetest.register_node("mcl_breakers:breaker_up", up_def)