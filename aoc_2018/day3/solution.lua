local AOC = require("AOC")
local day = {}

function day:part1(input_data)
  local matrix = {}
  local claims = AOC.map(input_data, day.parseInput)
  for _, claim in pairs(claims) do
    for y = claim.y, claim.y + claim.height - 1 do
      for x = claim.x, claim.x + claim.width - 1 do
        local key = x .. "x" .. y
        local value = matrix[key]
        if value then matrix[key] = value + 1 else matrix[key] = 1 end
      end
    end
  end

  local result = 0
  for _, v in pairs(matrix) do
    if v > 1 then result = result + 1 end
  end
  return result
end

function day:part2(input_data)
  local matrix = {}
  local found = {}
  local claims = AOC.map(input_data, day.parseInput)
  for _, claim in pairs(claims) do
    for y = claim.y, claim.y + claim.height - 1 do
      for x = claim.x, claim.x + claim.width - 1 do
        local key = x .. "x" .. y
        local value = matrix[key]
        if value then
          if found[value] == nil then
            found[value] = true
          end
          if found[claim.id] == nil then
            found[claim.id] = true
          end
        else
          matrix[key] = claim.id
        end
      end
    end
  end

  for i = 1, #claims do
    if found[i] == nil then return i end
  end
end

function day.parseInput(data)
  local result = {}
  local i = 1
  for str in data:gmatch("%S+") do
    if i == 1 then result.id = tonumber(str:sub(2)) end
    if i == 3 then
      local vec = AOC.split(str:sub(1, -2), ",")
      result.x = vec[1]
      result.y = vec[2]
    end
    if i == 4 then
      local size = AOC.split(str, "x")
      result.width = size[1]
      result.height = size[2]
    end
    i = i + 1
  end
  return result
end

return day
