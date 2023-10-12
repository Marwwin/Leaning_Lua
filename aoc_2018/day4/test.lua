local AOC = require('AOC')
local day4 = require('day4.solution')

describe("parse input", function()
  it("should parse input for starting work", function()
    local result = day4.parse_input("[1518-11-01 00:00] Guard #10 begins shift")
    assert.are.same({
      id = 10,
      year = 1518,
      month = 11,
      day = 1,
      hour = 00,
      minute = 00,
      time = -14237516389,
      action = day4.Action.START_WORK
    }, result)
  end)

  it("should parse input for starting work", function()
    local result = day4.parse_input("[1518-11-01 00:05] falls asleep")
    assert.are.same({
      year = 1518,
      month = 11,
      day = 1,
      hour = 00,
      minute = 05,
      time = -14237516089,
      action = day4.Action.FALL_ASLEEP
    }, result)
  end)
  it("should parse input for starting work", function()
    local result = day4.parse_input("[1518-11-01 00:25] wakes up")
    assert.are.same({
      year = 1518,
      month = 11,
      day = 1,
      hour = 00,
      minute = 25,
      time = -14237514889,
      action = day4.Action.WAKE_UP
    }, result)
  end)
end)

describe("events", function()
  it("should order events chronologically", function()
    local string_events = { "[1518-11-01 00:25] wakes up",
      "[1518-11-01 00:05] falls asleep",
      "[1518-11-01 00:00] Guard #10 begins shift" }
    local events = AOC.map(string_events, day4.parse_input)
    local sorted_events = day4.sort_events(events)
    assert.is_true(sorted_events[1].time < sorted_events[2].time)
    assert.is_true(sorted_events[2].time < sorted_events[3].time)
  end)
  it("should count sleeping time for one event", function()
    local string_events = { "[1518-11-01 00:25] wakes up",
      "[1518-11-01 00:05] falls asleep",
      "[1518-11-01 00:00] Guard #10 begins shift",
      "[1518-11-01 00:30] Guard #11 begins shift" }
    local events = AOC.map(string_events, day4.parse_input)
    local sorted_events = day4.sort_events(events)
    assert.are.same({ [10] = { [1] = { fall_asleep = 5, wakeup = 25, slept = 20 } }, [11] = { [1] = {} } },
      day4.count_sleep(sorted_events))
  end)
  it("should find who slept most", function()
    local events = { "[1518-11-01 00:05] falls asleep",
      "[1518-11-01 00:00] Guard #10 begins shift",
      "[1518-11-01 00:25] wakes up",
      "[1518-11-01 00:30] falls asleep",
      "[1518-11-01 00:55] wakes up",
      "[1518-11-03 00:24] falls asleep",
      "[1518-11-03 00:05] Guard #10 begins shift",
      "[1518-11-02 00:40] falls asleep",
      "[1518-11-02 00:50] wakes up",
      "[1518-11-04 00:02] Guard #99 begins shift",
      "[1518-11-05 00:45] falls asleep",
      "[1518-11-03 00:29] wakes up",
      "[1518-11-04 00:36] falls asleep",
      "[1518-11-01 23:58] Guard #99 begins shift",
      "[1518-11-05 00:55] wakes up",
      "[1518-11-04 00:46] wakes up",
      "[1518-11-05 00:03] Guard #99 begins shift", }
    events = AOC.map(events, day4.parse_input)
    events = day4.sort_events(events)
    events = day4.count_sleep(events)
    assert.is_true(10, day4.most_sleep(events))
  end)
end)
