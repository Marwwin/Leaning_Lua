local AOC = require("AOC")
local day = {}

local Action = {
  START_WORK = 1,
  FALL_ASLEEP = 2,
  WAKE_UP = 3
}

day.Action = Action

function day:part1(input_data)
end

function day:part2(input_data)
end

function day.sort_events(events)
  events = AOC.map(events,
    function(t)
      t.time = os.time({
        year = t.year,
        month = t.month,
        day = t.day,
        hour = t.hour,
        min = t.minute
      })
      return t
    end)
  table.sort(events, day.compare_by_time)
  return events
end

function day.compare_by_time(ev1, ev2)
  return ev1.time < ev2.time
end

function day.parse_input(str)
  str = str:gsub("[-:%[%]#]", " ")
  local result = {}
  local split = AOC.split(str, " ")
  for i, v in ipairs(split) do
    if i == 1 then result.year = tonumber(v) end
    if i == 2 then result.month = tonumber(v) end
    if i == 3 then result.day = tonumber(v) end
    if i == 4 then result.hour = tonumber(v) end
    if i == 5 then result.minute = tonumber(v) end
    if i == 6 then
      if v == "Guard" then
        result.id = tonumber(split[i + 1])
        result.action = Action.START_WORK
      end
      if v == "falls" then result.action = Action.FALL_ASLEEP end
      if v == "wakes" then result.action = Action.WAKE_UP end
    end
  end
  return result
end

return day
