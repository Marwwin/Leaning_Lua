local AOC = require('AOC')
local day = require('day7.solution')

describe("day 7",function ()
  it("should parse input string",function()
    local step = day.parse_input("Step F must be finished before step P can begin.")
    assert.are.same({first= "F", after= "P"},step)
  end)
end)
