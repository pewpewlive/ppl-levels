
pplaf.entities = {player = {}, enemy = {}, enemy_bullets = {}}

local __tmp_u = {'player', 'enemy', 'enemy_bullets'}

pplaf.entity = {
	
	type = {},

	add_union = function(union)
		pplaf.entities[union] = {}
	end,

	create = function(x, y, type, ...)
		local id = pewpew.new_customizable_entity(x, y)
		pewpew.customizable_entity_set_position_interpolation(id, true)
		local entity = 	{
										 id = id,
									 type = pplaf.entity.type[type]
										}
		if pplaf.settings.copy_ppl_methods_to_entities then
			setmetatable(entity, {__index = pplaf.entity.prototype})
		end
		if entity.type.weapons then
			entity.weapons = pplaf.weapon.create(entity, type)
		end
		--[[if entity.type.animation then
			entity.animation = {
				frame = 1,
				timer = 1
			}
		end]]--
		if entity.type.constructor then
			entity.type.constructor(entity, {...})
		end
		if entity.type.destructor then
			function entity:destroy()
				entity.type.destructor(self)
				self.destroyed = true
			end
		end
		table.insert(pplaf.entities[entity.type.union], entity)
		entity.index = #pplaf.entities[entity.type.union]
		return entity
	end,
	
	main = function()
		for _, union in ipairs(__tmp_u) do
			for _, entity in ipairs(pplaf.entities[union]) do
				if entity.destroyed == nil and entity.type.ai then
					entity.type.ai(entity)
				end
				if entity.destroyed == nil and entity.weapons then
					for _, weapon in ipairs(entity.weapons) do
						weapon.type.ai(weapon)
					end
				end
			end
			for i = #pplaf.entities[union], 1, -1 do
				if pplaf.entities[union][i].destroyed then
					table.remove(pplaf.entities[union], i)
					for k = i, #pplaf.entities[union] do
						pplaf.entities[union][k].index = k
					end
				end
			end
		end
	end,

	load = function(path, ...)
		for _, name in pairs({...}) do
			pplaf.entity.type[name] = require(path .. name .. '/type.lua')
			pplaf.entity.type[name].path = path .. name .. '/'
		end
	end
	
}

pplaf.entity.load(pplaf.content .. 'entity/', 'pewpew_player')

--[[
	
	type parameters:
		union
		weapons
		constructor
		destructor
		ai
		whatever you want
		
]]--
