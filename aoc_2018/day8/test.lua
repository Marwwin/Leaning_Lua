local AOC = require('AOC')
local day = require("day8.solution")

describe("day 8", function()
  it("should parse input", function()
    assert.are.same({ 1, 42, 2, 3, 4 }, day.parse_input({ "1 42 2 3 4" }))
  end)
  it("should create tree", function()
    local input = day.parse_input({ "2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2" })
    local tree = day.create_tree(input)
    assert.are.same({
      [1] = {
        children = {},
        metadata = { 10, 11, 12 } }
    }, tree["A"].children["C"])
--     assert.are.same({
--       [1] = {
--         children = {[1] = {
--           children = {}, metadata = {99}
--         }},
--         metadata = { 2 } }
--     }, tree[1].children[2])
  end)
end)
