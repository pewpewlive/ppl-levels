c_vertexes={}
c_colors={}
c_segments={}

local index1 = 0
local index2 = 1

for i=1,50 do

x=math.random(0,5000)
y=math.random(0,5000)
  table.insert(c_vertexes, {x,y,125})
x=math.random(0,5000)
y=math.random(0,5000)
  table.insert(c_vertexes, {x,y,125})
  table.insert(c_segments, {index1,index2})
  index1 = index1 + 2
  index2 = index2 + 2
  
local c1=0xffffff55
local c2=0x00ff0055
local isc1 = math.random(0,1)
local isc2 = math.random(0,1)
if isc1 == 1 then
table.insert(c_colors, c1)
else
  table.insert(c_colors, c2)
end
if isc2 == 0 then
table.insert(c_colors, c1)
else
  table.insert(c_colors, c2)
end
end

meshes = {
  {
    vertexes = c_vertexes,
    segments = c_segments,
    colors = c_colors
  }
}