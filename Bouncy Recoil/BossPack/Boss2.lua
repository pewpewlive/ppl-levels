function Boss2Spinner(x,y, index, core, direction, angular_speed)
    local spinner = pewpew.new_customizable_entity(x, y)
    pewpew.customizable_entity_set_mesh(spinner, "/dynamic/BossPack/enemy_meshes.lua", index)
    pewpew.customizable_entity_set_position_interpolation(spinner, true)
    local angle = 0fx
    pewpew.entity_set_update_callback(spinner, function()
      if pewpew.entity_get_is_alive(core) then
        if not pewpew.entity_get_is_started_to_be_destroyed(core) then 
          local ex, ey = pewpew.entity_get_position(core)
          pewpew.entity_set_position(spinner, ex, ey)
          pewpew.customizable_entity_set_mesh_angle(spinner, angle, 0fx, 0fx, 1fx)
          angle = angle + angular_speed * direction
        else
          pewpew.customizable_entity_start_exploding(spinner, 30)
          pewpew.entity_set_update_callback(spinner, nil)
        end
      end
    end)
  
    return spinner
  end
  
  function Boss2Projectile(x,y,angle,speed,core, ship_id)
    local target = ship_id
    local Projectile = pewpew.new_customizable_entity(x,y)
    local direction = angle
    local rotation = 0fx
    local sin, cos = fmath.sincos(direction)
    local size = 60fx
    local basecolor = 0xfc4997ff
    local colors = {basecolor, 0xfc49e8ff, 0xcc49fcff, 0x9a49fcff, 0x5849fcff, 0x497ffcff, 0x49b4fcff, 0x49e4fcff, 0x49fcd5ff, 0x3dff91ff, 0x3dff91ff}
    pewpew.customizable_entity_set_mesh(Projectile, "/dynamic/BossPack/enemy_meshes.lua", 16)
    pewpew.entity_set_radius(Projectile, size)
    pewpew.customizable_entity_start_spawning(Projectile,5)
    pewpew.customizable_entity_set_position_interpolation(Projectile, true)
    pewpew.customizable_entity_set_mesh_color(Projectile, basecolor)
    pewpew.add_arrow_to_player_ship(ship_id, Projectile, basecolor)
    local health = 10
    local ChangeDebounce = true
    local DamageDebounce = true
    local TargetDebounce = true
  
  
    pewpew.customizable_entity_configure_wall_collision(Projectile, true, function()
      pewpew.customizable_entity_start_exploding(Projectile, 10)
    end)
    pewpew.entity_set_update_callback(Projectile, function()
      local ex, ey = pewpew.entity_get_position(Projectile)
      pewpew.customizable_entity_set_mesh_color(Projectile, colors[11-health])
  
      pewpew.customizable_entity_set_mesh_angle(Projectile, rotation, cos, sin, 0fx)
      rotation = rotation + fmath.tau()/30fx
      
      pewpew.entity_set_position(Projectile, ex + cos * speed, ey + sin * speed)
      if target == core and TargetDebounce  and #game[core].spinners > 0 then
        local cx, cy = pewpew.entity_get_position(core)
        local dx = cx - ex
        local dy = cy - ey
        local distance = fmath.sqrt(dx*dx + dy*dy)
        if distance <= game[core].size + size and pewpew.entity_get_is_alive(Projectile) then
          if not pewpew.entity_get_is_started_to_be_destroyed(Projectile) then
            TargetDebounce = false
            game[core].spinnercount = game[core].spinnercount - 1
            pewpew.customizable_entity_start_exploding(Projectile, 10)
            pewpew.entity_set_update_callback(Projectile, nil)
          end
        end
      end
    end)
    
    pewpew.customizable_entity_set_weapon_collision_callback(Projectile, function()
      if pewpew.entity_get_is_alive(Projectile) then
        if not pewpew.entity_get_is_started_to_be_destroyed(Projectile) then
          if health > 0 then
            health = health - 1
            return true
  
          elseif ChangeDebounce then
            ChangeDebounce = false
            target = core
            local px, py = pewpew.entity_get_position(ship_id)
            local ex, ey = pewpew.entity_get_position(Projectile)
            local dx = px - ex
            local dy = py - ey
            direction = fmath.atan2(dy, dx) + fmath.tau()/2fx
            sin, cos = fmath.sincos(direction)
  
          elseif TargetDebounce then
            return true
          end
        end
      end
    end)
  
    pewpew.customizable_entity_set_player_collision_callback(Projectile, function()
      if target ~= core and DamageDebounce then
        DamageDebounce = false
        pewpew.add_damage_to_player_ship(ship_id, 2)
        pewpew.customizable_entity_start_exploding(Projectile, 15)
      end
    end)
  end
  
  
  
  function Boss2Bullet(x, y, angle, damage, speed, core)
    local bullet = pewpew.new_customizable_entity(x,y)
    pewpew.entity_set_radius(bullet, 15fx)
    pewpew.customizable_entity_set_mesh(bullet, "/dynamic/BossPack/enemy_meshes.lua", 11)
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
  
  function Boss2Rain(x,y,z,fallspeed, core)
    local Rain = pewpew.new_customizable_entity(x,y)
    local height = z
    local Indicator = pewpew.new_customizable_entity(x,y)
    local angle = 0fx
    local radius = 60fx
    pewpew.customizable_entity_set_mesh_z(Rain, height)
    pewpew.customizable_entity_set_position_interpolation(Rain, true)
    pewpew.customizable_entity_set_mesh(Rain, "/dynamic/BossPack/enemy_meshes.lua", 12)
    pewpew.customizable_entity_start_spawning(Rain, 5)
    pewpew.entity_set_radius(Rain, radius)
    pewpew.customizable_entity_set_mesh_color(Rain, 0xffffff11)
  
    local color = 0xffffff11
    pewpew.customizable_entity_set_mesh(Indicator, "/dynamic/BossPack/enemy_meshes.lua", 13)
    pewpew.customizable_entity_set_string(Indicator, "#ff3333ffX")
    pewpew.entity_set_update_callback(Rain, function()
      height = height - fallspeed
      pewpew.customizable_entity_set_mesh_z(Rain, height)
      pewpew.customizable_entity_set_mesh_angle(Rain, angle, 0.23fx, 0.07fx, 0.16fx)
      angle = angle + fmath.tau()/30fx
  
      if color < 0xfffffffa then
        color = color + 5
        pewpew.customizable_entity_set_mesh_color(Rain, color)
      end
  
      if pewpew.entity_get_is_alive(core) then
        if pewpew.entity_get_is_started_to_be_destroyed(core) then
          if pewpew.entity_get_is_alive(Rain) then
            pewpew.customizable_entity_start_exploding(Rain, 15)
          end
          if pewpew.entity_get_is_alive(Indicator) then
            pewpew.customizable_entity_start_exploding(Indicator, 15)
          end
        end
      end
  
      if height >= -radius and height <= radius then
        pewpew.customizable_entity_set_player_collision_callback(Rain, function(player_index, player_ship)
          pewpew.add_damage_to_player_ship(player_ship, 1)
          pewpew.customizable_entity_start_exploding(Rain, 15)
          pewpew.customizable_entity_start_exploding(Indicator, 15)
          pewpew.customizable_entity_set_string(Indicator, "")
          pewpew.customizable_entity_set_player_collision_callback(Rain, nil)
          pewpew.entity_set_update_callback(Rain, nil)
        end)
      elseif height < -radius then
        pewpew.customizable_entity_start_exploding(Rain, 15)
        pewpew.customizable_entity_start_exploding(Indicator, 15)
        pewpew.customizable_entity_set_string(Indicator, "")
        pewpew.customizable_entity_set_player_collision_callback(Rain, nil)
        pewpew.entity_set_update_callback(Rain, nil)
      end
    end)
  
  end
  
  function Boss2Inertiac(x,y,angle,core,speed,lifetime)
    local InertiacBullet = pewpew.new_customizable_entity(x,y)
    local life = lifetime
    pewpew.customizable_entity_set_mesh(InertiacBullet, "/dynamic/BossPack/enemy_meshes.lua", 15)
    pewpew.customizable_entity_set_position_interpolation(InertiacBullet, true)
    pewpew.entity_set_radius(InertiacBullet, 30fx)
    pewpew.customizable_entity_set_mesh_color(InertiacBullet, 0xff7f08ff)
    pewpew.customizable_entity_set_mesh_angle(InertiacBullet, angle+ fmath.tau()/4fx, 0fx,0fx,1fx)
    pewpew.customizable_entity_start_spawning(InertiacBullet, 0)
  
    pewpew.entity_set_update_callback(InertiacBullet, function()
      if pewpew.entity_get_is_alive(core) then
        if pewpew.entity_get_is_started_to_be_destroyed(core) then
          pewpew.customizable_entity_start_exploding(InertiacBullet, 5)
          pewpew.entity_set_update_callback(InertiacBullet,nil)
        end
      end
      local ex, ey = pewpew.entity_get_position(InertiacBullet)
      local sin, cos = fmath.sincos(angle)
      local dx = ex + cos * speed
      local dy = ex + sin * speed
      pewpew.entity_set_position(InertiacBullet, dx, dy)
      life = life - 1
      local scoredebounce = true
      if life <= 0 then
        local wx, wy = pewpew.entity_get_position(InertiacBullet)
        local NewInertiac = pewpew.new_inertiac(wx, wy, 1fx, angle)
        pewpew.entity_set_update_callback(NewInertiac, function()
          if pewpew.entity_get_is_alive(core) then
            if pewpew.entity_get_is_started_to_be_destroyed(core) then
              pewpew.entity_destroy(NewInertiac)
              pewpew.entity_set_update_callback(NewInertiac,nil)
            end
          end
          if pewpew.entity_get_is_alive(NewInertiac) then
            if pewpew.entity_get_is_started_to_be_destroyed(NewInertiac) and PracticeBoolean and scoredebounce then
              scoredebounce = false
            end
          end
        end)
        pewpew.customizable_entity_start_exploding(InertiacBullet, 5)
        pewpew.entity_set_update_callback(InertiacBullet,nil)
      end
    end)
  end
  
  function Boss2MarchingCube(x,y,angle,core,speed,lifetime)
    local CubeBullet = pewpew.new_customizable_entity(x,y)
    local life = lifetime
    pewpew.customizable_entity_set_mesh(CubeBullet, "/dynamic/BossPack/enemy_meshes.lua", 15)
    pewpew.customizable_entity_set_position_interpolation(CubeBullet, true)
    pewpew.entity_set_radius(CubeBullet, 30fx)
    pewpew.customizable_entity_set_mesh_color(CubeBullet, 0xfffc4dff)
    pewpew.customizable_entity_set_mesh_angle(CubeBullet, angle+ fmath.tau()/4fx, 0fx,0fx,1fx)
    pewpew.customizable_entity_start_spawning(CubeBullet, 0)
  
    pewpew.entity_set_update_callback(CubeBullet, function()
      if pewpew.entity_get_is_alive(core) then
        if pewpew.entity_get_is_started_to_be_destroyed(core) then
          pewpew.customizable_entity_start_exploding(CubeBullet, 5)
          pewpew.entity_set_update_callback(CubeBullet,nil)
        end
      end
      local ex, ey = pewpew.entity_get_position(CubeBullet)
      local sin, cos = fmath.sincos(angle)
      local dx = ex + cos * speed
      local dy = ex + sin * speed
      pewpew.entity_set_position(CubeBullet, dx, dy)
      life = life - 1
      local scoredebounce = true
      if life <= 0 then
        local wx, wy = pewpew.entity_get_position(CubeBullet)
        local NewCube = pewpew.new_rolling_cube(wx, wy)
        pewpew.entity_set_update_callback(NewCube, function()
          if pewpew.entity_get_is_alive(core) then
            if pewpew.entity_get_is_started_to_be_destroyed(core) then
              pewpew.entity_destroy(NewCube)
              pewpew.entity_set_update_callback(NewCube,nil)
            end
          end
          if pewpew.entity_get_is_alive(NewCube) then
            if pewpew.entity_get_is_started_to_be_destroyed(NewCube) and PracticeBoolean and scoredebounce then
              scoredebounce = false
            end
          end
        end)
        pewpew.customizable_entity_start_exploding(CubeBullet, 5)
        pewpew.entity_set_update_callback(CubeBullet,nil)
      end
    end)
  end
  
  function newBoss2(x,y,range, ship_id)
    local core = pewpew.new_customizable_entity(x, y)
    local radius = 60fx
    local mode = 1
    local HitDebounce = 0
    game[core] = {size = radius, spinnercount = 4}
    pewpew.customizable_entity_set_mesh(core, "/dynamic/BossPack/enemy_meshes.lua", 6)
    
    pewpew.entity_set_radius(core, radius)
    local debounce = true
    local health = 150
    
    local cooldown = 90
    local rotation = 0fx
    local ShootAngle = 0fx
    local RainCooldown = 10
    local InertiacCooldown = 150
    local CubeCooldown = 120
    local hurt = 0
    local sendangle
    local sendspeed = 0fx
  
    local spinner1 = Boss2Spinner(x, y, 7, core, -1fx, 3fx)
    local spinner2 = Boss2Spinner(x, y, 8, core, 1fx, 2fx)
    local spinner3 = Boss2Spinner(x, y, 9, core, -1fx, 1fx)
    local spinner4 = Boss2Spinner(x, y, 10, core, -1fx, 2fx)
  
    game[core].spinners = {spinner4, spinner3, spinner2, spinner1}
  
  
    pewpew.customizable_entity_set_player_collision_callback(core, function(player_id, player_ship)
      if HitDebounce == 0 then
        local playerx, playery = pewpew.entity_get_position(player_ship)
        local entityx, entityy = pewpew.entity_get_position(core)
        local x = playerx - entityx
        local y = playery - entityy
        sendangle = fmath.atan2(y,x)
        sendspeed = 30fx
        pewpew.add_damage_to_player_ship(player_ship, 3)
      end
    end)
  
    pewpew.customizable_entity_set_weapon_collision_callback(core, function()
  
      if health > 0 then
        if(#game[core].spinners == 0) and game[core].spinnercount == 0 then
          health = health - 1
          hurt = 5
          return true
        else
          return true
        end
      elseif debounce then
          debounce = false
          if pewpew.entity_get_is_alive(core) then
            pewpew.customizable_entity_start_exploding(core, 30)
          end
      end
    end)
  
    pewpew.entity_set_update_callback(core, function()
  
      if HitDebounce > 0 then
        HitDebounce = HitDebounce - 1
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
  
      if InertiacCooldown > 0 then
        InertiacCooldown = InertiacCooldown - 1
  
      else
        InertiacCooldown = 210
        local x,y = pewpew.entity_get_position(core)
        local angle = fmath.tau()/40fx * fmath.random_fixedpoint(0fx,40fx)
        local InertiacLifetime = fmath.random_int(30,40)
        --Boss2Inertiac(x,y,angle,core,13fx,30)
      end
  
      if CubeCooldown > 0 then
        CubeCooldown = CubeCooldown - 1
      else
        CubeCooldown = 120
        local x,y = pewpew.entity_get_position(core)
        local angle = fmath.tau()/40fx * fmath.random_fixedpoint(0fx,40fx)
        local InertiacLifetime = fmath.random_int(30,40)
        --Boss2MarchingCube(x,y,angle,core,13fx,30)
      end
  
      if hurt > 0 then
        hurt = hurt - 1
        pewpew.customizable_entity_set_mesh(core, "/dynamic/BossPack/enemy_meshes.lua", 14)
      else
        pewpew.customizable_entity_set_mesh(core, "/dynamic/BossPack/enemy_meshes.lua", 6)
      end
  
      if RainCooldown > 0 then
        RainCooldown = RainCooldown - 1
      else
        RainCooldown = 10
        local ex, ey = pewpew.entity_get_position(core)
        local x = ex + fmath.random_fixedpoint(-range, range)
        local y = ey + fmath.random_fixedpoint(-range, range)
        local z = fmath.random_fixedpoint(1000fx, 1200fx)
        local fallspeed = fmath.random_fixedpoint(20fx,30fx)
        Boss2Rain(x,y,z,fallspeed,core)
      end
    pewpew.customizable_entity_set_mesh_angle(core, rotation, 0.3fx, 0.4fx, 0.5fx)
    rotation = rotation + fmath.tau()/20fx
      if #game[core].spinners > game[core].spinnercount then
        game[core].size  = game[core].size - 10fx
        pewpew.customizable_entity_start_exploding(table.remove(game[core].spinners, #game[core].spinners), 30)
        pewpew.entity_set_radius(core, game[core].size)
      end
      if #game[core].spinners == 0 and game[core].spinnercount == 0 and mode == 1 then
        mode = 2
      end
      if mode == 1 then
        if cooldown > 0 then
          cooldown = cooldown - 1
        elseif debounce and pewpew.entity_get_is_alive(ship_id) then
          local px, py = pewpew.entity_get_position(ship_id)
          local ex, ey = pewpew.entity_get_position(core)
          local dx = px - ex
          local dy = py - ey
          local angle = fmath.atan2(dy, dx)
          cooldown = fmath.random_int(120,180)
          Boss2Projectile(ex,ey,angle,12fx,core,ship_id)
          
        end
      elseif mode == 2 then
        if cooldown > 0 then
          cooldown = cooldown - 1
        elseif debounce then
          local ex, ey = pewpew.entity_get_position(core)
          local offset = fmath.tau()/4fx
          -- cooldown = 5
          cooldown = 2
          Boss2Bullet(ex, ey, ShootAngle + offset * 1fx, 1, 15fx, core)
          Boss2Bullet(ex, ey, ShootAngle + offset * 2fx, 1, 15fx, core)
          Boss2Bullet(ex, ey, ShootAngle + offset * 3fx, 1, 15fx, core)
          Boss2Bullet(ex, ey, ShootAngle + offset * 4fx, 1, 15fx, core)
          -- ShootAngle = ShootAngle + fmath.tau()/20fx
          ShootAngle = ShootAngle + fmath.tau()/120fx
        end
      end
    end)
  end

  return newBoss2