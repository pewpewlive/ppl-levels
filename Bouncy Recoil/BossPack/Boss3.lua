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

function NewSkully(x,y)
    local skully = pewpew.new_customizable_entity(x, y)
    pewpew.customizable_entity_set_mesh(skully, "/dynamic/BossPack/Skull_Mesh.lua", 0)
    pewpew.customizable_entity_set_mesh_scale(skully, 75fx)
    pewpew.customizable_entity_set_position_interpolation(skully, true)
    
    local bones = pewpew.new_customizable_entity(x, y)
    pewpew.customizable_entity_set_mesh(bones, "/dynamic/BossPack/skullbones.lua", 0)
    pewpew.customizable_entity_set_mesh_scale(bones, 75fx)
    pewpew.customizable_entity_set_position_interpolation(bones, true)
    return skully, bones
  end
  
  
  
  function NewOrbiter(x,y,distance,size,speed,angle,basecolor,Head,ship_id)
  
  
    local orbiter = pewpew.new_customizable_entity(x, y)
    local rotation = 0fx
    local sendspeed = 0fx
    local sendangle
  
    pewpew.customizable_entity_set_mesh(orbiter, "/dynamic/BossPack/enemy_meshes.lua", 17)
    pewpew.entity_set_radius(orbiter, size)
    pewpew.customizable_entity_set_position_interpolation(orbiter, true)
    pewpew.customizable_entity_set_mesh_color(orbiter, basecolor)
  
    pewpew.customizable_entity_set_player_collision_callback(orbiter, function(player_id, player_ship)
      if game[Head].OrbiterHitDebounce <= 0 then
        game[Head].OrbiterHitDebounce = 90
        local playerx, playery = pewpew.entity_get_position(player_ship)
        local entityx, entityy = pewpew.entity_get_position(orbiter)
        local x = playerx - entityx
        local y = playery - entityy
        sendangle = fmath.atan2(y,x)
        sendspeed = 20fx
        pewpew.add_damage_to_player_ship(player_ship, 1)
      end
    end)
  
    pewpew.entity_set_update_callback(orbiter, function()
      if pewpew.entity_get_is_alive(Head) then
        if not pewpew.entity_get_is_started_to_be_destroyed(Head) and pewpew.entity_get_is_alive(Head) and game[Head].mode == 1 then
          local x, y = pewpew.entity_get_position(Head)
          angle = angle + fmath.tau() * speed
          rotation = rotation + fmath.tau() * speed
          local sin, cos = fmath.sincos(angle)
          pewpew.entity_set_position(orbiter, x + cos * distance, y + sin * distance)
          pewpew.customizable_entity_set_mesh_angle(orbiter, angle, 0fx, 0fx, 1fx)
  
  
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
        else
          pewpew.customizable_entity_start_exploding(orbiter, 30)
          pewpew.entity_set_update_callback(orbiter, nil)
        end
      end
    end)
  
    pewpew.customizable_entity_set_weapon_collision_callback(orbiter, function()
      return true
    end)
  end
  
  function Boss3Orbiters(x,y, split, FREQ, distance, size, Head, colors, ship_id)
    local anglesplit = fmath.tau()/split
  
    local speed = 1fx/50fx
  
    local offset = fmath.tau()/2fx
  
    local basecolor = 0x59ffd3ff
    
    for i = 1fx, split, 1fx do
      for j = 1fx, FREQ, 1fx do
        local color = colors[fmath.random_int(1,#colors)]
        local angle = anglesplit * i + fmath.tau()/60fx * j
        local sin, cos = fmath.sincos(angle)
        local dx = x + cos * distance
        local dy = y + sin * distance
        NewOrbiter(dx,dy,distance,size,speed,angle,color,Head, ship_id)
        --NewOrbiter(x,y,distance,size,speed,angle,basecolor,Head)
        
      end
    end
  
  end
  
  function Boss3Bullet(x, y, angle, damage, speed, core)
    local bullet = pewpew.new_customizable_entity(x,y)
    pewpew.entity_set_radius(bullet, 35fx)
    pewpew.customizable_entity_set_mesh(bullet, "/dynamic/BossPack/enemy_meshes.lua", 18)
    pewpew.customizable_entity_set_position_interpolation(bullet, true)
    pewpew.customizable_entity_start_spawning(bullet, 5)
    local rotation = 0fx
    pewpew.entity_set_update_callback(bullet, function()
      
      if pewpew.entity_get_is_alive(core) then
        if pewpew.entity_get_is_started_to_be_destroyed(core) then
          pewpew.customizable_entity_start_exploding(bullet, 15)
        end
      end
  
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
  
  
  function newBoss3(x,y,vertices, ship_id)
    local Head, Bones = NewSkully(x,y)
    local PulsatingHead, PulsatingBones = NewSkully(x,y)
    local StarOffset = 30fx
    local Star = pewpew.new_customizable_entity(x,y+StarOffset)
    pewpew.customizable_entity_set_mesh(Star, "/dynamic/BossPack/enemy_meshes.lua", 19)
    local color = 0xfc2003ff
    local hurtcolor = 0xbaddffff
    local sendangle
    local sendspeed = 0fx
    local hold = false
    local RapidCoolDown = 0
    local repeatcount = 30
    local middlecount = 120
    local middle = false
    local decision = false
    local PulsateColorOffset = 145
    local StarColor = 0xffd659ff
    local HeadRotate = 0fx
    local initialangle = 0fx
    local DirectionCooldown = 0
    local Mode2Cooldown = 0
    local HitDebounce = 0
  
    game[Head] = {health = 200, mode = 1, direction = 1fx, OrbiterHitDebounce = 0}
    pewpew.customizable_entity_set_mesh_color(Head, color)
    pewpew.customizable_entity_set_mesh_color(Bones, color)
    pewpew.customizable_entity_set_mesh_color(PulsatingHead, color - PulsateColorOffset)
    pewpew.customizable_entity_set_mesh_color(PulsatingBones, color - PulsateColorOffset)
    pewpew.customizable_entity_set_mesh_color(Star, StarColor)
    pewpew.customizable_entity_set_position_interpolation(Star, true)
    pewpew.entity_set_radius(Head, 130fx)
  
    local colors = {0x59ffd3ff}
    Boss3Orbiters(x,y, 1fx, 40fx, 150fx, 20fx, Head, colors, ship_id)
    --Boss3Orbiters(x,y, split, FREQ, distance, size, Head, colors)
    local debounce = true
    local hurt = 0
    pewpew.customizable_entity_set_weapon_collision_callback(Head, function()
      if game[Head].health > 0 then
        game[Head].health = game[Head].health - 1
        hurt = 3
        return true
      elseif debounce then
        debounce = false
        pewpew.customizable_entity_start_exploding(Head, 30)
        return true
      end
    end)
  
  
    local PulsateTime1 = 0fx
    local PulsateTime2 = 0fx
  
  
    local margin = 100fx
    local index = fmath.random_int(1,#vertices)
    local current_point = vertices[index]
    local angleset = true
  
    pewpew.entity_set_update_callback(Head, function()
      if HitDebounce > 0 then
        HitDebounce = HitDebounce - 1
      end
      if game[Head].OrbiterHitDebounce > 0 then
        game[Head].OrbiterHitDebounce = game[Head].OrbiterHitDebounce - 1
      end
      if DirectionCooldown > 0 then
        DirectionCooldown = DirectionCooldown - 1
      end
      if game[Head].mode == 2 and initialangle == 0fx and angleset then
        angleset = false
        local ex, ey = pewpew.entity_get_position(Head)
        local px, py = pewpew.entity_get_position(ship_id)
        local dx = px - ex
        local dy = py - ey
        initialangle = fmath.atan2(dy, dx) + fmath.tau()/5fx
      end
      if game[Head].health < 100 and game[Head].mode == 1 then
        game[Head].mode = 2
        pewpew.entity_set_radius(Head, 100fx)
      end
      if game[Head].mode == 2 then
        pewpew.customizable_entity_set_mesh_angle(Head, HeadRotate, 0fx, 0fx, 1fx)
        pewpew.customizable_entity_set_mesh_angle(PulsatingHead, HeadRotate, 0fx, 0fx, 1fx)
        HeadRotate = HeadRotate + fmath.tau()/30fx
      end
      if hurt > 0 then
        hurt = hurt - 1
        pewpew.customizable_entity_set_mesh_color(Head, hurtcolor)
        pewpew.customizable_entity_set_mesh_color(Star, hurtcolor)
        if pewpew.entity_get_is_alive(Bones) then
          pewpew.customizable_entity_set_mesh_color(Bones, hurtcolor)
        end
        pewpew.customizable_entity_set_mesh_color(PulsatingHead, hurtcolor - PulsateColorOffset)
        if pewpew.entity_get_is_alive(PulsatingBones) then
          pewpew.customizable_entity_set_mesh_color(PulsatingBones, hurtcolor - PulsateColorOffset)
        end
      else
        pewpew.customizable_entity_set_mesh_color(Star, StarColor)
        pewpew.customizable_entity_set_mesh_color(Head, color)
        if pewpew.entity_get_is_alive(Bones) then
          pewpew.customizable_entity_set_mesh_color(Bones, color)
        end
        pewpew.customizable_entity_set_mesh_color(PulsatingHead, color - PulsateColorOffset)
        if pewpew.entity_get_is_alive(PulsatingBones) then
          pewpew.customizable_entity_set_mesh_color(PulsatingBones, color - PulsateColorOffset)
        end
      end
  
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
      
  
      if game[Head].mode == 1 then
        if not hold then
          current_point, hold = PointMove(Head, 20fx, vertices, current_point, hold)
        elseif repeatcount > 0 then
          if RapidCoolDown <= 0 then
            local ex, ey = pewpew.entity_get_position(Head)
            local dx = x - ex
            local dy = y - ey
            local angle = fmath.atan2(dy,dx)
            local spread = fmath.random_fixedpoint(-fmath.tau()/5fx, fmath.tau()/5fx)
            Boss3Bullet(ex, ey, angle + spread, 1, 8fx, Head)
            --(x, y, angle, damage, speed, core)
            RapidCoolDown = 2
            repeatcount = repeatcount - 1
          else
            RapidCoolDown = RapidCoolDown - 1
          end
        elseif repeatcount <= 0 and not decision then
  
          local outcome = fmath.random_int(1,3)
          if outcome == 3 then
            decision = true
            middle = false
            middlecount = 120
  
          else
            repeatcount = 30
            hold = false
            local function newpoint()
              local NewPoint = vertices[fmath.random_int(1,#vertices)]
              if NewPoint == current_point then
                return newpoint()
              else
                return NewPoint
              end
            end
            current_point = newpoint()
          end
        elseif not middle then
          local hx, hy = pewpew.entity_get_position(Head)
          local middlepoint = {x,y}
          local dx = middlepoint[1] - hx
          local dy = middlepoint[2] - hy
          local angle = fmath.atan2(dy, dx)
          local sin, cos = fmath.sincos(angle)
          local speed = 20fx
          local distance = fmath.sqrt(dx*dx + dy*dy)
          if distance > 10fx then
            pewpew.entity_set_position(Head, hx + cos * speed, hy + sin * speed)
          else
            if RapidCoolDown > 0 then
              RapidCoolDown = RapidCoolDown - 1
            elseif middlecount > 0 then
              middlecount = middlecount - 1
              RapidCoolDown = 1
              local ex, ey = pewpew.entity_get_position(Head)
              local angle = fmath.random_fixedpoint(0fx,fmath.tau())
              
              Boss3Bullet(ex, ey, angle, 1, 8fx, Head)
            else
              middle = true
            end
            
          end
          else
          hold = false
          middle = false
          repeatcount = 30
          middlecount = 120
          local function newpoint()
            local NewPoint = vertices[fmath.random_int(1,#vertices)]
            if NewPoint == current_point then
              return newpoint()
            else
              return NewPoint
            end
          end
          current_point = newpoint()
          
        end
  
  
  
      elseif game[Head].mode == 2 and pewpew.entity_get_is_alive(Head) then
        if not pewpew.entity_get_is_started_to_be_destroyed(Head) then
          initialangle = CirclePlayer(Head, 15fx, 10fx, 300fx, initialangle, ship_id)
          --CirclePlayer(entity, torque, speed, radius, initialangle)
  
          if Mode2Cooldown > 0 and pewpew.entity_get_is_alive(ship_id) then
            Mode2Cooldown = Mode2Cooldown - 1
          elseif pewpew.entity_get_is_alive(ship_id) then
            Mode2Cooldown = 20
            local ex, ey = pewpew.entity_get_position(Head)
            local px, py = pewpew.entity_get_position(ship_id)
            local dx = px - ex
            local dy = py - ey
            local angle = fmath.atan2(dy, dx)
            local spread = fmath.tau()/12fx
            Boss3Bullet(ex, ey, angle, 2, 10fx, Head)
            Boss3Bullet(ex, ey, angle + spread, 2, 10fx, Head)
            Boss3Bullet(ex, ey, angle + spread * 2fx, 2, 10fx, Head)
            Boss3Bullet(ex, ey, angle - spread * 2fx, 2, 10fx, Head)
            Boss3Bullet(ex, ey, angle- spread, 2, 10fx, Head)
  
            --Boss3Bullet(x, y, angle, damage, speed, core)
          end
        end
      end
    end)
  
    pewpew.customizable_entity_set_player_collision_callback(Head, function(player_index, player_ship)
      if HitDebounce == 0 then
        HitDebounce = 60
        local playerx, playery = pewpew.entity_get_position(player_ship)
        local entityx, entityy = pewpew.entity_get_position(Head)
        local x = playerx - entityx
        local y = playery - entityy
        sendangle = fmath.atan2(y,x)
        sendspeed = 20fx
        pewpew.add_damage_to_player_ship(player_ship, 3)
      end
    end)
  
    pewpew.entity_set_update_callback(Bones, function()
      if pewpew.entity_get_is_alive(Head) then
        if not pewpew.entity_get_is_started_to_be_destroyed(Head) and pewpew.entity_get_is_alive(Head) and game[Head].mode == 1 then
          pewpew.entity_set_position(Bones, pewpew.entity_get_position(Head))
        else
          pewpew.customizable_entity_start_exploding(Bones, 30)
        end
      end
    end)
  
  
  
    pewpew.entity_set_update_callback(PulsatingHead, function()
      if pewpew.entity_get_is_alive(Head) then
        if not pewpew.entity_get_is_started_to_be_destroyed(Head) and pewpew.entity_get_is_alive(Head) then
          PulsateTime1 = PulsateTime1 + 1fx
          local sin, cos = fmath.sincos(fmath.tau()/20fx*PulsateTime1)
          pewpew.customizable_entity_set_mesh_scale(PulsatingHead, 75fx + sin * 4fx)
          pewpew.entity_set_position(PulsatingHead, pewpew.entity_get_position(Head))
        else
          pewpew.customizable_entity_start_exploding(PulsatingHead, 30)
        end
      end
    end)
    pewpew.entity_set_update_callback(PulsatingBones, function()
      if pewpew.entity_get_is_alive(Head) then
        if not pewpew.entity_get_is_started_to_be_destroyed(Head) and pewpew.entity_get_is_alive(Head) and game[Head].mode == 1 then
          PulsateTime2 = PulsateTime2 + 1fx
          local sin, cos = fmath.sincos(fmath.tau()/20fx*PulsateTime2)
          pewpew.customizable_entity_set_mesh_scale(PulsatingBones, 75fx + sin * 4fx)
          pewpew.entity_set_position(PulsatingBones, pewpew.entity_get_position(Head))
        else
          pewpew.customizable_entity_start_exploding(PulsatingBones, 30)
        end
      end
    end)
  
    local StarAngle = 0fx
    pewpew.entity_set_update_callback(Star, function()
      if pewpew.entity_get_is_alive(Head) then
        if not pewpew.entity_get_is_started_to_be_destroyed(Head) and pewpew.entity_get_is_alive(Head) then
          pewpew.customizable_entity_set_mesh_angle(Star, StarAngle, 0fx, 0fx, 1fx)
          StarAngle = StarAngle + fmath.tau()/100fx
          local ex, ey = pewpew.entity_get_position(Head)
          local sin, cos = fmath.sincos(HeadRotate + fmath.tau()/4fx)
          pewpew.entity_set_position(Star, ex + StarOffset * cos, ey + StarOffset * sin)
        else
          pewpew.customizable_entity_start_exploding(Star, 30)
        end
      end
    end)
  
    pewpew.customizable_entity_configure_wall_collision(Head, false, function()
      -- if game[Head].mode == 2 and DirectionCooldown <= 0 then
      --   game[Head].direction = game[Head].direction * -1fx
      --   DirectionCooldown = 300
      -- end
    end)
  end

  return newBoss3