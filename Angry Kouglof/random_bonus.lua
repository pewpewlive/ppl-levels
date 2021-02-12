local message = require("/dynamic/helpers/floating_message.lua")

local random_box = {}

function random_box.new(x, y, ship_id)

  local box_colors = {0x00ff00ff, 0x40aaffff, 0xff6060ff, 0xaa00ffff, 0xe6e6faff, 0x1010ffff}
  local bows_colors = {0xffff00ff, 0xff0000ff, 0xff6000ff}


  local angle = fmath.random_fixedpoint(0fx, 100fx)
  local scale = fmath.random_fixedpoint(80fx / 100fx, 120fx / 100fx)

  local box_color = box_colors[fmath.random_int(1, #box_colors)]
  local id = pewpew.new_customizable_entity(x, y)
  pewpew.entity_set_radius(id, 25fx * scale)
  pewpew.customizable_entity_start_spawning(id, 15)
  pewpew.customizable_entity_set_mesh(id,  "/dynamic/random_bonus_graphics.lua", 0)
  pewpew.customizable_entity_set_mesh_color(id, box_color)
  pewpew.add_arrow_to_player_ship(ship_id , id, box_color)
  pewpew.customizable_entity_set_mesh_angle(id, angle, 0fx, 0fx, 1fx)

  local bow_color = bows_colors[fmath.random_int(1, #bows_colors)]
  local bow_id = pewpew.new_customizable_entity(x, y)
  pewpew.customizable_entity_start_spawning(bow_id, 15)
  pewpew.customizable_entity_set_mesh(bow_id,  "/dynamic/random_bonus_graphics.lua", 1)
  pewpew.customizable_entity_set_mesh_color(bow_id, bow_color)
  pewpew.customizable_entity_set_mesh_angle(bow_id, angle, 0fx, 0fx, 1fx)

  local mesh_frame = 0

  local time = 0fx
  pewpew.entity_set_update_callback(id, function()
    time = time + 1fx
    local sin, cos = fmath.sincos(time / 6fx)
    sin = sin / 15fx
    pewpew.customizable_entity_set_mesh_scale(id, scale + sin)
    pewpew.customizable_entity_set_mesh_scale(bow_id, scale + sin)
  end)

  pewpew.customizable_entity_set_player_collision_callback(id, function(player_id, ship_id)
    pewpew.customizable_entity_start_exploding(bow_id, 30)
    pewpew.customizable_entity_start_exploding(id, 30)
    local gift_type = fmath.random_int(0, 100)
    if gift_type < 25 then
      pewpew.configure_player(0, {shield = pewpew.get_player_configuration(0).shield + 1})
      message.new(x, y, "Shield +1", 1fx, 0xffff00ff, 2)
    elseif gift_type < 60 then
      local score_increase = gift_type * 5
      pewpew.increase_score_of_player(0, score_increase)
      message.new(x, y, "+" .. score_increase, 1fx, 0x00ff00ff, 2)
    else
      local duration = fmath.random_int(30, 300)
      local frequencies = {pewpew.CannonFrequency.FREQ_30, pewpew.CannonFrequency.FREQ_15, pewpew.CannonFrequency.FREQ_10, pewpew.CannonFrequency.FREQ_7_5}
      local frequencies_str = {"30Hz", "15Hz", "10Hz", "7.5Hz"}
      local cannon_types = {pewpew.CannonType.DOUBLE, pewpew.CannonType.HEMISPHERE, pewpew.CannonType.TRIPLE , pewpew.CannonType.TIC_TOC, pewpew.CannonType.DOUBLE_SWIPE, pewpew.CannonType.FOUR_DIRECTIONS}
      local cannon_str = {"Double", "Hemisphere", "Triple", "Tic Toc", "Double Swipe", "Four directions"}
      local frequency_index = fmath.random_int(1, #frequencies)
      local frequency = frequencies[frequency_index]
      local cannon_index = fmath.random_int(1, #cannon_types)
      local cannon_type = cannon_types[cannon_index]
      if cannon_type == pewpew.CannonType.HEMISPHERE then
        if frequency == pewpew.CannonFrequency.FREQ_30 or frequency == pewpew.CannonFrequency.FREQ_15 then
          frequency = pewpew.CannonFrequency.FREQ_10
          frequency_index = 3
        end
        duration = fmath.random_int(30, 150)
      end

      weapon_config = {frequency = frequency, cannon = cannon_type, duration = duration}
      pewpew.configure_player_ship_weapon(ship_id, weapon_config)
      message.new(x, y, cannon_str[cannon_index] .. " @ " .. frequencies_str[frequency_index], 1fx, 0xff0000ff, 1)
    end
  end)

  return id
end

return random_box
