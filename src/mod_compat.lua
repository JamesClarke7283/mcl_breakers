if minetest.get_modpath("screwdriver") then
	on_rotate = screwdriver.rotate_simple
end

-- Add entry aliases for the Help
if minetest.get_modpath("doc") then
	doc.add_entry_alias("nodes", "mcl_breakers:breaker", "nodes", "mcl_breakers:breaker_down")
	doc.add_entry_alias("nodes", "mcl_breakers:breaker", "nodes", "mcl_breakers:breaker_up")
end