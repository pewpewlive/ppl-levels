local eh = require("/dynamic/helpers/enemy_helpers.lua")

local tank = {}

function tank.new(x,y,ship,weapon_config)
    local id = eh.basic_needs(x,y,"/dynamic/enemies/tank/mesh.lua",0,nil,1fx,19fx)
    eh.add_entity_to_type(eh.types.TANK, id)

    local enable_hit = true
    local immunity_frames = 0
    local hits = 1
    local dead = false
    local weapon_config2 = {frequency = weapon_config.frequency + 1, cannon = weapon_config.cannon-1}
    local time = 0
    local px, py = pewpew.entity_get_position(ship)
    local ex, ey = pewpew.entity_get_position(id)
    local distance = fmath.sqrt((ex - px)*(ex - px) + (ey - py)*(ey - py))
    local once2 = true
    if distance < 145fx then
        once = true
    elseif distance > 145fx then
        once = false
    end
    pewpew.entity_set_update_callback(id,function()
        if pewpew.entity_get_is_alive(ship) then
            time = time + 1
            local px, py = pewpew.entity_get_position(ship)
            local ex, ey = pewpew.entity_get_position(id)
            local distance = fmath.sqrt((ex - px)*(ex - px) + (ey - py)*(ey - py))
            if immunity_frames > 0 then
                enable_hit = false
                immunity_frames = immunity_frames - 1
            elseif immunity_frames == 0 then enable_hit = true end
            if distance <= 145fx and not dead then
                pewpew.set_player_ship_speed(ship, 1fx/2fx, 2fx, 1)
            end
            if not dead then
                if distance < 145fx and once then
                    pewpew.configure_player_ship_weapon(ship, weapon_config2)
                    once = false
                elseif distance > 145fx and not once then
                    pewpew.configure_player_ship_weapon(ship, weapon_config)
                    once = true
                end
            elseif once2 then
                pewpew.configure_player_ship_weapon(ship, weapon_config)
                once2 = false
            end
        end
    end)
    pewpew.customizable_entity_set_weapon_collision_callback(id,function(entity_id, player_index, weapon_type)
        if not dead then
            if weapon_type == pewpew.WeaponType.BULLET then 
                if hits < 7 then
                    pewpew.customizable_entity_set_mesh(id,"/dynamic/enemies/tank/mesh.lua",hits-1)
                    pewpew.play_ambient_sound("/dynamic/enemies/tank/sfx.lua",1)
                else
                    pewpew.customizable_entity_start_exploding(id,30)
                    if not dead then pewpew.play_ambient_sound("/dynamic/enemies/tank/sfx.lua",0); pewpew.create_explosion(x, y, 0xffff00ff, 1fx, 30) end
                    dead = true
                end
                pewpew.increase_score_of_player(0,10)
                hits = hits + 1
                return true
            elseif weapon_type == pewpew.WeaponType.ATOMIZE_EXPLOSION then
                pewpew.customizable_entity_start_exploding(id,30)
                pewpew.play_ambient_sound("/dynamic/enemies/tank/sfx.lua",0)
                pewpew.create_explosion(x, y, 0xffff00ff, 1fx, 30)
            end
        end
    end)
    pewpew.customizable_entity_set_player_collision_callback(id,function(entity_id, player_index, ship_entity_id)
        if enable_hit then
            pewpew.add_damage_to_player_ship(ship,1)
            immunity_frames = 10
            if hits < 7 then
                pewpew.customizable_entity_set_mesh(id,"/dynamic/enemies/tank/mesh.lua",hits)
                pewpew.play_ambient_sound("/dynamic/enemies/tank/sfx.lua",1)
            else
                pewpew.customizable_entity_start_exploding(id,30)
                pewpew.configure_player_ship_weapon(ship, weapon_config)
                if not dead then pewpew.play_ambient_sound("/dynamic/enemies/tank/sfx.lua",0); pewpew.create_explosion(x, y, 0xffff00ff, 1fx, 30) end
                dead = true
            end
            hits = hits + 1
        end
    end)
    return id
end

return tank