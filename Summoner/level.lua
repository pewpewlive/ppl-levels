require'/dynamic/main.lua'

PLAYER = pplaf.player.create(START_POS_X, START_POS_Y) -- player collision is 20fx
PLAYER.invulnerable = 0
PLAYER.invulnerable_b = false

local __tmp_copy__ = PLAYER.get_position
function PLAYER:get_position()
	if is_alive(PLAYER.id) then
		return __tmp_copy__(self)
	end
	return START_POS_X, START_POS_Y
end

pewpew.configure_player(0, {shield = 1})

local bg_main = pewpew.new_customizable_entity(LEVEL_WIDTH / 2fx, LEVEL_HEIGTH / 2fx)
pewpew.customizable_entity_set_mesh(bg_main, '/dynamic/assets/bg/main.lua', 0)

wave_string_id = pewpew.new_customizable_entity(800fx, -50fx)
time_left_string_id = pewpew.new_customizable_entity(800fx, 850fx)

create_wave()

pewpew.add_update_callback(function()
	if GAME_STATE then
		
		pewpew.customizable_entity_set_string(wave_string_id, WAVE)
		pewpew.customizable_entity_set_string(time_left_string_id, WAVE_TIME_LIMIT - WAVE_TIME)
		pplaf.main()
		if PLAYER.invulnerable > 0 then
			PLAYER.invulnerable = PLAYER.invulnerable - 1
		end
		if PLAYER.invulnerable == 0 then
			PLAYER.invulnerable_b = false
		end
		if not is_alive(PLAYER.id) then
			GAME_STATE = false
			for id, entity in pairs(pplaf.entities.enemy) do
				entity:destroy()
			end
			for id, entity in pairs(pplaf.entities.enemy_bullets) do
				entity:destroy()
			end
			pplaf.camera.configure{x_static = 800fx, y_static = 2400fx, heigth = -800fx}
			TIMER = 0
			new_string(800fx, 2750fx, 2fx, '#ddddddddAchievements')
			create_achievement_box(200fx, 2400fx, 560fx, 560fx, achievements_color_bronze)
			create_achievement_box(800fx, 2400fx, 560fx, 560fx, achievements_color_silver)
			create_achievement_box(1400fx, 2400fx, 560fx, 560fx, achievements_color_gold)
			respawn_all_owo()
			pewpew.configure_player(0, {has_lost = false})
			return nil
		end
		
		wave_handler()
		
	else
		pplaf.camera.main()
		print_achievements(800fx, 2400fx)
		TIMER = TIMER + 1
		if TIMER == 300 then
			pewpew.stop_game()
		end
	end
end)