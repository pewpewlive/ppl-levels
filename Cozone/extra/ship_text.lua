local ph = require'/dynamic/helpers/player_helpers.lua'
local ch = require'/dynamic/helpers/color_helpers.lua'
local gh = require'/dynamic/helpers/gameplay_helpers.lua'

--<summary> A text that will popup above the player ship
local ship_text = {}

function ship_text:popup(value)
  self.time = self.max_time
  self.value = value
end

function ship_text:new(max_time,color,string,extra_value)
  local z = {
    id,
    time = 0,
    value,
    max_time = 90,
    color,
    a = 255
  }
  setmetatable(z,self)
  self.__index = self

  z.max_time = max_time
  z.color = color
  z.value = extra_value

  local px,py = pewpew.entity_get_position(ph.player_ships[1])
  local y_off = 50fx
  z.id = pewpew.new_customizable_entity(px, py+y_off)
  pewpew.customizable_entity_set_position_interpolation(z.id, true)
  pewpew.customizable_entity_set_mesh_scale(z.id, 1fx-(1fx/4fx))

  function z.euc(entity_id)
    if not pewpew.entity_get_is_alive(ph.player_ships[1]) then
      pewpew.entity_destroy(entity_id)
      pewpew.entity_set_update_callback(entity_id, nil)
      return
    end
    px,py = pewpew.entity_get_position(ph.player_ships[1])
    pewpew.entity_set_position(entity_id, px, py+y_off)
    
    pewpew.customizable_entity_set_string(entity_id, ch.color_to_string(ch.make_color_with_alpha(z.color,gh.lerpINT(0,255,gh.invLerp(0,z.max_time,z.time))//1))..string..z.value)
    if z.time > 0 then
      z.time = z.time - 1
    end
  end

  pewpew.entity_set_update_callback(z.id, z.euc)

  table.insert(gh.ship_texts,z)
  return z
end

return ship_text