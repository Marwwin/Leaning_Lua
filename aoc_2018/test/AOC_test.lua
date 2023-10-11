local AOC = require("AOC")
local split, map, filter, reduce = AOC.split, AOC.map, AOC.filter, AOC.reduce
local accumulators = AOC.acc

describe("split function", function()
  it("should split on ,", function()
    assert.are.same({ "this", "is", "splitted" }, split("this,is,splitted", ","))
  end)
  it("should split on space", function()
    assert.are.same({ "this", "is", "splitted" }, split("this is splitted", " "))
  end)
  it("should split every char", function()
    assert.are.same({ "t", "h", "i", "s" }, split("this", ""))
  end)
end)

describe("map function", function()
  it("should map over numbers", function()
    local function times_two(e) return e * 2 end
    assert.are.same({ 2, 4, 6, 8 }, map({ 1, 2, 3, 4 }, times_two))
  end)
  it("should map over strings", function()
    local function length(e) return #e end
    assert.are.same({ 2, 4 }, map({ "aa", "bbbb" }, length))
  end)
  it("should map over tables", function()
    local function get_id(e) return e.id end
    assert.are.same(
      { 1, 2 },
      map({ { id = 1, name = "test" }, { id = 2, other = 3 } }, get_id))
  end)
end)

describe("filter function", function()
  it("should filter numbers", function()
    local is_2 = function(e) return e == 2 end
    assert.are.same({ 2 }, filter({ 1, 2, 3, 4 }, is_2))
  end)
  it("should filter tables", function()
    local id_is_1 = function(e) return e.id == 1 end
    assert.are.same({ { id = 1, name = "test" } },
      filter({ { id = 1, name = "test" }, { id = 2, other = 3 } }, id_is_1))
  end)
end)

describe("reduce function", function()
  it("should sum list of numbers without setting inital value", function()
    assert.are.same(10, reduce({ 5, 1, 2, 2 }, accumulators.sum))
  end)
  it("should join strings without setting inital value", function()
    local join = function(acc, cur) return acc .. cur end
    assert.are.same("pelle svanslös", reduce({ "pelle", " ", "svanslös" }, join))
  end)
  it("should reduce tables", function()
    local split_and_add_to_table = function(acc, cur)
      local e = split(cur, " ")
      acc[e[1]] = e[2]
      return acc
    end
    assert.are.same(
      { one = '1', two = '2' },
      reduce({ "one 1", "two 2" }, split_and_add_to_table, {}))
  end)
end)
