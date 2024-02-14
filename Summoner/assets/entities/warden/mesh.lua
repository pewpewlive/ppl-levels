local vertexes, segments, colors1, colors2 = {}, {}, {}, {}

local a = 48
local s = 24
local o = {0, 12, 24, 36}
local c = {	0xff2266ff, 0xff6666ff, 0xffaa66ff, 0xffdd66ff,
						0xff88aaff, 0xffaaaaff, 0xffddaaff, 0xffffaaff}
local index = 0

for f = 1, #o do
	for i = 1, 6 do
		local v = {(s + a / 2) * math.cos(math.pi * (i / 3 - 1 / 3)), (s + a / 2) * math.sin(math.pi * (i / 3 - 1 / 3))}
		for k = 1, 4 do
			local dx = (a - o[f]) * math.cos(math.pi * (i / 3 + k / 2 - 1 / 3))
			local dy = (a - o[f]) * math.sin(math.pi * (i / 3 + k / 2 - 1 / 3))
			if k % 2 == 1 then
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
			table.insert(colors1, c[f])
			table.insert(colors2, c[f + 4])
		end
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

--[[

local a = 16
local offset = 12
local o = {
	{offset, 0},
	{offset * math.cos(math.pi * 2 / 3), offset * math.sin(math.pi * 2 / 3)},
	{offset * math.cos(math.pi * 4 / 3), offset * math.sin(math.pi * 4 / 3)}
}

local v = {}
local s = {}
local c = {}
local index = 0

for i = 1, 3 do
	table.insert(v, o[i])
	for k = 1, 3 do
		table.insert(v, {o[i][1] + a * math.cos(math.pi * (-4 + k + i * 2) / 3), o[i][2] + a * math.sin(math.pi * (-4 + k + i * 2) / 3)})
	end
	table.insert(s, {index, index + 1, index + 2, index + 3, index})
	index = index + 4
	for h = 1, 4 do
		table.insert(c, 0xdd33aacc)
	end
end

local q = {}
for i = 1, 3 do
	for k = 1, 3 do
		table.insert(q,	{	v[-3 + k + i * 4][1] + offset * math.cos(math.pi * (-4 + k + i * 2) / 3),
											v[-3 + k + i * 4][2] + offset * math.sin(math.pi * (-4 + k + i * 2) / 3)})
	end
end

for i = 1, 9 do
	for k = 1, 4 do
		table.insert(v, {q[i][1] + v[-4 + k + math.ceil(i / 3) * 4 ][1], q[i][2] + v[-4 + k + math.ceil(i / 3) * 4 ][2]})
	end
	table.insert(s, {index, index + 1, index + 2, index + 3, index})
	index = index + 4
	for h = 1, 4 do
		table.insert(c, 0xff9999aa)
	end
end

meshes = {{
	vertexes = v,
	segments = s,
	colors = c
}}

]]--