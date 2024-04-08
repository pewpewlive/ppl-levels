
ASSETS_PATH = '/dynamic/assets/'
SOUNDS_PATH = ASSETS_PATH .. 'sounds.lua'

GAME_STATE = true
TIME = 0

LEVEL_SIZE_X = 1200fx
LEVEL_SIZE_Y = 800fx
SPAWN_X = LEVEL_SIZE_X / 2fx
SPAWN_Y = LEVEL_SIZE_Y / 2fx
LEVEL_SIZE_XY_RATIO = LEVEL_SIZE_X / LEVEL_SIZE_Y
LEVEL_SIZE_YX_RATIO = LEVEL_SIZE_Y / LEVEL_SIZE_X

PLAYER_X = SPAWN_X
PLAYER_Y = SPAWN_Y

BONUS_TYPES = {
  pinky = 0,
  candy = 1,
  potato = 2,
  player_laser = 3,
  shield = 4,
}

BOMB_TYPES = {
  force = 0,
  destruction = 1,
}

LASER_COLORS = {
  0x40ffff00,
  0x40ff4000,
  0xff400000,
  0x8040ff00,
  0x4040ff00,
}

CURRENT_PLAYER_LASER_COLOR = LASER_COLORS[fmath.random_int(1, #LASER_COLORS)]
