local vertexes, segments, colors1, colors2 = {}, {}, {}, {}

local a = 32
local o1 = 6
local o2 = 12
local index = 0

for i = 1, 3 do
	local v = {(o1 + a / 2) * math.cos(math.pi * (i * 2 / 3 - 1 / 3)), (o1 + a / 2) * math.sin(math.pi * (i * 2 / 3 - 1 / 3))}
	for k = 1, 4 do
		local dx = a * math.cos(math.pi * (i * 2 / 3 + k / 2 - 1 / 3))
		local dy = a * math.sin(math.pi * (i * 2 / 3 + k / 2 - 1 / 3))
		if k % 2 == 0 then
			dx = dx / 2
			dy = dy / 2
		else
			dx = dx * math.sin(math.pi / 3)
			dy = dy * math.sin(math.pi / 3)
		end
		table.insert(vertexes, {v[1] + dx, v[2] + dy})
	end
	table.insert(segments, {index, index + 1, index + 2, index + 3, index})
	index = index + 4
	for h = 1, 4 do
		table.insert(colors1, 0xff22ccdd)
		table.insert(colors2, 0xff88ffdd)
	end
end

for i = 1, 3 do
	local v = {(o1 + a / 2) * math.cos(math.pi * (i * 2 / 3 - 1 / 3)), (o1 + a / 2) * math.sin(math.pi * (i * 2 / 3 - 1 / 3))}
	for k = 1, 4 do
		local dx = (a - o2) * math.cos(math.pi * (i * 2 / 3 + k / 2 - 1 / 3))
		local dy = (a - o2) * math.sin(math.pi * (i * 2 / 3 + k / 2 - 1 / 3))
		if k % 2 == 0 then
			dx = dx / 2
			dy = dy / 2
		else
			dx = dx * math.sin(math.pi / 3)
			dy = dy * math.sin(math.pi / 3)
		end
		table.insert(vertexes, {v[1] + dx, v[2] + dy})
	end
	table.insert(segments, {index, index + 1, index + 2, index + 3, index})
	index = index + 4
	for h = 1, 4 do
		table.insert(colors1, 0xff66aaff)
		table.insert(colors2, 0xffaaffff)
	end
end

meshes = {
	{
		vertexes = vertexes,
		segments = segments,
		colors = colors1
	},
	{
		vertexes = vertexes,
		segments = segments,
		colors = colors2
	}
}