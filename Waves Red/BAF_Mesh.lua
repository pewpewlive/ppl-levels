--[[

  x0
  |
  |
  ****   -- y0
   *  ****
    *     ****  
   *| ****   |
  **|*       |
    |        x2
    x1

--]]


-- function NewBafMesh()
--     local x0 = -12
--     local x1 = -6
--     local x2 = 20
--     local y0 = -16
--     return {
--         vertexes = {{x0,y0}, {x2,0}, {x0,-y0}, {x1,0},     {x0,0,y0}, {x2,0,0}, {x0,0,-y0}, {x1,0,0}},
--         segments = {{0,1,2,3,0}, {4,5,6,7,4}},
--         colors = 0xffffffff
--       }
-- end

function NewBafMeshRight()
  local x0 = -12
  local x1 = -6
  local x2 = 20
  local y0 = -16
  return {
      vertexes = {{x0,y0}, {x2,0}, {x0,-y0}, {x1,0},     {x0,0,y0}, {x2,0,0}, {x0,0,-y0}, {x1,0,0}},
      segments = {{0,1,2,3,0}, {4,5,6,7,4}},
      colors = 0xffffffff
    }
end
function NewBafMeshLeft()
  local x0 = -12
  local x1 = -6
  local x2 = 20
  local y0 = -16
  return {
      vertexes = {{-x0,y0}, {-x2,0}, {-x0,-y0}, {-x1,0},     {-x0,0,y0}, {-x2,0,0}, {-x0,0,-y0}, {-x1,0,0}},
      segments = {{0,1,2,3,0}, {4,5,6,7,4}},
      colors = 0xffffffff
    }
end

function NewBafMeshUp()
  local x0 = -12
  local x1 = -6
  local x2 = 20
  local y0 = -16
  return {
    vertexes = {{-y0,x0}, {0,x2}, {y0,x0}, {0,x1},     {0,x0,y0}, {0,x2,0}, {0,x0,-y0}, {0,x1,0}},
    segments = {{0,1,2,3,0}, {4,5,6,7,4}},
    colors = 0xffffffff
  }
end
function NewBafMeshDown()
  local x0 = -12
  local x1 = -6
  local x2 = 20
  local y0 = -16
  return {
    vertexes = {{-y0,-x0}, {0,-x2}, {y0,-x0}, {0,-x1},     {0,-x0,y0}, {0,-x2,0}, {0,-x0,-y0}, {0,-x1,0}},
    segments = {{0,1,2,3,0}, {4,5,6,7,4}},
    colors = 0xffffffff
  }
end

-- Multiple identical mesh to have variety in the destruction/spawning animation.
meshes = {
  NewBafMeshRight(), -- 0
  NewBafMeshRight(), -- 1
  NewBafMeshRight(), -- 2
  NewBafMeshRight(), -- 3
  NewBafMeshLeft(), -- 4
  NewBafMeshLeft(), -- 5
  NewBafMeshLeft(), -- 6
  NewBafMeshLeft(), -- 7
  NewBafMeshUp(), -- 8
  NewBafMeshUp(), -- 9
  NewBafMeshUp(), -- 10
  NewBafMeshUp(), -- 11
  NewBafMeshDown(), -- 12
  NewBafMeshDown(), -- 13
  NewBafMeshDown(), -- 14
  NewBafMeshDown(), -- 15
  }