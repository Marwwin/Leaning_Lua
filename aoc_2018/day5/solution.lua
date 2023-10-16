local AOC = require("AOC")
local d = {}

function d:part1(input_data)
  local input = input_data[1]
  local i, flag = 1, false
  local found = false
  while not flag do
    local unit = input:sub(i,i+1)
    local a,b = unit:sub(1,1), unit:sub(2,2)
    if string.lower(a) == string.lower(b) and string.byte(a) ~= string.byte(b) then
      input = input:sub(1,i-1) .. input:sub(i+2)
      found = true
      i = 1
    end
    i = i + 1
    if i == #input and found then flag = true end
  end
  print(input, #input)
  return #input
end

function d:part2(input_data)
end

return d
