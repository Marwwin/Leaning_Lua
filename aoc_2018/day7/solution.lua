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
  local steps = FList(input_data):reduce(function(acc, str)
    local step = d.parse_input(str)
    if not acc[step.stop] then acc[step.stop] = {} end
    table.insert(acc[step.stop], step.start)
    return acc
  end, FList({}))
  local starting_steps = d.get_starting_steps(steps)
  local queue = PriorityHeap.from_keys(starting_steps)

  local result = FList({})
  local workers = 5
  local timeline = FList({})
  local time = 0
  while steps:size() > 0  do
    print(steps:size())
    --put workers to workers
    while workers > 0 and queue:size() > 0 do
      local step = queue:pop()
      print(step, queue:size())
      local time_stamp = step:byte() + 60 - 64
      timeline[time_stamp] = step
      workers = workers - 1
      steps[step] = nil
    end
print("workers",workers,"queue",queue:print())

    local next_time_stamp = math.maxinteger
    local next_step
    for time_stamp, step in pairs(timeline) do
      if time_stamp < next_time_stamp then
        next_step = step
        next_time_stamp = time_stamp
      end
    end
    print("next ",next_time_stamp, next_step)

    table.insert(result, next_step)
    for step, required in pairs(steps) do
      local new_required = {}
      for i, required_step in pairs(required) do
        if required_step ~= next_step then
          table.insert(new_required, required_step)
        end
      end

      if not new_required then queue:push(step) end
      steps[step] = new_required
    end
    time = next_time_stamp
    --    time = time + 1
    --     print("Start",time,"workers",workers,"queue",queue:print(),"q",timeline:print())
    --     workers = d.put_workers_to_work(workers,queue, timeline, steps)
    --     print("workers are working", workers)
    --     if timeline[time] then
    --       for key, value in pairs(timeline[time]) do
    --         table.insert(result, value)
    --         workers = workers + 1
    --       end
    --       for next_step, required_steps in pairs(steps) do
    --         if d.all_steps_completed(required_steps, result) then
    --           queue:push(next_step)
    --           steps[next_step] = nil
    --         end
    --       end
    --     end
  end

  print("time", time)
  --   return time
  return table.concat(result, "")
end

function d.put_workers_to_work(workers, queue, timeline, steps)
  local delta <const> = 64
  local delay <const> = 60
  while workers > 0 and queue:peek() ~= false do
    local cur = steps[queue:pop()]
    print(cur)
    if not cur then break end
    print("mext", cur)
    local t = delay + cur:byte() - delta
    if not timeline[t] then
      timeline[t] = { cur }
    else
      table.insert(timeline[t], cur)
    end
    workers = workers - 1
  end
  return workers
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
