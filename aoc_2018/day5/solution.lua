local AOC = require("AOC")
local d = {}

function d:part1(input_data)
  local input = d.react_chain(input_data[1])
  return #input
end

function d:part2(input_data)
  local input = input_data[1]
  local shortest = math.maxinteger
  for i = ("a"):byte(), ("z"):byte(), 1 do
    local small = string.char(i)
    local large = string.char(i - 32)
    local result = input:gsub("[" .. small .. large .. "]", "")
    result = d.react_chain(result)
    if #result < shortest then shortest = #result end
  end
  return shortest
end

function d.react_chain(input)
  local i = 1
  local found = false
  while true do
    local a, b = input:sub(i, i), input:sub(i + 1, i + 1)
    if string.lower(a) == string.lower(b) and a ~= b then
      input = input:sub(1, i - 1) .. input:sub(i + 2)
      found = true
    end
    i = i + 1
    if i >= #input then
      if not found then
        break
      else
        i = 1
        found = false
      end
    end
  end
  return input
end

return d
