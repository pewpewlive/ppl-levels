local color_helper = require("/dynamic/helpers/color_helpers.lua")

local disappearing_message = {}

function disappearing_message.new(x, y, text, scale, color, d_alpha)
  local id = pewpew.new_customizable_entity(x, y)
  local alpha = 255
  pewpew.customizable_entity_set_mesh_scale(id, scale)

  pewpew.entity_set_update_callback(id, function()
    local color = color_helper.make_color_with_alpha(color, alpha)
    local color_s = color_helper.color_to_string(color)
    pewpew.customizable_entity_set_string(id, color_s .. text)
    alpha = alpha - d_alpha
    if alpha <= 0 then
      pewpew.entity_destroy(id)
    end
  end)
  return id
end

return disappearing_message
