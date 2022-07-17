c_vertexes={}
c_colors={}
c_segments={}

local index1 = 0
local index2 = 1

for i=1,150 do

x=math.random(-(750*2),750*2)
y=math.random(-(600*2),600*2)
  table.insert(c_vertexes, {x,y,500})
x=math.random(-(750*2),750*2)
y=math.random(-(600*2),600*2)
  table.insert(c_vertexes, {x,y,-500})
  table.insert(c_segments, {index1,index2})
  index1 = index1 + 2
  index2 = index2 + 2
  
local c1=0x00ff0010
local c2=0x00ff0020
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
  },
  {
    vertexes = {{-4000,-4000},{-4050,-4000}},
    segments = {{0,1}},
    colors = {0x000000ff,0x000000ff}
  }
}