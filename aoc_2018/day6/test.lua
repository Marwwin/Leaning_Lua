local AOC = require('AOC')
local solution = require('day6.solution')

describe("day6",function ()
  it("should parse input",function()
    local vec = solution.parse_input("1, 1")
    assert.are.same({x = 1, y= 1}, vec)
  end)
end)
