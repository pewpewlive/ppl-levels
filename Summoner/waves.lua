CREATE_OWO_OFFSET = 24fx
OWO_AMOUNT = 0fx

wave_delay = {
	
	holey = 0,
	overlord = 0,
	warden = 0
	
}

function next_wave()
	WAVE = WAVE + 1
	WAVE_TIME = -1
	for t, td in pairs(wave_delay) do
		if td > 0 then
			wave_delay[t] = wave_delay[t] - 1
		end
	end
	if OWO_AMOUNT < 72fx then
		create_owo()
		if OWO_AMOUNT == 36fx then
			pplaf.entity.type.owo.respawn_time = 48
			pplaf.entity.type.owo.respawn_time_ifx = 1fx / 48fx
			respawn_all_owo()
		elseif OWO_AMOUNT == 48fx then
			pplaf.entity.type.owo.respawn_time = 52
			pplaf.entity.type.owo.respawn_time_ifx = 1fx / 52fx
			respawn_all_owo()
		elseif OWO_AMOUNT == 60fx then
			pplaf.entity.type.owo.respawn_time = 56
			pplaf.entity.type.owo.respawn_time_ifx = 1fx / 56fx
			respawn_all_owo()
		elseif OWO_AMOUNT == 72fx then
			pplaf.entity.type.owo.respawn_time = 60
			pplaf.entity.type.owo.respawn_time_ifx = 1fx / 60fx
			respawn_all_owo()
		end
	end
	if WAVE % 6 == 0 then -- every 6
		pewpew.configure_player(0, {shield = pewpew.get_player_configuration(0).shield + 1})
		pplaf.entity.type.diamond.hp = pplaf.entity.type.diamond.hp + 1
		pplaf.entity.type.hexo.hp = pplaf.entity.type.hexo.hp + 1
	end
	if WAVE % 10 == 0 then -- every 10
		pplaf.entity.type.dagger.hp = pplaf.entity.type.dagger.hp + 1
		pplaf.entity.type.mine.hp = pplaf.entity.type.mine.hp + 3
		pplaf.entity.type.warden_mine.hp = pplaf.entity.type.warden_mine.hp + 2
	end
	if WAVE <= 30 then
		pplaf.entity.type.hAlpha.max_speed = 2fx + fmath.to_fixedpoint(WAVE) / 15fx
		pplaf.entity.type.hBeta.max_speed = 2fx + fmath.to_fixedpoint(WAVE) / 15fx
	end
	create_wave()
end

function clear_wave()
	for id, entity in pairs(pplaf.entities.enemy_bullets) do
		entity:destroy()
	end
	next_wave()
	pewpew.increase_score_of_player(0, WAVE)
end

local allowed_positions_to_spawn = {}

for i = 0fx, 12fx, 1fx do
	table.insert(allowed_positions_to_spawn, {200fx, 100fx + i * 50fx})
	table.insert(allowed_positions_to_spawn, {1400fx - i * 100fx, 200fx})
	table.insert(allowed_positions_to_spawn, {1400fx, 700fx - i * 50fx})
	table.insert(allowed_positions_to_spawn, {200fx + i * 100fx, 600fx})
end

function get_allowed_position_to_spawn(index)
	return allowed_positions_to_spawn[index][1], allowed_positions_to_spawn[index][2]
end

