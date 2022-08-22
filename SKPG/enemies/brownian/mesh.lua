radius = 10

function mesh_with_color(color)
  return {
    vertexes = {{radius, radius, radius},
                {radius, -radius, -radius},
                {-radius, radius, -radius},
                {-radius, -radius, radius}},
    segments = {{0,1},{0,2},{0,3},{1,2},{1,3},{2,3}},
    colors = color
  }
end

meshes = {
  mesh_with_color(0xff0000ff),
  mesh_with_color(0x0000ffff),
}