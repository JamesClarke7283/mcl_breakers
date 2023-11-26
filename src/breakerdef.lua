-- Shared core definition table
breakerdef = {
	is_ground_content = false,
	sounds = mcl_sounds.node_sound_stone_defaults(),
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local name = player:get_player_name()
		if minetest.is_protected(pos, name) then
			minetest.record_protection_violation(pos, name)
			return 0
		else
			return count
		end
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local name = player:get_player_name()
		if minetest.is_protected(pos, name) then
			minetest.record_protection_violation(pos, name)
			return 0
		else
			return stack:get_count()
		end
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local name = player:get_player_name()
		if minetest.is_protected(pos, name) then
			minetest.record_protection_violation(pos, name)
			return 0
		else
			return stack:get_count()
		end
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local meta = minetest.get_meta(pos)
		local meta2 = meta:to_table()
		meta:from_table(oldmetadata)
		local inv = meta:get_inventory()
		for i = 1, inv:get_size("main") do
			local stack = inv:get_stack("main", i)
			if not stack:is_empty() then
				local p = { x = pos.x + math.random(0, 10) / 10 - 0.5, y = pos.y, z = pos.z + math.random(0, 10) / 10 - 0.5 }
				minetest.add_item(p, stack)
			end
		end
		meta:from_table(meta2)
	end,
	_mcl_blast_resistance = 3.5,
	_mcl_hardness = 3.5,
	mesecons = {
		effector = {
			-- Break block with tool when triggered
			action_on = function(pos, node)
				local meta = minetest.get_meta(pos)
				local inv = meta:get_inventory()
				local breakpos, breakdir
				if node.name == "mcl_breakers:breaker" then
					breakdir = vector.multiply(minetest.facedir_to_dir(node.param2), -1)
					breakpos = vector.add(pos, breakdir)
				elseif node.name == "mcl_breakers:breaker_up" then
					breakdir = { x = 0, y = 1, z = 0 }
					breakpos = { x = pos.x, y = pos.y + 1, z = pos.z }
				elseif node.name == "mcl_breakers:breaker_down" then
					breakdir = { x = 0, y = -1, z = 0 }
					breakpos = { x = pos.x, y = pos.y - 1, z = pos.z }
				end
				local breaknode = minetest.get_node(breakpos)
				local breaknodedef = minetest.registered_nodes[breaknode.name]
				local stacks = {}
				for i = 1, inv:get_size("main") do
					local stack = inv:get_stack("main", i)
					if not stack:is_empty() then
						table.insert(stacks, { stack = stack, stackpos = i })
					end
				end
				local tool
				local stackdef
				local stackpos
				for _, stack in ipairs(stacks) do
					stackdef = stack.stack:get_definition()
					stackpos = stack.stackpos

					-- Break on first matching tool
					if (function()
						if not stackdef then
							return
						end

						local iname = stack.stack:get_name()

						if not mcl_autogroup.can_harvest(breaknode.name, iname) then
							return
						end

						tool = stack.stack
						return true
					end)() then
						break
					end
				end
				if not tool then
					return
				end

				-- This is a fake player object that the breaker will use
				-- It may break in testing
				local breaker_digger = {
					is_player = function(self)
						return false
					end,
					get_player_name = function(self)
						return ""
					end,
					get_wielded_item = function(self)
						return tool
					end,
					set_wielded_item = function(self, item)
						inv:set_stack("main", stackpos, item)
						return true
					end,
					get_inventory = function(self)
						return nil
					end
				}
				breaknodedef.on_dig(breakpos, breaknode, breaker_digger)
			end,
			rules = mesecon.rules.alldirs,
		},
	},
	on_rotate = on_rotate,
}