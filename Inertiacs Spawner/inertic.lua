local inertic = {}

local function toRad(x)
    return x * (22fx/7fx) / 180fx
  end
    
local function toDeg(x)
    return x * 180fx / (22fx/7fx)
end

function inertic.new(x, y, rotato)
    local pentagon1 = pewpew.new_customizable_entity(x, y)
    pewpew.customizable_entity_set_mesh(pentagon1, "/dynamic/pentagon.lua", 0)
    local pentagon2 = pewpew.new_customizable_entity(x, y)
    pewpew.customizable_entity_set_mesh(pentagon2, "/dynamic/pentagon.lua", 1)
    local octagon1 = pewpew.new_customizable_entity(x, y)
    pewpew.customizable_entity_set_mesh(octagon1, "/dynamic/pentagon.lua", 2)
    local octagon2 = pewpew.new_customizable_entity(x, y)
    pewpew.customizable_entity_set_mesh(octagon2, "/dynamic/pentagon.lua", 3)
    local octagon3 = pewpew.new_customizable_entity(x, y)
    pewpew.customizable_entity_set_mesh(octagon3, "/dynamic/pentagon.lua", 4)
    local octagon4 = pewpew.new_customizable_entity(x, y)
    pewpew.customizable_entity_set_mesh(octagon4, "/dynamic/pentagon.lua", 5)

    local random_rotation = {}
    local random_angle = {}
    local random_axis1 = {}
    local random_axis2 = {}

    local time = 0
    local callback_entity = pewpew.new_customizable_entity(0fx, 0fx)

    for i = 1, 6 do
        table.insert(random_rotation, fmath.random_fixedpoint(6fx, 10fx))
        table.insert(random_axis1, {fmath.random_fixedpoint(2fx, 6fx), fmath.random_fixedpoint(2fx, 6fx), fmath.random_fixedpoint(2fx, 6fx)})
    end

    for i = 1, 6 do
        local x, y, z = fmath.random_int(0, 1), fmath.random_int(0, 1), fmath.random_int(0, 1)
        table.insert(random_axis2, {fmath.to_fixedpoint(x), fmath.to_fixedpoint(y), fmath.to_fixedpoint(z)})
        table.insert(random_angle, fmath.random_fixedpoint(0fx, fmath.tau() / 2fx))
    end 

    pewpew.customizable_entity_set_mesh_angle(pentagon1, random_angle[1], random_axis2[1][1], random_axis2[1][2], random_axis2[1][3])
    pewpew.customizable_entity_set_mesh_angle(pentagon2, random_angle[2], random_axis2[2][1], random_axis2[2][2], random_axis2[2][3])
    pewpew.customizable_entity_set_mesh_angle(octagon1, random_angle[1], random_axis2[1][1], random_axis2[1][2], random_axis2[1][3])
    pewpew.customizable_entity_set_mesh_angle(octagon2, random_angle[2], random_axis2[2][1], random_axis2[2][2], random_axis2[2][3])
    pewpew.customizable_entity_set_mesh_angle(octagon3, random_angle[3], random_axis2[3][1], random_axis2[3][2], random_axis2[3][3])
    pewpew.customizable_entity_set_mesh_angle(octagon4, random_angle[4], random_axis2[4][1], random_axis2[4][2], random_axis2[4][3])

    local function update_callback(entity_id)
        time = time + 1
        if time > 1 and time % 1 == 0 then 
            if rotato then
                pewpew.customizable_entity_add_rotation_to_mesh(pentagon1, toRad(random_rotation[1]), random_axis1[1][1], random_axis1[1][2], random_axis1[1][3])
                pewpew.customizable_entity_add_rotation_to_mesh(pentagon2, toRad(random_rotation[2]), random_axis1[2][1], random_axis1[2][2], random_axis1[2][3])     
                pewpew.customizable_entity_add_rotation_to_mesh(octagon1, toRad(random_rotation[3]), random_axis1[3][1], random_axis1[3][2], random_axis1[3][3])       
                pewpew.customizable_entity_add_rotation_to_mesh(octagon2, toRad(random_rotation[4]), random_axis1[4][1], random_axis1[4][2], random_axis1[4][3])      
                pewpew.customizable_entity_add_rotation_to_mesh(octagon3, toRad(random_rotation[5]), random_axis1[5][1], random_axis1[5][2], random_axis1[5][3])        
                pewpew.customizable_entity_add_rotation_to_mesh(octagon4, toRad(random_rotation[6]), random_axis1[6][1], random_axis1[6][2], random_axis1[6][3])
            end
        end
    end
    pewpew.entity_set_update_callback(callback_entity, update_callback)
end

return inertic