local box = require("/dynamic/helpers/boxes/box_template.lua")
local floating_message = require("/dynamic/helpers/floating_message.lua")
local player_helpers = require("/dynamic/helpers/player_helpers.lua")


local cannon_box = {}

function cannon_box.new(x, y, type)

  local duration

  local frequency
  local cannon_type
  local frame
  local explosion_color
  local msg

  if type == 0 then
    frequency = pewpew.CannonFrequency.FREQ_30
    cannon_type = pewpew.CannonType.TRIPLE
    frame = 1
    explosion_color = 0x00ffffff
    msg = "BULLET SHOWER"
    duration = 100
  elseif type == 1 then
    frequency = pewpew.CannonFrequency.FREQ_30
    cannon_type = pewpew.CannonType.FOUR_DIRECTIONS
    frame = 1
    explosion_color = 0xff8080ff
    msg = "X WEAPON"
    duration = 140
  elseif type == 2 then
    frequency = pewpew.CannonFrequency.FREQ_6
    cannon_type = pewpew.CannonType.HEMISPHERE
    frame = 3
    explosion_color = 0xffff00ff
    msg = "ENEMY ANNIHILATOR"
    duration = 90
  elseif type == 3 then
    frequency = pewpew.CannonFrequency.FREQ_30
    cannon_type = pewpew.CannonType.SINGLE
    frame = 4
    explosion_color = 0x8020ffff
    msg = "RAY OF DOOM"
    duration = 120
  else
    return
  end

  pewpew.play_sound("/dynamic/helpers/boxes/bonus_spawn.lua", 0, x, y)

  local b = box.new(x, y, {"/dynamic/helpers/boxes/box_graphics.lua", 1}, {"/dynamic/helpers/boxes/inner_box_graphics.lua", frame},
    function(player_id, entity_id)
      pewpew.configure_player_ship_weapon(
          entity_id, {frequency = frequency, cannon = cannon_type, duration = duration})
      pewpew.play_sound("/dynamic/helpers/boxes/cannon_pickup_sound.lua", 0, x, y)
      pewpew.create_explosion(x, y, 0xff8080ff, 1fx, 20)
      pewpew.create_explosion(x, y, explosion_color, 0.4000fx, 20)
      floating_message.new(x, y, msg, 1.2048fx, explosion_color, 3)
    end, 160)
  player_helpers.add_arrow(b, 0xff8080ff)

  return b
end

return cannon_box