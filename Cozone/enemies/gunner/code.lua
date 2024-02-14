local gh = require'/dynamic/helpers/gameplay_helpers.lua'--
local ph = require'/dynamic/helpers/player_helpers.lua'--for access to the ship

--[[GAMEPLAY HELPER FUNCTIONS:

function helpers.chance(num)
  local rn = fmath.random_int(0, 100)
  if rn <= num then
      return true
  else return false end
end

]]

local gunner = {}

local bullets = {}

local enemy_path = "/dynamic/enemies/gunner/"

function gunner:angle_to_player(id)
    local ex,ey = pewpew.entity_get_position(id)
    local px,py = pewpew.entity_get_position(ph.player_ships[1])
    local dx,dy = px-ex,py-ey
    return fmath.atan2(dy,dx)
end

function gunner:shoot_bullet(x,y,angle,speed,bounce,bounce_amount)
    local id = pewpew.new_customizable_entity(x, y)
    table.insert(bullets,id)
    pewpew.customizable_entity_start_spawning(id, 0)
    pewpew.customizable_entity_set_position_interpolation(id, true)
    pewpew.customizable_entity_set_mesh(id, enemy_path.."bullet_graphics.lua", fmath.random_int(0, 4))
    pewpew.play_sound(enemy_path.."sounds.lua", 0, x, y)
    pewpew.entity_set_radius(id, 9fx)

    local color = 0xffffffff
    if bounce then
        color = 0xff8a95ff
    else 
        color = 0xff7a15ff
    end
    pewpew.customizable_entity_set_mesh_color(id, color)

    local my,mx = fmath.sincos(angle)
    local speed_mult = 1fx
    local bounces = 0

    local function euc()
        if not pewpew.entity_get_is_alive(id) then
            return 
        end
        local ex,ey = pewpew.entity_get_position(id)
        local es = pewpew.get_entities_colliding_with_disk(ex, ey, 9fx)
        for i = 1, #es do
            if pewpew.entity_get_is_started_to_be_destroyed(id) then
                break
            end
            if gh.id_is_inside_array(es[i],bullets) and es[i] ~= id and not pewpew.entity_get_is_started_to_be_destroyed(es[i]) then 
                speed_mult = 1fx/3fx
                pewpew.create_explosion(ex, ey, color, 1fx/2fx, 15)
                pewpew.entity_destroy(id)
                pewpew.entity_destroy(es[i])
            end
            local collided = pewpew.entity_react_to_weapon(es[i], {type = pewpew.WeaponType.BULLET, x = mx*speed*speed_mult, y = my*speed*speed_mult, player_index = 0})
            if collided then
                speed_mult = 1fx/3fx
                pewpew.customizable_entity_start_exploding(id, 15)
            end
        end
        pewpew.entity_set_position(id, ex+mx*speed*speed_mult, ey+my*speed*speed_mult)
    end

    pewpew.entity_set_update_callback(id, euc)

    local function pcc(entity_id, player_index, ship_entity_id)
        pewpew.add_damage_to_player_ship(ship_entity_id, 1)
        speed_mult = 1fx/3fx
        pewpew.customizable_entity_start_exploding(id, 15)
    end

    pewpew.customizable_entity_set_player_collision_callback(id, pcc)

    local function wcc(entity_id, player_index, weapon_type)
        if weapon_type == pewpew.WeaponType.REPULSIVE_EXPLOSION then
            local px,py = pewpew.entity_get_position(ph.player_ships[1])
            local ex,ey = pewpew.entity_get_position(id)
            local dx,dy = ex-px,ey-py
            my,mx = fmath.sincos(fmath.atan2(dy,dx))
        end
    end

    pewpew.customizable_entity_set_weapon_collision_callback(id, wcc)

    local function wacc()
        if bounce then
            bounces = bounces + 1
            if pewpew.entity_get_is_alive(ph.player_ships[1]) then
                my,mx = fmath.sincos(self:angle_to_player(id))
            else 
                bounces = 99999 
            end

            if bounces > bounce_amount then
                pewpew.entity_set_update_callback(id, nil)
                pewpew.customizable_entity_start_exploding(id, 30)
            end
        else 
            pewpew.entity_set_update_callback(id, nil)
            pewpew.customizable_entity_start_exploding(id, 30)
        end
    end

    pewpew.customizable_entity_configure_wall_collision(id, true, wacc)
end

function gunner:set_angle()
    self.angle = --[[gh.lerp(self.angle,self:angle_to_player(self.id),1fx/2fx)]]self:angle_to_player(self.id)
