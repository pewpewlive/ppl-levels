
local ws = {
  player_bullet = 1,
  pinky = 2,
  candy = 3,
  potato = 4,
  player_laser = 5,
}

local wp = {
  player_bullet = {
    recharge = 2,
    spread_angle = 0.256fx,
    angle_offset = 0.512fx,
  },
  pinky = {
    recharge = 0,
  },
  candy = {
    recharge = 1,
    dif_angle = 0.512fx,
    spread_angle = 0.128fx,
  },
  potato = {
    recharge = 3,
    spread_angle = 0.512fx,
  },
  player_laser = {
    recharge = 1,
    spread_angle = 0.256fx,
  },
}

local recharge = 0
local counter = 1
local ma, md, sa, sd

local maintain_weapon = {}

maintain_weapon[ws.player_bullet] = function(entity)
  if recharge > 0 then
    recharge = recharge - 1
  elseif sd ~= 0fx then
    local amount = __DEF_FMATH_TO_FX(counter % 5 // 2)
    for i = 0fx, amount, 1fx do
      player_bullet:create(PLAYER_X, PLAYER_Y, sa + __DEF_FMATH_RANDOM_FX(-1fx, 1fx) * wp.player_bullet.spread_angle + (i - amount / 2fx) * wp.player_bullet.angle_offset)
    end
    pewpew.play_ambient_sound(SOUNDS_PATH, 1)
    recharge = wp.player_bullet.recharge
    counter = counter + 1
  end
end

maintain_weapon[ws.pinky] = function(entity)
  if recharge > 0 then
    recharge = recharge - 1
  elseif sd ~= 0fx then -- PI_FX / 3fx = 1.193fx ; 2fx / 3fx * PI_FX = 2.384fx
    pinky:create(PLAYER_X, PLAYER_Y, sa + 1.193fx * __DEF_FMATH_TO_FX(counter % 4 + 2 * (counter % 2) - 1))
    pewpew.play_ambient_sound(SOUNDS_PATH, 2)
    recharge = wp.pinky.recharge
    counter = counter + 1
  end
end

maintain_weapon[ws.candy] = function(entity)
  if recharge > 0 then
    recharge = recharge - 1
  elseif sd ~= 0fx then
    local angle = __DEF_FMATH_RANDOM_FX(-1fx, 1fx) * wp.candy.spread_angle
    for i = -1fx, 1fx, 1fx do
      candy:create(PLAYER_X, PLAYER_Y, sa + wp.candy.dif_angle * i + __DEF_FMATH_RANDOM_FX(-1fx, 1fx) * wp.candy.spread_angle)
    end
    pewpew.play_ambient_sound(SOUNDS_PATH, 3)
    recharge = wp.candy.recharge
  end
end

maintain_weapon[ws.potato] = function(entity)
  if recharge > 0 then
    recharge = recharge - 1
  elseif sd ~= 0fx then
    potato:create(PLAYER_X, PLAYER_Y, sa + __DEF_FMATH_RANDOM_FX(-1fx, 1fx) * wp.potato.spread_angle)
    pewpew.play_ambient_sound(SOUNDS_PATH, 4)
    recharge = wp.potato.recharge
  end
end

maintain_weapon[ws.player_laser] = function(entity)
  if recharge > 0 then
    recharge = recharge - 1
  elseif sd ~= 0fx then
    player_laser:create(PLAYER_X, PLAYER_Y, sa + __DEF_FMATH_RANDOM_FX(-1fx, 1fx) * wp.player_laser.spread_angle, CURRENT_PLAYER_LASER_COLOR)
    pewpew.play_ambient_sound(SOUNDS_PATH, 11)
    recharge = wp.player_laser.recharge
  end
end

function maintain_player_weapon(entity)
  ma, md, sa, sd = pewpew.get_player_inputs(0)
  maintain_weapon[entity[i_weapon_state]](entity)
end

return ws
