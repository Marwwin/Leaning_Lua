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
end)