end

function gunner:fast_shoot_update()
    self.time = self.time + 1
    if pewpew.entity_get_is_alive(ph.player_ships[1]) and self.player_nearby then
        self:set_angle()
    end
    pewpew.customizable_entity_set_mesh_angle(self.id, self.angle, 0fx, 0fx, 1fx)
    local ex,ey = 0fx,0fx
    local ay,ax = 0fx,0fx
    if self.time >= self.first_short_interval and self.first_current_times < self.first_times then
        self.first_current_times = self.first_current_times + 1
        self.time = 0
        ex,ey = pewpew.entity_get_position(self.id)
        ay,ax = fmath.sincos(self.wings[2]+self.angle)
        self:shoot_bullet(ex+ax*self.offset, ey+ay*self.offset, self.wings[2]+self.angle, self.first_speed, false, 0)
        self.frame = self.max_frames//1.5
    elseif self.time >= self.first_short_interval and self.first_current_times >= self.first_times then
        self.time = 0
        self.first_current_times = 0
        pewpew.entity_set_update_callback(self.id, self.euc)
    end
end

function gunner:main_update()
    if not pewpew.entity_get_is_alive(ph.player_ships[1]) then
        pewpew.entity_set_update_callback(self.id,nil)
    end
    if pewpew.entity_get_is_alive(ph.player_ships[1]) and self.player_nearby then
        self.time = self.time + 1
        self:set_angle()
    end
    local ex,ey = 0fx,0fx
    pewpew.customizable_entity_set_mesh_angle(self.id, self.angle, 0fx, 0fx, 1fx)
    if self.second_ellegibe and self.time >= self.second_interval and self.player_nearby then
        self.second_ellegibe = false
        self.second_chance = 0
        self.time = 0
        ex,ey = pewpew.entity_get_position(self.id)
        for i = 1, 3 do
            local ay,ax = fmath.sincos(self.wings[i]+self.angle)
            self:shoot_bullet(ex+ax*self.offset, ey+ay*self.offset, self.wings[i]+self.angle, self.second_speed, true, 1)
        end
        self.frame = self.max_frames
        return
    end
    if self.time >= self.first_interval and self.player_nearby then
        self.second_ellegibe = gh.chance(self.second_chance)
        self.second_chance = self.second_chance + self.second_chance_step
        self.time = 0
        pewpew.entity_set_update_callback(self.id, self.euc2)
    end
end

function gunner:handle_animation()
    if not self.hit then
        pewpew.customizable_entity_set_mesh(self.id, enemy_path.."graphics.lua", self.frame)
    end
    self.frame = self.frame - 1
    if self.frame < 0 then
        self.frame = 0
    end
end

function gunner:handle_hit()
    if self.hit then
        self.hit_timer = self.hit_timer + 1
        pewpew.customizable_entity_set_mesh(self.id, enemy_path.."graphics2.lua", self.frame)
        if self.hit_timer > self.hit_time then
            self.hit_timer = 0
            self.hit = false
            pewpew.customizable_entity_set_mesh(self.id, enemy_path.."graphics.lua", self.frame)
        end
    end
end

function gunner:freeze_state()
    self.time = 0
    self.frozen = true
    pewpew.entity_set_update_callback(self.id, self.euc)
end

function gunner:detect_player()
    if pewpew.entity_get_is_alive(ph.player_ships[1]) then
        local px,py = pewpew.entity_get_position(ph.player_ships[1])
        local ex,ey = pewpew.entity_get_position(self.id)
        local dx,dy = px-ex,py-ey
        local dist = fmath.sqrt((dx*dx)+(dy*dy))
        if dist <= self.distance_tol then
            self.player_nearby = true
        else
            self.player_nearby = false
        end
    end
end

function gunner:die(player_index)
    pewpew.entity_set_update_callback(self.id, nil)
    pewpew.customizable_entity_start_exploding(self.id, 60)
    pewpew.customizable_entity_set_mesh(self.id, enemy_path.."graphics.lua", self.frame)
    local ex,ey = pewpew.entity_get_position(self.id)
    pewpew.play_sound(enemy_path.."sounds.lua", 1, ex, ey)
    pewpew.create_explosion(ex, ey, 0xffcc00ff, 1fx, 60)
    pewpew.increase_score_of_player(player_index, 200)
    pewpew.new_floating_message(ex, ey, "#00ff00ff200", {scale = 1fx+1fx/4fx, ticks_before_fade = 25})
