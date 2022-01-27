computed_vertexes = {}
computed_segments = {}
computed_colors = {}

meshes = {
    {
      vertexes = computed_vertexes,
      segments = computed_segments,
      colors = computed_colors
    }
  }  

local index1 = 0
local index2 = 1
local index3 = 2
local index4 = 3

for i=0,1000 do
  local x = math.random(-2000, 2000)
  local y = math.random(-2000, 2000)
  local z = math.random(-500, 250)

  table.insert(computed_vertexes, {x-3,y-3,z})
  table.insert(computed_vertexes, {x-3,y+3,z})
  table.insert(computed_vertexes, {x+3,y+3,z})
  table.insert(computed_vertexes, {x+3,y-3,z})
  table.insert(computed_segments, {index1, index2, index3, index4, index1})

  index1 = index1 + 4
  index2 = index2 + 4
  index3 = index3 + 4
  index4 = index4 + 4
  for i = 1,4 do
    local e = math.random(1, 5)
    if e == 1 then
      table.insert(computed_colors, 0xce3aad88)
    elseif e == 2 then
        table.insert(computed_colors, 0x5afd7288)
    elseif e == 3 then
       table.insert(computed_colors, 0x360ca488)
    elseif e == 4 then
        table.insert(computed_colors, 0xafd2b088)
    elseif e == 5 then
        table.insert(computed_colors, 0xdbd84288)
    end
  end
end