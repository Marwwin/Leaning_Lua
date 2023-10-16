local AOC = require("AOC")
local day = {}

function day:part1(input_data)
  local events = day.parse_input(input_data)
  table.sort(events, AOC.sort.by_year)

  local guards = day.get_guards(events)
  guards = day.generate_sleep_data(guards)

  local sleepiest_guard = 0
  local sleep_time = 0
  for key, guard in pairs(guards) do
    if guard.total_sleep > sleep_time then
      sleep_time = guard.total_sleep
      sleepiest_guard = key
    end
  end
  return sleepiest_guard * guards[sleepiest_guard].most_slept_minute
end

function day:part2(input_data)
  local events = day.parse_input(input_data)
  table.sort(events, AOC.sort.by_year)

  local guards = day.get_guards(events)
  guards = day.generate_sleep_data(guards)

  local most_slept_minute = 0
  local times = 0
  local id = 0
  for key, guard in pairs(guards) do
    if guard.most_slept_minute > 30 then print(guard.most_slept_minute, key) end
    if guard.most_minute_times > times then
      most_slept_minute = guard.most_slept_minute
      times = guard.most_minute_times
      id = key
    end
  end
  print(most_slept_minute,id)
  return most_slept_minute * id
end

function day.parse_input(input_data)
  local events = {}
  for _, value in ipairs(input_data) do
    local Y, M, D, h, m, word1, word2 =
        string.match(value, "%[(%d+)-(%d+)-(%d+) (%d+):(%d+)] (%a+) (.+)")
    table.insert(events, {
      year = tonumber(Y),
      month = tonumber(M),
      day = tonumber(D),
      hour = tonumber(h),
      minute = tonumber(m),
      word1 = word1,
      word2 = word2
    })
  end
  return events
end

function day.get_guards(events)
  local guards = {}
  local current_id = 0
  local fall_asleep = 0
  for _, guard in ipairs(events) do
    if guard.word1 == "Guard" then
      local id = tonumber(guard.word2:match("#(%d+) begins shift"))
      if not id then error("id not number") end
      current_id = id
      if not guards[id] then guards[id] = {} end
    end
    if guard.word1 == "falls" then fall_asleep = guard.minute end
    if guard.word1 == "wakes" then
      table.insert(guards[current_id],
        { month = guard.month, day = guard.day, fall_asleep = fall_asleep, wake = guard.minute })
      fall_asleep = 0
    end
  end
  return guards
end

function day.generate_sleep_data(guards)
  for _, guard in pairs(guards) do
    local total_sleep = 0
    local minutes = day.create_minutes()
    for _, event in ipairs(guard) do
      for i = event.fall_asleep, event.wake - 1, 1 do
        minutes[i] = minutes[i] + 1
      end
      total_sleep = total_sleep + event.wake - event.fall_asleep
    end
    guard.total_sleep = total_sleep
    guard.total_minutes = minutes

    local most_times_slept = 0
    local most_slept_minute = 0
    for minute, times_slept in ipairs(minutes) do
      if times_slept > most_times_slept then
        most_times_slept = times_slept
        most_slept_minute = minute
      end
    end
    guard.most_minute_times = most_times_slept
    guard.most_slept_minute = most_slept_minute
  end
  return guards
end

function day.create_minutes()
  local minutes = {}
  for i = 0, 59, 1 do
    minutes[i] = 0
  end
  return minutes
end

return day
