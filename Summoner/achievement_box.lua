local vertexes, segments = {}, {}
local index_s = 0
local index = 0
local segment = {}

local heigth_offset = 50
local alpha_offset = 30
local side = 0.8
local corner_size = 0.1
local corner_precision = 6
local a, b = 5, 3

local d90 = -math.pi / 2
local s = side / 2

function get_table_copy(arr)
	local c = {}
	for k, v in ipairs(arr) do
		table.insert(c, v)
	end
	return c
end

function insert_vertex(vertex)
	table.insert(vertexes, vertex)
	table.insert(segment, index)
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

for h = 0, -3, -1 do
	draw_square(0, 0, h * heigth_offset)
end

meshes = {{
	vertexes = vertexes,
	segments = segments
}}