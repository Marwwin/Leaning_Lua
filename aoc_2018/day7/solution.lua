local AOC = require("AOC")
local FList = require("utils.FList")
local PriorityHeap = require("utils.PriorityHeap")
local day = {}

function table.p(t)
  print(t[0])
end

function day:part1(input_data)
  local steps = FList(input_data):reduce(function(acc,str) local step = day.parse_input(str)
    if not acc[step] then acc[step] = {} end
    table.insert(acc[step], step.after)
    return acc
  end, {})
  local starting_steps = day.getting_starting_steps(steps)
  local afters = steps:map(function(step) return step.after end):set()
  local start = steps:map(function(step) return step.first end):unique():filter(function(e)
    return not afters[e]
  end)
  table.sort(start, function(e1, e2) return e1 < e2 end)
  start:print()

  local result = ""
  local heap = PriorityHeap()
  local tree_data = FList{}
  for index, value in ipairs(steps) do
    print("index",index,"value",value)
    if not tree_data[value.first] then tree_data[value.first] = {} end
    table.insert(tree_data[value.first], value.after)
  end


  for key, value in pairs(start) do
    print("pushing", key, value)
    heap:push(value)
  end

  print("TREE DATA")
  tree_data:print()
  while heap:peek() do
    local v = heap:pop()
    if not v then break end
    local next = tree_data[v]
    print("s",next.first)
    result = result + next.first
    for _, value in ipairs(next) do
      heap:push(value)
    end
    v = heap:pop()
  end
end

function day:part2(input_data)
end

function day.getting_starting_steps(steps)
  local result = {}
  for key, value in pairs(steps) do
    
  end
end
 

function day.parse_input(str)
  local a, b = str:match("Step (%a) must be finished before step (%a) can begin.")
  print("p",a,b)
  return { first = a, after = b }
end

return day
