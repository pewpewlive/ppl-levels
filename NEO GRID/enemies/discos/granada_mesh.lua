require("/static/graphics/helpers/icosahedron_helpers.lua")
local gfx = require("/dynamic/graphics_helper.lua")

function Icosahedron()
    local radius = 19
    local vertexes = MakePointyEndOfIcosahedronUp(GetIcosahedronVertexes(radius))
    local triangles = GetIcosahedronTriangles()
    triangles = IcosahedronSubdivide(vertexes, triangles, radius)

    local mesh = NewEmptyMesh()
    mesh.vertexes = vertexes
    mesh.segments = TransformTrianglesIntoSegments(triangles)
    return mesh
end

meshes = {
    Icosahedron(),
    gfx.new_mesh()
}

gfx.add_flat_poly_angle(meshes[2], {0,0,0}, 20, 0xff000088, 140, 0)