--[[
	**********************************************
	***                       Kohlrabi                        ***
	**********************************************
	
]]--

local farming_default = true

-- looking if farming_redo is activ?
if(farming.mod ~= nil and farming.mod == "redo") then

	farming_default = false

end

if (farming_default) then

	print("[MOD] " .. minetest.get_current_modname() .. " set to default mode.")
	
	-- kohlrabi
	farming.register_plant("kohlrabi:kohlrabi", {
		description = "Kohlrabi",
		inventory_image = "kohlrabi_seed.png",
		steps = 6,
		minlight = 13,
		maxlight = default.LIGHT_MAX,
		fertility = {"grassland"},
		groups = {flammable = 4},
	})
	
	-- Register for Mapgen
	minetest.register_node("kohlrabi:wild_kohlrabi", {
		description = "Wild kohlrabi",
		paramtype = "light",
		walkable = false,
		drop = { 
				items = { 
						{items = {"kohlrabi:seed_kohlrabi 3"}},
						{items = {"kohlrabi:kohlrabi"}},
					}
				},
		drawtype = "plantlike",
		paramtype2 = "facedir",
		tiles = {"kohlrabi_kohlrabi_5.png"},
		groups = {snappy = 3, dig_immediate=1, flammable=2, plant=1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.5, -0.5, 0.5, -0.35, 0.5}, -- side f
				},
		},
	})

else

	print("[MOD] " .. minetest.get_current_modname() .. " set to redo mode.")
	
	-- kohlrabi
	minetest.register_node("kohlrabi:seed", {
		description = "Kohlrabi Seed",
		tiles = {"kohlrabi_seed.png"},
		inventory_image = "kohlrabi_seed.png",
		wield_image = "kohlrabi_seed.png",
		drawtype = "signlike",
		groups = {seed = 1, snappy = 3, attached_node = 1, dig_immediate=1, flammable = 4},
		paramtype = "light",
		paramtype2 = "wallmounted",
		walkable = false,
		sunlight_propagates = true,
		selection_box = farming.select,
		on_place = function(itemstack, placer, pointed_thing)
			return farming.place_seed(itemstack, placer, pointed_thing, "kohlrabi:kohlrabi_1")
		end,
	})

	minetest.register_craftitem("kohlrabi:kohlrabi", {
		description = "Kohlrabi",
		inventory_image = "kohlrabi_kohlrabi.png",
		groups = {flammable = 4},
		})
	
	-- kohlrabi definition
	local crop_def = {
		drawtype = "plantlike",
		tiles = {"kohlrabi_kohlrabi_1.png"},
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		drop =  "",
		selection_box = farming.select,
		groups = {
			flammable = 4, snappy=3, dig_immediate=1, plant = 1, attached_node = 1,
			not_in_creative_inventory = 1, growing = 1
		},
		sounds = default.node_sound_leaves_defaults()
	}

	-- stage 1
	minetest.register_node("kohlrabi:kohlrabi_1", table.copy(crop_def))

	-- stage 2
	crop_def.tiles = {"kohlrabi_kohlrabi_2.png"}
	minetest.register_node("kohlrabi:kohlrabi_2", table.copy(crop_def))

	-- stage 3
	crop_def.tiles = {"kohlrabi_kohlrabi_3.png"}
	minetest.register_node("kohlrabi:kohlrabi_3", table.copy(crop_def))

	-- stage 4
	crop_def.tiles = {"kohlrabi_kohlrabi_4.png"}
	crop_def.drop = {
		items = {
			{items = {"kohlrabi:seed"}, rarity = 2},
		}
	}
	minetest.register_node("kohlrabi:kohlrabi_4", table.copy(crop_def))

	-- stage 5
	crop_def.tiles = {"kohlrabi_kohlrabi_5.png"}
	crop_def.drop = {
		items = {
			{items = {"kohlrabi:seed"}, rarity = 1},
			{items = {"kohlrabi:seed"}, rarity = 2},
			{items = {"kohlrabi:kohlrabi"}, rarity = 3}
		}
	}
	minetest.register_node("kohlrabi:kohlrabi_5", table.copy(crop_def))

	-- stage 6
	crop_def.tiles = {"kohlrabi_kohlrabi_6.png"}
	crop_def.drop = {
		items = {
			{items = {"kohlrabi:kohlrabi"}, rarity = 1},
			{items = {"kohlrabi:kohlrabi"}, rarity = 2},
			{items = {"kohlrabi:kohlrabi"}, rarity = 3},
			{items = {"kohlrabi:seed"}, rarity = 1},
			{items = {"kohlrabi:seed"}, rarity = 1},
			{items = {"kohlrabi:seed"}, rarity = 3},
		}
	}
	minetest.register_node("kohlrabi:kohlrabi_6", table.copy(crop_def))

	-- Register for Mapgen
	minetest.register_node("kohlrabi:wild_kohlrabi", {
		description = "Wild Kohlrabi",
		paramtype = "light",
		walkable = false,
		drop = { 
				items = { 
						{items = {"kohlrabi:seed 3"}},
						{items = {"kohlrabi:kohlrabi"}},
					}
				},
		drawtype = "plantlike",
		paramtype2 = "facedir",
		tiles = {"kohlrabi_kohlrabi_5.png"},
		groups = {snappy=3, dig_immediate=1, flammable=2, plant=1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.5, -0.5, 0.5, -0.35, 0.5}, -- side f
				},
		},
	})
	
