c_vertexes={}
c_colors={}
c_segments={}

local mn2=50
local mn1=50
local fk=2*math.pi
local r1=4000
local r2=4000
local r3=4000
local index1 = 0
local c1=0x00903050
local segm1 =fk/mn1
local segm2 =fk/mn2/2

for k=0,mn2 do
local z=r3*math.cos(k*segm2)
for i=1,mn1 do
local x=math.sin(i*segm1)*r1*math.sin(k*segm2)
local y=math.cos(i*segm1)*r2*math.sin(k*segm2)
table.insert(c_vertexes,{x,y,z})
table.insert(c_colors,c1)
if i~=mn1 then table.insert(c_segments,{index1,index1+1}) else table.insert(c_segments,{index1,index1+1-mn1}) end
index1=index1+1
end

end

index1= 0

for k=0,mn2-1 do

for i=1,mn1 do
table.insert(c_segments,{index1,index1+mn1})
index1=index1+1
end

end

meshes = {
  {
    vertexes = c_vertexes,
    segments = c_segments,
    colors = c_colors
  }
}