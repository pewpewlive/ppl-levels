--[[
FUNCTIONS LIST


]]

Vector2 = {}
Vector2.__index = Vector2

function Vector2.new(x,y)
    return setmetatable({X = x or 1fx, Y = y or 1fx}, Vector2)
end
function Vector2:Magnitude()
    return fmath.sqrt(self.X*self.X+self.Y*self.Y)
end
function Vector2:Unit()
    return setmetatable({X = self.X/self:Magnitude(), Y = self.Y/self:Magnitude()}, Vector2)
end
function Vector2:Normal()
    return setmetatable({X = -self.Y, Y = self.X}, Vector2)
end

function Vector2.__mul(arg1,arg2)
    if type(arg1) == "number" then
        return Vector2.new(arg2.X*arg1,arg2.Y*arg1)
    elseif type(arg2) == "number" then
        return Vector2.new(arg1.X*arg2,arg1.Y*arg2)
    else
        return Vector2.new(arg1.X * arg2.X ,arg1.Y * arg2.Y)
    end
end

function Vector2.__div(arg1,arg2)
    if type(arg2) == "number" then
        return Vector2.new(arg1.X/arg2,arg1.Y/arg2)
    elseif type(arg1) == 'number' then
        pewpew.print("ERROR: DON'T DIVIDE NUMBY BY VECTOR")
    else
        return Vector2.new(arg1.X / arg2.X ,arg1.Y / arg2.Y)
    end
end

function Vector2.__unm(vector)
    return Vector2.new(-vector.X,-vector.Y)
end

function Vector2.__add(arg1,arg2)
    if type(arg1) == 'number' or type(arg2) == 'number' then
        print("ERROR: ADD VECTOR AND VECTOR ONLY")
        return
    end
    return Vector2.new(arg1.X + arg2.X, arg1.Y + arg2.Y)
end

function Vector2.__sub(arg1,arg2)
    if type(arg1) == 'number' or type(arg2) == 'number' then
        print("ERROR: SUBTRACT VECTOR AND VECTOR ONLY")
        return
    end
    return Vector2.new(arg1.X - arg2.X, arg1.Y - arg2.Y)
end

function Vector2:Dot(vector)

    local X = self.X * vector.X
    local Y = self.Y * vector.Y

    return X+Y
end

function Vector2:Rotate(angle)
    local Vector1Length = Vector2.UnitFromAngle(angle)
    local Magnitude = self:Magnitude()

    local X = self.X * Vector1Length.X - self.Y * Vector1Length.Y
    local Y = self.X * Vector1Length.Y + self.Y * Vector1Length.X
    local Direction = self:Unit()
    
    return Direction * Magnitude
end

function Vector2:Rotate2(angle)
    local CurrentAngle = fmath.atan2(self.Y,self.X)
    local NewAngle = CurrentAngle + angle
    local Magnitude = self:Magnitude()
    local Vector = Vector2.UnitFromAngle(NewAngle)

    return Vector * Magnitude
end

function Vector2:SetAngle(angle)
    local Length = self:Magnitude()
    local sin, cos = fmath.sincos(angle)
    return Vector2.new(Length*cos,Length*sin)
end

function Vector2:SetLength(length)
    local Length = length or 0fx
    local Direction = self:Unit()
    return Direction * Length
end

-- r=d−2(d⋅n)n
function Vector2:Reflect(vector)
    local NormalVector = vector
    NormalVector = NormalVector * self:Dot(NormalVector)
    NormalVector = NormalVector * 2fx
    return self - NormalVector
end

function Vector2:Clone()
    return Vector2.new(self.X, self.Y)
end

function Vector2:Component(vector)
    local Component = self:Dot(vector.Unit)
    return Component
end

function Vector2:Projection(vector)
    local Component = self:Component(vector)
    local Projection = vector:Clone()
    
    return Projection * Component
end




function Vector2.UnitFromAngle(angle)
    local sin, cos = fmath.sincos(angle)
    return Vector2.new(cos,sin)
end

return Vector2