local Vec2D = require("utils.Vec2D")
local Stack = require("utils.Stack")
local Queue = require("utils.Queue")
local PriorityQueue = require('utils.PriorityHeap')
local Node = require("utils.Node")

local SIZE = 20
local M = {}

-- Breadth First Search

M.BFS = function(start, goal, is_walkable_fn, map)
  local q = Queue()
  q:push(Node(start))
  return M.BFS_(goal, is_walkable_fn, map, q, {})
end

M.BFS_ = function(goal, is_walkable, map, q, seen)
  local current = q:pop()
  local current_node = current.node
  if current_node:equals(goal) then
    local result = M.backtrack(current, Vec2D(3, 3))
    for index, path in ipairs(result) do
      map[path:to_string()] = "@"
      M.print_map(seen, map, goal)
    end
    return
  end
  seen[current_node:to_string()] = current
  for i, neighbour in ipairs(current_node:neighbours(true)) do
    if seen[neighbour:to_string()] == nil and is_walkable(neighbour, map) then
      seen[neighbour:to_string()] = true
      if neighbour.x >= 0 and neighbour.x <= SIZE and neighbour.y >= 0 and neighbour.y <= SIZE then
        q:push(Node(neighbour, current))
      end
    end
  end
  M.print_map(seen, map, goal)
  return M.BFS_(goal, is_walkable, map, q, seen)
end

-- Depth First Search

M.DFS = function(start, goal, is_walkable, map)
  local q = Stack()
  q:push(start)
  -- TODO NOT THIS CALLS BFS_
  -- That function should have a better more generic name probably?
  -- Or then just use DFS_ as is
  return M.DFS_(goal, is_walkable, map, q, {}, {})
end

M.DFS_ = function(goal, is_walkable, map, q, path, seen)
  local next_node = q:pop()
  path[next_node:to_string()] = true
  seen[next_node:to_string()] = true
  for i, neighbour in ipairs(next_node:neighbours()) do
    if seen[neighbour:to_string()] == nil and is_walkable(neighbour, map) then
      seen[neighbour:to_string()] = true
      if neighbour.x >= 0 and neighbour.x <= SIZE and neighbour.y >= 0 and neighbour.y <= SIZE then
        q:push(neighbour)
      end
    end
  end
  if next_node:equals(goal) then
    M.backtrack(path)
  else
    M.print_map(path, map, goal)
    return M.DFS_(goal, is_walkable, map, q, path, seen)
  end
end

M.AStar = function(start, goal, is_walkable, map)
  local q = PriorityQueue()
  q:push(start, start:manhattan(goal))
  M.AStar_(goal, is_walkable, map, q, {}, {})
end

M.AStar_ = function(goal, is_walkable, map, q, path, seen)
  local next_node = q:pop().value
  print("new", next_node:to_string())
  path[next_node:to_string()] = true
  seen[next_node:to_string()] = true
  for i, neighbour in ipairs(next_node:neighbours()) do
    if seen[neighbour:to_string()] == nil and is_walkable(neighbour, map) then
      seen[neighbour:to_string()] = true
      if neighbour.x >= 0 and neighbour.x <= SIZE and neighbour.y >= 0 and neighbour.y <= SIZE then
        print(" ", neighbour:to_string(), neighbour:manhattan(goal))
        q:push(neighbour, neighbour:manhattan(goal))
      end
    end
  end
  if next_node:equals(goal) then
    M.backtrack(path)
  else
    M.print_map(path, map, goal)
    return M.AStar_(goal, is_walkable, map, q, path, seen)
  end
end


M.backtrack = function(current, result)
  if current == nil then
    return result
  end
  table.insert(result, current.node)
  return M.backtrack(current.parent, result)
end

local colour = {
  reset = "\27[0m",
  red = "\27[31m",
  green = "\27[32m",
  white = "\27[37m"
}
M.print_map = function(m, terrain, goal)
  os.execute("sleep 0.05")
  os.execute("clear")
  for y = 0, SIZE, 1 do
    for x = 0, SIZE, 1 do
      local v = x .. " " .. y
      if x == goal.x and y == goal.y then
        io.write(" G ")
      elseif terrain[v] == "#" then
        io.write(" # ")
      elseif terrain[v] == "@" then
        io.write(colour.white)
        io.write(" @ ")
        io.write(colour.reset)
      elseif m[v] ~= nil then
        io.write(colour.red)
        io.write(" * ")
        io.write(colour.reset)
      else
        io.write(" . ")
      end
    end
    io.write("\n")
  end
end


--
--TEST DATA
--

local function walkable(vec, map)
  if map[vec:to_string()] == "#" then
    return false
  end
  return true
end

function generateRandomMaze(rows, cols)
  local maze = {}

  -- Add random walls to the maze
  for i = 1, rows do
    for j = 1, cols do
      local key = string.format("%d %d", i, j)
      maze[key] = math.random() < 0.2 -- Adjust the probability to control the density of walls
    end
  end

  return maze
end

local map = {}

map["8 0"] = "#"
map["8 1"] = "#"
map["8 2"] = "#"
map["8 3"] = "#"
map["8 4"] = "#"
map["8 5"] = "#"
map["8 6"] = "#"
map["8 7"] = "#"
map["8 8"] = "#"
map["7 8"] = "#"
map["6 7"] = "#"
map["3 10"] = "#"
map["4 10"] = "#"
map["5 10"] = "#"
map["6 10"] = "#"
map["7 10"] = "#"
map["8 10"] = "#"
map["9 10"] = "#"
map["10 7"] = "#"
map["10 8"] = "#"
map["10 9"] = "#"
map["10 10"] = "#"
map["10 11"] = "#"
map["10 12"] = "#"
map["11 11"] = "#"
map["12 11"] = "#"
map["13 11"] = "#"
map["16 7"] = "#"
map["16 8"] = "#"
map["16 9"] = "#"
map["16 10"] = "#"
map["16 11"] = "#"
map["16 12"] = "#"
map["16 13"] = "#"
map["14 13"] = "#"
map["14 12"] = "#"
map["14 11"] = "#"
map["14 10"] = "#"
map["14 9"] = "#"
map["14 8"] = "#"
map["16 8"] = "#"
map["17 8"] = "#"
map["18 8"] = "#"
map["12 8"] = "#"
map["11 8"] = "#"
map["10 8"] = "#"
map["19 11"] = "#"
map["8 15"] = "#"
map["9 15"] = "#"
map["10 15"] = "#"
map["11 15"] = "#"
map["12 15"] = "#"
map["13 15"] = "#"
map["14 15"] = "#"
map["15 15"] = "#"
map["14 17"] = "#"
map["15 17"] = "#"
map["16 17"] = "#"
map["17 17"] = "#"
map["18 17"] = "#"
map["18 16"] = "#"
map["18 15"] = "#"
map["18 14"] = "#"
map["18 13"] = "#"
map["18 12"] = "#"
map["18 11"] = "#"
map["14 18"] = "#"
map["14 19"] = "#"
map["13 19"] = "#"
map["12 19"] = "#"
map["11 19"] = "#"
map["10 19"] = "#"
map["10 18"] = "#"
M.BFS(Vec2D(3, 3), Vec2D(7, 9), walkable, map)
-- M.DFS(Vec2D(3, 3), Vec2D(12, 10), walkable, map)
-- M.AStar(Vec2D(3, 3), Vec2D(17, 18), walkable, map)



return M
