local ch = require'/dynamic/helpers/color_helpers.lua'
local ph = require'/dynamic/helpers/player_helpers.lua'
local gh = require'/dynamic/helpers/gameplay_helpers.lua'
local int_mesh_info = require'/dynamic/zone/mesh_info.lua'

local red,gre,blu,alp = 255,120,50,255
local wred,wgre,wblu = 255,20,20
local duration = 50
local short_duration = 25
local alphaStep = (250-alp)//duration
local shortAlphaStep = (250-alp)//short_duration
local laps = 5

-- meta class
local zone = {}

local function copy(obj, seen)--some code from stack overflow that I might never understand
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end
    local s = seen or {}
    local res = setmetatable({}, getmetatable(obj))
    s[obj] = res
    for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
    return res
end

local mesh_info = copy(int_mesh_info)

local h = 0
for i = 1, #mesh_info do
    h = 0
    for j = 1, #mesh_info[i] do
        if j > 4 then
            table.remove(mesh_info[i],j-h)
            h = h + 1
        else
            mesh_info[i][j][1] = fmath.to_fixedpoint(mesh_info[i][j][1])
            mesh_info[i][j][2] = fmath.to_fixedpoint(mesh_info[i][j][2])
        end
    end
end

local function lerp(a,b,t)--point a to point b, t has to be somewhere from 0 to 1
    local v = (1fx - t) * a + b * t
    return v
end

local function invLerp(a,b,v)--point a to point b, but value is used
    local t = (v - a) / (b - a)
    return t
end

local function findCenterOfPolygon(vertices)
    local cx,cy = 0fx,0fx
    for i = 1, #vertices do
        cx = cx + vertices[i][1]
        cy = cy + vertices[i][2]
    end
    cx = cx/fmath.to_fixedpoint(#vertices)
    cy = cy/fmath.to_fixedpoint(#vertices)
    return {cx, cy}
end

local function findDominantAxis(line)
    local xDiff = fmath.abs_fixedpoint(line[1][1]-line[2][1])
    local yDiff = fmath.abs_fixedpoint(line[1][2]-line[2][2])
    if xDiff > yDiff then
        return 1,2
    else 
        return 2,1
    end
end

function zone:new(x,y,speed,index)
    local ms = 1fx+1fx/2fx
    local z = {
        entity_id = -99999, vertices = {},lines = {},player_inside = false,num = 0,
        red = 255,gre = 120,blu = 50,
        move_vector = {0fx,0fx},
        angle = 0fx,
        speed = 0fx,
        axis = 0, otherAxis = 0,
        position = {0fx,0fx},
        maxScale = ms,
        scale = ms,
        minScale = ms/2fx
    }
    setmetatable(z,self)
    self.__index = self
    local expT = gh.t2*1000000
    expT = fmath.to_fixedpoint(expT//1)
    expT = expT / 1000000fx
    z.scale = gh.lerp(z.maxScale,z.minScale,expT)
    z.entity_id = pewpew.new_customizable_entity(x, y)
    pewpew.customizable_entity_set_mesh(z.entity_id, "/dynamic/zone/graphics.lua", index)
    pewpew.customizable_entity_set_mesh_color(z.entity_id, ch.make_color(z.red,z.gre,z.blu,255))
    pewpew.customizable_entity_set_position_interpolation(z.entity_id, true)
    pewpew.customizable_entity_configure_music_response(z.entity_id, {scale_z_start = 1fx, scale_z_end = 3fx})
    pewpew.entity_set_radius(z.entity_id, 1fx)
    z.vertices = mesh_info[index+1]
    z.speed = speed
    --z.center = findCenterOfPolygon(z.vertices)
    --local str = pewpew.new_customizable_entity(z.center[1], z.center[2])
    --pewpew.customizable_entity_set_string(str, ch.color_to_string(ch.make_color(red,gre,blu,z.a))..tostring(z.mesh_id))

    for i = 1, #z.vertices do
        if i == #z.vertices then
            table.insert(z.lines,{z.vertices[i],z.vertices[1]})
        else
            table.insert(z.lines,{z.vertices[i],z.vertices[i+1]})
        end
    end
    z.angle = fmath.random_fixedpoint(0fx, fmath.tau())
    z.move_vector[2],z.move_vector[1] = fmath.sincos(z.angle)
    function z.euc()
        local expT = gh.t2*1000000
        expT = fmath.to_fixedpoint(expT//1)
        expT = expT / 1000000fx
        z.speed = gh.lerp(speed,speed/2,expT)
        z.scale = gh.lerp(z.maxScale,z.minScale,expT)
        pewpew.customizable_entity_set_mesh_scale(z.entity_id, z.scale)
        if gh.timeScale == 1fx then
            z.red,z.gre,z.blu = red,gre,blu
        else
            z.red,z.gre,z.blu = 60,200,255
        end
        z.position[1],z.position[2] = pewpew.entity_get_position(z.entity_id)
        pewpew.entity_set_position(z.entity_id, z.position[1]+z.move_vector[1]*z.speed*gh.timeScale, z.position[2]+z.move_vector[2]*z.speed*gh.timeScale)
        if pewpew.entity_get_is_alive(ph.player_ships[1]) then
            z:checkForPlayerInside()
        end
    end
    pewpew.entity_set_update_callback(z.entity_id, z.euc)

    function z.wcc(entity_id, wall_normal_x, wall_normal_y)
        local dot_product_move = ((wall_normal_x * z.move_vector[1]) + (wall_normal_y * z.move_vector[2])) * 2fx; 
        z.move_vector[1] = z.move_vector[1] - (wall_normal_x * dot_product_move)
        z.move_vector[2] = z.move_vector[2] - (wall_normal_y * dot_product_move)
        z.angle = fmath.atan2(z.move_vector[2],z.move_vector[1])
    end
    pewpew.customizable_entity_configure_wall_collision(z.entity_id, true, z.wcc)
    return z
end

function zone:checkForPlayerInside()
    self.num = 0

    self.position[1],self.position[2] = pewpew.entity_get_position(self.entity_id)
    local px,py = pewpew.entity_get_position(ph.player_ships[1])
    local pPos = {px,py}

    local polyCenter = findCenterOfPolygon(self.vertices)
    local player_outside = false
    for i = 1, #self.lines do
        self.axis,self.otherAxis = findDominantAxis(self.lines[i])

        local t_value = invLerp(self.position[self.axis]+(self.lines[i][1][self.axis]*self.scale),
                                self.position[self.axis]+(self.lines[i][2][self.axis]*self.scale),
                                pPos[self.axis])
        local borderPos = lerp(self.position[self.otherAxis]+(self.lines[i][1][self.otherAxis]*self.scale),self.position[self.otherAxis]+(self.lines[i][2][self.otherAxis]*self.scale),t_value)
        if t_value <= 1fx or t_value >= 0fx then
            if ((self.lines[i][1][self.otherAxis]*self.scale)+(self.lines[i][2][self.otherAxis]*self.scale))/2fx > polyCenter[self.otherAxis] then
                if pPos[self.otherAxis] > borderPos then
                    player_outside = true
                    break;
                end
            else
                if pPos[self.otherAxis] < borderPos then
                    player_outside = true
                    break;
                end
            end
        end
    end

    if player_outside then
        self.player_inside = false
    else
        self.player_inside = true
    end
    --print(self.player_inside)
    --pewpew.print'player: {"..pPos[1]..", "..pPos[2].."}. Center: {"..polyCenter[1]..", "..polyCenter[2].."}.'
    --THIS WORKS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
end

return zone