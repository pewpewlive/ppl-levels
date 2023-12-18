
-- stuff related to modifying camera movement. Smoooth

local positions = {}
local x, y, z = 0fx, 0fx, 0fx

local function __NoEFunc(v)
  return 1fx
end

local function normalize(x, y) -- normalizes vector
  local l = __DEF_FMATH_SQRT(x * x + y * y)
  return x / l, y / l
end

local function normalizeA(x, y, r) -- normalize vector up to certain lenght
  local l = x * x + y * y -- lenght of vector squared
  local d = r * r -- maximum lenght squared
  if l > d then
    local sl = __DEF_FMATH_SQRT(l) -- lenght of vector
    x = x / sl * r
    y = y / sl * r
  end
  return x, y
end

local function process_free_mode() -- in free mode camera is controled by movement joystick and height is set to base_z
  local ma, md = pewpew.get_player_inputs(0)
  if md then
    local k = md * pplaf.camera.options.velocity
    local dy, dx = __DEF_FMATH_SINCOS(ma)
    dx, dy = normalizeA(dx * k, dy * k, pplaf.camera.options.velocity)
    x = pplaf.camera.options.current_x + dx
    y = pplaf.camera.options.current_y + dy
  end
end

local function adjust_camera_by_entites() -- calculates average position of respective entities according to set options
  local n = 0fx
  if pplaf.camera.options.following_type == pplaf.camera.following_types.entity then -- follow 1 entity
    x, y = pewpew.entity_get_position(pplaf.camera.options.following_param)
    return nil
  elseif pplaf.camera.options.following_type == pplaf.camera.following_types.entity_list then -- follow list of entity
    for _, id in ipairs(pplaf.camera.options.following_param) do
      local ex, ey = pewpew.entity_get_position(id)
      x, y = x + ex, y + ey
      n = n + 1fx
      table.insert(positions, {x, y})
    end
  elseif pplaf.camera.options.following_type == pplaf.camera.following_types.group then -- follow group
    for id, _ in pairs(pplaf.entity.get_group(pplaf.camera.options.following_param)) do
      local ex, ey = pewpew.entity_get_position(id)
      x, y = x + ex, y + ey
      n = n + 1fx
      table.insert(positions, {x, y})
    end
  elseif pplaf.camera.options.following_type == pplaf.camera.following_types.group_list then -- follow list of groups
    for _, group_name in ipairs(pplaf.camera.options.following_param) do
      for id, _ in pairs(pplaf.entity.get_group(group_name)) do
        local ex, ey = pewpew.entity_get_position(id)
        x, y = x + ex, y + ey
        n = n + 1fx
        table.insert(positions, {x, y})
      end
    end
  else -- follow every entity
    for _, group in pairs(pplaf.entity.get_entities()) do
      for id, _ in pairs(group) do
        local ex, ey = pewpew.entity_get_position(id)
        x, y = x + ex, y + ey
        n = n + 1fx
        table.insert(positions, {x, y})
      end
    end
  end
  x = x / n
  y = y / n
  for _, pos in ipairs(positions) do -- this is where the fun begins
    local tx, ty = pos.x, pos.y
    local dx = tx - x
    local dy = ty - y -- calculate distance to every entity
    local l = dx * dx + dy * dy
    if l > z then z = l end -- take the biggest one
  end
  z = z * pplaf.camera.options.z_distance_ratio -- apply ratio and it will be additional distance; might work, idk
end

