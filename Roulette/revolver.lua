local gfx = require("/dynamic/helpers/mesh_helpers.lua")

meshes = {gfx.new_mesh(), gfx.new_mesh(),gfx.new_mesh()}

--big circle
gfx.add_horizontal_regular_polygon_to_mesh(meshes[1], {0,0,0}, 100, 30, 0xffffff99, 0)
--small mid circle
gfx.add_horizontal_regular_polygon_to_mesh(meshes[1], {0,0,0}, 27, 30, 0xffffff99, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[1], {0,0,0}, 13, 30, 0xffffff60, 0)

--left down
gfx.add_horizontal_regular_polygon_to_mesh(meshes[1], {-32,-55,0}, 30, 30, 0xffffff99, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[1], {-32,-55,0}, 23, 30, 0x00ffff60, 0)
--right down
gfx.add_horizontal_regular_polygon_to_mesh(meshes[1], {32,-55,0}, 30, 30, 0xffffff99, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[1], {32,-55,0}, 23, 30, 0x0000ff60, 0)
--right up
gfx.add_horizontal_regular_polygon_to_mesh(meshes[1], {32,55,0}, 30, 30, 0xffffff99, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[1], {32,55,0}, 23, 30, 0x00ff0060, 0)
--left up
gfx.add_horizontal_regular_polygon_to_mesh(meshes[1], {-32,55,0}, 30, 30, 0xffffff99, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[1], {-32,55,0}, 23, 30, 0xff00ff60, 0)

--left mid
gfx.add_horizontal_regular_polygon_to_mesh(meshes[1], {-65,0,0}, 30, 30, 0xffffff99, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[1], {-65,0,0}, 23, 30, 0xffff0060, 0)
--right mid
gfx.add_horizontal_regular_polygon_to_mesh(meshes[1], {65,0,0}, 30, 30, 0xffffff99, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[1], {65,0,0}, 23, 30, 0xff000060, 0)

gfx.add_square(meshes[3], {0,0,0}, 750, 600, 0xffffffff)







--gfx.add_horizontal_regular_polygon_to_mesh(meshes[1], {0,0,0}, 100, 6, 0xffffff50, 0)

--big circle
gfx.add_horizontal_regular_polygon_to_mesh(meshes[2], {0,0,0}, 100, 30, 0xffffff00, 0)
--small mid circle
gfx.add_horizontal_regular_polygon_to_mesh(meshes[2], {0,0,0}, 27, 30, 0xffffff00, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[2], {0,0,0}, 13, 30, 0xffffff00, 0)

--left down
gfx.add_horizontal_regular_polygon_to_mesh(meshes[2], {-32,-55,0}, 30, 30, 0xffffff00, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[2], {-32,-55,0}, 23, 30, 0xffffff00, 0)
--right down
gfx.add_horizontal_regular_polygon_to_mesh(meshes[2], {32,-55,0}, 30, 30, 0xffffff00, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[2], {32,-55,0}, 23, 30, 0xffffff00, 0)
--right up
gfx.add_horizontal_regular_polygon_to_mesh(meshes[2], {32,55,0}, 30, 30, 0xffffff00, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[2], {32,55,0}, 23, 30, 0xffffff00, 0)
--left up
gfx.add_horizontal_regular_polygon_to_mesh(meshes[2], {-32,55,0}, 30, 30, 0xffffff00, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[2], {-32,55,0}, 23, 30, 0xffffff00, 0)

--left mid
gfx.add_horizontal_regular_polygon_to_mesh(meshes[2], {-65,0,0}, 30, 30, 0xffffff00, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[2], {-65,0,0}, 23, 30, 0xffffff00, 0)
--right mid
gfx.add_horizontal_regular_polygon_to_mesh(meshes[2], {65,0,0}, 30, 30, 0xffffff00, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[2], {65,0,0}, 23, 30, 0xffffff00, 0)