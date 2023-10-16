local AOC = require("AOC")
local day = {}

function day:part1(input_data)
  local events = day.parse_input(input_data)
  table.sort(events, AOC.sort.by_year)

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


  for key, guard in pairs(guards) do
    local total_sleep = 0
    local minutes = day.create_minutes()
    for _, event in ipairs(guard) do
      total_sleep = total_sleep + event.wake - event.fall_asleep
      for i = event.fall_asleep, event.wake - 1, 1 do
        minutes[i] = minutes[i] + 1
      end
    end
    guard.total_sleep = total_sleep
    guard.total_minutes = minutes

    local max = 0
    local most_slept_minute = 0
    for m, v in ipairs(minutes) do
      if v > max then
        max = v
        most_slept_minute = m
      end
    end
    guard.most_slept_minute = most_slept_minute
  end

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

function day.create_minutes()
  local minutes = {}
  for i = 0, 59, 1 do
    minutes[i] = 0
  end
  return minutes
end

function day:part2(input_data)
end

return day
