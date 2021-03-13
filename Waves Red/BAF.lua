local AdvancedEntity = require("/dynamic/Modules/Enemy.lua")
local Vector2 = require("/dynamic/Modules/Vector2.lua")

local BAFEntity = {}


function CreateExplosion(x,y)
    pewpew.create_explosion(x, y, 0xff0000ff, 1fx, 40)
end

function ThrowAway(BAF)
    BAF:SetUpdateCallback()
    BAF:PlayerCollision()
    BAF:WallCollision()
    BAF:WeaponCollision()
end

function BAFEntity.new_horizontal(x, y, health, speed, lifetime, direction,game)

    local BAF = AdvancedEntity:New(x,y)
    table.insert(game.BAFs,BAF)
    BAF.MoveVector = Vector2.new()
    BAF.Health = health
    BAF.Lifetime = lifetime
    local CurrentDirection = direction
    BAF.MoveVector.Y = 0fx 
    if CurrentDirection == "LEFT" then
       BAF.MoveVector.X = -1fx
       BAF:SetMesh("/dynamic/BAF_Mesh.lua",fmath.random_int(4,7))
    elseif CurrentDirection == "RIGHT" then
        BAF.MoveVector.X = 1fx
        BAF:SetMesh("/dynamic/BAF_Mesh.lua",fmath.random_int(0,3))
    end

    BAF.MoveVector = BAF.MoveVector * speed
    BAF:SetMovementInterpolation(true)
    BAF:SetVisibilityRadius(15fx)
    BAF:SetColor(0xff0000ff)
    BAF:SetRadius(15fx)
    BAF:StartSpawning(30)
    local angle = 0fx
    local wait = 30
    local DeathDebounce = true
    BAF:SetUpdateCallback(function(entity)
        local BAF = AdvancedEntity.Entities[entity]
        if wait > 0 then
            wait = wait - 1
        else
            if BAF.Lifetime > 0 then
                
                BAF.Lifetime = BAF.Lifetime - 1
            elseif BAF.Lifetime == 0 and DeathDebounce then
                for i, v in pairs(game.BAFs) do
                    if v == BAF then
                        table.remove(game.BAFs,i)
                        break
                    end
                end
                DeathDebounce = false
                ThrowAway(BAF)
                BAF:StartExploding(5)
                AdvancedEntity.Entities[entity] = nil
            end
            if BAF.Hurt > 0 then
                BAF.Hurt = BAF.Hurt - 1
                BAF:SetColor(0xffb3b3ff)
            else
                BAF:SetColor(0xff0000ff)
            end
            
            angle = angle + fmath.tau()/30fx

            
            if BAF.Health <= 0 and DeathDebounce then
                DeathDebounce = false
                for i, v in pairs(game.BAFs) do
                    if v == BAF then
                        table.remove(game.BAFs,i)
                        break
                    end
                end
                BAF:StartExploding(30)
                ThrowAway(BAF)
                local x,y = BAF:GetPosition()
                CreateExplosion(x,y)
                AdvancedEntity.Entities[entity] = nil
            elseif BAF.Health > 0 then
                BAF:Move()
                BAF:SetAngle(angle, 1fx, 0fx, 0fx)
            end
        end
    end)

    BAF:WallCollision(true,function(entity)
        local BAF = AdvancedEntity.Entities[entity]
        if CurrentDirection == "LEFT" then
            CurrentDirection = "RIGHT"
            BAF:SetMesh("/dynamic/BAF_Mesh.lua",fmath.random_int(0,3))
        elseif CurrentDirection == "RIGHT" then
            CurrentDirection = "LEFT"
            BAF:SetMesh("/dynamic/BAF_Mesh.lua",fmath.random_int(4,7))
        end
        BAF.MoveVector.X = -BAF.MoveVector.X
    end)
    BAF:WeaponCollision(function(entity,player_id,weapontype)
        local BAF = AdvancedEntity.Entities[entity]
    
        if BAF.Health > 0 and wait == 0 and weapontype == 0 then
            local x,y = BAF:GetPosition()
            pewpew.play_sound("/dynamic/sounds.lua",6,x,y)
            pewpew.increase_score_of_player(player_id,15)
            BAF.Health = BAF.Health - 1
            BAF.Hurt = 10
            return true
        elseif BAF.Health > 0 and wait == 0 and weapontype > 0 then
            BAF.Health = 0
            pewpew.increase_score_of_player(player_id,30)
            return true
        end
    end)

    BAF:PlayerCollision(function(entity,player_id,ship_id)
        local BAF = AdvancedEntity.Entities[entity]
        pewpew.add_damage_to_player_ship(ship_id,1)
        for i, v in pairs(game.BAFs) do
            if v == BAF then
                table.remove(game.BAFs,i)
                break
            end
        end
        BAF:StartExploding(30)
        ThrowAway(BAF)
        
        local x,y = BAF:GetPosition()
        CreateExplosion(x,y)
        AdvancedEntity.Entities[entity] = nil
    end)

    return BAF

