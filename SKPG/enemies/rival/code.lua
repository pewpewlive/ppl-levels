local global_vars = require("/dynamic/global_vars.lua")
local eh = require("/dynamic/helpers/enemy_helpers.lua")

local rival = {}

gifted_rivals = {}

function rival.new(x,y)
    local id2 = eh.basic_needs(x,y,"/dynamic/enemies/rival/mesh.lua",0,nil,1fx,50fx)
    pewpew.entity_set_radius(id2,50fx)
    local width,height = global_vars[1][1],global_vars[1][2]
    local dx, dy = width/2fx-x,height/2fx-y
    local angle = fmath.atan2(dy,dx)
    pewpew.customizable_entity_set_mesh_angle(id2,angle,0fx,0fx,1fx)
    return id2
end

function rival.react(id)
    for i = 1, #gifted_rivals do
        if gifted_rivals[i] == id then return end
    end 
    table.insert(gifted_rivals, id)
    gifted_rival_count = gifted_rival_count + 1
    pewpew.customizable_entity_set_mesh(id,"/dynamic/enemies/rival/mesh.lua",1)
end

return rival