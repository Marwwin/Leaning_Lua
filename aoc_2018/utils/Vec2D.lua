local Vec2D = {}

local metatable = {
  __call = function(self, x, y)
    local o = { x = x, y = y }
    setmetatable(o, { __index = self })
    return o
  end,
}

setmetatable(Vec2D, metatable)

function Vec2D:manhattan(vec, y)
  if y then
    local x = vec
    return math.abs(self.x - x) + math.abs(self.y - y)
  end
  return math.abs(self.x - vec.x) + math.abs(self.y - vec.y)
end

return Vec2D
