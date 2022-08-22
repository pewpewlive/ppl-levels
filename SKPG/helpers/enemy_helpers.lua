local enemies = {}

local entity_list = {}
--NOTE: THIS IS STILL SOMEWHAT BROKEN
enemies.types = {
  RIVAL = 0,
  BROWNIAN = 1,
  BAF = 2,
  TANK = 3,
  LUCKY_STAR = 4,
  ALTAR = 5
}

function enemies.add_entity_to_type(type, entityid)
  entity_list[entityid] = type
end

function enemies.get_entity_type(id)
  if entity_list[id] ~= nil then return entity_list[id] else return -1 end
end

function enemies.basic_needs(x,y,mesh,mesh_index,color,scale,radius)
    local id = pewpew.new_customizable_entity(x,y)
    pewpew.customizable_entity_set_mesh(id,mesh,mesh_index)
    if color ~= nil then
        pewpew.customizable_entity_set_mesh_color(id,color)
    end
    pewpew.customizable_entity_set_mesh_scale(id,scale)
    pewpew.customizable_entity_set_position_interpolation(id, true)
    if radius ~= nil then
      pewpew.entity_set_radius(id,radius)
    end
    return id
end

function enemies.newbullet(x, y, mesh, mesh_index, angle, color, speed, radius)
  local bullet = enemies.basic_needs(x,y,mesh,mesh_index,nil,1fx,radius)
  pewpew.customizable_entity_start_spawning(bullet,0)

  local time = 0
  pewpew.entity_set_update_callback(bullet, function(entity_id)
      time = time + 1
      local move_y, move_x = fmath.sincos(angle)
      local bullet_x, bullet_y = pewpew.entity_get_position(bullet)
      pewpew.customizable_entity_set_mesh_angle(bullet,angle,0fx,0fx,1fx)
      pewpew.entity_set_position(bullet, bullet_x + move_x * speed, bullet_y + move_y * speed)
  end)

  pewpew.customizable_entity_set_player_collision_callback(bullet, function(entity_id, player_index, ship_entity_id)
      local bullet_x, bullet_y = pewpew.entity_get_position(entity_id)
      pewpew.entity_destroy(entity_id)
      pewpew.create_explosion(bullet_x, bullet_y, color, 1fx/2fx, 10)
      pewpew.add_damage_to_player_ship(ship_entity_id, 1)
  end)

  pewpew.customizable_entity_configure_wall_collision(bullet, true, function(entity_id, wall_normal_x, wall_normal_y)
      local bullet_x, bullet_y = pewpew.entity_get_position(entity_id)
      pewpew.entity_destroy(entity_id)
      pewpew.create_explosion(bullet_x, bullet_y, color, 1fx/2fx, 10)
  end)
end

function enemies.get_angle_to_player(ship,entityid)
  local px, py = pewpew.entity_get_position(ship)
  local ex, ey = pewpew.entity_get_position(entityid)
  local dx, dy = ex-px,ey-py
  local angle = fmath.atan2(dy,dx)
  return angle
end

return enemies