require'/dynamic/pplaf/global_variables.lua'

local vertexes, segments, colors = {}, {}, {}
local index_s = 0
local index = 0
local segment = {}
local color = 0

local width, heigth = fmath.to_int(LEVEL_WIDTH), fmath.to_int(LEVEL_HEIGTH)
local offset = 50
local heigth_offset = 50
local alpha_offset = 100
local side = 100
local corner_size = 25
local corner_precision = 6
local a, b = 4, 2

local d90 = -math.pi / 2
local s = side / 2
local m = side + corner_size * 2 + offset

function get_table_copy(arr)
	local c = {}
	for k, v in ipairs(arr) do
		table.insert(c, v)
	end
	return c
end

local color_presets = {
	function()
		return {math.random(190, 240), math.random(80 , 120), math.random(80 , 120)}
	end,
	function()
		return {math.random(80 , 120), math.random(190, 240), math.random(80 , 120)}
	end,
	function()
		return {math.random(80 , 120), math.random(80 , 120), math.random(190, 240)}
	end,
	function()
		return {math.random(190, 240), math.random(190, 240), math.random(40 , 80 )}
	end
}

function make_color(r, g, b, a)
	return ((r * 256 + g) * 256 + b) * 256 + a
end

function insert_vertex(vertex)
	table.insert(vertexes, vertex)
	table.insert(segment, index)
	table.insert(colors, color)
	index = index + 1
end

function draw_square(offset_x, offset_y, offset_z)
	insert_vertex({offset_x + s, offset_y - s - corner_size, offset_z})
	insert_vertex({offset_x - s, offset_y - s - corner_size, offset_z})
	for i = 1, corner_precision - 1 do
		local ang = d90 * (1 + i / corner_precision)
		insert_vertex({offset_x - s + corner_size * math.cos(ang), offset_y - s + corner_size * math.sin(ang), offset_z})
	end
	insert_vertex({offset_x - s - corner_size, offset_y - s, offset_z})
	insert_vertex({offset_x - s - corner_size, offset_y + s, offset_z})
	for i = 1, corner_precision - 1 do
		local ang = d90 * (2 + i / corner_precision)
		insert_vertex({offset_x - s + corner_size * math.cos(ang), offset_y + s + corner_size * math.sin(ang), offset_z})
	end
	insert_vertex({offset_x - s, offset_y + s + corner_size, offset_z})
	insert_vertex({offset_x + s, offset_y + s + corner_size, offset_z})
	for i = 1, corner_precision - 1 do
		local ang = d90 * (3 + i / corner_precision)
		insert_vertex({offset_x + s + corner_size * math.cos(ang), offset_y + s + corner_size * math.sin(ang), offset_z})
	end
	insert_vertex({offset_x + s + corner_size, offset_y + s, offset_z})
	insert_vertex({offset_x + s + corner_size, offset_y - s, offset_z})
	for i = 1, corner_precision - 1 do
		local ang = d90 * (4 + i / corner_precision)
		insert_vertex({offset_x + s + corner_size * math.cos(ang), offset_y - s + corner_size * math.sin(ang), offset_z})
	end
	table.insert(segment, index_s)
	index_s = index
	table.insert(segments, get_table_copy(segment))
	segment = {}
end

for i = -a, a do
	for k = -b, b do
		local rgb = color_presets[math.random(1, #color_presets)]()
		for h = 0, -2, -1 do
			color = make_color(rgb[1], rgb[2], rgb[3], 255 + h * alpha_offset)
			draw_square(i * m, k * m, h * heigth_offset)
		end
		for h = 1, 2 do
			color = make_color(rgb[1], rgb[2], rgb[3], 255 - h * alpha_offset)
			draw_square(i * m, k * m, h * heigth_offset)
		end
	end
end

meshes = {{
	vertexes = vertexes,
	segments = segments,
	colors = colors
}}