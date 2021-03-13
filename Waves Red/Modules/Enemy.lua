local Vector2 = require("/dynamic/Modules/Vector2.lua")

--[[
FUNCTIONS LIST

    enemy:GetPosition()

    enemy:SetPosition(x,y) ; Leaving a parameter blank or nil will default to 0fx!

    enemy:SetMovementInterpolation(boolean)

    enemy:SetMesh(string_path, path_index)

    enemy:FlipMesh(string_path, path_index1, path_index2)

    enemy:SetRadius(radius)

    enemy:SetColor(Color)

    enemy:SetString(string)

    enemy:SetZ(z)

    enemy:SetScale(scale)

    enemy:SetAngle(Angle, xAxis, yAxis, zAxis)

    enemy:SetUpdateCallback(UpdateCallback)

    enemy:WallCollision(Boolean, CollisionCallback)

    enemy:PlayerCollision(CollisionCallback)

    enemy:WeaponCollision(CollisionCallback)

    enemy:GetAlive()

    enemy:GetIsDestroying()

    enemy:StartSpawning(time)

    enemy:StartExploding(time)
]]


local enemy = {EntityId = 0}
enemy.__index = enemy
enemy.Entities = {}



function enemy:New(x,y) -- x and y are both fixed point numbers
    local NewEnemy = setmetatable({EntityId = pewpew.new_customizable_entity(x or 0fx,y or 0fx)}, enemy)
    enemy.Entities[NewEnemy.EntityId] = NewEnemy
    return NewEnemy
end

function enemy:ThrowAway()
    self:SetUpdateCallback()
    self:PlayerCollision()
    self:WeaponCollision()
    enemy.Entities[self.EntityId] = nil
end

function enemy:SetPosition(x,y) -- x and y are both fixed point numbers
    local ex = x or 0fx
    local ey = y or 0fx
    pewpew.entity_set_position(self.EntityId, ex, ey)
end

function enemy:SetVisibilityRadius(radius)
    pewpew.customizable_entity_set_visibility_radius(self.EntityId, radius)
end

function enemy:SetMovementInterpolation(boolean)
    local Interpolation = boolean or false
    pewpew.customizable_entity_set_position_interpolation(self.EntityId, Interpolation)
end

function enemy:SetMesh(string_path, path_index) -- string_path is a string value and path_index is an integer number
    local path = string_path or ""
    local index = path_index or 0
    pewpew.customizable_entity_set_mesh(self.EntityId, path, index)
end

function enemy:FlipMesh(string_path, path_index1, path_index2) -- string_path is a string value and path_index1 and path_index2 are integer numbers
    local path = string_path or ""
    local FirstIndex = path_index1 or 0
    local SecondIndex = path_index2 or 1
    pewpew.customizable_entity_set_flipping_meshes(self.EntityId, path, FirstIndex, SecondIndex)
end

function enemy:SetUpdateCallback(UpdateCallback)
    local CallbackFunction = UpdateCallback or nil
    pewpew.entity_set_update_callback(self.EntityId, CallbackFunction)
end

function enemy:GetPosition(choice)
    local Choice = choice or false
    if Choice then
        local x,y = pewpew.entity_get_position(self.EntityId)
        return Vector2.new(x,y)
    else
        return pewpew.entity_get_position(self.EntityId)
    end
end

function enemy:GetAlive()
    return pewpew.entity_get_is_alive(self.EntityId)
end

function enemy:GetIsDestroying()
    return pewpew.entity_get_is_started_to_be_destroyed(self.EntityId)
end

function enemy:SetRadius(radius) -- radius is a fixed point number
    local Radius = radius or 1fx
    pewpew.entity_set_radius(self.EntityId, Radius)
end

function enemy:SetColor(Color) -- Color is an integer number
    local color = Color or 0xffffffff
    pewpew.customizable_entity_set_mesh_color(self.EntityId, Color)
end

function enemy:SetString(string)
    local String = string or ""
    pewpew.customizable_entity_set_string(self.EntityId, String)
end

function enemy:SetZ(z) -- z is a fixed point number
    local Z = z or 0fx
    pewpew.customizable_entity_set_mesh_z(self.EntityId, Z)
end

function enemy:SetScale(scale) -- scale is a fixed point number
    local Scale = scale or 1fx
    pewpew.customizable_entity_set_mesh_scale(self.EntityId, Scale)
end

function enemy:SetAngle(Angle, xAxis, yAxis, zAxis) -- All four parameters are fixed point numbers
    local angle = Angle or 0fx
    local x = xAxis or 0fx
    local y = yAxis or 0fx
    local z = zAxis or 0fx
    pewpew.customizable_entity_set_mesh_angle(self.EntityId,angle, x, y, z)
end

function enemy:WallCollision(Boolean, CollisionCallback)
    local boolean = Boolean or false
    local CallbackFunction = CollisionCallback or nil
    pewpew.customizable_entity_configure_wall_collision(self.EntityId, boolean, CallbackFunction)
end

function enemy:PlayerCollision(CollisionCallback)
    local CallbackFunction = CollisionCallback or nil
    pewpew.customizable_entity_set_player_collision_callback(self.EntityId, CallbackFunction)
end

