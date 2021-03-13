local Entity = require("/dynamic/Modules/Enemy.lua")
local Vector2 = require("/dynamic/Modules/Vector2.lua")

Bounce = {}


function Bounce.new(x,y,size,game)
    local Bounce = Entity:New(x,y)
    local InBounce = Entity:New(x,y)
    local InBounce2 = Entity:New(x,y)
    local BounceDebounce = 0fx
    Bounce:SetMesh("/dynamic/entity_meshes.lua",1)
    InBounce:SetMesh("/dynamic/entity_meshes.lua",1)
    InBounce2:SetMesh("/dynamic/entity_meshes.lua",1)
    Bounce:SetColor(0x61ffddff)
    InBounce:SetColor(0x408cffff)
    InBounce2:SetColor(0x592bffff)
    Bounce:SetRadius(13fx*size)
    Bounce:SetVisibilityRadius(15fx*size)

    Bounce:SetMovementInterpolation(true)
    InBounce:SetMovementInterpolation(true)
    InBounce2:SetMovementInterpolation(true)

    Bounce:PlayerCollision(function(entity_id,player_id,player_ship)
        local Bounce = Entity.Entities[entity_id]

        if game and game[player_ship] and BounceDebounce == 0fx then
            BounceDebounce = 45fx
            pewpew.play_ambient_sound("/dynamic/sounds.lua", 6)
            local player = game[player_ship]
            local ex, ey = Bounce:GetPosition()
            local px, py = player:GetPosition()
            local dx = px - ex
            local dy = py - ey
            local angle = fmath.atan2(dy,dx)

            player.BounceVector = Vector2.UnitFromAngle(angle) * 30fx
        end
    end)
    Bounce:SetUpdateCallback(function(entity_id)
        local Bounce = Entity.Entities[entity_id]
        if BounceDebounce > 0fx then
            BounceDebounce = BounceDebounce - 1fx
        end
        Bounce:SetScale((BounceDebounce+45fx)*size/45fx)
        InBounce:SetScale((BounceDebounce+45fx)*(size*(8fx/10fx))/45fx)
        InBounce2:SetScale((BounceDebounce+45fx)*(size*(6fx/10fx))/45fx)
    end)
    Bounce.InBounce = InBounce
    Bounce.InBounce2 = InBounce2

    return Bounce
end

return Bounce