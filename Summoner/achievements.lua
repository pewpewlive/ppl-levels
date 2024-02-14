
--- BRONZE ---

ACHIEVEMENT_SCORE_BRONZE = false -- That was easy
ACHIEVEMENT_DESTROY_50_CUBES = false -- Cube crusher
ACHIEVEMENT_DESTROY_10_DIAMONDS = false -- Diamond smasher
ACHIEVEMENT_GET_18_OWOS = false -- Legion commander

--- ====== ---



--- SILVER ---

ACHIEVEMENT_SCORE_SILVER = false -- Real treasure
ACHIEVEMENT_DESTROY_HOLEY = false -- Dazzled death
ACHIEVEMENT_DESTROY_25_DAGGERS = false -- Too slow
ACHIEVEMENT_GET_36_OWOS = false -- Noone can stop us

--- ====== ---



--- GOLD ---

ACHIEVEMENT_SCORE_GOLD = false -- Shiny
ACHIEVEMENT_DESTROY_WARDEN = false -- Cute snowflake
ACHIEVEMENT_DESTROY_WARDEN_BY_MELEE = false -- I'm full of surprises
ACHIEVEMENT_DESTROY_OVERLORD_AND_WARDEN_BY_MELEE = false -- It's even funnier the second time

--- ==== ---

ACHIEVEMENT_PROGRESS_DESTROY_50_CUBES = 0
ACHIEVEMENT_PROGRESS_DESTROY_10_DIAMONDS = 0
ACHIEVEMENT_PROGRESS_DESTROY_25_DAGGERS = 0
ACHIEVEMENT_PROGRESS_DESTROY_OVERLORD_BY_MELEE = false
ACHIEVEMENT_PROGRESS_DESTROY_WARDEN_BY_MELEE = false


achievements_offset_bronze = -600fx
achievements_offset_silver = 0fx
achievements_offset_gold = 600fx

achievements_color_bronze = 0xaa4411aa
achievements_color_bronze_str = '#aa4411aa'
achievements_color_silver = 0xddddddbb
achievements_color_silver_str = '#ddddddbb'
achievements_color_gold = 0xffbb33ff
achievements_color_gold_str = '#ffbb33ff'

local appear_offset = 60

function print_achievements(x, y)
	if			TIMER == appear_offset + 10 then
		local id = new_string(x + achievements_offset_bronze, y + 150fx, 1fx, achievements_color_bronze_str .. '---')
		if pewpew.get_score_of_player(0) >= 256 then
			pewpew.customizable_entity_set_string(id, achievements_color_bronze_str .. 'That was easy')
		end
	elseif	TIMER == appear_offset + 20 then
	local id = new_string(x + achievements_offset_bronze, y + 50fx, 1fx, achievements_color_bronze_str .. '---')
		if ACHIEVEMENT_PROGRESS_DESTROY_50_CUBES >= 50 then
			pewpew.customizable_entity_set_string(id, achievements_color_bronze_str .. 'Cube crusher')
			pewpew.increase_score_of_player(0, 16)
		end
	elseif	TIMER == appear_offset + 30 then
		local id = new_string(x + achievements_offset_bronze, y - 50fx, 1fx, achievements_color_bronze_str .. '---')
		if ACHIEVEMENT_PROGRESS_DESTROY_10_DIAMONDS >= 10 then
			pewpew.customizable_entity_set_string(id, achievements_color_bronze_str .. 'Diamond smasher')
			pewpew.increase_score_of_player(0, 16)
		end
	elseif	TIMER == appear_offset + 40 then
		local id = new_string(x + achievements_offset_bronze, y - 150fx, 1fx, achievements_color_bronze_str .. '---')
		if OWO_AMOUNT >= 18fx then
			pewpew.customizable_entity_set_string(id, achievements_color_bronze_str .. 'Legion commander')
			pewpew.increase_score_of_player(0, 16)
		end
	elseif	TIMER == appear_offset + 50 then
		local id = new_string(x + achievements_offset_silver, y + 150fx, 1fx, achievements_color_silver_str .. '---')
		if pewpew.get_score_of_player(0) >= 512 then
			pewpew.customizable_entity_set_string(id, achievements_color_silver_str .. 'Real treasure')
		end
	elseif	TIMER == appear_offset + 60 then
		local id = new_string(x + achievements_offset_silver, y + 50fx, 1fx, achievements_color_silver_str .. '---')
		if ACHIEVEMENT_DESTROY_HOLEY then
			pewpew.customizable_entity_set_string(id, achievements_color_silver_str .. 'Dazzled death')
			pewpew.increase_score_of_player(0, 32)
		end
	elseif	TIMER == appear_offset + 70 then
		local id = new_string(x + achievements_offset_silver, y - 50fx, 1fx, achievements_color_silver_str .. '---')
		if ACHIEVEMENT_PROGRESS_DESTROY_25_DAGGERS >= 25 then
			pewpew.customizable_entity_set_string(id, achievements_color_silver_str .. 'Too slow')
			pewpew.increase_score_of_player(0, 32)
		end
	elseif	TIMER == appear_offset + 80 then
		local id = new_string(x + achievements_offset_silver, y - 150fx, 1fx, achievements_color_silver_str .. '---')
		if OWO_AMOUNT >= 18fx then
			pewpew.customizable_entity_set_string(id, achievements_color_silver_str .. 'Noone can stop us')
			pewpew.increase_score_of_player(0, 32)
		end 
	elseif	TIMER == appear_offset + 90 then
		local id = new_string(x + achievements_offset_gold, y + 150fx, 1fx, achievements_color_gold_str .. '---')
		if pewpew.get_score_of_player(0) >= 2048 then
			pewpew.customizable_entity_set_string(id, achievements_color_gold_str .. 'Shiny')
		end
	elseif	TIMER == appear_offset + 100 then
		local id = new_string(x + achievements_offset_gold, y + 50fx, 1fx, achievements_color_gold_str .. '---')
		if ACHIEVEMENT_DESTROY_WARDEN then
			pewpew.customizable_entity_set_string(id, achievements_color_gold_str .. 'Cute snowflake')
			pewpew.increase_score_of_player(0, 64)
		end
	elseif	TIMER == appear_offset + 110 then
		local id = new_string(x + achievements_offset_gold, y - 50fx, 1fx, achievements_color_gold_str .. "---")
		if ACHIEVEMENT_PROGRESS_DESTROY_WARDEN_BY_MELEE then
			pewpew.customizable_entity_set_string(id, achievements_color_gold_str .. "I'm full of surprises")
			pewpew.increase_score_of_player(0, 256)
		end
	elseif	TIMER == appear_offset + 120 then
		local id = new_string(x + achievements_offset_gold, y - 150fx, 1fx, achievements_color_gold_str .. "---")
		if ACHIEVEMENT_PROGRESS_DESTROY_OVERLORD_BY_MELEE and ACHIEVEMENT_PROGRESS_DESTROY_WARDEN_BY_MELEE then
			pewpew.customizable_entity_set_string(id, achievements_color_gold_str .. "It's even funnier the second time")
			pewpew.increase_score_of_player(0, 1024)
		end
	end
end

function create_achievement_box(x, y, sx, sy, c)
	local id = pewpew.new_customizable_entity(x, y)
	pewpew.customizable_entity_set_mesh(id, '/dynamic/achievement_box.lua', 0)
	pewpew.customizable_entity_set_mesh_xyz_scale(id, sx, sy, 1fx)
	pewpew.customizable_entity_set_mesh_color(id, c)
end