function create_owo()
	OWO_AMOUNT = OWO_AMOUNT + 1fx
	pplaf.entity.create(OWO_AMOUNT * (1fx + CREATE_OWO_OFFSET % 65fx), OWO_AMOUNT * (1fx + CREATE_OWO_OFFSET // 65fx), 'owo')
end

function respawn_all_owo()
	for id, entity in ipairs(OWO) do
		entity:destroy()
	end
end

for i = 1, 8 do
	create_owo()
end

function create_cube_cluster(x, y, xn, yn, dx, dy, color)
	local offset_x, offset_y = x + pplaf.entity.type.cube.collision * (1fx - xn) / 2fx, y + pplaf.entity.type.cube.collision * (1fx - yn) / 2fx
	for i = 0fx, xn - 1fx, 1fx do
		for k = 0fx, yn - 1fx, 1fx do
			pplaf.entity.create(offset_x + i * pplaf.entity.type.cube.collision, offset_y + k * pplaf.entity.type.cube.collision, 'cube', dx, dy, color)
		end
	end
end

WAVE = 1
WAVE_TIME = -1
WAVE_TIME_LIMIT = 3000

waves = {}

--[[

difficulty system:
	
	>15 - holey
	>30 - overlord
	>60 - overlord + warden
	
	1p - cubes
	2p - daggers
	3p - hexo
	4p - diamond
	15p - holey
	30p - overlord
	30p - warden
	
]]--

WAVE_COST_CUBE = 1
WAVE_COST_DAGGER = 2
WAVE_COST_HEXO = 4
WAVE_COST_DIAMOND = 5
WAVE_COST_HOLEY = 8
WAVE_COST_WARDEN = 21
WAVE_COST_OVERLORD = 27

WAVE_DELAY_HOLEY = 2
WAVE_DELAY_OVERLORD = 4
WAVE_DELAY_WARDEN = 4

function wave_handler()
	
	WAVE_TIME = WAVE_TIME + 1
	if WAVE_TIME > WAVE_TIME_LIMIT then
		next_wave()
		return nil
	end
	for id, entity in pairs(pplaf.entities.enemy) do
		return nil
	end
	clear_wave()
	
end

DAGGER_WAVE_LIMIT = 1
HEXO_WAVE_LIMIT = 1
DIAMOND_WAVE_LIMIT = 1
HOLEY_WAVE_LIMIT = 1

function create_wave()
	
	if WAVE == 20 then
		DAGGER_WAVE_LIMIT = 2
	end
	if WAVE % 5 == 0 then
		HEXO_WAVE_LIMIT = HEXO_WAVE_LIMIT + 1
	end
	if WAVE % 10 == 0 then
		DIAMOND_WAVE_LIMIT = DIAMOND_WAVE_LIMIT + 1
	end
	if WAVE >= 15 and WAVE % 15 == 0 then
		HOLEY_WAVE_LIMIT = HOLEY_WAVE_LIMIT + 1
	end
	
	local difficulty = pplaf.math.round(WAVE ^ 1.25)
	local cube_wave_amount = 0
	local dagger_wave_amount = 0
	local hexo_wave_amount = 0
	local diamond_wave_amount = 0
	local holey_wave_amount = 0
		
	if difficulty >= WAVE_COST_OVERLORD and wave_delay.overlord == 0 then
		create_overlord_wave()
		difficulty = difficulty - WAVE_COST_OVERLORD
	end
	if difficulty >= WAVE_COST_WARDEN and wave_delay.warden == 0 then
		create_warden_wave()
		difficulty = difficulty - WAVE_COST_WARDEN
	end
	while difficulty >= WAVE_COST_HOLEY and holey_wave_amount ~= HOLEY_WAVE_LIMIT and wave_delay.holey == 0 do
		if difficulty == 0 then
			return nil
		end
		create_holey_wave()
		difficulty = difficulty - WAVE_COST_HOLEY
		holey_wave_amount = holey_wave_amount + 1
	end
	while difficulty >= WAVE_COST_DIAMOND and diamond_wave_amount ~= DIAMOND_WAVE_LIMIT do
		if difficulty == 0 then
			return nil
		end
		create_diamond_wave()
		difficulty = difficulty - WAVE_COST_DIAMOND
		diamond_wave_amount = diamond_wave_amount + 1
	end
	while difficulty >= WAVE_COST_HEXO and hexo_wave_amount ~= HEXO_WAVE_LIMIT do
		if difficulty == 0 then
			return nil
		end
		create_hexo_wave()
		difficulty = difficulty - WAVE_COST_HEXO
		hexo_wave_amount = hexo_wave_amount + 1
	end
	while difficulty >= WAVE_COST_DAGGER and dagger_wave_amount ~= DAGGER_WAVE_LIMIT do
		if difficulty == 0 then
			return nil
		end
		create_dagger_wave()
		difficulty = difficulty - WAVE_COST_DAGGER
		dagger_wave_amount = dagger_wave_amount + 1
	end
	while difficulty >= WAVE_COST_CUBE and cube_wave_amount < 1 do
		if difficulty == 0 then
			return nil
		end
		create_cube_wave()
		difficulty = difficulty - WAVE_COST_CUBE
		cube_wave_amount = cube_wave_amount + 1
	end
	
end

WAVE_TEMPLATE_COUNT_DAGGER = 0
WAVE_TEMPLATE_COUNT_CUBE = 0


PARAMETER_CUBE_SPEED = 1fx
PARAMETER_CUBE_SQUARE_SIZE = 3fx
PARAMETER_CUBE_LINE_WIDTH = 1fx

function create_cube_wave()
	
	if WAVE >= 30 then
		PARAMETER_CUBE_SQUARE_SIZE = 8fx
		PARAMETER_CUBE_LINE_WIDTH = 3fx
		PARAMETER_CUBE_SPEED = 6fx
	else
		PARAMETER_CUBE_SQUARE_SIZE = 3fx + fmath.to_fixedpoint(WAVE) // 6fx
		PARAMETER_CUBE_LINE_WIDTH = 1fx + fmath.to_fixedpoint(WAVE) // 15fx
		PARAMETER_CUBE_SPEED = 1fx + fmath.to_fixedpoint(WAVE) / 6fx
	end
	
	if			WAVE_TEMPLATE_COUNT_CUBE % 4 == 0 then
		create_cube_cluster(200fx, 200fx, PARAMETER_CUBE_SQUARE_SIZE, PARAMETER_CUBE_SQUARE_SIZE, PARAMETER_CUBE_SPEED, 0fx, 0x66ff66ff)
		create_cube_cluster(1400fx, 600fx, PARAMETER_CUBE_SQUARE_SIZE, PARAMETER_CUBE_SQUARE_SIZE, -PARAMETER_CUBE_SPEED, 0fx, 0x66ff66ff)
	elseif	WAVE_TEMPLATE_COUNT_CUBE % 4 == 1 then
		create_cube_cluster(200fx, 200fx, PARAMETER_CUBE_SQUARE_SIZE, PARAMETER_CUBE_SQUARE_SIZE, 0fx, PARAMETER_CUBE_SPEED, 0xffaa66ff)
		create_cube_cluster(600fx, 600fx, PARAMETER_CUBE_SQUARE_SIZE, PARAMETER_CUBE_SQUARE_SIZE, 0fx, -PARAMETER_CUBE_SPEED, 0xffaa66ff)
		create_cube_cluster(1000fx, 200fx, PARAMETER_CUBE_SQUARE_SIZE, PARAMETER_CUBE_SQUARE_SIZE, 0fx, PARAMETER_CUBE_SPEED, 0xffaa66ff)
		create_cube_cluster(1400fx, 600fx, PARAMETER_CUBE_SQUARE_SIZE, PARAMETER_CUBE_SQUARE_SIZE, 0fx, -PARAMETER_CUBE_SPEED, 0xffaa66ff)
	elseif	WAVE_TEMPLATE_COUNT_CUBE % 4 == 2 then
		create_cube_cluster(1400fx, 200fx, PARAMETER_CUBE_SQUARE_SIZE, PARAMETER_CUBE_SQUARE_SIZE, -PARAMETER_CUBE_SPEED, 0fx, 0x6666ffff)
		create_cube_cluster(200fx, 600fx, PARAMETER_CUBE_SQUARE_SIZE, PARAMETER_CUBE_SQUARE_SIZE, PARAMETER_CUBE_SPEED, 0fx, 0x6666ffff)
	elseif	WAVE_TEMPLATE_COUNT_CUBE % 4 == 3 then
		create_cube_cluster(200fx, 600fx, PARAMETER_CUBE_SQUARE_SIZE, PARAMETER_CUBE_SQUARE_SIZE, 0fx, -PARAMETER_CUBE_SPEED, 0xff66aaff)
		create_cube_cluster(600fx, 200fx, PARAMETER_CUBE_SQUARE_SIZE, PARAMETER_CUBE_SQUARE_SIZE, 0fx, PARAMETER_CUBE_SPEED, 0xff66aaff)
		create_cube_cluster(1000fx, 600fx, PARAMETER_CUBE_SQUARE_SIZE, PARAMETER_CUBE_SQUARE_SIZE, 0fx, -PARAMETER_CUBE_SPEED, 0xff66aaff)
		create_cube_cluster(1400fx, 200fx, PARAMETER_CUBE_SQUARE_SIZE, PARAMETER_CUBE_SQUARE_SIZE, 0fx, PARAMETER_CUBE_SPEED, 0xff66aaff)
	end
	WAVE_TEMPLATE_COUNT_CUBE = WAVE_TEMPLATE_COUNT_CUBE + 1
	
end

PARAMETER_DAGGER_LINE_AMOUNT = 1fx
PARAMETER_DAGGER_DIAGONAL_AMOUNT = 1fx

function create_dagger_wave()
	
	if WAVE >= 30 then
		PARAMETER_DAGGER_LINE_AMOUNT = 6fx
		PARAMETER_DAGGER_DIAGONAL_AMOUNT = 4fx
	else
		PARAMETER_DAGGER_LINE_AMOUNT = 1fx + fmath.to_fixedpoint(WAVE) // 5fx
		PARAMETER_DAGGER_DIAGONAL_AMOUNT = 1fx + fmath.to_fixedpoint(WAVE) // 10fx
	end
	
	if WAVE_TEMPLATE_COUNT_DAGGER % 3 == 0 then
		for i = 0fx, PARAMETER_DAGGER_LINE_AMOUNT - 1fx, 1fx do
			pplaf.entity.create(200fx, 200fx + i * 400fx / PARAMETER_DAGGER_LINE_AMOUNT, 'dagger')
			pplaf.entity.create(1400fx, 600fx - i * 400fx / PARAMETER_DAGGER_LINE_AMOUNT, 'dagger')
		end
	elseif WAVE_TEMPLATE_COUNT_DAGGER % 3 == 1 then
		for i = 0fx, PARAMETER_DAGGER_DIAGONAL_AMOUNT - 1fx, 1fx do
			pplaf.entity.create(200fx + i * 400fx / PARAMETER_DAGGER_DIAGONAL_AMOUNT, 200fx + i * 200fx / PARAMETER_DAGGER_DIAGONAL_AMOUNT, 'dagger')
			pplaf.entity.create(200fx + i * 400fx / PARAMETER_DAGGER_DIAGONAL_AMOUNT, 600fx - i * 200fx / PARAMETER_DAGGER_DIAGONAL_AMOUNT, 'dagger')
			pplaf.entity.create(1400fx - i * 400fx / PARAMETER_DAGGER_DIAGONAL_AMOUNT, 600fx - i * 200fx / PARAMETER_DAGGER_DIAGONAL_AMOUNT, 'dagger')
			pplaf.entity.create(1400fx - i * 400fx / PARAMETER_DAGGER_DIAGONAL_AMOUNT, 200fx + i * 200fx / PARAMETER_DAGGER_DIAGONAL_AMOUNT, 'dagger')
		end
	elseif WAVE_TEMPLATE_COUNT_DAGGER % 3 == 2 then
		for i = 0fx, PARAMETER_DAGGER_LINE_AMOUNT - 1fx, 1fx do
			pplaf.entity.create(200fx + i * 1200fx / PARAMETER_DAGGER_LINE_AMOUNT, 200fx, 'dagger')
			pplaf.entity.create(1400fx - i * 1200fx / PARAMETER_DAGGER_LINE_AMOUNT, 600fx, 'dagger')
		end
		
	end
	WAVE_TEMPLATE_COUNT_DAGGER = WAVE_TEMPLATE_COUNT_DAGGER + 1
	
end

__Q_SPAWN_POS_COUNT = 0

function create_hexo_wave()
	
	local x, y = get_allowed_position_to_spawn(1 + __Q_SPAWN_POS_COUNT % #allowed_positions_to_spawn)
	pplaf.entity.create(x, y, 'hexo')
	__Q_SPAWN_POS_COUNT = __Q_SPAWN_POS_COUNT + 1
	
end

function create_diamond_wave()
	
	local x, y = get_allowed_position_to_spawn(1 + __Q_SPAWN_POS_COUNT % #allowed_positions_to_spawn)
	pplaf.entity.create(x, y, 'diamond', fmath.atan2(START_POS_Y - y, START_POS_X - x))
	__Q_SPAWN_POS_COUNT = __Q_SPAWN_POS_COUNT + 1
	
end

function create_holey_wave()
	
	local x, y = get_allowed_position_to_spawn(1 + __Q_SPAWN_POS_COUNT % #allowed_positions_to_spawn)
	pplaf.entity.create(x, y, 'holey', fmath.atan2(START_POS_Y - y, START_POS_X - x))
	__Q_SPAWN_POS_COUNT = __Q_SPAWN_POS_COUNT + 1
	
	if WAVE == 30 then
		WAVE_DELAY_HOLEY = 0
	end
	wave_delay.holey = WAVE_DELAY_HOLEY
	
end

function create_warden_wave()
	
	local x, y = get_allowed_position_to_spawn(1 + __Q_SPAWN_POS_COUNT % #allowed_positions_to_spawn)
	pplaf.entity.create(x, y, 'warden')
	__Q_SPAWN_POS_COUNT = __Q_SPAWN_POS_COUNT + 1
	
	if WAVE_DELAY_WARDEN > 2 then
		WAVE_DELAY_WARDEN = WAVE_DELAY_WARDEN - 1
	end
	if WAVE == 45 then
		WAVE_DELAY_OVERLORD = 0
	end
	wave_delay.warden = WAVE_DELAY_WARDEN
	
end

function create_overlord_wave()
	
	local x, y = get_allowed_position_to_spawn(1 + __Q_SPAWN_POS_COUNT % #allowed_positions_to_spawn)
	pplaf.entity.create(x, y, 'overlord')
	__Q_SPAWN_POS_COUNT = __Q_SPAWN_POS_COUNT + 1
	
	if WAVE_DELAY_OVERLORD > 2 then
		WAVE_DELAY_OVERLORD = WAVE_DELAY_OVERLORD - 1
	end
	if WAVE == 45 then
		WAVE_DELAY_OVERLORD = 0
	end
	wave_delay.overlord = WAVE_DELAY_OVERLORD
	
end

-- DEBUG --

-- WAVE_TIME_LIMIT = 3600
-- WAVE = 29
-- for i = 1, WAVE // 2 do
	-- create_owo()
-- end

-- DEBUG --