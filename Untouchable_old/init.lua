
require'/dynamic/def.lua'
require'/dynamic/functions.lua'

pewpew.set_level_size(LEVEL_SIZE_X, LEVEL_SIZE_Y)

pplaf.animation.load_by_typed_dir('/dynamic/assets/',
  'star_trail',
  'sentry',
  'cube',
  
  'bonus',
  'bomb'
)
pplaf.animation.preload_all()

pplaf.entity.add_groups(
  'player',
  'player_bullet',
  'player_laser',
  'enemy',
  'enemy_bullet',
  
  'animation',
  
  'bonus_box',
  'bomb'
)
pplaf.entity.load_by_typed_dir('/dynamic/assets/',
  'player',
  
  'bonus',
  'bomb',
  
  'star',
  'star_trail',
  'sentry',
  'cube',
  
  'square_animation',
  'circle_explosion',
  'circle_animation',
  
  'enemy_projectile'
)
pplaf.entity.load_by_typed_dir('/dynamic/assets/bullets/',
  'player_bullet',
  'player_laser',
  
  'pinky',
  'candy',
  'potato',
  'small_potato'
)

pplaf.entity.def_types_globally()

PLAYER = player:create(SPAWN_X, SPAWN_Y)

local bg_colors = {
  0xb0000000,
  0x00b00000,
  0x0000b000,
}
local bg_wall_colors = {
  0x60000000,
  0x60404000,
}
local bg_amount = __DEF_FMATH_TO_FX(#bg_colors)
local bg_distance = 1fx
local bg_z_distance = -25fx
for i = 1fx, bg_amount, 1fx do
  local dy, dx = __DEF_FMATH_SINCOS(i / bg_amount * TAU_FX)
  local id = create_static_bg(dx * bg_distance, dy * bg_distance, 'bg_poles', bg_colors[__DEF_FMATH_TO_INT(i)])
  pewpew.customizable_entity_set_mesh_z(id, (bg_amount / 2fx - i + 1fx) * bg_z_distance)
end
local bg_amount = __DEF_FMATH_TO_FX(#bg_wall_colors)
for i = 1fx, bg_amount, 1fx do
  local dy, dx = __DEF_FMATH_SINCOS(i / bg_amount * TAU_FX)
  local id = create_static_bg(dx * bg_distance, dy * bg_distance, 'bg_poles_walls', bg_wall_colors[__DEF_FMATH_TO_INT(i)])
  pewpew.customizable_entity_set_mesh_z(id, (bg_amount / 2fx - i + 1fx) * bg_z_distance)
end

local function ease_function(v) -- https://www.desmos.com/calculator/uqonw39jl9
  return __DEF_FMATH_SINCOS(v * PI_FX / 2fx) * 2fx
end

pplaf.camera.configure{
  following_param = PLAYER.id,
  ease_function = ease_function,
  current_x = SPAWN_X,
  current_y = SPAWN_Y,
  base_z = 750fx,
}

pewpew.configure_player(0, {shield = 2})

require'/dynamic/wave_generator.lua'

--[[

star:create(600fx, 100fx)
cube:create(100fx, 100fx, 10fx, 0fx)

for i = -5fx, 5fx, 1fx do
  sentry:create(SPAWN_X + i * 100fx, 700fx)
end
for i = 0fx, 4fx, 1fx do
  bonus:create(450fx + i * 100fx, 300fx, __DEF_FMATH_TO_INT(i))
end
for i = 0fx, 1fx, 1fx do
  bomb:create(400fx + i * 400fx, 200fx, __DEF_FMATH_TO_INT(i))
end

]]--
