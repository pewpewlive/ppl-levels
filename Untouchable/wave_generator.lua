
BONUS_LIST = {
  BONUS_TYPES.pinky,
  BONUS_TYPES.shield,
  BONUS_TYPES.potato,
  BONUS_TYPES.shield,
  BONUS_TYPES.player_laser,
  BONUS_TYPES.shield,
  BONUS_TYPES.candy,
}

BONUS_COUNTER = 0
BOMB_COUNTER = 0

BONUS_TIMER = 650
BOMB_TIMER = 800

BONUS_SPAWN_LOCATIONS = {
  {400fx , 400fx},
  {800fx, 400fx},
}
SPAWN_OFFSET = 40fx

function spawn_bonuses()
  if TIME % BONUS_TIMER == 0 then
    local location = BONUS_SPAWN_LOCATIONS[__DEF_FMATH_RANDOM_INT(1, #BONUS_SPAWN_LOCATIONS)]
    bonus:create(location[1] + __DEF_FMATH_RANDOM_FX(-SPAWN_OFFSET, SPAWN_OFFSET), location[2] + __DEF_FMATH_RANDOM_FX(-SPAWN_OFFSET, SPAWN_OFFSET), BONUS_LIST[BONUS_COUNTER % #BONUS_LIST + 1])
    BONUS_COUNTER = BONUS_COUNTER + 1
  end
  if TIME % BOMB_TIMER == 0 then
    local location = BONUS_SPAWN_LOCATIONS[__DEF_FMATH_RANDOM_INT(1, #BONUS_SPAWN_LOCATIONS)]
    bomb:create(location[1] + __DEF_FMATH_RANDOM_FX(-SPAWN_OFFSET, SPAWN_OFFSET), location[2] + __DEF_FMATH_RANDOM_FX(-SPAWN_OFFSET, SPAWN_OFFSET), BOMB_COUNTER % 2)
    BOMB_COUNTER = BOMB_COUNTER + 1
  end
end

SENTRY_SPAWN_LIST = {
  SENTRY_VARIATIONS.constant,
  SENTRY_VARIATIONS.shotgun,
  SENTRY_VARIATIONS.stalker,
  SENTRY_VARIATIONS.rotating_chain,
  SENTRY_VARIATIONS.rotating,
  SENTRY_VARIATIONS.face,
  SENTRY_VARIATIONS.homing,
  SENTRY_VARIATIONS.constant,
  SENTRY_VARIATIONS.rotating,
  SENTRY_VARIATIONS.chain,
}

-- SENTRY_VARIATIONS.constant,
-- SENTRY_VARIATIONS.chain,
-- SENTRY_VARIATIONS.rotating,
-- SENTRY_VARIATIONS.rotating_chain,
-- SENTRY_VARIATIONS.shotgun,
-- SENTRY_VARIATIONS.face,
-- SENTRY_VARIATIONS.stalker,
-- SENTRY_VARIATIONS.homing,

CUBE_SPEED = 1fx

CUBE_SPAWN_LOCATIONS = {
  {300fx, 100fx, 0fx, CUBE_SPEED},
  {900fx, 700fx, 0fx, -CUBE_SPEED},
  {1100fx, 300fx, -CUBE_SPEED, 0fx},
  {100fx, 700fx, 0fx, -CUBE_SPEED},
  {700fx, 100fx, 0fx, CUBE_SPEED},
  {100fx, 500fx, CUBE_SPEED, 0fx},
  {1100fx, 100fx, 0fx, CUBE_SPEED},
  {500fx, 700fx, 0fx, -CUBE_SPEED},
}

ENEMY_SPAWN_X_MIN = 40fx
ENEMY_SPAWN_Y_MIN = 40fx
ENEMY_SPAWN_X_MAX = LEVEL_SIZE_X - 40fx
ENEMY_SPAWN_Y_MAX = LEVEL_SIZE_Y - 40fx

SENTRY_SPAWN_COUNTER = 0
CUBE_SPAWN_COUNTER = 0
WAVE_SPAWN_COUNTER = 0

CUBE_SPAWN_TIMER = 1200
CUBE_SPAWN_DECREMENT_TIMER = 1200

STAR_SPAWN_TIMER = 300

SENTRY_LIMIT = 7
SENTRY_LIMIT_DECREMENT_TIMER = 720
ADDITIONAL_SENTRY_SPAWN_TIMER = 300

function spawn_enemies()
  if TIME % CUBE_SPAWN_TIMER == 0 then
    local x, y, dx, dy = table.unpack(CUBE_SPAWN_LOCATIONS[CUBE_SPAWN_COUNTER % #CUBE_SPAWN_LOCATIONS + 1])
    cube:create(x, y, dx, dy)
    CUBE_SPAWN_COUNTER = CUBE_SPAWN_COUNTER + 1
  end
  if TIME % STAR_SPAWN_TIMER == 0 then
    star.hp = star.hp + 0.2048fx
    star:create(__DEF_FMATH_RANDOM_FX(ENEMY_SPAWN_X_MIN, ENEMY_SPAWN_X_MAX), __DEF_FMATH_RANDOM_FX(ENEMY_SPAWN_Y_MIN, ENEMY_SPAWN_Y_MAX))
  end
  if TIME % CUBE_SPAWN_DECREMENT_TIMER == 0 then
    cube.hp = cube.hp + 8fx
  end
  
  if (TIME % 15 == 0 and sentry_counter < SENTRY_LIMIT) or (sentry_counter < 12 and TIME % ADDITIONAL_SENTRY_SPAWN_TIMER == 180) then
    local x = __DEF_FMATH_RANDOM_FX(ENEMY_SPAWN_X_MIN, ENEMY_SPAWN_X_MAX)
    local y = __DEF_FMATH_RANDOM_FX(ENEMY_SPAWN_Y_MIN, ENEMY_SPAWN_Y_MAX)
    sentry:create(x, y, SENTRY_SPAWN_LIST[SENTRY_SPAWN_COUNTER % #SENTRY_SPAWN_LIST + 1])
    if TIME % 600 < 400 then
      SENTRY_SPAWN_COUNTER = SENTRY_SPAWN_COUNTER + 1
    end
  end
  if TIME % SENTRY_LIMIT_DECREMENT_TIMER == 0 then
    SENTRY_LIMIT = SENTRY_LIMIT + 1
    for _, sentry_variation in pairs(SENTRY_TYPES) do
      sentry_variation.recharge = sentry_variation.recharge - 1
    end
    enemy_projectile.speed = enemy_projectile.speed + 0.128fx
  end
end

function wave_generator()
  spawn_bonuses()
  spawn_enemies()
end
