local AOC = require("AOC")
local Vec2D = require("utils.Vec2D")
local FList = require("utils.FList")
local day = {}

function day:part1(input_data)
  local coordinates = FList(AOC.reduce(input_data, function(acc, cur)
    table.insert(acc, day.parse_input(cur))
    return acc
  end, {}))
  local result = day.generate_closest(coordinates)
  -- AOC.print_t(result)
  return #coordinates
end

function day:part2(input_data)
end

function day.generate_closest(list)
  local max_x = math.max(table.unpack(list:map(function(e) return e.x end)))
  local max_y = math.max(table.unpack(list:map(function(e) return e.y end)))
  local edge = Vec2D(max_x, max_y)
  local result = {}
  for y = 0, edge.y, 1 do
    for x = 0, edge.x, 1 do
      local closest = math.maxinteger
      local same = false
      local id = 0
      for index, value in ipairs(list) do
        local distance = value:manhattan(x, y)
        if distance == closest then same = true end
        if distance < closest then
          closest = distance
          id = index
          same = false
        end
      end
      if same then
      else
        table.insert(result, id)
      end
    end
  end
  AOC.print_t(result)
  return result
end

function day.parse_input(str)
  local strings = AOC.split(str, ", ")
  return Vec2D(tonumber(strings[1]), tonumber(strings[2]))
end

return day
