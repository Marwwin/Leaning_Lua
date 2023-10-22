local AOC = require("AOC")
local FList = require("utils.FList")
local day = {}


function day:part1(input_data)
  local input = day.parse_input(input_data)
  local tree = day.create_tree(input)
  return day.count_metadata(tree)
end

function day:part2(input_data)
  local input = day.parse_input(input_data)
  local tree = day.create_tree(input)
  return day.count_value(tree)
end

function day.count_value(tree)
  local sum = 0
  for _, node in pairs(tree) do
    if FList(node.children):size() == 0 then
      sum = sum + FList(node.metadata)
          :reduce(function(acc, cur) return acc + cur end, 0)
    else
      local keys = day.get_sorted_child_ids(node.children)
      for _, id in pairs(node.metadata) do
        if node.children[keys[id]] then
          sum = sum + day.count_value({ node.children[keys[id]] })
        end
      end
    end
  end
  return sum
end

function day.get_sorted_child_ids(children)
  local keys = {}
  for index, _ in pairs(children) do
    table.insert(keys, index)
  end
  table.sort(keys, function(a, b)
    return a:byte() < b:byte()
  end)
  return keys
end

function day.count_metadata(tree)
  local sum = 0
  for _, node in pairs(tree) do
    sum = sum + FList(node.metadata)
        :reduce(function(acc, cur) return acc + cur end, 0)
    if node.children then
      sum = sum + day.count_metadata(node.children)
    end
  end
  return sum
end

function day.create_tree(list, tree, id)
  tree = tree or {}
  id = id or 65
  local header = list:take(2)
  local n_children, n_metadata = header[1], header[2]
  local cur_id = string.char(id)
  local children = {}
  while n_children > 0 do
    id = id + 1
    day.create_tree(list, children, id)
    n_children = n_children - 1
  end

  local metadata = list:take(n_metadata)
  tree[cur_id] = { children = children, metadata = metadata }
  return tree
end

function day.parse_input(input)
  return FList(AOC.split(input[1], " "))
      :map(function(e) return tonumber(e) end)
end

return day
