local j = {6, 8}
local a = {6, 12}
local f = 12
local h = 24
local q = 32

meshes = {
	{
		vertexes = {	{a[1], a[2]}, {a[1], -a[2]}, {-a[1], -a[2]}, {-a[1], a[2]},
									{j[1], j[2]}, {j[1] + h, j[2]}, {j[1] + q, 0}, {j[1] + h, -j[2]}, {j[1], -j[2]},
									{-j[1], j[2]}, {-j[1] - f, j[2]}, {-j[1] - f, -j[2]}, {-j[1], -j[2]}},
		segments = {{0, 1, 2, 3, 0}, {4, 5, 6, 7, 8}, {9, 10, 11, 12}},
		colors = {0xff3333ff, 0xff3333ff, 0xff3333ff, 0xff3333ff,
							0xff3333ff, 0xff3333ff, 0xff3333ff, 0xff3333ff, 0xff3333ff,
							0xff3333ff, 0xff3333ff, 0xff3333ff, 0xff3333ff}
	},
	{
		vertexes = {	{a[1], a[2]}, {a[1], -a[2]}, {-a[1], -a[2]}, {-a[1], a[2]},
									{j[1], j[2]}, {j[1] + h, j[2]}, {j[1] + q, 0}, {j[1] + h, -j[2]}, {j[1], -j[2]},
									{-j[1], j[2]}, {-j[1] - f, j[2]}, {-j[1] - f, -j[2]}, {-j[1], -j[2]}},
		segments = {{0, 1, 2, 3, 0}, {4, 5, 6, 7, 8}, {9, 10, 11, 12}},
		colors = {0xffddddff, 0xffddddff, 0xffddddff, 0xffddddff,
							0xffddddff, 0xffddddff, 0xffddddff, 0xffddddff, 0xffddddff,
							0xffddddff, 0xffddddff, 0xffddddff, 0xffddddff}
	}
}