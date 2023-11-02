local vertexes, segments, colors1, colors2 = {}, {}, {}, {}

local r = {36, 18}
local n = 8
local index = 0

local offset = math.pi / n

for i = 1, n do
	if i % 2 == 0 then
		table.insert(vertexes, {r[1] * math.cos(offset * (i * 2 - 0.5)), r[1] * math.sin(offset * (i * 2 - 0.5))})
		table.insert(vertexes, {r[1] * math.cos(offset * (i * 2 + 0.5)), r[1] * math.sin(offset * (i * 2 + 0.5))})
		table.insert(vertexes, {r[2] * math.cos(offset * (i * 2)), r[2] * math.sin(offset * (i * 2))})
		for h = 1, 3 do
			table.insert(colors1, 0x44eeaaff)
			table.insert(colors1, 0xbbffffff)
		end
	else
		table.insert(vertexes, {r[1] * math.cos(offset * (i * 2 - 0.5)), r[1] * math.sin(offset * (i * 2 - 0.5))})
		table.insert(vertexes, {r[1] * math.cos(offset * (i * 2 + 0.5)), r[1] * math.sin(offset * (i * 2 + 0.5))})
		table.insert(vertexes, {r[2] * math.cos(offset * (i * 2)), r[2] * math.sin(offset * (i * 2))})
		for h = 1, 3 do
			table.insert(colors1, 0x88eeeeff)
			table.insert(colors1, 0xddffffff)
		end
	end
	table.insert(segments, {index, index + 1, index + 2, index})
	index = index + 3
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