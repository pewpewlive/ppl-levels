c_vertexes={}
c_colors={}
c_segments={}

local mn1=22
local mn2=22 --amount of lines
local n1=6 --alpha ratio(~255 / mn1 or mn2)
local a=60
local b=60
local z0=15 --sizes
local index=0
local fk=math.pi*2
local segm1 =fk/mn1
local segm2 =fk/mn2

function a_color(re, gr, bl, al)
  local color = re * 256 + gr
  color = color * 256 + bl
  color = color * 256 + al
  return color
end

for k=1,mn1 do
local x0=-mn2*a/2+(k-1)*a
for i=1,mn2 do
local y0=-mn1*b/2+(i-1)*b
local x=x0+a/2
local y=y0+b/2
local z
if (i+k)%2==0 then z=z0 else z=-z0 end
table.insert(c_vertexes,{x,y,z})
table.insert(c_colors,a_color(237,157,7,60))
if i~=mn2 then table.insert(c_segments,{index,index+1}) end
index=index+1
end
if k~=mn1 then
for f=0,mn2-1 do
table.insert(c_segments,{index+f-mn2,index+f})
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