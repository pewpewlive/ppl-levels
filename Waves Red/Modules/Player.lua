local Vector2 = require("/dynamic/Modules/Vector2.lua")
--[[
FUNCTIONS LIST

    PlayerShip:NewShip(x, y, player_index)

    PlayerShip:ConfigureWeapon(Freq, Cannontype, Duration)

    PlayerShip:ConfigurePlayer(Map)

    PlayerShip:GetInputs()

    PlayerShip:GetConfiguration()

    PlayerShip:GetAlive()
    
    PlayerShip:GetScore()

    PlayerShip:GetIsDestroying()

    PlayerShip:IncreaseScore(score)

    PlayerShip:AddDamage(Damage)

    PlayerShip:AddArrow(TargetId, color)

    PlayerShip:RemoveArrow(ArrowId)

    PlayerShip:MakeTransparent(TransparencyDuration)

    PlayerShip:SetPosition(x, y)

    PlayerShip:GetPosition(x, y)

    PlayerShip:SetRadius(Radius)

    PlayerShip:SetUpdateCallback(callback)
    
    PlayerShip:Destroy()


]]

local PlayerShip = {ShipId = 0, PlayerIndex = 0}
PlayerShip.__index = PlayerShip
PlayerShip.Players = {}
function PlayerShip:NewShip(player_index, x, y)
    local NewPlayer = setmetatable({ShipId = pewpew.new_player_ship(x or 0fx, y or 0fx, player_index), PlayerIndex = player_index}, self)
    PlayerShip.Players[NewPlayer.ShipId] = NewPlayer
    return NewPlayer
end

function PlayerShip:ConfigureWeapon(Freq, Cannontype, Duration) --  Map { enum CannonFrequency frequency, enum CannonType cannon, int duration } configuration
    local FREQ = Freq or self.Frequency or "FREQ_0"
    local CannonType = Cannontype or self.CannonType or "NONE"
    pewpew.configure_player_ship_weapon(self.ShipId, { frequency = pewpew.CannonFrequency[FREQ], cannon = pewpew.CannonType[CannonType], duration = Duration })
    self.Frequency = FREQ
    self.CannonType = CannonType
end

function PlayerShip:GetIsDestroying()
    return pewpew.entity_get_is_started_to_be_destroyed(self.ShipId)
end

function PlayerShip:GetInputs()
    return pewpew.get_player_inputs(self.PlayerIndex)
end

function PlayerShip:ConfigurePlayer(Map)  -- Map { Boolean has_lost, int shield, FixedPoint camera_distance, 
                                          -- FixedPoint camera_rotation_x_axis, int move_joystick_color, int shoot_joystick_color }
    pewpew.configure_player(self.PlayerIndex, Map)
end

function PlayerShip:GetConfiguration()
    return pewpew.get_player_configuration(self.PlayerIndex)
end

function PlayerShip:GetScore()
    return pewpew.get_score_of_player(self.PlayerIndex)
end

function PlayerShip:AddDamage(Damage) -- Damage is an integer value
    local damage = Damage or 0
    if pewpew.entity_get_is_alive(self.ShipId) then
        pewpew.add_damage_to_player_ship(self.ShipId, damage)
    end
end

function PlayerShip:AddArrow(TargetId, color)
    return pewpew.add_arrow_to_player_ship(self.ShipId, TargetId, color)
end

function PlayerShip:RemoveArrow(ArrowId)
    pewpew.remove_arrow_from_player_ship(self.ShipId, ArrowId)
end

function PlayerShip:MakeTransparent(TransparencyDuration)
    pewpew.make_player_ship_transparent(self.Shipid, TransparencyDuration)
end

function PlayerShip:GetAlive()
    return pewpew.entity_get_is_alive(self.ShipId)
end

function PlayerShip:SetPosition(x, y)
    local player_x = x or 0fx
    local player_y = y or 0fx
    pewpew.entity_set_position(self.ShipId, player_x, player_y)
end

function PlayerShip:GetPosition(choice)
    local Choice = choice or false
    if Choice then
        local x, y = pewpew.entity_get_position(self.ShipId)
        return Vector2.new(x,y)
    else
        return pewpew.entity_get_position(self.ShipId)
    end
end

function PlayerShip:SetRadius(Radius)
    local radius = Radius or 1fx
    pewpew.entity_set_radius(self.ShipId, radius)
end

function PlayerShip:SetUpdateCallback(callback)
    local Callback = callback or nil
    pewpew.entity_set_update_callback(self.ShipId, Callback)
end

function PlayerShip:Destroy()
    pewpew.entity_destroy(self.ShipId)
    self:SetUpdateCallback()
    PlayerShip.Players[self.ShipId] = nil
    self = nil
end

function PlayerShip:IncreaseScore(score)
    local Score = score or 0
    pewpew.increase_score_of_player(self.PlayerIndex, Score)
end

return PlayerShip