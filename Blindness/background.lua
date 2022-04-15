c_vertexes={}
c_colors={}
c_segments={}

local index1 = 0
local index2 = 1

for i=1,100 do

x=math.random(0,1250)
y=math.random(0,1600)
  table.insert(c_vertexes, {x,y})
x=math.random(0,1250)
y=math.random(0,1600)
  table.insert(c_vertexes, {x,y})
  table.insert(c_segments, {index1,index2})
  index1 = index1 + 2
  index2 = index2 + 2
  
local c1=0xffffff10
table.insert(c_colors, c1)
table.insert(c_colors, c1)
end

meshes = {
  {
    vertexes = c_vertexes,
    segments = c_segments,
    colors = c_colors
  }
}