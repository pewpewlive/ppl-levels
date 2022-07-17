meshes = {}

-- first mesh
local tau = math.pi * 2
local sides = 12
local radius = 16

local mesh_vertexes = {}
local mesh_segments = {}

for i = 1, sides do
    table.insert(mesh_vertexes, {math.cos((tau / sides) * i) * radius, math.sin((tau / sides) * i) * radius})
    table.insert(mesh_vertexes, {math.cos((tau / sides) * i) * (radius + 8), math.sin((tau / sides) * i) * (radius + 8)})
end

for i = 1, sides * 2, 2 do
    table.insert(mesh_segments, {i - 1, i})
end

table.insert(meshes, {vertexes = mesh_vertexes, segments = mesh_segments})

mesh_vertexes = {}
mesh_segments = {}
segment_collection = {}

-- second mesh
for i = 1, sides do
    table.insert(mesh_vertexes, {math.cos((tau / sides) * i) * (radius / 2), math.sin((tau / sides) * i) * (radius / 2)})
end

local segment_collection = {}

for i = 0, sides do
    if i == sides then
        table.insert(segment_collection, 0)
    else
        table.insert(segment_collection, i)
    end
end

table.insert(mesh_segments, segment_collection)

table.insert(meshes, {vertexes = mesh_vertexes, segments = mesh_segments})

mesh_vertexes = {}
mesh_segments = {}
segment_collection = {}

-- third mesh (PewPew 2 Style)
local spring_length = 150
local cuts = 10
local cut_h = -15

table.insert(mesh_vertexes, {0, 0})

for i = 1, cuts - 1 do
    if i % 2 == 0 then
        table.insert(mesh_vertexes, {(spring_length / cuts) * i, cut_h})
    else
        table.insert(mesh_vertexes, {(spring_length / cuts) * i, -cut_h})
    end
end

table.insert(mesh_vertexes, {spring_length, 0})

for i = 0, cuts do
    table.insert(segment_collection, i)
end

table.insert(mesh_segments, segment_collection)

table.insert(meshes, {vertexes = mesh_vertexes, segments = mesh_segments})

mesh_vertexes = {}
mesh_segments = {}
segment_collection = {}

-- fourth mesh (Realistic Spring)
local spring_length = 150
local turns = 10
local detail = 16
local radius = 18

table.insert(mesh_vertexes, {0, 0})

for i = 0, cuts - 1 do
    for j = 1, detail do
        table.insert(mesh_vertexes, {((spring_length / cuts) * i) + ((spring_length / cuts) / detail) * j, math.sin((tau / detail) * j) * radius, math.cos((tau / detail) * j) * radius})
    end
end

for i = 0, #mesh_vertexes - 1 do
    table.insert(segment_collection, i)
end

table.insert(mesh_segments, segment_collection)

table.insert(meshes, {vertexes = mesh_vertexes, segments = mesh_segments})