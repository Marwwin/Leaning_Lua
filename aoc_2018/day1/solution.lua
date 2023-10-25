local AOC = require "AOC"
local day = {}
local part2Solution
local part1Solution

function day:part1(input_data)
  local result = 0
  local numbers = { [0] = true }
  while (not part2Solution) do
    for _, v in pairs(input_data) do
      local command, n = v:sub(1, 1), v:sub(2)
      if command == "+" then result = result + n end
      if command == "-" then result = result - n end

      if not part2Solution and numbers[result] then
        part2Solution = result
      else
        numbers[result] = true
      end
    end
    if not part1Solution then part1Solution = result end
  end
  return part1Solution
end

function day:part2(_)
  return part2Solution
end

return day
