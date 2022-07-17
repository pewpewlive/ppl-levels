local floating_message = require("/dynamic/helpers/floating_message.lua")

local powerups = {}

function powerups.yellow(x, y, ship, yes)
    local yellow = pewpew.new_customizable_entity(x, y)
    local yellow2 = pewpew.new_customizable_entity(x, y)
    local yellow3 = pewpew.new_customizable_entity(x, y)
    if yes then
        pewpew.customizable_entity_set_mesh(yellow, "/dynamic/powerups/powerups_mesh.lua",0)
        pewpew.customizable_entity_set_mesh(yellow2, "/dynamic/powerups/powerups_mesh.lua",1)
        pewpew.customizable_entity_set_mesh(yellow3, "/dynamic/powerups/powerups_mesh.lua",2)
    else
        pewpew.customizable_entity_set_mesh(yellow, "/dynamic/powerups/powerups_mesh.lua",4)
        pewpew.customizable_entity_set_mesh(yellow2, "/dynamic/powerups/powerups_mesh.lua",5)
        pewpew.customizable_entity_set_mesh(yellow3, "/dynamic/powerups/powerups_mesh.lua",6)
    end
    pewpew.entity_set_radius(yellow,22fx)
    local duration = pewpew.new_customizable_entity(x, y)
    pewpew.customizable_entity_set_mesh(duration, "/dynamic/powerups/powerups_mesh.lua",3)

    local scaling = false
    local scale = 1fx
    local rolling_angle = 0fx
    local dead = false
    local changed = false
    local time = 0
    local random = fmath.random_int(1,3)
    local truetime = 0
    pewpew.add_update_callback(function()
        if changed then
            time = time + 1
        end
        truetime = truetime + 1
        rolling_angle = rolling_angle + 0.509fx
        if not dead then
            pewpew.customizable_entity_set_mesh_angle(yellow2,rolling_angle,0fx,0fx,1fx)
            pewpew.customizable_entity_set_mesh_scale(yellow,scale)
            pewpew.customizable_entity_set_mesh_scale(yellow2,scale)
            pewpew.customizable_entity_set_mesh_scale(yellow3,scale)
    
            pewpew.customizable_entity_add_rotation_to_mesh(yellow3,0.409fx,1fx,1fx,1fx)
        end
        if not scaling then
            scale = scale - 1fx/40fx
        elseif scaling then
            scale = scale + 1fx/40fx
        end
        if scale > 11fx/10fx then
            scaling = false
        end
        if scale < 1fx then
            scaling = true
        end
        if yes then
            if time == 60 then
                pewpew.configure_player_ship_weapon(ship,{frequency = pewpew.CannonFrequency.FREQ_10, cannon = pewpew.CannonType.FOUR_DIRECTIONS})
                pewpew.entity_destroy(duration)
            end
        else
            if time == 105 then
                pewpew.configure_player_ship_weapon(ship,{frequency = pewpew.CannonFrequency.FREQ_7_5, cannon = pewpew.CannonType.SINGLE})
                pewpew.entity_destroy(duration)
            end
        end
        if truetime == 300 then
            dead = true
            pewpew.customizable_entity_start_exploding(yellow,30)
            pewpew.customizable_entity_start_exploding(yellow2,30)
            pewpew.customizable_entity_start_exploding(yellow3,30)
            pewpew.entity_destroy(duration)
        end
    end)
    pewpew.customizable_entity_set_player_collision_callback(yellow,function(entity_id, player_index, ship_entity_id)
        local conf = pewpew.get_player_configuration(0)
        pewpew.configure_player(0, {shield = conf.shield + 1})
        if yes then
            pewpew.configure_player_ship_weapon(ship,{frequency = pewpew.CannonFrequency.FREQ_30, cannon = pewpew.CannonType.FOUR_DIRECTIONS})
        else
            pewpew.configure_player_ship_weapon(ship,{frequency = pewpew.CannonFrequency.FREQ_15, cannon = pewpew.CannonType.SINGLE})
        end
        pewpew.customizable_entity_start_exploding(yellow,30)
        pewpew.customizable_entity_start_exploding(yellow2,30)
        pewpew.customizable_entity_start_exploding(yellow3,30)
        pewpew.play_ambient_sound("/dynamic/powerups/sfx.lua",0)
        if yes then
            if random == 1 then
                local new_message = floating_message.new(x, y, "FASTER", 1.5fx, 0xff9000ff, 3)
            elseif random == 2 then
                local new_message = floating_message.new(x, y, "BETTER", 1.5fx, 0xff9000ff, 3)
            else 
                local new_message = floating_message.new(x, y, "STRONGER", 1.5fx, 0xff9000ff, 3)
            end
        else
            if random == 1 then
                local new_message = floating_message.new(x, y, "FASTER", 1.5fx, 0x00ff00ff, 3)
            elseif random == 2 then
                local new_message = floating_message.new(x, y, "BETTER", 1.5fx, 0x00ff00ff, 3)
            else 
                local new_message = floating_message.new(x, y, "STRONGER", 1.5fx, 0x00ff00ff, 3)
            end
        end
        dead = true
        changed = true
    end)
end

return powerups