end

function BAFEntity.new_vertical(x, y, health, speed, lifetime, direction,game)

    local BAF = AdvancedEntity:New(x,y)
    table.insert(game.BAFs,BAF)
    BAF.MoveVector = Vector2.new()
    BAF.Health = health
    BAF.Lifetime = lifetime
    local CurrentDirection = direction
    BAF.MoveVector.X = 0fx 
    if CurrentDirection == "UP" then
       BAF.MoveVector.Y = 1fx
       BAF:SetMesh("/dynamic/BAF_Mesh.lua",fmath.random_int(8,11))
    elseif CurrentDirection == "DOWN" then
        BAF.MoveVector.Y = -1fx
        BAF:SetMesh("/dynamic/BAF_Mesh.lua",fmath.random_int(12,15))
    end

    local DeathDebounce = true
    local wait = 30
    BAF.MoveVector = BAF.MoveVector * speed
    BAF:SetMovementInterpolation(true)
    BAF:SetVisibilityRadius(15fx)
    BAF:SetColor(0xff0000ff)
    BAF:SetRadius(15fx)
    BAF:StartSpawning(30)
    local angle = 0fx
    BAF:SetUpdateCallback(function(entity)
        local BAF = AdvancedEntity.Entities[entity]
        if wait > 0 then
            wait = wait - 1
        else
            if BAF.Lifetime > 0 then
                BAF.Lifetime = BAF.Lifetime - 1
            elseif BAF.Lifetime == 0 and DeathDebounce then
                DeathDebounce = false
                for i, v in pairs(game.BAFs) do
                    if v == BAF then
                        table.remove(game.BAFs,i)
                        break
                    end
                end
                BAF:StartExploding(5)
                ThrowAway(BAF)
                AdvancedEntity.Entities[entity] = nil
            end
            if BAF.Hurt > 0 then
                BAF.Hurt = BAF.Hurt - 1
                BAF:SetColor(0xffb3b3ff)
            else
                BAF:SetColor(0xff0000ff)
            end
            
            angle = angle + fmath.tau()/30fx

            
            if BAF.Health <= 0 and DeathDebounce then
                DeathDebounce = false
                for i, v in pairs(game.BAFs) do
                    if v == BAF then
                        table.remove(game.BAFs,i)
                        break
                    end
                end
                BAF:StartExploding(30)
                ThrowAway(BAF)
                
                local x,y = BAF:GetPosition()
                CreateExplosion(x,y)
                AdvancedEntity.Entities[entity] = nil
            elseif BAF.Health > 0 then
                BAF:Move()
                BAF:SetAngle(angle, 0fx, 1fx, 0fx)
            end
        end
    end)

    BAF:WallCollision(true,function(entity)
        local BAF = AdvancedEntity.Entities[entity]
        if CurrentDirection == "UP" then
            CurrentDirection = "DOWN"
            BAF:SetMesh("/dynamic/BAF_Mesh.lua",fmath.random_int(12,15))
        elseif CurrentDirection == "DOWN" then
            CurrentDirection = "UP"
            BAF:SetMesh("/dynamic/BAF_Mesh.lua",fmath.random_int(8,11))
        end
        BAF.MoveVector.Y = -BAF.MoveVector.Y
    end)

    BAF:WeaponCollision(function(entity,player_id,weapontype)
        local BAF = AdvancedEntity.Entities[entity]
    
        if BAF.Health > 0 and wait == 0 and weapontype == 0 then
            local x,y = BAF:GetPosition()
            pewpew.play_sound("/dynamic/sounds.lua",6,x,y)
            pewpew.increase_score_of_player(player_id,15)
            BAF.Health = BAF.Health - 1
            BAF.Hurt = 10
            return true
        elseif BAF.Health > 0 and wait == 0 and weapontype > 0 then
            BAF.Health = 0
            pewpew.increase_score_of_player(player_id,30)
            return true
        end
    end)

    BAF:PlayerCollision(function(entity,player_id,ship_id)
        local BAF = AdvancedEntity.Entities[entity]
        pewpew.add_damage_to_player_ship(ship_id,1)
        for i, v in pairs(game.BAFs) do
            if v == BAF then
                table.remove(game.BAFs,i)
                break
            end
        end
        BAF:StartExploding(30)
        ThrowAway(BAF)
        local x,y = BAF:GetPosition()
        CreateExplosion(x,y)
        AdvancedEntity.Entities[entity] = nil
    end)

    return BAF

end

return BAFEntity