local gv = require("/dynamic/gv.lua")
local ph = require("/dynamic/helpers/player_helpers.lua")
local w,h = gv[1][1],gv[1][2]
local number = 10
local inc = 0fx
local gameplay = {
    enemies = 0
}

function gameplay.add()
    gameplay.enemies = gameplay.enemies + 1
end

function gameplay.sub()
    gameplay.enemies = gameplay.enemies - 1
end

return gameplay