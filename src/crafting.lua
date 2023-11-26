minetest.register_craft({
	output = "mcl_breakers:breaker",
	recipe = {
		{ "mcl_ocean:prismarine", "mcl_ocean:prismarine", "mcl_ocean:prismarine", },
		{ "mcl_ocean:prismarine", "mcl_ocean:sea_lantern", "mcl_ocean:prismarine", },
		{ "mcl_ocean:prismarine", "mesecons:redstone", "mcl_ocean:prismarine", },
	}
})