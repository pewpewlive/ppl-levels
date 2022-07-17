require("/static/graphics/helpers/icosahedron_helpers.lua")

function Icosahedron()
    local radius = 19
    local vertexes = MakePointyEndOfIcosahedronUp(GetIcosahedronVertexes(radius))
    local triangles = GetIcosahedronTriangles()
    triangles = IcosahedronSubdivide(vertexes, triangles, radius-7)

    local mesh = NewEmptyMesh()
    mesh.vertexes = vertexes
    mesh.segments = TransformTrianglesIntoSegments(triangles)
    return mesh
end

meshes = {
    Icosahedron()
}