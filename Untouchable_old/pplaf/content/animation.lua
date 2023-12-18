
-- allows you to create animation types and automatically maintain related stuff

local action_list = {}

local function modify_animation_type(animation_type)
  if not animation_type.variation_amount then
    animation_type.variation_amount = 1
  end
  if not animation_type.frame_offset then
    animation_type.frame_offset = 0
  end
  for _, action_table in pairs(animation_type.actions) do
    action_table[1] = action_list[action_table[1]] or action_table[1] -- get corresponding index if needed
  end
end

local function go_to_next_action(animation, animation_type)
  animation.action = animation.action + 1
  local next_action = animation_type.actions[animation.action]
  if next_action then
    animation.action_param = table.copy(next_action)
  else
    animation.action_param = {100, animation_type.frames_per_tick + animation_type.frame_offset}
  end
end

local function action_wait_base(animation, animation_type)
  local timer = animation.action_param[2]
  if timer <= 1 then
    go_to_next_action(animation, animation_type)
  else
    animation.action_param[2] = timer - 1
  end
end

pplaf.animation = {
  
  template = {
    sf = 0, -- animation is stored in 1 file
    mf_variation = 1, -- every animation file contains 1 variation with B frames; A files
    mf_frame = 2, -- every animation file contains 1 frame of A variations(you store additional frames after animated frames); B files
    mf_variated_frame = 3, -- every animation file contains 1 frame of 1 variation; A * B files
  },
  
  types = {},
  
  actions = {
    wait = 100,
    wait_and_increment = 101,
    wait_and_decrement = 102,
    animate = 200,
    animate_back = 201,
    loop = 300,
    loopW = 301,
    loop_back = 302,
    loop_backW = 303,
    loop_back_forth = 304,
    loop_back_forthW = 305,
    set_frame = 400,
  },
  
  load_by_typed_dir = function(path, ...) -- load animations from folder; animations are stored in folders with type declared as animation.lua
    for _, type_name in ipairs{...} do
      local folder_path = path .. type_name .. '/'
      current_folder_path = folder_path
      local animation_type = require(folder_path .. 'animation.lua')
      animation_type.folder_path = folder_path
      modify_animation_type(animation_type)
      pplaf.animation.types[type_name] = animation_type
    end
  end,
  
  load_by_typed_files = function(path, ...) -- load animations from folder; animation types are stored in one folder with respective names
    for _, type_name in ipairs{...} do
      current_folder_path = path
      local animation_type = require(path .. type_name .. '.lua')
      animation_type.folder_path = path
      modify_animation_type(animation_type)
      pplaf.animation.types[type_name] = animation_type
    end
  end,
  
  preload_all = function() -- preloads all meshes to avoid lag/delay on 1st mesh load
    local id = pewpew.new_customizable_entity(0fx, 0fx) -- create temporary entity
    pewpew.customizable_entity_set_mesh_color(id, 1)
    local animation_type_list = {} -- create list to iterate
    for animation_type_name, animation_type in pairs(pplaf.animation.types) do
      table.insert(animation_type_list, animation_type)
    end
    local type_state = 0
    local sub_state = 1
    local lifetime = 6
    pewpew.entity_set_update_callback(id, function(id)
      if lifetime > 1 then
        lifetime = lifetime - 1
        return nil
      end
      if sub_state == 1 then
        type_state = type_state + 1
      end
      if type_state > #animation_type_list then
        lifetime = 0
      end
      if lifetime == 0 then
        pewpew.entity_destroy(id)
        return nil
      end
      local animation_type = animation_type_list[type_state]
      if     animation_type.template == 0 then
        pewpew.customizable_entity_set_mesh(id, animation_type.path, 0)
      elseif animation_type.template == 1 then
        if sub_state > animation_type.variation_amount then
          sub_state = 1
        end
        pewpew.customizable_entity_set_mesh(id, animation_type.path .. sub_state .. '.lua', 0)
        sub_state = sub_state + 1
      elseif animation_type.template == 2 then
        pewpew.customizable_entity_set_mesh(id, animation_type.path .. sub_state .. '.lua', 0)
        sub_state = sub_state + 1
        if sub_state > animation_type.frame_amount then
          sub_state = 1
        end
      elseif animation_type.template == 3 then
        pewpew.customizable_entity_set_mesh(id, animation_type.path .. sub_state .. '.lua', 0)
        sub_state = sub_state + 1
        if sub_state > animation_type.variation_amount * animation_type.frame_amount then
          sub_state = 1
        end
      end
    end)
  end,
  
  modify_entity = function(entity) -- adds animation table in entity
    local animation_type = pplaf.animation.types[entity.type.animation]
    entity.animation = {
      type = animation_type,
      frame = 0,
      action = 1,
      action_param = table.copy(animation_type.actions[1]),
    }
    function entity:set_animation_variation(index)
      self.animation.variation_index = index
      self.animation.variation_offset = index * self.animation.type.frame_amount
    end
    entity:set_animation_variation(0)
  end,
  
  maintain = function(entity) -- maintains entity's animation
    local animation = entity.animation
    local animation_type = animation.type
    local template = animation_type.template
    local current_action = animation_type.actions[animation.action]
    local current_action_param = animation.action_param
    local action_type = current_action[1]
    
    local modify_frame = 0 -- 0 - don't modify, 1 - increment, 2 - decrement
    local path = 0
    local frame = 0
    
    if action_type == action_list.wait then
      action_wait_base(animation, animation_type)
      goto al_me -- if you're confused: Animation Label _ Maintain End / filename label _ function_name index/name
    elseif action_type == action_list.wait_and_increment then
      action_wait_base(animation, animation_type)
      modify_frame = 1
      goto al_mmf
    elseif action_type == action_list.wait_and_decrement then
      action_wait_base(animation, animation_type)
      modify_frame = 2
      goto al_mmf
    elseif action_type == action_list.animate then
      if animation.frame == current_action_param[2] then
        go_to_next_action(animation, animation_type)
      end
      modify_frame = 1
    elseif action_type == action_list.animate_back then
      if animation.frame == current_action_param[2] then
        go_to_next_action(animation, animation_type)
      end
      modify_frame = 2
    elseif action_type == action_list.loop then
      if animation.frame == current_action_param[3] then
        animation.frame = current_action[2]
      end
      modify_frame = 1
    elseif action_type == action_list.loopW then
      if current_action_param[4] == 1 and animation.frame == current_action_param[3] - 1 then
        go_to_next_action(animation, animation_type)
      end
      if animation.frame == current_action_param[3] then
        animation.frame = current_action[2]
        current_action_param[4] = current_action_param[4] - 1
      end
      modify_frame = 1
    elseif action_type == action_list.loop_back then
      if animation.frame == current_action_param[2] then
        animation.frame = current_action[3]
      end
      modify_frame = 2
    elseif action_type == action_list.loop_backW then
      if current_action_param[4] == 1 and animation.frame == current_action_param[2] + 1 then
        go_to_next_action(animation, animation_type)
      end
      if animation.frame == current_action_param[2] then
        animation.frame = current_action[3]
        current_action_param[4] = current_action_param[4] - 1
      end
      modify_frame = 1
    elseif action_type == action_list.loop_back_forth then
      if animation.frame == current_action_param[2] then
        current_action_param.loop_increment_param = 1
      end
      if animation.frame == current_action_param[3] then
        current_action_param.loop_increment_param = 2
      end
      modify_frame = current_action_param.loop_increment_param
    elseif action_type == action_list.loop_back_forthW then
      if animation.frame == current_action_param[2] then
        current_action_param.loop_increment_param = 1
        current_action_param[4] = current_action_param[4] - 1
      end
      if animation.frame == current_action_param[3] then
        current_action_param.loop_increment_param = 2
        current_action_param[4] = current_action_param[4] - 1
      end
      local df = 0
      if current_action_param.loop_increment_param == 1 then
        df = current_action_param[3] - animation.frame
      elseif current_action_param.loop_increment_param == 2 then
        df = animation.frame - current_action_param[2]
      end
      if current_action_param[4] == 1 and df == 1 then
        go_to_next_action(animation, animation_type)
      end
      modify_frame = current_action_param.loop_increment_param
    elseif action_type == action_list.set_frame then
      animation.frame = current_action_param[2]
      go_to_next_action(animation, animation_type)
    end
    
    if     template == 0 then -- animation is stored in 1 file; file contains A variation stored in order; every variation contains B frames
      path = animation_type.path
      frame = animation.variation_offset + animation.frame
    elseif template == 1 then -- every animation file contains 1 variation with B frames; A files
      path = animation_type.path .. animation.variation_index + 1 .. '.lua'
      frame = animation.frame
    elseif template == 2 then -- every animation file contains 1 frame of A variations(you store additional frames after animated frames); B files
      path = animation_type.path .. animation.frame + animation_type.frame_offset + 1 .. '.lua'
      frame = animation.variation_index * (animation_type.frames_per_tick + animation_type.frame_offset) -- OwO
    elseif template == 3 then -- every animation file contains 1 frame of 1 variation; A * B files
      path = animation_type.path .. animation.variation_offset + animation.frame + animation_type.frame_offset + 1 .. '.lua'
    end
    
    if animation_type.frames_per_tick == 1 then
      entity:set_mesh(path, frame)
    else
      if modify_frame == 1 then
        entity:set_flipping_meshes(path, frame, frame + 1)
      elseif modify_frame == 2 then
        entity:set_flipping_meshes(path, frame + 1, frame) -- we're decrementing frames, so we should use corresponding frames
      end
    end
    
    ::al_mmf::
    if modify_frame == 1 then
      animation.frame = animation.frame + animation_type.frames_per_tick + animation_type.frame_offset
    elseif modify_frame == 2 then
      animation.frame = animation.frame - animation_type.frames_per_tick - animation_type.frame_offset
    end
    ::al_me::
  end,
  
}

