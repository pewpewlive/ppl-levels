local w = 100

function new_sino_mesh()
  local mesh = {}
  mesh.vertexes = {}
  mesh.segments = {}

  mesh.segments[1] = {}
  mesh.segments[2] = {}

  local inner_radius = 80
  local outer_radius = 100

  local inner_radius2 = 40
  local outer_radius2 = 50

  local n = 30
  for i=0,n do
    local angle = 6.28318530718 * i / n

    local radius = 0
    local radius2 = 0
    if i % 2 == 0 then
      radius = inner_radius
      radius2 = inner_radius2
    else
      radius = outer_radius
      radius2 = outer_radius2
    end
    local sin,cos = math.sincos(angle)
    local x = sin * radius
    local y = cos * radius
    table.insert(mesh.vertexes, {x, y})

    local sin2,cos2 = math.sincos(angle + 0.3)
    local x2 = sin2 * radius2
    local y2 = cos2 * radius2
    table.insert(mesh.vertexes, {x2, y2, 100})

    table.insert(mesh.segments[1], i*2)
    table.insert(mesh.segments[2], i*2  +1)
    table.insert(mesh.segments, {i*2, i*2+1})
  end
  return mesh
end

meshes = {
  new_sino_mesh()
}