end -- if( default ....)


minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass", "default:dirt_with_dry_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.02,
		spread = {x = 100, y = 100, z = 100},
		seed = 6349,
		octaves = 4,
		persist = 0.6
	},
	y_min = 30,
	y_max = 120,
	decoration = "kohlrabi:wild_kohlrabi",
})

minetest.register_craft({
	type = "fuel",
	recipe = "kohlrabi:kohlrabi",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "kohlrabi:kohlrabi",
	burntime = 3
})

minetest.register_craftitem("kohlrabi:kohlrabi", {
	description = "Kohlrabi",
	inventory_image = "kohlrabi_kohlrabi.png",
	groups = {flammable = 1, food = 1, eatable = 1},
	on_use = minetest.item_eat(3),
})

minetest.register_craftitem("kohlrabi:kohlrabi_roasted", {
	description = "Roasted Kohlrabi",
	groups = {food = 1},
	inventory_image = "kohlrabi_roasted.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craft({
	type = "cooking",
	cooktime = 20,
	output = "kohlrabi:kohlrabi_roasted",
	recipe = "kohlrabi:kohlrabi"
})

minetest.register_craft({
	type = "fuel",
	recipe = "kohlrabi:kohlrabi_roasted",
	burntime = 4
})

minetest.register_node("kohlrabi:soup", {
	description = "Kohlrabi Soup (raw)",
	drawtype = "plantlike",
	tiles = {"kohlrabi_soup.png"},
	inventory_image = "kohlrabi_soup.png",
	wield_image = "kohlrabi_soup.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	output = "kohlrabi:soup",
	recipe = {	{"kohlrabi:kohlrabi", "group:food_oil", "parsley:parsley"},
				{"", "bucket:bucket_water", ""},
				{"", "group:food_bowl", ""}
			},
			replacements = {{"bucket:bucket_water", "bucket:bucket_empty"},
						   {"group:food_oil", "vessels:glass_bottle"},
						}
})

minetest.register_craft({
	output = "kohlrabi:soup",
	recipe = {	{"kohlrabi:kohlrabi", "group:food_oil", "parsley:parsley"},
				{"", "bucket:bucket_river_water", ""},
				{"", "group:food_bowl", ""}
			},
			replacements = {{"bucket:bucket_river_water", "bucket:bucket_empty"},
						   {"group:food_oil", "vessels:glas_bottle"},
						}
})

minetest.register_node("kohlrabi:soup_cooked", {
	description = "Kohlrabi Soup",
	drawtype = "plantlike",
	tiles = {"kohlrabi_soup_cooked.png"},
	inventory_image = "kohlrabi_soup_cooked.png",
	wield_image = "kohlrabi_soup_cooked.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	on_use = minetest.item_eat(5,  "lettuce:bowl"),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "kohlrabi:soup_cooked",
	recipe = "kohlrabi:soup"
})

print("[MOD] " .. minetest.get_current_modname() .. " loaded.")