local AOC = require("AOC")
local day = {}
local Vec2d = require("utils.Vec2D")

function day:part1(input_data)
  for second, position in ipairs(input_data) do
    local vec = Vec2d()
    for n in ipairs(position:gmatch("()"))
    print(second,position:gmatch("(-?%d+)"))
  end
  print("after for")
end
  
function day:part2(input_data)
end

return day
