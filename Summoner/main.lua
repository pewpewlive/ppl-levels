require'/dynamic/pplaf/pplaf.lua'
pplaf.init'/dynamic/pplaf/'

pplaf.weapon.load('/dynamic/assets/weapons/', 'laser', 'cannon', 'holey_cannon', 'overlord_laser', 'mortar', 'warden_mortar')

pplaf.entity.load('/dynamic/assets/entities/', 'laser', 'hBeta', 'hAlpha', 'mine', 'warden_mine', 'owo', 'cube', 'diamond', 'holey', 'hexo', 'dagger', 'overlord', 'warden')

PLAYER_RADIUS = 15fx
PLAYER_COLLISION = 20fx
PLAYER_COLLISION2 = PLAYER_COLLISION / 2fx
OWO_RADIUS = 12fx
OWO_COLLISION = pplaf.entity.type.owo.collision
OWO_COLLISION2 = OWO_COLLISION / 2fx

CUBE_PLAYER_COLLISION = (PLAYER_COLLISION + pplaf.entity.type.cube.collision) / 2fx
CUBE_OWO_COLLISION = (OWO_COLLISION + pplaf.entity.type.cube.collision) / 2fx

DAGGER_PLAYER_COLLISION = (PLAYER_COLLISION + pplaf.entity.type.dagger.collision) / 2fx
DAGGER_OWO_COLLISION = (OWO_COLLISION + pplaf.entity.type.dagger.collision) / 2fx

HEXO_PLAYER_COLLISION = (PLAYER_COLLISION + pplaf.entity.type.hexo.collision) / 2fx
HEXO_OWO_COLLISION = (OWO_COLLISION + pplaf.entity.type.hexo.collision) / 2fx

DIAMOND_PLAYER_COLLISION = (PLAYER_COLLISION + pplaf.entity.type.diamond.collision) / 2fx
DIAMOND_OWO_COLLISION = (OWO_COLLISION + pplaf.entity.type.diamond.collision) / 2fx

HOLEY_PLAYER_COLLISION = (PLAYER_COLLISION + pplaf.entity.type.holey.collision) / 2fx
HOLEY_OWO_COLLISION = (OWO_COLLISION + pplaf.entity.type.holey.collision) / 2fx

MINE_PLAYER_COLLISION = (PLAYER_COLLISION + pplaf.entity.type.mine.collision) / 2fx
MINE_OWO_COLLISION = (OWO_COLLISION + pplaf.entity.type.mine.collision) / 2fx

WARDEN_MINE_PLAYER_COLLISION = (PLAYER_COLLISION + pplaf.entity.type.warden_mine.collision) / 2fx
WARDEN_MINE_OWO_COLLISION = (OWO_COLLISION + pplaf.entity.type.warden_mine.collision) / 2fx

OVERLORD_PLAYER_COLLISION = (PLAYER_COLLISION + pplaf.entity.type.overlord.collision) / 2fx
OVERLORD_OWO_COLLISION = (OWO_COLLISION + pplaf.entity.type.overlord.collision) / 2fx

OWO = {}

require'/dynamic/waves.lua'
require'/dynamic/achievements.lua'

--[[

--- mesh test ---

local id = pewpew.new_customizable_entity(START_POS_X, START_POS_Y)
pewpew.customizable_entity_set_mesh(id, '/dynamic/assets/entities/owo/mesh.lua', 0)
pewpew.entity_set_update_callback(id, function()
	pewpew.customizable_entity_add_rotation_to_mesh(id, 0.200fx, 1fx, 1fx, 0fx)
end)

--- ============= ---

--- entity test ---

pplaf.entity.create(START_POS_X, START_POS_Y, 'dagger')

--- ============= ---

--- wave template ---

waves[1] = {
	init = function()
		clear_wave()
		
	end,
	handle = function()
		
		for id, entity in pairs(pplaf.entities.enemy) do
			return nil
		end
		waves[WAVE + 1].init()
	end
}

--- ============= ---

]]--