local function apply_position_modifications() -- camera position modifications
  
  local ma, md, sa, sd = pewpew.get_player_inputs(0) -- get joystick inputs
  if md ~= 0fx then -- movement joystick is used
    if pplaf.camera.options.movement_offset then -- movement joystick offset set
      local dy, dx = __DEF_FMATH_SINCOS(ma)
      x = x + dx * md * pplaf.camera.options.movement_offset
      y = y + dy * md * pplaf.camera.options.movement_offset
    end
    if pplaf.camera.options.movement_z_offset then -- movement joystick z offset set
      z = z + md * pplaf.camera.options.movement_z_offset
    end
  end
  if sd ~= 0fx then -- shooting joystick is used
    if pplaf.camera.options.shooting_offset then -- shooting joystick offset set
      local dy, dx = __DEF_FMATH_SINCOS(sa)
      x = x + dx * sd * pplaf.camera.options.shooting_offset
      y = y + dy * sd * pplaf.camera.options.shooting_offset
    end
    if pplaf.camera.options.shooting_z_offset then -- shooting joystick z offset set
      z = z + sd * pplaf.camera.options.shooting_z_offset
    end
  end
  
  if pplaf.camera.options.offset_x then
    x = x + pplaf.camera.options.offset_x
  end
  if pplaf.camera.options.offset_y then
    y = y + pplaf.camera.options.offset_y
  end
  if pplaf.camera.options.offset_z then
    z = z + pplaf.camera.options.offset_z
  end
  
  if pplaf.camera.options.min_x and x < pplaf.camera.options.min_x then
    x = pplaf.camera.options.min_x
  end
  if pplaf.camera.options.min_y and y < pplaf.camera.options.min_y then
    y = pplaf.camera.options.min_y
  end
  if pplaf.camera.options.min_z and z < pplaf.camera.options.min_z then
    z = pplaf.camera.options.min_z
  end
  
  if pplaf.camera.options.max_x and x > pplaf.camera.options.max_x then
    x = pplaf.camera.options.max_x
  end
  if pplaf.camera.options.max_y and y > pplaf.camera.options.max_y then
    y = pplaf.camera.options.max_y
  end
  if pplaf.camera.options.max_z and z > pplaf.camera.options.max_z then
    z = pplaf.camera.options.max_z
  end
  
  if pplaf.camera.options.static_x then
    x = pplaf.camera.options.static_x
  end
  if pplaf.camera.options.static_y then
    y = pplaf.camera.options.static_y
  end
  if pplaf.camera.options.static_z then
    z = pplaf.camera.options.static_z
  end
  
end

local function ease_xy() -- ease xy
  local dx = x - pplaf.camera.options.current_x
  local dy = y - pplaf.camera.options.current_y
  local __l = dx * dx + dy * dy -- lenght squared
  if __l == 0fx then -- no changes to be done
    return nil
  end
  local l = __DEF_FMATH_SQRT(__l) -- lenght
  local ease_distance = pplaf.camera.options.ease_distance
  local velocity = pplaf.camera.options.velocity
  local k = 1fx -- ease ratio
  if l < ease_distance then -- if lenght is lower than ease distance, apply ease function
    k = pplaf.camera.options.ease_function(l / ease_distance)
  end
  if l > velocity then -- if needed, normalize position change
    dx = dx / l * velocity
    dy = dy / l * velocity
  end
  x = pplaf.camera.options.current_x + dx * k -- now x, y are target coordinates
  y = pplaf.camera.options.current_y + dy * k
end

local function ease_z() -- ease z
  local dz = z - pplaf.camera.options.current_z
  if dz == 0fx then -- no changes to be done
    return nil
  end
  local adz = dz > 0fx and dz or -dz -- absolute value of z distance
  local ease_distance = pplaf.camera.options.ease_distance
  local velocity = pplaf.camera.options.velocity
  local k = 1fx -- ease ratio
  if adz < ease_distance then -- if distance is lower than ease distance, apply ease function
    k = pplaf.camera.options.ease_function(adz / ease_distance)
  end
  if adz > velocity then -- normalize to velocity if required
    dz = dz / adz * velocity
  end
  z = pplaf.camera.options.current_z + dz * k
end

