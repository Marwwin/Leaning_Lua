local m = {}

function m.rotating_rectangles(a, b)
  local x = math.floor(a / math.sqrt(2))
  local y = math.floor(b / math.sqrt(2))
  local points = (x+1) * (y+1) + x * y
  return points % 2 ~= 0 and points or points -1
end

print(m.rotating_rectangles(6, 4))