function enemy:WeaponCollision(CollisionCallback)
    local CallbackFunction = CollisionCallback or nil
    pewpew.customizable_entity_set_weapon_collision_callback(self.EntityId, CallbackFunction)
end

function enemy:StartSpawning(time) -- time is an integer number
    local Time = time or 0
    pewpew.customizable_entity_start_spawning(self.EntityId, Time)
end

function enemy:StartExploding(time) -- time is an integer number
    local Time = time or 0
    pewpew.customizable_entity_start_exploding(self.EntityId, Time)
end

enemy.Health = 0
enemy.Hurt = 0
enemy.MoveVector = Vector2.new()
enemy.SineAngle = 0fx
enemy.ZigZagLength = 0
enemy.Speed = 0fx

function enemy:Shoot()

end

function enemy:Move()
    local x, y = self:GetPosition()
    self:SetPosition(x + self.MoveVector.X, y + self.MoveVector.Y)
end

function enemy:MoveTo(MoveConfigs)
    local Point = MoveConfigs.Point or Vector2.new()
    local x,y = self:GetPosition()
    local Position = Vector2.new(x,y)

    
    local Vector = Point:Subtract(Position)
    if Point.Magnitude> 1fx/10fx then
        local Direct = Point:Unit()
        self.MoveVector = Direct:Multiply(self.Speed)

        self:SetPosition(x + self.MoveVector.X, y + self.MoveVector.Y)
    end
end

function enemy:SineMove(MoveConfigs)
    local Amplitude = MoveConfigs.Amplitude or 1fx
    local Period = MoveConfigs.Period or 1fx
    local x, y = self:GetPosition()
    local Normal = self.MoveVector.Normal
    local sin, cos = fmath.sincos(self.SineAngle)

    sin = sin * Amplitude
    self:SetPosition(x + self.MoveVector.X + Normal.X * sin, y + self.MoveVector.Y + Normal.Y * sin)
    self.SineAngle = self.SineAngle + fmath.tau()/Period
end

function enemy:SineMoveTo(MoveConfigs)
    local Point = MoveConfigs.Point or Vector2.new()
    local Amplitude = MoveConfigs.Amplitude or 1fx
    local Period = MoveConfigs.Period or 1fx
    local x, y = self:GetPosition()
    local Vector = Point - Vector2.new(x,y)

    local distance = Vector:Magnitude()
    local Direction = Vector:Unit()
    local Magnitude = self.MoveVector:Magnitude()
    self.MoveVector = Direction * self.Speed


    local Normal = self.MoveVector:Normal()
    local sin, cos = fmath.sincos(self.SineAngle)

    if distance > 1fx/10fx then
        sin = sin * Amplitude
        self:SetPosition(x + self.MoveVector.X + Normal.X * sin, y + self.MoveVector.Y + Normal.Y * sin)
        self.SineAngle = self.SineAngle + fmath.tau()/Period
    end
end

function enemy:ZigZagMove(MoveConfigs)
    local length = MoveConfigs.Length or 10
    local x, y = self:GetPosition()
    local Normal = self.MoveVector.Normal:Clone()
    if self.ZigZagLength < length then
        self.ZigZagLength = self.ZigZagLength%(length*2) + 1
    elseif self.ZigZagLength < length * 2 then
        self.ZigZagLength = self.ZigZagLength%(length*2) + 1
        Normal = Normal:Rotate(fmath.tau()/4fx)
    else
        self.ZigZagLength = 0
    end
    
    self:SetPosition(x + self.MoveVector.X + Normal.X, y + self.MoveVector.Y + Normal.Y)
end

function enemy:ZigZagMoveTo(MoveConfigs)
    local Point = MoveConfigs.Point or Vector2.new()
    local length = MoveConfigs.Length or 30
    local x, y = self:GetPosition()
    local Normal = self.MoveVector.Normal:Clone()
    Point = Point:Subtract(Vector2.new(x,y))
    local Magnitude = self.MoveVector.Magnitude
    local Direction = Point.Unit
    self.MoveVector = Direction:Multiply(Magnitude)


    if self.ZigZagLength < length then
        self.ZigZagLength = self.ZigZagLength + 1
    elseif self.ZigZagLength < length * 2 then
        self.ZigZagLength = self.ZigZagLength + 1
        Normal = Normal:Rotate(fmath.tau()/4fx)
    else
        self.ZigZagLength = 0
    end
    
    self:SetPosition(x + self.MoveVector.X + Normal.X, y + self.MoveVector.Y + Normal.Y)
end

function enemy:Circle(MoveConfigs)
    local x, y = self:GetPosition()
    local Time = MoveConfigs.Time or 1fx
    Time = Time * 30fx
    local Angle = fmath.tau()/Time
    self.MoveVector = self.MoveVector:Rotate2(Angle)
    self:SetPosition(x + self.MoveVector.X, y + self.MoveVector.Y)
end

function enemy:CircleAround(self,MoveConfigs)
    
end

function enemy:Accelerate(self,MoveConfigs)

end

function enemy:AccelerateTo(self,MoveConfigs)

end

function enemy:PointMoveOrdered(self,MoveConfigs)

end

function enemy:PointMoveRandom(self,MoveConfigs)

end

function enemy:TakeDamage(damage)
    self.Health = self.Health - damage
end


return enemy