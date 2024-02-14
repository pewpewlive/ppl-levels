local color_helpers = require("/dynamic/helpers/color_helpers.lua")
local lh = require'/dynamic/helpers/layer_helpers.lua'
require'/dynamic/gv.lua'
local helpers = {
  obstacle_positions = {},
  wall_positions = {},
  player_inside = false,
  layers = {negative_layers = {},positive_layers = {}},
  X2 = 9000,X = 14000, t = 0,t2 = 0,
  ship_texts = {},
  hypothermia_mode = false,
  timeScale = 1fx
}

local lvl_ctr = {FX/2fx,FY/2fx}

function helpers.new_layer(layer_interval,spawns,special_func,active,type)
  local l = lh:new(layer_interval,spawns,special_func,active)
  if type == "-" then
    table.insert(helpers.layers.negative_layers,{l,l.persistent_func[1]})
  elseif type == "+" then
    table.insert(helpers.layers.positive_layers,l)
  end
  return l
end

function helpers.step_layer_modulos()
  for i = 1, #helpers.layers.negative_layers do
    if helpers.layers.negative_layers[i][2] ~= nil then 
      local max = helpers.layers.negative_layers[i][2]
      local min = helpers.layers.negative_layers[i][2]/4--4 times the difficulty
      helpers.layers.negative_layers[i][1].persistent_func[1] = helpers.lerpINT(max,min,helpers.t)//1
      --print(i.." | "..helpers.layers.negative_layers[i][1].persistent_func[1])
    end
  end
end

function helpers.copy_table(obj, seen)--some code from stack overflow that I might never understand
  if type(obj) ~= 'table' then return obj end
  if seen and seen[obj] then return seen[obj] end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do res[helpers.copy_table(k, s)] = helpers.copy_table(v, s) end
  return res
end

function helpers.work_layers()
  for i = 1, #helpers.layers.negative_layers do
    helpers.layers.negative_layers[i][1]:work()
  end
  for i = 1, #helpers.layers.positive_layers do
    helpers.layers.positive_layers[i]:work()
  end
end

function helpers.random_angle()
  return fmath.random_fixedpoint(0fx, fmath.tau())
end

function helpers.angle_from_ratio_of_tau(numerator, denominator)
  return fmath.tau() * fmath.from_fraction(numerator, denominator)
end

function helpers.floating_message(x, y, text, scale, color, d_alpha, z_inc)
  local id = pewpew.new_customizable_entity(x, y)
  local z = 0fx
  local alpha = 255
  pewpew.customizable_entity_set_mesh_scale(id, scale)
  pewpew.entity_set_update_callback(id, function()
    z = z + z_inc
    local color = color_helpers.make_color_with_alpha(color, alpha)
    local color_s = color_helpers.color_to_string(color)
    pewpew.customizable_entity_set_string(id, color_s .. text)
    pewpew.customizable_entity_set_mesh_z(id, z)
    alpha = alpha - d_alpha
    if alpha <= 8 or z > 1000fx then
      pewpew.entity_destroy(id)
    end
  end)
end

function helpers.arr_to_fixedpoint(arr)
  for i = 1,#arr do 
    arr[i][1] = fmath.to_fixedpoint(arr[i][1])
    arr[i][2] = fmath.to_fixedpoint(arr[i][2])
  end
  return arr
end

function helpers.chance(num)
  local rn = fmath.random_int(0, 100)
  if rn <= num then
      return true
  else return false end
end

function helpers.id_is_inside_array(id,array)
  for i = 1, #array do
    if array[i] == id then
      return true
    end
  end
  return false
end

local function parametricBlend(t)
  sqr = t * t;
  return sqr / (2 * (sqr - t) + 1);
end

function helpers.mathf1(time)
  helpers.t = time / (time+helpers.X)
  --print(helpers.t)
end

function helpers.mathf2(time)
  helpers.t2 = time / (time+helpers.X2)
  helpers.t2 = helpers.t2 * 100000
  helpers.t2 = helpers.t2//1
  helpers.t2 = helpers.t2/100000
  helpers.t2 = parametricBlend(helpers.t2)
  --print(helpers.t2)
