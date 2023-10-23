local AOC = require('AOC')
local day = require("day9.solution")

describe("Day 9", function()
  it("parse input", function()
    assert.are.same({ players = 10, last_marble = 1618 },
      day:parse_input("10 players; last marble is worth 1618 points"))
  end)
end)
