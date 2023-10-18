local AOC = require("AOC")
local Vec2D = require("utils.Vec2D")
local FList = require("utils.FList")
local day = {}

function day:part1(input_data)
  local coordinates = FList(AOC.reduce(input_data, function(acc, cur)
    table.insert(acc, day.parse_input(cur))
    return acc
  end, {}))
  local infinites = day.find_coordinates_that_go_infinite(coordinates)
  local result = day.generate_closest(coordinates)
  result = result
      :filter(function(id) return id ~= -1 and not infinites:contains(id) end)
      :reduce(function(acc, cur)
        if not acc[cur] then acc[cur] = 1 else acc[cur] = acc[cur] + 1 end
        return acc
      end, FList({}))
      :reduce(function(acc, cur)
        if cur > acc then return cur end
        return acc
      end, 0, true)
  return result
end

function day:part2(input_data)
end

function day.generate_closest(list)
  local max_x = math.max(table.unpack(list:map(function(e) return e.x end)))
  local max_y = math.max(table.unpack(list:map(function(e) return e.y end)))
  local result = FList({})
  for y = 0, max_y, 1 do
    for x = 0, max_x, 1 do
      table.insert(result,day.find_closest(list,x,y))
    end
  end
  return result
end

function day.find_coordinates_that_go_infinite(list)
  local max_x = math.max(table.unpack(list:map(function(e) return e.x end)))
  local max_y = math.max(table.unpack(list:map(function(e) return e.y end)))
  local result = FList({})
  for x = 0, max_x, 1 do
    table.insert(result, day.find_closest(list, x, 0))
    table.insert(result, day.find_closest(list, x, max_y))
  end
  for y = 0, max_y, 1 do
    table.insert(result, day.find_closest(list, 0, y))
    table.insert(result, day.find_closest(list, max_x, y))
  end
  result = result:unique():filter(function(e) return e > 0 end)
  return result
end

function day.find_closest(list, x, y)
  local closest = math.maxinteger
  local id = 0
  local same = false
  for index, value in ipairs(list) do
    local distance = value:manhattan(x, y)
    if distance == closest then same = true end
    if distance < closest then
      closest = distance
      id = index
      same = false
    end
  end
  if same then return -1 else return id end
end

function day.parse_input(str)
  local strings = AOC.split(str, ", ")
  return Vec2D(tonumber(strings[1]), tonumber(strings[2]))
end

return day
