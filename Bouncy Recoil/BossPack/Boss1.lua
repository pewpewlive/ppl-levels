local game = {}

function spin(entity,angle,reduce)
  pewpew.customizable_entity_set_mesh_angle(entity, angle, 0fx, 0fx, 1fx)
  return angle + fmath.tau()/reduce
end

function PointMove(entity, speed, vertices, current_point, hold)
  local newhold = false
  local Point = current_point
  local ex, ey = pewpew.entity_get_position(entity)
  local dx = Point[1] - ex
  local dy = Point[2] - ey
  local distance = fmath.sqrt(dx*dx + dy*dy)
  if distance > 10fx then
    
    local angle = fmath.atan2(dy, dx)
    local sin, cos = fmath.sincos(angle)
    pewpew.entity_set_position(entity, ex + cos * speed, ey + sin * speed)

  elseif hold ~= nil and hold == false then
    newhold = true
  else
    local index = fmath.random_int(1,#vertices)
    Point = vertices[index]
  end
  return Point, newhold
end

function ToPlayer(entity, speed, ship_id) 
  if pewpew.entity_get_is_alive(ship_id) then
    local ex, ey = pewpew.entity_get_position(entity)
    local px, py = pewpew.entity_get_position(ship_id)
    local dy = py - ey
    local dx = px - ex
    local angle = fmath.atan2(dy, dx)
    local sin, cos = fmath.sincos(angle)

    pewpew.entity_set_position(entity, ex + cos * speed, ey + sin * speed)
  end
end

function CirclePlayer(entity, torque, speed, radius, initialangle, direction, ship_id)
  local angle = initialangle
  local Direction = game[entity].direction
  if pewpew.entity_get_is_alive(ship_id) then
    local ex, ey = pewpew.entity_get_position(entity)
    local px, py = pewpew.entity_get_position(ship_id)
    local sin,cos = fmath.sincos(angle)
    local point = {px + radius * cos, py + radius * sin}
    local dx = point[1] - ex
    local dy = point[2] - ey
    local newangle = fmath.atan2(dy, dx)
    local sin2, cos2 = fmath.sincos(newangle)
    local distance = fmath.sqrt(dx*dx + dy*dy)
    if distance > 3fx * speed then
      pewpew.entity_set_position(entity, ex + cos2 * speed, ey + sin2 * speed)
    else
      pewpew.entity_set_position(entity, point[1], point[2])
      angle = angle + torque/200fx * Direction
    end
    
  end
  return angle
end


function Boss1Bullet(x, y, angle, damage)
  local bullet = pewpew.new_customizable_entity(x,y)
  pewpew.entity_set_radius(bullet, 15fx)
  pewpew.customizable_entity_set_mesh(bullet, "/dynamic/BossPack/enemy_meshes.lua", 4)
  pewpew.customizable_entity_set_position_interpolation(bullet, true)
  pewpew.customizable_entity_start_spawning(bullet, 5)
  local rotation = 0fx
  pewpew.entity_set_update_callback(bullet, function()
    local speed = 15fx
    local x2, y2 = pewpew.entity_get_position(bullet)
    local sin, cos = fmath.sincos(angle)
    local dx = x2 + cos * speed
    local dy = y2 + sin * speed
    pewpew.entity_set_position(bullet, dx, dy)
    pewpew.customizable_entity_set_mesh_angle(bullet, rotation, sin, cos, 0fx)
    rotation = rotation + fmath.tau()/15fx
  end)
  pewpew.customizable_entity_set_player_collision_callback(bullet, function(player_id, player_ship)
    pewpew.add_damage_to_player_ship(player_ship, damage)
    pewpew.customizable_entity_start_exploding(bullet, 12)
  end)

  pewpew.customizable_entity_configure_wall_collision(bullet, true, function()
    pewpew.customizable_entity_start_exploding(bullet, 12)
  end)
end

function Boss1Orbiters(x,y, distance, size, BossEntity, bossf, ship_id)
  local anglesplit = fmath.tau()/3fx
  local angle1 = anglesplit*1fx
  local angle2 = anglesplit*2fx
  local angle3 = anglesplit*3fx
  local dy1, dx1 = fmath.sincos(angle1)
  local dy2, dx2 = fmath.sincos(angle2)
  local dy3, dx3 = fmath.sincos(angle3)
  local orbiter1 = pewpew.new_customizable_entity(x + dx1 * distance, y + dy1 * distance)
  local orbiter2 = pewpew.new_customizable_entity(x + dx2 * distance, y + dy2 * distance)
  local orbiter3 = pewpew.new_customizable_entity(x + dx3 * distance, y + dy3 * distance)

  pewpew.add_arrow_to_player_ship(ship_id, orbiter1, 0xff2222ff)
  pewpew.add_arrow_to_player_ship(ship_id, orbiter2, 0xff2222ff)
  pewpew.add_arrow_to_player_ship(ship_id, orbiter3, 0xff2222ff)

  pewpew.customizable_entity_set_mesh(orbiter1, "/dynamic/BossPack/enemy_meshes.lua", 5)
  pewpew.customizable_entity_set_mesh(orbiter2, "/dynamic/BossPack/enemy_meshes.lua", 5)
  pewpew.customizable_entity_set_mesh(orbiter3, "/dynamic/BossPack/enemy_meshes.lua", 5)
  pewpew.entity_set_radius(orbiter1, size)
  pewpew.entity_set_radius(orbiter2, size)
  pewpew.entity_set_radius(orbiter3, size)
  pewpew.customizable_entity_set_position_interpolation(orbiter1, true)
  pewpew.customizable_entity_set_position_interpolation(orbiter2, true)
  pewpew.customizable_entity_set_position_interpolation(orbiter3, true)
  local speed = 1fx/60fx
  local health1 = 45
  local health2 = 45
  local health3 = 45
  local debounce1 = true
  local debounce2 = true
  local debounce3 = true
  local hurt1 = 0
  local hurt2 = 0
  local hurt3 = 0



  pewpew.customizable_entity_set_weapon_collision_callback(orbiter1, function()
    if debounce1 then
      health1 = health1 - 1
      hurt1 = 5
      if health1 <= 0 then
        debounce1 = false
        pewpew.customizable_entity_start_exploding(orbiter1, 20)
        game[bossf].orbitercount = game[bossf].orbitercount - 1
      end
      return true
    end
  end)
  pewpew.customizable_entity_set_weapon_collision_callback(orbiter2, function()
    if debounce2 then
      health2 = health2 - 1
      hurt2 = 5
      if health2 <= 0 then
        debounce2 = false
        pewpew.customizable_entity_start_exploding(orbiter2, 20)
        game[bossf].orbitercount = game[bossf].orbitercount - 1
      end
      return true
    end
  end)
  pewpew.customizable_entity_set_weapon_collision_callback(orbiter3, function()
    if debounce3 then
      health3 = health3 - 1
      hurt3 = 5
      if health3 <= 0 then
        debounce3 = false
        pewpew.customizable_entity_start_exploding(orbiter3, 20)
        game[bossf].orbitercount = game[bossf].orbitercount - 1
      end
      return true
    end
  end)
  local rotation1 = 0fx
  local rotation2 = 0fx
  local rotation3 = 0fx
  local angletime = 0fx
  local offset = fmath.tau()/3fx
  local sendangle1
  local sendangle2
  local sendangle3
  local sendspeed1 = 0fx
  local sendspeed2 = 0fx
  local sendspeed3 = 0fx


  pewpew.customizable_entity_set_player_collision_callback(orbiter1, function(player_id, player_ship)
    if game[BossEntity].OrbiterHitDebounce <= 0 then
      game[BossEntity].OrbiterHitDebounce = 30
      local playerx, playery = pewpew.entity_get_position(player_ship)
      local entityx, entityy = pewpew.entity_get_position(orbiter1)
      local x = playerx - entityx
      local y = playery - entityy
      sendangle1 = fmath.atan2(y,x)
      sendspeed1 = 50fx
      pewpew.add_damage_to_player_ship(player_ship, 1)
    end
  end)
  pewpew.customizable_entity_set_player_collision_callback(orbiter2, function(player_id, player_ship)
    if game[BossEntity].OrbiterHitDebounce <= 0 then
      game[BossEntity].OrbiterHitDebounce = 30
      local playerx, playery = pewpew.entity_get_position(player_ship)
      local entityx, entityy = pewpew.entity_get_position(orbiter2)
      local x = playerx - entityx
      local y = playery - entityy
      sendangle2 = fmath.atan2(y,x)
      sendspeed2 = 50fx
      pewpew.add_damage_to_player_ship(player_ship, 1)
    end
  end)
  pewpew.customizable_entity_set_player_collision_callback(orbiter3, function(player_id, player_ship)
    if game[BossEntity].OrbiterHitDebounce <= 0 then
      game[BossEntity].OrbiterHitDebounce = 30
      local playerx, playery = pewpew.entity_get_position(player_ship)
      local entityx, entityy = pewpew.entity_get_position(orbiter3)
      local x = playerx - entityx
      local y = playery - entityy
      sendangle3 = fmath.atan2(y,x)
      sendspeed3 = 50fx
      pewpew.add_damage_to_player_ship(player_ship, 1)
    end
  end)

  local basecolor = 0xff2222ff
  local hurtcolor = 0xffaaaaff

  pewpew.entity_set_update_callback(orbiter1, function()
    local x, y = pewpew.entity_get_position(bossf)
    angletime = angletime + 1fx
    local dsin, dcos = fmath.sincos(angletime/5fx + offset * 1fx)
    dsin = dsin/2fx
    dcos = dcos/2fx
    angle1 = angle1 + fmath.tau() * speed
    rotation1 = rotation1 + fmath.tau() * speed
    local sin, cos = fmath.sincos(angle1)
    pewpew.entity_set_position(orbiter1, x + 100fx *dcos + cos * distance, y + 100fx * dsin + sin * distance)
    pewpew.customizable_entity_set_mesh_angle(orbiter1, rotation1, 1fx, 1fx, 1fx)

    if hurt1 > 0 then
      pewpew.customizable_entity_set_mesh_color(orbiter1, hurtcolor)
      hurt1 = hurt1 - 1
    else
      pewpew.customizable_entity_set_mesh_color(orbiter1, basecolor)
    end

    if sendspeed1 > 0fx and pewpew.entity_get_is_alive(ship_id) then
      local x, y = pewpew.entity_get_position(ship_id)
      local ychange, xchange = fmath.sincos(sendangle1)
      if x + xchange < 0fx or x + xchange > level_length then
        xchange = 0fx
      end
      if y + ychange < 0fx or y + ychange > level_height then
        ychange = 0fx
      end
      
      pewpew.entity_set_position(ship_id, x + xchange * sendspeed1, y + ychange * sendspeed1)
      if ychange == 0fx or xchange == 0fx then
        sendspeed1 = sendspeed1 - 10fx
      else
        sendspeed1 = sendspeed1 - 1fx
      end
    end
  end)
  pewpew.entity_set_update_callback(orbiter2, function()
    local x, y = pewpew.entity_get_position(bossf)
    local dsin, dcos = fmath.sincos(angletime/5fx + offset * 2fx)
    dsin = dsin/2fx
    dcos = dcos/2fx
    angle2 = angle2 + fmath.tau() * speed
    rotation2 = rotation2 + fmath.tau() * speed
    local sin, cos = fmath.sincos(angle2)
    pewpew.entity_set_position(orbiter2, x + 100fx *dcos + cos * distance, y + 100fx * dsin + sin * distance)
    pewpew.customizable_entity_set_mesh_angle(orbiter2, rotation2, 1fx, 1fx, 1fx)

    if hurt2 > 0 then
      pewpew.customizable_entity_set_mesh_color(orbiter2, hurtcolor)
      hurt2 = hurt2 - 1
    else
      pewpew.customizable_entity_set_mesh_color(orbiter2, basecolor)
    end
    if sendspeed2 > 0fx and pewpew.entity_get_is_alive(ship_id) then
      local x, y = pewpew.entity_get_position(ship_id)
      local ychange, xchange = fmath.sincos(sendangle2)
      if x + xchange < 0fx or x + xchange > level_length then
        xchange = 0fx
      end
      if y + ychange < 0fx or y + ychange > level_height then
        ychange = 0fx
      end
      
      pewpew.entity_set_position(ship_id, x + xchange * sendspeed2, y + ychange * sendspeed2)
      if ychange == 0fx or xchange == 0fx then
        sendspeed2 = sendspeed2 - 10fx
      else
        sendspeed2 = sendspeed2 - 1fx
      end
    end
  end)
  pewpew.entity_set_update_callback(orbiter3, function()
    local x, y = pewpew.entity_get_position(bossf)
    local dsin, dcos = fmath.sincos(angletime/5fx + offset * 3fx)
    dsin = dsin/2fx
    dcos = dcos/2fx
    angle3 = angle3 + fmath.tau() * speed
    rotation3 = rotation3 + fmath.tau() * speed
    local sin, cos = fmath.sincos(angle3)
    pewpew.entity_set_position(orbiter3, x + 100fx *dcos + cos * distance, y + 100fx * dsin + sin * distance)
    pewpew.customizable_entity_set_mesh_angle(orbiter3, rotation3, 1fx, 1fx, 1fx)

    if hurt3 > 0 then
      pewpew.customizable_entity_set_mesh_color(orbiter3, hurtcolor)
      hurt3 = hurt3 - 1
    else
      pewpew.customizable_entity_set_mesh_color(orbiter3, basecolor)
    end
    if sendspeed3 > 0fx and pewpew.entity_get_is_alive(ship_id) then
      local x, y = pewpew.entity_get_position(ship_id)
      local ychange, xchange = fmath.sincos(sendangle3)
      if x + xchange < 0fx or x + xchange > level_length then
        xchange = 0fx
      end
      if y + ychange < 0fx or y + ychange > level_height then
        ychange = 0fx
      end
      
      pewpew.entity_set_position(ship_id, x + xchange * sendspeed3, y + ychange * sendspeed3)
      if ychange == 0fx or xchange == 0fx then
        sendspeed3 = sendspeed3 - 10fx
      else
        sendspeed3 = sendspeed3 - 1fx
      end
    end
  end)
end

function newBoss(x,y, ship_id, vertices)
  local health = 100
  local healthtrack = 100
  local HitDebounce = 0
  local bossf = pewpew.new_customizable_entity(x, y)
  game[bossf] = {OrbiterHitDebounce = 0, orbitercount = 0}
  local bossf2 = pewpew.new_customizable_entity(x, y)
  local bossf3 = pewpew.new_customizable_entity(x, y)
  local bossf4 = pewpew.new_customizable_entity(x, y)
  pewpew.customizable_entity_set_mesh(bossf, "/dynamic/BossPack/enemy_meshes.lua", 0)
  pewpew.customizable_entity_set_mesh(bossf2, "/dynamic/BossPack/enemy_meshes.lua", 1)
  pewpew.customizable_entity_set_mesh(bossf3, "/dynamic/BossPack/enemy_meshes.lua", 2)
  pewpew.customizable_entity_set_mesh(bossf4, "/dynamic/BossPack/enemy_meshes.lua", 3)
  pewpew.customizable_entity_set_position_interpolation(bossf, true)
  pewpew.customizable_entity_set_position_interpolation(bossf2, true)
  pewpew.customizable_entity_set_position_interpolation(bossf3, true)
  pewpew.customizable_entity_set_position_interpolation(bossf4, true)
  local bossfcolor = 0xf3fa23ff
  local bossf2color = 0x99fa23ff
  local bossf3color = 0x31fa23ff
  local bossf4color = 0xff6d29ff
  local hurtcolor = 0xff0000ff
  local invincibilitycolor = 0x00ffffff
  local hurt = 0
  local invincibility = false
  local invincdebounce = true
  pewpew.customizable_entity_set_mesh_color(bossf, bossfcolor)
  pewpew.customizable_entity_set_mesh_color(bossf2, bossf2color)
  pewpew.customizable_entity_set_mesh_color(bossf3, bossf3color)
  pewpew.customizable_entity_set_mesh_color(bossf4, bossf4color)
  pewpew.entity_set_radius(bossf, 90fx)
  local debounce = true
  local angle = fmath.tau()
  local angle2 = fmath.tau()
  local angle3 = fmath.tau()
  local angle4 = fmath.tau()
  local sendangle
  local sendspeed = 0fx
  local current_point = vertices[fmath.random_int(1,#vertices)]
  pewpew.entity_set_update_callback(bossf, function()
    if HitDebounce > 0 then
      HitDebounce = HitDebounce - 1
    end
    if game[bossf].OrbiterHitDebounce > 0 then
      game[bossf].OrbiterHitDebounce = game[bossf].OrbiterHitDebounce - 1
    end
    angle = spin(bossf,angle,40fx)
    if sendspeed > 0fx and pewpew.entity_get_is_alive(ship_id) then
      local x, y = pewpew.entity_get_position(ship_id)
      local ychange, xchange = fmath.sincos(sendangle)
      if x + xchange < 0fx or x + xchange > level_length then
        xchange = 0fx
      end
      if y + ychange < 0fx or y + ychange > level_height then
        ychange = 0fx
      end
      
      pewpew.entity_set_position(ship_id, x + xchange * sendspeed, y + ychange * sendspeed)
      if ychange == 0fx or xchange == 0fx then
        sendspeed = sendspeed - 10fx
      else
        sendspeed = sendspeed - 1fx
      end
    end
    if healthtrack - health >= 30 and invincdebounce then

      healthtrack = health
      invincibility = true
      invincdebounce = false
      game[bossf].orbitercount = 3
      local newx, newy = pewpew.entity_get_position(bossf)
      Boss1Orbiters(newx, newy, 200fx, 52fx, bossf, bossf, ship_id)

    elseif invincibility then
      pewpew.customizable_entity_set_mesh_color(bossf, invincibilitycolor)
      pewpew.customizable_entity_set_mesh_color(bossf2, invincibilitycolor)
      pewpew.customizable_entity_set_mesh_color(bossf3, invincibilitycolor)
      pewpew.customizable_entity_set_mesh_color(bossf4, invincibilitycolor)
      ToPlayer(bossf, 5fx/2fx, ship_id)
      if game[bossf].orbitercount <= 0 then
        invincibility = false
        invincdebounce = true
      end
    else
      current_point = PointMove(bossf, 20fx, vertices, current_point)
      if hurt > 0 then
        hurt = hurt - 1
        pewpew.customizable_entity_set_mesh_color(bossf, hurtcolor)
        pewpew.customizable_entity_set_mesh_color(bossf2, hurtcolor)
        pewpew.customizable_entity_set_mesh_color(bossf3, hurtcolor)
        pewpew.customizable_entity_set_mesh_color(bossf4, hurtcolor)
      else
        pewpew.customizable_entity_set_mesh_color(bossf, bossfcolor)
        pewpew.customizable_entity_set_mesh_color(bossf2, bossf2color)
        pewpew.customizable_entity_set_mesh_color(bossf3, bossf3color)
        pewpew.customizable_entity_set_mesh_color(bossf4, bossf4color)
      end
    end


  end)
  pewpew.customizable_entity_set_player_collision_callback(bossf, function(player_id, player_ship)
    if HitDebounce == 0 then
      HitDebounce = 30
      local playerx, playery = pewpew.entity_get_position(player_ship)
      local entityx, entityy = pewpew.entity_get_position(bossf)
      local x = playerx - entityx
      local y = playery - entityy
      sendangle = fmath.atan2(y,x)
      sendspeed = 30fx
      pewpew.add_damage_to_player_ship(player_ship, 2)
    end
  end)
  pewpew.entity_set_update_callback(bossf2, function()
    angle2 = spin(bossf2,angle2,-80fx)
    pewpew.entity_set_position(bossf2, pewpew.entity_get_position(bossf))
    if pewpew.entity_get_is_alive(bossf) then
      if pewpew.entity_get_is_started_to_be_destroyed(bossf) then
        pewpew.customizable_entity_start_exploding(bossf2, 30)
      end
    end
  end)
  pewpew.entity_set_update_callback(bossf3, function()
    angle3 = spin(bossf3,angle3,60fx)
    pewpew.entity_set_position(bossf3, pewpew.entity_get_position(bossf))
    if pewpew.entity_get_is_alive(bossf) then
      if pewpew.entity_get_is_started_to_be_destroyed(bossf) then
        pewpew.customizable_entity_start_exploding(bossf3, 30)
      end
    end
  end)
  pewpew.entity_set_update_callback(bossf4, function()
    angle4 = spin(bossf4,angle4,30fx)
    pewpew.entity_set_position(bossf4, pewpew.entity_get_position(bossf))
    if pewpew.entity_get_is_alive(bossf) then
      if pewpew.entity_get_is_started_to_be_destroyed(bossf) then
        pewpew.customizable_entity_start_exploding(bossf4, 30)
      end
    end
  end)
  local i = 0
  pewpew.customizable_entity_set_weapon_collision_callback(bossf, function()


    if not invincibility then
      if health > 0 then
        health = health - 1
        hurt = 5
        return true
      elseif debounce then
        debounce = false

        if pewpew.entity_get_is_alive(bossf) then
          pewpew.customizable_entity_start_exploding(bossf, 30)
        end
      end
    else
      i = i + 1
      if i % 5 == 0 then
        local px, py = pewpew.entity_get_position(ship_id)
        local ex, ey = pewpew.entity_get_position(bossf)
        local BulletAngle = fmath.atan2(py - ey, px - ex)
        local offset = fmath.tau()/10fx
        Boss1Bullet(ex, ey, BulletAngle + offset, 1)
        Boss1Bullet(ex, ey, BulletAngle - offset, 1)
        return true
      else
        local px, py = pewpew.entity_get_position(ship_id)
        local ex, ey = pewpew.entity_get_position(bossf)
        local BulletAngle = fmath.atan2(py - ey, px - ex)
        local offset = fmath.tau()/14fx
        Boss1Bullet(ex, ey, BulletAngle, 1)
        return true
      end
    end
  end)
end

return newBoss