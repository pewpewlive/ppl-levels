local set = {}

function set.timeout(time, callback)
  local temp_entity = pewpew.new_customizable_entity(0fx, 0fx)
  local internal_time = 0
  pewpew.entity_set_update_callback(temp_entity, function()
    internal_time = internal_time + 1
    if internal_time == time then
      callback()
      pewpew.entity_destroy(temp_entity)
    end
  end)
end

return set