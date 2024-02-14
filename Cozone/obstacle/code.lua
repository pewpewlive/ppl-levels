

local obstacle = {}

local function new_poly_wall(center,radius,sides)--{fx,fx},fx,int (im glad old me made this function)
    local x = center[1]
    local y = center[2]
    local vertices = {}
    local angle = fmath.tau()/sides
    local sin, cos = fmath.sincos(angle)
    for i = 1, sides do
        table.insert(vertices, {x + radius * cos,y + radius * sin})
        angle = angle + fmath.tau()/sides
        sin, cos = fmath.sincos(angle)
    end
    for i = 1, #vertices do
        if i == #vertices then
            pewpew.add_wall(vertices[i][1], vertices[i][2], vertices[1][1], vertices[1][2])
        else
            pewpew.add_wall(vertices[i][1], vertices[i][2], vertices[i+1][1], vertices[i+1][2])
        end
    end
end
 

function obstacle.new(x,y,angle)
    local id = pewpew.new_customizable_entity(x, y)
    local radius = 70fx
    pewpew.customizable_entity_set_mesh(id, "/dynamic/obstacle/graphics.lua", 0)
    new_poly_wall({x,y},radius,25)
    pewpew.customizable_entity_set_mesh_angle(id, angle, 0fx, 0fx, 1fx)

    local frames = 60
    local frame = 0
    local time = 0
    pewpew.entity_set_update_callback(id, function()
        time = time + 1
        if frame >= frames then
            frame = 0
        end
        pewpew.customizable_entity_set_mesh(id, "/dynamic/obstacle/graphics.lua", frame)
        frame = frame + 1
        --print(frame)
    end)
end

return obstacle