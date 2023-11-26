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

function Vec2D:equals(v)
  if not v then print("not") return false end
  if self.x == v.x and self.y == v.y then
    return true
  end
  return false
end

function Vec2D:to_string()
  return tostring(self.x) .. " " .. tostring(self.y)
end

function Vec2D:neighbours(diagonals)
  local diagonals = false or diagonals
  local neighbours = { self:left(), self:right(), self:up(), self:down() }
  if diagonals then
    table.insert(self:left_up(),neighbours)
    table.insert(self:right_up(),neighbours)
    table.insert(self:right_down(),neighbours)
    table.insert(self:left_down(),neighbours)
  end
  return neighbours
end

function Vec2D:left() return Vec2D(self.x - 1, self.y) end

function Vec2D:right() return Vec2D(self.x + 1, self.y) end

function Vec2D:up() return Vec2D(self.x, self.y + 1) end

function Vec2D:down() return Vec2D(self.x, self.y - 1) end

function Vec2D:left_up() return Vec2D(self.x - 1, self.y + 1) end

function Vec2D:right_up() return Vec2D(self.x + 1, self.y + 1) end

function Vec2D:right_down() return Vec2D(self.x + 1, self.y - 1) end

function Vec2D:left_down() return Vec2D(self.x - 1, self.y - 1) end

return Vec2D
