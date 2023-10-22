local FList = {}


local metatable = {
  __call = function(self, list)
    local o = list
    setmetatable(o, { __index = self })
    return o
  end,
}

setmetatable(FList, metatable)


function FList:map(func)
  local result = {}
  for i, value in ipairs(self) do
    result[i] = func(value)
  end
  return FList(result)
end

function FList:filter(func)
  local result = {}
  for _, v in ipairs(self) do
    if func(v) then
      table.insert(result, v)
    end
  end
  return FList(result)
end

function FList:reduce(func, init, not_indexed)
  not_indexed = not_indexed or false
  local result = init
  if not_indexed then
    for _, value in pairs(self) do
      result = func(result, value)
    end
  else
    for _, value in ipairs(self) do
      result = func(result, value)
    end
  end
  return result
end

function FList:size()
  local result = 0
  for _, _ in pairs(self) do
    result = result + 1
  end
  return result
end

function FList:unique()
  local result = {}
  local seen = {}
  for _, value in pairs(self) do
    if not seen[value] then
      table.insert(result, value)
      seen[value] = true
    end
  end
  return FList(result)
end

function FList:set()
  local set = {}
  for _, value in ipairs(self) do
    set[value] = true
  end
  return FList(set)
end

function FList:ifor(fn)
  for index, value in ipairs(self) do
    self[index] = fn(value)
  end
end

function FList:contains(val)
  for _, value in pairs(self) do
    if value == val then return true end
  end
  return false
end

function FList:take(n)
  local result = {}
  for i = 1, n do
    table.insert(result, table.remove(self,i - #result))
  end
  return result
end

function FList:print()
  for _, value in pairs(self) do
    if type(value) == "table" then FList(value):print() else print(value) end
  end
end

return FList
