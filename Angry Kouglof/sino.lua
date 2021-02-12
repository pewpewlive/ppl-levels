local message = require("/dynamic/helpers/floating_message.lua")

local e = {}

local number_of_sinos = 0
local number_of_sinos_killed = 0

function create_sino_spawner(x, y, ship_id)
  local id = pewpew.new_customizable_entity(x, y)
  local time = 0
  pewpew.entity_set_update_callback(id, function()
    time = time + 1
    if time == 180 then
      pewpew.entity_destroy(id)
      local max_number_of_sinos = 1 + pewpew.get_time() // 2400
      local up_or_down_first = fmath.random_int(0, 1)
      for i = 1,2 do
        if number_of_sinos >= max_number_of_sinos then
          return
        end
        if i == up_or_down_first then
          e.new(x, y, 1fx, 0fx, ship_id)
        else
          e.new(x, y, 0fx, 1fx, ship_id)
        end
      end
    end
  end)
end

function destroy_sino(sino_id, ship_id, time)
  local x,y = pewpew.entity_get_position(sino_id)
  local score_increase = 1000 + 300 * number_of_sinos_killed - 2*time
  pewpew.increase_score_of_player(0, score_increase)
  message.new(x, y, "+" .. score_increase, 1fx, 0x00ff00ff, 2)
  pewpew.customizable_entity_start_exploding(sino_id, 30)
  create_sino_spawner(x, y, ship_id)
  pewpew.create_explosion(x, y, 0xff0000ff, 3fx, 150)
  for i=0fx,6fx,1fx do
    local angle = fmath.tau() * i / 7fx
    pewpew.new_mothership(x, y, pewpew.MothershipType.SEVEN_CORNERS, angle)
  end
  number_of_sinos = number_of_sinos - 1
end

function angle_to_player(x, y, ship_id)
  if pewpew.entity_get_is_alive(ship_id) == false then
    return fmath.random_fixedpoint(0fx, 100fx)
  end
  local px, py = pewpew.entity_get_position(ship_id)
  return fmath.atan2(py - y, px - x)
end

function new_bullet(x, y, ship_id, angle_offset)
  local bullet_id = pewpew.new_customizable_entity(x, y)
  pewpew.customizable_entity_start_spawning(bullet_id, 0)
  pewpew.entity_set_radius(bullet_id, 16fx)
  pewpew.customizable_entity_set_position_interpolation(bullet_id, true)
  pewpew.customizable_entity_set_mesh(bullet_id,  "/dynamic/sino_bullet_graphics.lua", 0)
  local angle = angle_to_player(x, y, ship_id) + angle_offset
  pewpew.customizable_entity_set_mesh_angle(bullet_id, angle, 0fx, 0fx, 1fx)
  local dy,dx = fmath.sincos(angle)
  local speed=10fx
  dx = dx*speed
  dy = dy * speed
  local frame = 0
  local dead = false
  pewpew.entity_set_update_callback(bullet_id, function()
    if dead == false then
      frame = frame + 2
    end
    if frame == 32 then
      frame = 0
    end
    pewpew.customizable_entity_set_flipping_meshes(bullet_id, "/dynamic/sino_bullet_graphics.lua", frame, frame + 1)

    local x,y = pewpew.entity_get_position(bullet_id)
    x = x + dx
    y = y + dy
    pewpew.entity_set_position(bullet_id, x, y)
  end)

  pewpew.customizable_entity_configure_wall_collision(bullet_id , true , function()
    pewpew.customizable_entity_start_exploding(bullet_id, 10)
    dead = true
  end)

  pewpew.customizable_entity_set_player_collision_callback(bullet_id, function(player_id, entity_id)
    pewpew.customizable_entity_start_exploding(bullet_id, 10)
    pewpew.add_damage_to_player_ship(ship_id, 1)

    dead = true
  end)

end

function e.new(x, y, vx, vy, ship_id)
  number_of_sinos = number_of_sinos + 1
  local id = pewpew.new_customizable_entity(x, y)
  pewpew.customizable_entity_start_spawning(id, 70)
  pewpew.customizable_entity_set_position_interpolation(id, true)
  pewpew.customizable_entity_set_mesh(id,  "/dynamic/sino_mesh.lua", 0)
  pewpew.customizable_entity_set_mesh_color(id, 0xff0000ff)
  pewpew.entity_set_radius(id, 70fx)

  local life = 30
  local hit_time = -100fx
  local time = 0fx
  local last_shoot_time = 0fx
  local dead = false

  pewpew.customizable_entity_set_weapon_collision_callback(id, function(player_id, weapon_type)
    if dead == true or time < 50fx then
      return false
    end
    if weapon_type == pewpew.WeaponType.BULLET then
      local x,y = pewpew.entity_get_position(id)
      pewpew.increase_score_of_player(0, 50)
      if last_shoot_time ~= time then
        hit_time = time
        new_bullet(x, y, ship_id, 0.300fx)
        new_bullet(x, y, ship_id, -0.300fx)  
      end
      life = life - 1
      if life == 0 then
        dead = true
        number_of_sinos_killed = number_of_sinos_killed + 1
        destroy_sino(id, ship_id, fmath.to_int(time))
      end
    end
    return true
  end)


  local movement = 5fx
  pewpew.entity_set_update_callback(id, function()
    if dead == true then
      return
    end
    x = x + movement * vx
    y = y + movement * vy
    time = time + 1fx
    local sin, cos = fmath.sincos(time / 10fx)
    local y2 = y + sin * 80fx * vx
    local x2 = x + cos * 80fx * vy
    pewpew.entity_set_position(id, x2, y2)
    if time - hit_time < 2fx then
      pewpew.customizable_entity_set_mesh_scale(id, 95fx/100fx)
      pewpew.customizable_entity_set_mesh_color(id, 0xffffffff)
    else
      pewpew.customizable_entity_set_mesh_scale(id, 1fx)
      pewpew.customizable_entity_set_mesh_color(id, 0xff0000ff)
    end
    pewpew.customizable_entity_set_mesh_angle(id, time / 10fx, 0fx, 0fx ,1fx)
    if number_of_sinos == 1 and time > 1500fx then
      local range = 10
      if time > 2000fx then
        range = 1
      end
      if fmath.random_int(0, range) == 0 then
        new_bullet(x2, y2, ship_id, fmath.random_fixedpoint(-0.1800fx, 0.1800fx))
      end
    end
  end)

  pewpew.customizable_entity_configure_wall_collision(id , true , function()
    movement = -movement
  end)

  pewpew.customizable_entity_set_player_collision_callback(id, function(player_id, entity_id)
    pewpew.add_damage_to_player_ship(ship_id, 5)
    dead = true
    destroy_sino(id, ship_id, 1000)
  end)

  return id
end

return e
