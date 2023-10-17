local V = {}

local metatable = {
  __call = function(self, x, y)
    local o = { x = x, y = y }
    setmetatable(o, { __index = self })
    return o
  end,
}

function V:manhattan(vec, y)
  if y then
    local x = vec
    return math.abs(self.x - x) + math.abs(self.y - y)
  end
  return math.abs(self.x - vec.x) + math.abs(self.y - vec.y)
end

setmetatable(V, metatable)

return V
