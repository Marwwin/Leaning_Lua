local AOC = require("AOC")
local day = {}

local Action = {
  START_WORK = 1,
  FALL_ASLEEP = 2,
  WAKE_UP = 3
}

local ActionMetatable = {
  __tostring = function(self)
    for key, value in pairs(Action) do
      if value == self then return value end
    end
    return "Unknown Action"
  end
}

setmetatable(Action, ActionMetatable)

day.Action = Action
function day:part1(input_data)
  print(input_data)
  for key,value in ipairs(input_data) do
    print(value)
  end
end
function day:part1_temp(input_data)
  local events = AOC.map(input_data, day.parse_input)
  events = day.sort_events(events)
  events = day.count_sleep(events)
end

function day:part2(input_data)
end

function day.count_sleep(events)
  local result = {}
  local id = 0
  for _, event in ipairs(events) do
    print("id", event.id, "day", event.day, "action", tostring(event.action))
  end
  for _, event in ipairs(events) do
    
    print("event", event.id, event.day, event.hour, event.action)
    if event.action == Action.START_WORK then
      if not result[id] then
        result[id] = {}
      end
      local guard = result[id]
      if not guard[event.month] then guard[event.month] = {} end
      if not guard[event.month][event.day] then guard[event.month][event.day] = {} end
      local tomorrow = os.date("*t", os.time({ year = event.year, month = event.month, day = event.day }) + 24 * 60 * 60)
      if not guard[tomorrow.month] then guard[tomorrow.month] = {} end
      if not guard[tomorrow.month][tomorrow.day] then guard[tomorrow.month][tomorrow.day] = {} end
      print("start", guard[event.month][event.day], guard[tomorrow.month][tomorrow.day])
    end
    if event.action == Action.FALL_ASLEEP then
      print("sleep", event.day)
      print(result[id][event.month][event.day], "day")
      result[id][event.month][event.day].fall_asleep = event.minute
    end
    if event.action == Action.WAKE_UP then
      result[id][event.month][event.day].wakeup = event.minute
      result[id][event.month][event.day].slept = event.minute - result[id][event.month][event.day].fall_asleep
    end
  end
  return result
end

function day.most_sleep(events)
  local slept = AOC.map(events, function(guard)
    AOC.reduce(guard, function(acc, cur)
      return acc + cur.slept
    end, 0)
  end)
  table.sort(slept, function(g1, g2) return g1 < g2 end)
  AOC.print_t(slept)
end

function day.sort_events(events)
  table.sort(events, function(ev1, ev2)
    return ev1.time < ev2.time
  end
  )
  return events
end

function day.parse_input(str)
  str = str:gsub("[-:%[%]#]", " ")
  local event = {}
  local split = AOC.split(str, " ")
  for i, v in ipairs(split) do
    if i == 1 then event.year = tonumber(v) end
    if i == 2 then event.month = tonumber(v) end
    if i == 3 then event.day = tonumber(v) end
    if i == 4 then event.hour = tonumber(v) end
    if i == 5 then event.minute = tonumber(v) end
    if i == 6 then
      if v == "Guard" then
        event.id = tonumber(split[i + 1])
        event.action = Action.START_WORK
      end
      if v == "falls" then event.action = Action.FALL_ASLEEP end
      if v == "wakes" then event.action = Action.WAKE_UP end
    end
  end
  event.time = os.time({
    year = event.year,
    month = event.month,
    day = event.day,
    hour = event.hour,
    min = event.minute
  })
  return event
end

return day