end

function gunner:new(x,y)
    --general
    local extx,exty = 17fx+1fx/2fx, -14fx
    local cx,cy = 10fx+1fx/2fx, -7fx
    local gx,gy = extx-cx,exty-cy

    local z = {
        id = -9999, 
        spawning = true,
        time_to_spawn = 35,

        hp = 9,
        hit_time = 3,
        hit = false,
        hit_timer = 0,

        frame = 0,
        max_frames = 14,

        angle = 0fx,
        move_speed = 1fx,
        distance_tol = 520fx,
        player_nearby = false,

        first_speed = 17fx,
        first_interval = fmath.random_int(80,100),
        first_short_interval = 3,
        first_times = 3,
        first_current_times = 0,

        second_speed = 5fx,
        second_interval = fmath.random_int(50,70),

        second_ellegibe = false,
        second_chance = fmath.random_int(25, 75),
        second_chance_step = 20,

        wings = {
            fmath.atan2(gy,gx),--left
            0fx,--main
            -fmath.atan2(gy,gx),--right
        },
        offset = 40fx+1fx/2fx,
        
        time = 0,

        frozen = false,
        frozen_time = 110
    }
    setmetatable(z,self)
    self.__index = self
    z.id = pewpew.new_customizable_entity(x, y)
    pewpew.customizable_entity_set_mesh(z.id, enemy_path.."graphics.lua", 0)
    pewpew.customizable_entity_set_mesh_scale(z.id, 1fx+1fx/4fx)
    pewpew.customizable_entity_set_position_interpolation(z.id, true)
    pewpew.entity_set_radius(z.id, 18fx)
    pewpew.customizable_entity_start_spawning(z.id, 35)

    function z.spawn_check()
        if z.time >= z.time_to_spawn then
            z.spawning = false
        end
    end

    function z.euc()
        z:handle_hit()
        if z.frozen then
            z.time = z.time + 1
            if z.time >= z.frozen_time-1 then
                z.time = 0
                z.frozen = false
            end
            return 
        end
        z:handle_animation()
        z:detect_player()
        z:main_update()
        z.spawn_check()
    end

    function z.euc2()
        z:handle_animation()
        z:handle_hit()
        z:detect_player()
        z:fast_shoot_update()
    end

    function z.pcc(entity_id, player_index, ship_entity_id)
        if z.spawning then return end
        pewpew.add_damage_to_player_ship(ship_entity_id, 1)
        pewpew.increase_score_streak_of_player(player_index, 61)
        z:die(player_index)
    end

    function z.wcc(entity_id, player_index, weapon_type)
        if z.spawning then return false end
        if weapon_type == pewpew.WeaponType.BULLET then
            z.hp = z.hp - 1
            pewpew.increase_score_streak_of_player(player_index, 11)
            if z.hp < 0 and not pewpew.entity_get_is_started_to_be_destroyed(z.id) then
                local ex,ey = pewpew.entity_get_position(z.id)
                local ss = pewpew.get_score_streak_level(player_index)
                for i = 1, ss do
                    pewpew.new_pointonium(ex, ey, 128)
                end
                pewpew.increase_score_streak_of_player(player_index, 61)
                z:die(player_index)
            end
        elseif weapon_type == pewpew.WeaponType.ATOMIZE_EXPLOSION then
            if z.hp >= 0 then
                local ex,ey = pewpew.entity_get_position(z.id)
                z.hp = -1
                local ss = pewpew.get_score_streak_level(player_index)
                for i = 1, ss do
                    pewpew.new_pointonium(ex, ey, 128)
                end
                pewpew.increase_score_streak_of_player(player_index, 61)
                z:die(player_index)
            end
        elseif weapon_type == pewpew.WeaponType.FREEZE_EXPLOSION then
            if not z.frozen then z:freeze_state() end
            return false
        else return false end
        if not pewpew.entity_get_is_started_to_be_destroyed(z.id) then
            z.hit = true
            local ex,ey = pewpew.entity_get_position(z.id)
            pewpew.play_sound(enemy_path.."sounds.lua", 1, ex, ey)
            pewpew.increase_score_of_player(0, 15)
            return true
        end
    end

    pewpew.entity_set_update_callback(z.id, z.euc)

    pewpew.customizable_entity_set_weapon_collision_callback(z.id, z.wcc)

    pewpew.customizable_entity_set_player_collision_callback(z.id, z.pcc)
    return z
end

return gunner