end

function helpers.lerp(a,b,t)--point a to point b, t has to be somewhere from 0 to 1
  local v = (1fx - t) * a + b * t
  return v
end

function helpers.lerpINT(a,b,t)--point a to point b, t has to be somewhere from 0 to 1
  local v = (1 - t) * a + b * t
  return v
end

function helpers.invLerp(a,b,v)--point a to point b, but value is used
  local t = (v - a) / (b - a)
  return t
end

local function normalize(x,y)
  local angle = fmath.atan2(y,x)
  local ny,nx = fmath.sincos(angle)
  return nx,ny
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

local function verifyPositionsInWalls(x,y,vertices)
  local num = 0
  local pos = {x,y}
  --print("After obstacle check: ".."{"..pos[1]..", "..pos[2].."}")

  local lines = {}
  for i = 1, #vertices do 
    if i ~= #vertices then 
        table.insert(lines,{vertices[i],vertices[i+1]})
    end
  end

  local polyCenter = findCenterOfPolygon(vertices)
  for i = 1, #lines do
      local axis,otherAxis = findDominantAxis(lines[i])

      local t_value = helpers.invLerp(lines[i][1][axis],lines[i][2][axis],pos[axis])
      --pewpew.print("T: "..t_value)
      local borderPos = helpers.lerp(lines[i][1][otherAxis],lines[i][2][otherAxis],t_value)
      if t_value <= 1fx and t_value >= 0fx then
          --print(i)
          --pewpew.print("AXIS: "..otherAxis.." Average line axis: "..((lines[i][1][otherAxis]+lines[i][2][otherAxis])/2fx) .." Center axis: "..polyCenter[otherAxis])
          if (lines[i][1][otherAxis]+lines[i][2][otherAxis])/2fx < lvl_ctr[otherAxis] then
              if pos[otherAxis] <= borderPos then
                --pewpew.print("Axis: "..otherAxis.."Border Position: "..borderPos.." and axis position: "..pos[otherAxis])
                local dist = borderPos-pos[otherAxis]
                local dist1,dist2 = normalize(dist,dist)
                --pewpew.print("Move: "..(dist1*2fx))
                pos[otherAxis] = pos[otherAxis] + (dist1*2fx) *(fmath.abs_fixedpoint(dist)+8fx)
                return pos[1],pos[2]
              end
          else
              if pos[otherAxis] >= borderPos then
                --pewpew.print("Border Position: "..borderPos.." and axis position: "..pos[otherAxis])
                local dist = borderPos-pos[otherAxis]
                local dist1,dist2 = normalize(dist,dist)
                --pewpew.print("Move: "..(dist1*2fx))
                pos[otherAxis] = pos[otherAxis] + (dist1*2fx) *(fmath.abs_fixedpoint(dist)+8fx)
                return pos[1],pos[2]
              end
          end
      end
  end
  
  return pos[1],pos[2]
end

function helpers.verify_position(x,y)
  if #helpers.obstacle_positions ~= 0 then
    for i = 1, #helpers.obstacle_positions do
      local dx,dy = x-helpers.obstacle_positions[i][1],y-helpers.obstacle_positions[i][2]
      local dist = fmath.sqrt((dx*dx)+(dy*dy))
      local angle = fmath.atan2(dy,dx)
      local oy,ox = fmath.sincos(angle)
      local lil_push = 4fx
      if dist <= helpers.obstacle_positions[i][3] then
        x = x+ox*(helpers.obstacle_positions[i][3]-dist+lil_push)
        y = y+oy*(helpers.obstacle_positions[i][3]-dist+lil_push)
      end
    end
  end
  for i = 1, #helpers.wall_positions do 
    x,y = verifyPositionsInWalls(x,y,helpers.wall_positions[i])
  end
  local ext = fmath.random_fixedpoint(0fx, 100fx)
  if x > FX then x = FX-ext end
  if y > FY then y = FY-ext end

  if x < 0fx then x = ext end
  if y < 0fx then y = ext end
  --pewpew.print("final: {"..x..", "..y.."} ")
  return x,y
end

return helpers