pplaf.camera = {
  
  following_types = { -- types of camera alignment depending on entities
    entity = 100,
    entity_list = 101,
    group = 200,
    group_list = 201,
    all = 300
  },
  
  options = {
  
    current_x          = 0fx       , -- camera current position
    current_y          = 0fx       ,
    current_z          = 0fx       , -- strange one, because base camera distance in pewpew isn't 0fx
    
    static_x           = nil       , -- camera static position(if nil, respective axis aren't static)
    static_y           = nil       , -- static position ignores minimum and maximum limitations
    static_z           = nil       ,
    
    offset_x           = nil       , -- camera offset from actual calculated position
    offset_y           = nil       ,
    offset_z           = nil       ,
    
    min_x              = nil       , -- minimum camera position(if not nil)
    min_y              = nil       ,
    min_z              = nil       ,
    
    max_x              = nil       , -- maximum camera position(if not nil)
    max_y              = nil       ,
    max_z              = nil       ,
    
    base_z             = 1000fx    , -- basic camera z coordinate
    z_distance_ratio   = 0.128fx   , -- ratio of height and max distance between 2 entities, used to configure camera z coordinate
    
    movement_offset    = nil       , -- maximum camera offset while using movement joystick(if number)
    movement_z_offset  = nil       , -- maximum camera z offset while using movement joystick(if number)
    shooting_offset    = nil       , -- maximum camera offset while using shooting joystick(if number)
    shooting_z_offset  = nil       , -- maximum camera z offset while using shooting joystick(if number)
    
    following_type     = 100       , -- following type, according to following_types; defines which entities will be counted while centering camera 
    following_param    = 1         , -- entity id / group name / array / nil according to following type
    
    ease_function      = __NoEFunc , -- ease function, used to smooth camera position; [0;1] -> [0;1]; if ranges aren't correct, you will see strange behaviour
    ease_distance      = 200fx     , -- while camera is in this distance from target position, ease function will be applied
    
    velocity           = 20fx      , -- maximum velocity
    free_mode          = nil       , -- if true, you control camera without limitations, using movement joystick
    
  },
  
  configure = function(options) -- configure camera options
    for setting, value in pairs(options) do
      pplaf.camera.options[setting] = value
    end
    if not options.following_type then
      return nil
    end
    local following_type_index = pplaf.camera.following_types[options.following_type] -- if input is type name, it will be replaced with corresponding index
    if following_type_index then
      pplaf.camera.options.following_type = following_type_index
    end
  end,
  
  main = function() -- camera position calculations
    x, y, z = 0fx, 0fx, 0fx -- reset coordinates
    positions = {}
    if pplaf.camera.options.free_mode then -- if free_mode is true, control camera by movement joystick
      process_free_mode()
    else -- otherwise calculate camera position
      if pplaf.camera.options.static_x and
         pplaf.camera.options.static_y and
         pplaf.camera.options.static_z then -- if all coordinates are static, don't calculate anything and approach static coordinate
        x = pplaf.camera.options.static_x
        y = pplaf.camera.options.static_y
        z = pplaf.camera.options.static_z
      else -- otherwise calculate target position
        adjust_camera_by_entites()
        apply_position_modifications()
      end
      ease_xy() -- if free_mode isn't active, camera xy movement will be eased
    end
    ease_z() -- z axis is always eased
    pplaf.camera.options.current_x = x
    pplaf.camera.options.current_y = y
    pplaf.camera.options.current_z = z
    pewpew.configure_player(0, {
      camera_x_override = pplaf.camera.options.current_x,
      camera_y_override = pplaf.camera.options.current_y,
      camera_distance   = pplaf.camera.options.base_z + pplaf.camera.options.current_z - 1000fx,
    })
  end,
  
}

--[[
  
  calculating cemera position:
    
    z axis calculated separately, from x, y axis
  
  
  
  +   smooth camera             - camera moves smoothly to target point
  
  /   different movement types  - different/custom camera smooth movement variants
  
  +   static x/y                - keep camera in certain point
  
  +   joystick offset           - offsets camera depending on joysticks
  
  -   joystick color offset     - changes joystick colors depending on joysticks; seems more like hud thing, not camera
  
  +   entity aligned camera     - centers camera depending on certain entity groups
  
]]--
