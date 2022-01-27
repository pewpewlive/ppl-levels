c_vertexes={}
c_colors={}
c_segments={}

local index1 = 0
local index2 = 1

for i=1,15 do

    local x = math.random(-2000, 2000)
    local y = math.random(-2000, 2000)
    local z = math.random(-1000, 0)
    table.insert(c_vertexes, {x,y,z})
    local x = math.random(-2000, 2000)
    local y = math.random(-2000, 2000)
    local z = math.random(-1000, 0)
    table.insert(c_vertexes, {x,y,z})
    table.insert(c_segments, {index1,index2})
    index1 = index1 + 2
    index2 = index2 + 2
    
    for i = 1,2 do
    local e = math.random(1, 5)
    if e == 1 then
      table.insert(c_colors, 0xce3aad88)
    elseif e == 2 then
        table.insert(c_colors, 0x5afd7288)
    elseif e == 3 then
       table.insert(c_colors, 0x360ca488)
    elseif e == 4 then
        table.insert(c_colors, 0xafd2b088)
    elseif e == 5 then
        table.insert(c_colors, 0xdbd84288)
    end
  end
end
meshes = {
  {
    vertexes = c_vertexes,
    segments = c_segments,
    colors = c_colors
  }
}