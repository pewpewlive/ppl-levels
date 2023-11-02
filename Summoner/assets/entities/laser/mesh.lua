a = 10000
h = 1

meshes = {
	{
		vertexes = {{0, 0}, {a, 0}},
		segments = {{0, 1}}
	},
	{
		vertexes = {{0, 0}, {a, 0}, {0, h}, {a, h}, {0, -h}, {a, -h}},
		segments = {{0, 1}, {2, 3}, {4, 5}}
	}
}