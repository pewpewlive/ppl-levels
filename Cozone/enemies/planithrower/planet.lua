c_vertexes={}
c_colors={}
c_segments={}

local mn1=12 --number of vertical and horizontal lines
local mn2=12
local fk=2*math.pi --tau
local r1=35
local r2=35
local r3=35 --radiuses 
local index=0
local c1=0xffffff67 --you can declare color as variable in any part of program and use it later
local segm1 =fk/mn1
local segm2 =fk/mn2/2 --constants for correct positions of points on sphere

for k=0,mn2 do
	for i=1,mn1 do
		local z=math.cos(i*segm1)*r2*math.sin(k*segm2)
		local x=math.sin(i*segm1)*r1*math.sin(k*segm2)
		local y=r3*math.cos(k*segm2)
		
		table.insert(c_vertexes,{x,y,z})
		table.insert(c_colors,c1)
		if i~=mn1 then table.insert(c_segments,{index,index+1}) else table.insert(c_segments,{index,index+1-mn1}) end
		if mn1%30<=1 then table.insert(c_colors,0xffffff67)
		else table.insert(c_colors,0xffffff67) end
		index=index+1 --connecting dots in every circle
		
	end
end

index=0

for k=0,mn2-1 do
	for i=1,mn1 do
		table.insert(c_segments,{index,index+mn1})
		index=index+1
	end
end 

meshes = { --you can not declare this array in the beginning, but mesh file must contain it anyway
  {
    vertexes = c_vertexes,
    segments = c_segments,
    colors = c_colors
  }
}