local AOC = require("AOC")
local day = {}

function day:part1(input_data)
  local input = day:parse_input(input_data[1])
  print(input)
end

function day:part2(input_data)
end

function day:parse_input(input)
  local players, last_marble = input:match("(%d+) players; last marble is worth (%d+) points")
  print(input,players,last_marble)
  return { players = tonumber(players), last_marble = tonumber(last_marble) }
end

return day
