meshes = {} --creating main array

c_vertexes = {} --you can name this 3 arrays as you want
c_segments = {}
c_colors = {} --also you can not use colors


local a=20 b=20 --just numbers
local i=0 --index

for f=1,a do
	for k=1,b do
		local x=f*20
		local y=k*20--creating coordinates
        local z=k*f*-10
		local colr = 0x20ff6925

		table.insert(c_vertexes,{x,y,z}) --adding dot in vertexes
		if i~=0 then table.insert(c_segments,{i-1.5,i}) end --connecting this dot and previous 
		i=i+1 --increasing index
		table.insert(c_colors,colr) --now every dot will be gray
	end
end

meshes = {
  {
    vertexes = c_vertexes,
    segments = c_segments,
    colors = c_colors
  }
}