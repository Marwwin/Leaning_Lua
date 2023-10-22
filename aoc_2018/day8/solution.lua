local AOC = require("AOC")
local FList = require("utils.FList")
local day = {}


function day:part1(input_data)
  local input = day.parse_input(input_data)
end

function day.create_tree(list, tree)
  tree = tree or {}
  local header = list:take(2)
  local n_children, n_metadata = header[1], header[2]

  local children = {}
  while n_children > 0 do
    table.insert(children, day.create_tree(list))
    n_children = n_children - 1
  end

  local metadata = list:take(n_metadata)

  table.insert(tree, { children = children, metadata = metadata })
  return tree
end

function day:part2(input_data)
end

function day.parse_input(input)
  return FList(AOC.split(input[1], " "))
      :map(function(e) return tonumber(e) end)
end

return day
