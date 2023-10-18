local F = {}


local metatable = {
  __call = function(self, list)
    local o = list
    setmetatable(o, { __index = self })
    return o
  end,
}

function F:map(func)
  local result = {}
  for i, value in ipairs(self) do
    result[i] = func(value)
  end
  return F(result)
end

function F:filter(func)
  local result = {}
  for _, v in ipairs(self) do
    if func(v) then
      table.insert(result, v)
    end
  end
  return F(result)
end

function F:reduce(func, init, not_indexed)
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

function F:size()
  local result = 0
  for _, _ in ipairs(self) do
    result = result + 1
  end
  return result
end

function F:unique()
  local result = {}
  local seen = {}
  for _, value in ipairs(self) do
    if not seen[value] then
      table.insert(result, value)
      seen[value] = true
    end
  end
  return F(result)
end

function F:contains(val)
  for _, value in ipairs(self) do
    if value == val then return true end
  end
  return false
end

function F:print()
  for key, value in pairs(self) do
   if type(value) == "table" then F(value):print() else print(value) end 
  end
end

setmetatable(F, metatable)

return F
