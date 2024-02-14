
--[[
  
  PewPew Live version: 0.7.162
  Lua version: 5.3
  PPLAF version: 1.1
  
]]--

-- pplaf initialization, bunch of useful stuff

_ENV.pewpew_old = nil
_ENV.fmath_old = nil

pplaf = {
  
  version = 100, -- current pplaf vversion(maybe will be used for compatibility purposes)
  path = '', -- pplaf folder path
  content = '', -- pplaf content folder path
  assets = '', -- pplaf assets folder path
  
  load = function(dir, ...) -- root directory + module instead of full path
    for _, lib in ipairs{...} do
      require(dir .. lib .. '.lua')
    end
  end,
  
  init = function(path) -- init pplaf
    pplaf.path = path
    pplaf.content = path .. 'content/'
    pplaf.assets = path .. 'assets/'
    pplaf.load(pplaf.path, -- init settings and variables
      'variables'
    )
    pplaf.load(pplaf.content, -- init pplaf stuff
      'def',
      'math',
      'fmath',
      'animation',
      'entity',
      'camera'
    )
  end,
  
  
  
}

local __DEF_PEWPEW_PRINT = pewpew.print
pewpew.print = function(...)
  __DEF_PEWPEW_PRINT(table.concat({...}, '\t'))
end

function table.copy(arr) --copies table by value
  local copy = {}
  for key, value in pairs(arr) do copy[key] = value end
  return copy
end
