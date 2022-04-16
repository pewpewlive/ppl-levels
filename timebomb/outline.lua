local a_vertexes={}
local a_segments={}
local a_colors={}

local index1 = 0
local index2 = 1
local index3 = 2
local index4 = 3
local z=0

local c1=0xffffff30

for i=1,25 do

table.insert(a_colors,c1)
table.insert(a_colors,c1)
table.insert(a_colors,c1)
table.insert(a_colors,c1)
table.insert(a_vertexes,{0,0,z})
table.insert(a_vertexes,{1250,0,z})
table.insert(a_vertexes,{1250,1250,z})
table.insert(a_vertexes,{0,1250,z})

table.insert(a_segments,{index1,index2,index3,index4,index1})

index1=index1 + 4
index2=index2 + 4
index3=index3 + 4 
index4=index4 + 4

z=z+20
end

meshes = {
  {
    vertexes = a_vertexes,
    colors = a_colors,
    segments = a_segments
  }
}