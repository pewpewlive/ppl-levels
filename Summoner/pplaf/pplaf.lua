
_ENV.pewpew_old = nil
_ENV.fmath_old = nil

pplaf = {

	require = function(path, ...) --load ... files from certain folder
		for _, lib in ipairs({...}) do
			require(path .. lib .. ".lua")
		end
	end,

	main = function() --main callback
		TIME = TIME + 1
		pplaf.entity.main()
		pplaf.player.main()
		pplaf.camera.main()
	end,
	
	init = function(path) --load pplaf
		pplaf.path = path
		pplaf.content = path .. 'content/'
		pplaf.require(pplaf.path,
			'settings',
			'global_variables'
		)
		pplaf.require(pplaf.content,
			'math',
			'fxmath',
			'camera',
			'entity/main',
			'entity/player',
			'entity/prototype',
			'entity/player_prototype',
			'weapon/main'
		)
		pewpew.set_level_size(LEVEL_WIDTH, LEVEL_HEIGTH)
	end

}

function chance(c)
	return pplaf.math.random(1, 100) < c
end

function new_string(x, y, scale, text)
	local id = pewpew.new_customizable_entity(x, y)
	pewpew.customizable_entity_set_string(id, text)
	pewpew.customizable_entity_set_mesh_scale(id, scale)
	return id
end

function is_alive(id)
	return pewpew.entity_get_is_alive(id) and not pewpew.entity_get_is_started_to_be_destroyed(id)
end

function table.copy(arr) --copy table by value
	local copy = {}
	for key, value in pairs(arr) do copy[key] = value end
	return copy
end

function make_color(r, g, b, a)
	return ((r * 256 + g) * 256 + b) * 256 + a
end

pewpew.__print = pewpew.print
pewpew.print = function(...)
	pewpew.__print(table.concat({...}, '    '))
end