action_list = pplaf.animation.actions

--[[
  
  to use in entity, load animation type and include it in entity type
  to use in mesh, just require animation type
  
  animation type:
    
    static_variable_n   - anything you want
    
    template            - animation template; check pplaf.animation.template for more info
    
    frames_per_tick     - amount of frames per tick; 1 or 2; if you're using MF animation, 2 meshes have to be put in same file in order for 60fps animation to work; yeah, if you're using animations devided by frames, you'll have to use 2 frames per variation, which is a bit confusing, but I don't think anybody will use this one ever anyway, so have fun i guess - same for variated frame MF animations, 2 frames per file
    
    path                - path to mesh(SF) or folder(MF) with meshes, named as N.lua, starting from 1.lua
    
    variation_amount    - amount of different variations of mesh; if not presented, it will be automatically set to 1; animation is chosen randomly between variations
    
    frame_amount        - amount of frames in every variation
    
    actions             - sequence of actions
    
    frame_offset        - additional frame offset; this allows you to store multiple variations of frame that you will use manually for damaged frames, invulnerable frames, etc.
  
  
  animation:
    
    type             - type of this animation(table)
    
    frame            - current frame
    
    variation_index  - variation that will be used for this entity
    
    variation_offset - offset, calculated for SF or certain MF animations
  
  
  include animation in entity with all required information and it will be cycled automatically from frame 0 to frame N
  
  
  
  frame_offset:
    
    1 frame per tick, 0 frame offset:
      { 1 | 2 | 3 | 4 } - 30 fps, no additional frames, every frame is animated
    
    2 frames per ticks, 0 frame offset:
      { 1 2 | 3 4 | 5 6 | 7 8 | } - 60 fps, no additional frames, every second frame(starting from first frame) is animated with every frame after it being used for 60 fps animation
    
    1 frame per tick, 1 frame offset:
      { 1 2 | 3 4 | 5 6 | 7 8 | } - 30 fps, 1 additional frame, every second frame(starting from first) is animated; 1 additional frame is stored to be used manually after it
    
    2 frames per tick, 1 frame offset:
      { 1 2 3 | 4 5 6 | 7 8 9 | 10 11 12 } - 60 fps, 1 additional frame, every third frame(starting from first) is animated with every frame after it being used for 60 fps animation; 1 additional frame is stored to be used manually after them
  
  
  
  actions:
    
    wait - {100, 10} - mesh isn't set, waiting for N ticks; frames aren't incremented; after N frames go to next action
    
    wait_and_increment - {101, 10} - mesh isn't set, waiting for N ticks; frames are incremented; after N frames go to next action
    
    wait_and_decrement - {102, 10} - mesh isn't set, waiting for N ticks; frames are decremented; after N frames go to next action
    
    animate - {200, 9} - mesh is set to current frame while frame is in less than A; frames are incremented; after frame is equal to A go to next action
    
    animate_back - {201, 0} - mesh is set to current frame while frame is in more than A; frames are decremented; after frame is equal to A go to next action
    
    loop - {300, 0, 9} - mesh is set to current frame, after frame is equal to B, frame is set to A; frames are incremented
    
    loopW - {301, 0, 9, 2} - mesh is set to current frame, after frame is equal to B, frame is set to A; frames are incremented; after Q loops go to next action(last frame is kept instead of being reset to A)
    
    loop_back - {302, 0, 9} - mesh is set to current frame, after frame is equal to A, frame is set to B; frames are decremented
    
    loop_backW - {303, 0, 9, 2} - mesh is set to current frame, after frame is equal to A, frame is set to B; frames are decremented; after Q loops go to next action(last frame is kept instead of being reset to B)
    
    loop_back_forth - {304, 0, 9} - mesh is set to current frame; mesh is incremented/decremented after reaching corresponding frame
    
    loop_back_forthW - {305, 0, 9, 2} - mesh is set to current frame; mesh is incremented/decremented after reaching corresponding frame; after Q loops(forth-back loops, double for full loops) go to next action(last frame is kept instead of being reset to A/B)
    
    set_frame - {400, 10} - frame is set to A; go to next action
  
  
  
  animation proto functions:
    
    next_action() - stop current action and go to next one
    
  
  
  
  loadSF(path, ...)
  
  animations/
    anim1.lua
    anim2.lua
    ...
    
  loadSF('/dynamic/animations/', 'anim1', 'anim2')
  
  single-file animations are more convinient to maintain, but amount of memory, meshes array can take is limited
  
  
  loadMF(path, ...)
  
  animations/
    anim1/
      _t.lua
      1.lua
      2.lua
      ...
    anim2/
      ...
    ...
  
  loadSF('/dynamic/animations/', 'anim1', 'anim2')
  
  multiple-files animations are less convinient to maintain, but allow you to store bigger meshes; next problem is amount of time it takes to load those meshes :>
  
]]--
