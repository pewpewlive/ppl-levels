local eh = require("/dynamic/helpers/enemy_helpers.lua")

local altar = {}

local function laser(x,y,angle)
    local id2 = eh.basic_needs(x,y,"/dynamic/enemies/altar/laser_mesh.lua",0,nil,1fx,nil)
    pewpew.customizable_entity_set_mesh_angle(id2,angle,0fx,0fx,1fx)
    pewpew.customizable_entity_skip_mesh_attributes_interpolation(id2)
    pewpew.customizable_entity_start_spawning(id2,0)
    local time = 0
    pewpew.entity_set_update_callback(id2,function()
        time = time + 1
        pewpew.customizable_entity_set_mesh(id2,"/dynamic/enemies/altar/laser_mesh.lua",time % 60)
        if time > 50 then
            pewpew.entity_destroy(id2)
        end
    end)
end

function altar.new(x,y,ship)
    local dd = eh.basic_needs(x,y,"/dynamic/enemies/altar/altar_mesh.lua",0,0x0000ff30,2fx,nil)
    local ddd = eh.basic_needs(x,y,"/dynamic/enemies/altar/altar_mesh.lua",0,0xff000030,1fx,nil)
    local dddd = eh.basic_needs(x,y,"/dynamic/enemies/altar/altar_mesh.lua",0,0xff00ff30,4fx/10fx,nil)

    eh.add_entity_to_type(eh.types.ALTAR, dd)
    eh.add_entity_to_type(eh.types.ALTAR, ddd)
    eh.add_entity_to_type(eh.types.ALTAR, dddd)

    local time = 0
    local once = true
    local px, py
    pewpew.entity_set_update_callback(dd,function()
        time = time + 1
        local rangle = fmath.random_fixedpoint(0fx,fmath.tau())
        local offy,offx = fmath.sincos(rangle)
        pewpew.customizable_entity_add_rotation_to_mesh(dd,-0.059fx,0fx,0fx,1fx)
        pewpew.customizable_entity_add_rotation_to_mesh(ddd,0.059fx,0fx,0fx,1fx)
        pewpew.customizable_entity_add_rotation_to_mesh(dddd,-0.059fx,0fx,0fx,1fx)
        if time == 120 then
            laser(x,y,fmath.tau())
            laser(x,y,fmath.tau()/4)
            laser(x,y,fmath.tau()/2)
            laser(x,y,fmath.tau()/2+fmath.tau()/4)
        end
        if time == 150 then 
            pewpew.play_ambient_sound("/dynamic/enemies/altar/sfx.lua",0)
        end
        if pewpew.entity_get_is_alive(ship) then
            px, py= pewpew.entity_get_position(ship)
        end
        if time > 148 and time < 160 then
            pewpew.configure_player(0,{camera_x_override = px+offx*7fx,camera_y_override = py+offy*7fx})
            if py > y-9fx and py < y+9fx or px > x-9fx and px < x+9fx then
                if once then
                    if pewpew.entity_get_is_alive(ship) then
                        pewpew.add_damage_to_player_ship(ship,1)
                        once = false
                    end
                end
            end
        elseif time > 160 then
            time = 0
            once = true
        end

    end)

    return {dd, ddd, dddd}
end

return altar