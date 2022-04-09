---
--  Meshes for Polygons v1.0
--  Created by Tasty Kiwi
---

local helper = require("/dynamic/helpers/poly_mesh_helpers.lua")

meshes = {
  helper.polygonTower(600, 7, 0, 500, 100), -- seven corner mothership
  helper.polygonTower(500, 6, -500, 0, 100), -- six corner mothership
  helper.polygonTower(400, 5, -1000, -500, 100), -- five corner mothership
  helper.polygonTower(300, 4, -1500, -1000, 100), -- four corner mothership
  helper.polygonTower(200, 3, -2000, -1500, 100), -- three corner mothership
  helper.polygonTower(75, 8, -3000, 400, 200), -- 10 corner blue pillars (75fx radius)
  helper.polygonSimple(500, 12) -- Main wall border
}
