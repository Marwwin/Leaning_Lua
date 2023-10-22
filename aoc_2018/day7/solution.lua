local AOC = require("AOC")
local FList = require("utils.FList")
local PriorityHeap = require("utils.PriorityHeap")
local Set = require("utils.Set")
local d = {}

function d:part1(input_data)
  local steps = FList(input_data):reduce(function(acc, str)
    local step = d.parse_input(str)
    if not acc[step.stop] then acc[step.stop] = {} end
    table.insert(acc[step.stop], step.start)
    return acc
  end, {})
  local starting_steps = d.get_starting_steps(steps)
  local queue = PriorityHeap.from_keys(starting_steps, PriorityHeap.priority.char_value)

  local result = FList({})
  while queue:top() do
    table.insert(result, queue:pop().value)
    for next_step, required_steps in pairs(steps) do
      if d.all_steps_completed(required_steps, result) then
        queue:push(next_step, PriorityHeap.priority.char_value)
        steps[next_step] = nil
      end
    end
  end
  return table.concat(result, "")
end

function d:part2(input_data)
  local steps = FList(input_data):reduce(function(acc, str)
    local step = d.parse_input(str)
    if not acc[step.stop] then acc[step.stop] = {} end
    table.insert(acc[step.stop], step.start)
    return acc
  end, FList({}))

  local available_steps = PriorityHeap().from_keys(
    d.get_starting_steps(steps), PriorityHeap.priority.char_value)

  local result = FList({})
  local workers = 5
  local working = PriorityHeap()
  local time = 0
  local delta <const> = 60 - 64
  while steps:size() > 0 or available_steps:size() > 0 or working:size() > 0 do
    --put workers to workers
    while workers > 0 and available_steps:size() > 0 do
      local step = available_steps:pop().value
      local time_stamp = time + step:byte() + delta
      working:push(step, time_stamp)
      workers = workers - 1
    end

    -- get next step
    local next_step = working:pop()
    workers = workers + 1
    table.insert(result, next_step.value)
    time = next_step.priority

    -- add new free steps to queue
    for step, required_steps in pairs(steps) do
      local index_to_remove
      for index, value in pairs(required_steps) do
        if value == next_step.value then index_to_remove = index end
      end
      if index_to_remove then table.remove(required_steps, index_to_remove) end
      if #required_steps == 0 then
        steps[step] = nil
        available_steps:push(step, PriorityHeap.priority.char_value)
      end
    end
  end
  return time
end

function d.get_starting_steps(steps)
  local starts = Set()
  local afters = Set()
  for key, value in pairs(steps) do
    afters:add(key)
    for _, v in ipairs(value) do
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

function d.put_workers_to_work(workers, queue, timeline, steps)

end

function d.parse_input(str)
  local a, b = str:match("Step (%a) must be finished before step (%a) can begin.")
  return { start = a, stop = b }
end

return d
