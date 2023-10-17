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
  for i, v in ipairs(self) do
    result[i] = func(v)
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

function F:reduce(func, init)
  local result = init
  for _, value in ipairs(self) do
    result = func(result, value)
  end
  return result
end

function F:size()
  local result = 0
  for key, value in ipairs(self) do
    result = result + 1
  end
  return result
end

setmetatable(F, metatable)

return F
