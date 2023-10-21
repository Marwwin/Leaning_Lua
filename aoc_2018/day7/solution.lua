local AOC = require("AOC")
local FList = require("utils.FList")
local PriorityHeap = require("utils.PriorityHeap")
local Set = require("utils.Set")
local d = {}

function table.p(t)
  print(t[0])
end

function d:part1(input_data)
  local steps = FList(input_data):reduce(function(acc, str)
    local step = d.parse_input(str)
    if not acc[step.stop] then acc[step.stop] = {} end
    table.insert(acc[step.stop], step.start)
    return acc
  end, {})
  local starting_steps = d.get_starting_steps(steps)
  local queue = PriorityHeap.from_keys(starting_steps)

  local result = FList({})
  while queue:peek() do
    table.insert(result, queue:pop())
    for next_step, required_steps in pairs(steps) do
      if d.all_steps_completed(required_steps, result) then
        queue:push(next_step)
        steps[next_step] = nil
      end
    end
  end
  return table.concat(result, "")
end

function d:part2(input_data)
end

function d.get_starting_steps(steps)
  local starts = Set()
  local afters = Set()
  for key, value in pairs(steps) do
    afters:add(key)
    for index, v in ipairs(value) do
      starts:add(v)
    end
  end
  local diff = afters:diff(starts)
  return diff
end

function d.all_steps_completed(required_steps, result)
  for _, step in pairs(required_steps) do
    if not result:contains(step) then return false end
  end
  return true
end

function d.parse_input(str)
  local a, b = str:match("Step (%a) must be finished before step (%a) can begin.")
  return { start = a, stop = b }
end

return d
