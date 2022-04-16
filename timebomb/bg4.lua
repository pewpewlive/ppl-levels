computed_vertexes = {}
computed_segments = {}
computed_colors = {}

meshes = {
    {
      vertexes = computed_vertexes,
      segments = computed_segments,
      colors = computed_colors
    }
} 


local index1 = 0
local index2 = 1
local index3 = 2
local index4 = 3

for i=0,500 do
  local x = math.random(0, 5000)
  local y = math.random(0, 5000)

  table.insert(computed_vertexes, {x-1,y-1,-250})
  table.insert(computed_vertexes, {x-1,y+1,-250})
  table.insert(computed_vertexes, {x+1,y+1,-250})
  table.insert(computed_vertexes, {x+1,y-1,-250})
  table.insert(computed_segments, {index1, index2, index3, index4, index1})

  index1 = index1 + 4
  index2 = index2 + 4
  index3 = index3 + 4
  index4 = index4 + 4

  local e = math.random(1, 2)
  if e == 1 then
    table.insert(computed_colors, 0xffffffbb)
    table.insert(computed_colors, 0xffffffbb)
    table.insert(computed_colors, 0xffffffbb)
    table.insert(computed_colors, 0xffffffbb)
  else
    table.insert(computed_colors, 0x00ff00bb)
    table.insert(computed_colors, 0x00ff00bb)
    table.insert(computed_colors, 0x00ff00bb)
    table.insert(computed_colors, 0x00ff00bb)
  end
end
