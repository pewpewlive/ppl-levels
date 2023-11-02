local vertexes, segments, colors1, colors2 = {}, {}, {}, {}

local r = {48, 28, 60, 30}
local n = 16
local index = 0

local offset = math.pi / n

for i = 1, n do
	if i % 2 == 0 then
		table.insert(vertexes, {r[1] * math.cos(offset * i * 2), r[1] * math.sin(offset * i * 2)})
		table.insert(vertexes, {r[1] * math.cos(offset * (i * 2 + 1)), r[1] * math.sin(offset * (i * 2 + 1))})
		table.insert(vertexes, {r[2] * math.cos(offset * (i * 2 + 1 / 2)), r[2] * math.sin(offset * (i * 2 + 1 / 2))})
		for h = 1, 3 do
			table.insert(colors1, 0x33ddddff)
			table.insert(colors2, 0x99ffffff)
		end
	else
		table.insert(vertexes, {r[3] * math.cos(offset * i * 2), r[3] * math.sin(offset * i * 2)})
		table.insert(vertexes, {r[3] * math.cos(offset * (i * 2 + 1)), r[3] * math.sin(offset * (i * 2 + 1))})
		table.insert(vertexes, {r[4] * math.cos(offset * (i * 2 + 1 / 2)), r[4] * math.sin(offset * (i * 2 + 1 / 2))})
		for h = 1, 3 do
			table.insert(colors1, 0xffaa33ff)
			table.insert(colors2, 0xffff99ff)
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