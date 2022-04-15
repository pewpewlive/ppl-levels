---
--  Functions designed for polygon meshes
--  Created by The Assassin (Kira)
---

local helper = {}

function helper.polygonTower(radius,sides,heightF,heightT,divi)
  local mesh = {}
  mesh.vertexes = {}
  mesh.segments = {}
  mesh.colors = {}
  for k = heightF, heightT, divi do    
    for i=0,sides do
      local angle = (6.283 / sides) * i + 0.78539
      local x = math.cos(angle) * radius
      local y = math.sin(angle) * radius
      local z = k
      table.insert(mesh.vertexes, {x , y , z})
    end
  end

  for i = 0 , #mesh.vertexes - sides + 1 , sides + 1 do
    local toAdd = {}
    for k = i , i + sides do
      table.insert(toAdd , k)
    end
    table.insert(toAdd , i)
    table.insert(mesh.segments,toAdd)      
  end

  return mesh
end

function helper.polygonSimple(radius,sides)
  local mesh = {}
  mesh.vertexes = {}

  for i=0,sides do
    local angle = (6.283 / sides) * i 
    local x = math.cos(angle) * radius
    local y = math.sin(angle) * radius
    table.insert(mesh.vertexes, {x , y})
  end

  local segments = {}
  for i = 0, sides - 1 do
    table.insert(segments,i)
  end
  table.insert(segments,0)
  mesh.segments = {segments}
  return mesh
end

return helper
