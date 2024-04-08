
-- maintains stuff related to entities, so you don't have to. Simplifies custom entity development

local pewpew_proto = require(pplaf.content .. 'pewpew_proto.lua')
local pewpew_proto_mt = {__index = pewpew_proto}

local __entities = {} -- entities table, used to maintain entities

local __group_iter = 1
local __group_indexes = {} -- list of groups' indexes
local __group_list = {} -- list of groups

local function ensure_proto(type) -- if entity prototype isn't created, create one
  if not type.proto then
    type.proto = {}
  end
  type[i_proto_mt] = {__index = type.proto}
end

local function get_groupLE(entity) -- get list of entities from group of this entity
  return __entities[__group_indexes[entity[i_type].group]]
end

local function maintain_prototypes(type) -- maintains prototype inheritance
  
  function type:create(x, y, ...)
    return pplaf.entity.create(x, y, self.name, ...)
  end
  
  ensure_proto(type)
  setmetatable(type.proto, pewpew_proto_mt)
  -- assign pewpew prototype to entity prototype; will be overriden by other prototypes if possible and required
  
end

local function modify_entity(entity, x, y, ...) -- entity modifications during it's init
  setmetatable(entity, entity[i_type][i_proto_mt]) -- assign prototype to entity
  if entity[i_type].animation then -- if entity has animation, add specific variables to process it automatically
    pplaf.animation.modify_entity(entity)
  end
  if entity[i_type].constructor then -- if possible, call constructor
    entity[i_type].constructor(entity, x, y, ...)
  end
end

local function maintain_ai() -- call ai function if possible
  for group_index, group in ipairs(__entities) do
    for entity_id, entity in pairs(group) do
      if not entity:get_is_alive() then -- if entity isn't alive, don't process it
        pplaf.entity.get_group(entity[i_type].group)[entity[i_id]] = nil
        goto el_ma1
      end
      if entity[i_type].ai then -- if entity has ai, process it
        mem = collectgarbage'count'
        entity[i_type].ai(entity)
      end
      if entity[i_animation] then
        pplaf.animation.maintain(entity)
      end
      ::el_ma1::
    end
  end
end

local function update_size(arr, size)
  for i = size, 1, -1 do
    if arr[i] then
      return i
    end
  end
  return 0
end

pplaf.entity = {
  
  types = {}, -- stores loaded entity types
  
  add_group = function(group) -- adds group in entities array
    table.insert(__entities, {})
    table.insert(__group_list, group)
    __group_indexes[group] = __group_iter
    __group_iter = __group_iter + 1
  end,
  
  add_groups = function(...) -- adds groups using add_group()
    for _, group in ipairs{...} do
      pplaf.entity.add_group(group)
    end
  end,
  
  get_group = function(group) -- returns certain group from entities table; possible to iterate through pairs
    return __entities[__group_indexes[group]]
  end,
  
  -- differences in type loading methods are commented below
  
  load_by_typed_dir = function(path, ...) -- load entities from folder; entities are stored in folders with type declared as entity.lua
    for _, type_name in ipairs{...} do
      local folder_path = path .. type_name .. '/'
      current_folder_path = folder_path
      local entity_type = require(folder_path .. 'entity.lua')
      entity_type.name = type_name
      entity_type.folder_path = folder_path
      maintain_prototypes(entity_type)
      pplaf.entity.types[type_name] = entity_type
    end
  end,
  
  load_by_typed_files = function(path, ...) -- load entities from folder; entity types are stored in one folder with respective names
    for _, type_name in ipairs{...} do
      current_folder_path = path
      local entity_type = require(path .. type_name .. '.lua')
      entity_type.name = type_name
      entity_type.folder_path = path
      maintain_prototypes(entity_type)
      pplaf.entity.types[type_name] = entity_type
    end
  end,
  
  def_types_in_pplaf = function() -- every declared type will be accessible as pplaf.entity[i_type]_name
    for type_name, type in pairs(pplaf.entity.types) do
      pplaf.entity[type_name] = type
    end
  end,
  
  def_types_globally = function() -- every declared type will be accessible as type_name
    for type_name, type in pairs(pplaf.entity.types) do
      _ENV[type_name] = type
    end
  end,
  
  create = function(x, y, type, ...) -- create entity in position, with type and pass any parameters to constructor(if it exists)
    local entity_type = pplaf.entity.types[type]
    local entity = {}
    entity[i_type] = entity_type
    modify_entity(entity, x, y, ...) -- multiple modifications of entity; if required and possible*
    pplaf.entity.get_group(entity_type.group)[entity[i_id]] = entity -- store entity
    return entity
  end,
  
  main = function()
    return maintain_ai()
  end,
  
}

--[[
  
  entity structure:
    
    entity_type = {       - entity type
    
      static_variable_n,  - can be used to store common parameteres(that can be changed over time), counters or whatever you want
      
      folder_path,        - path of the folder, containing file; filled automatically if you're using load_by_typed_dir
      
      file_path,          - path of the file; filled automatically
      
      group,              - group of the entity; you can define groups yourself; made for simplicity of entity management
      
      constructor,        - called any time you create entity of this type, optional(you want to add it tho); additional args upon creation can be passed to constructor function
      
      destructor,         - called any time you destroy entity, optional(entity isn't automatically destroyed, only removed from entities table); additional args upon destruction can be passed to destructor function
      
      ai,                 - entity's ai, called automatically, optional(this way if you don't control it manually it will do nothing)
      
      animation,          - name of animation type; animation is processed automatically
      
      proto,              - entity prototype; better way, than declaring entity parameters/functions in constructor
      
    }
    
    
    entity = {            - entity, created using entity_type
      
      type,               - type of this entity(table)
      
      id,                 - pewpew id
      
      variable_n,         - whatever you want: hp, damage, counters, etc.; I usually define those in constructor
      
      __indexP,           - current index in table; used to maintain destruction
      
    }
  
  
  
  built-in stuff:
    
    mesh responses        - mesh changes on certain events; like, changing mesh to certain mesh for several ticks; depending on other modules that can be included, that may require you to create different animated meshes to use certain features of this
    
    music responses       - music responses for some basic things, such as creation/destruction; this would be inconsistent though, as you will still have to implement music responses for being damaged or whatever happens with this entity; maybe better way is to make it so you store files in 1 place and just simplify way you can use sounds for certain events; that can be easily implemeted for certain use case, so idk
    
    attached entities     - in case you want several entities to be connected; can be easily done manually
  
  
  
  load_by_typed_dir(path, ...): -- folder path, names
    
    folder/
      entity1/
        entity.lua
        mesh.lua
        animation.lua
        sounds.lua
        ...
      entity2/
        entity.lua
        ...
      ...
    
    load_by_typed_dir('/dynamic/folder/', 'entity1', 'entity2')
    
    if you want to store all entity's files in its own directory
  
  load_by_typed_files(path, ...): -- folder path, names
    
    folder/
      entity1.lua
      entity2.lua
      ...
    other_folder/
      animation1.lua
      animation2.lua
      ...
    ...
    
    load_by_typed_files('/dynamic/folder/', 'entity1', 'entity2')
    
    if you want to store certain files of entity in respective directories
  
  
  
  check settings to modify prototypes, applied to entity and how prototype inheritance/override will work
  any prototypes are optional
  you can also change if entity's functions ovverride prototype functions or expand them
  
  
  
]]--
