local F = {}


local metatable = {
  __call = function(self, list)
    local o = { list = list }
    setmetatable(o, { __index = self })
    return o
  end,
}

function F:map(func)
  local result = {}
  for i, v in ipairs(self.list) do
    result[i] = func(v)
  end
  return F(result)
end

function F:filter(func)
  local result = {}
  for i, v in ipairs(t) do
    if func(v) then
      table.insert(result, v)
    end
  end
  return result
end

setmetatable(F, metatable)

return F
