local Vec2D = require("utils.Vec2D")
local Stack = require("utils.Stack")
local Queue = require("utils.Queue")

local SIZE = 20
local M = {}

-- Breadth First Search

M.BFS = function(start, goal, is_walkable, map)
  local q = Queue()
  q:push(start)
  return M.BFS_(goal, is_walkable, map, q, {}, {})
end

M.BFS_ = function(goal, is_walkable, mapp, q, path, seen)
  local next_node = q:pop()
  path[next_node:to_string()] = true
  seen[next_node:to_string()] = true
  for i, neighbour in ipairs(next_node:neighbours(true)) do
    if seen[neighbour:to_string()] == nil and is_walkable(neighbour, mapp) then
      seen[neighbour:to_string()] = true
      if neighbour.x >= 0 and neighbour.x <= SIZE and neighbour.y >= 0 and neighbour.y <= SIZE then
        q:push(neighbour)
      end
    end
  end
  if next_node:equals(goal) then
    M.backtrack(path)
  else
    M.print_map(path, mapp, goal)
    return M.BFS_(goal, is_walkable, mapp, q, path, seen)
  end
end

-- Depth First Search

M.DFS = function(start, goal, is_walkable, map)
  local q = Stack()
  q:push(start)
  return M.BFS_(goal, is_walkable, map, q, {}, {})
end

M.DFS_ = function(goal, is_walkable, mapp, q, path, seen)
  local next_node = q:pop()
  path[next_node:to_string()] = true
  seen[next_node:to_string()] = true
  for i, neighbour in ipairs(next_node:neighbours(true)) do
    if seen[neighbour:to_string()] == nil and is_walkable(neighbour, mapp) then
      seen[neighbour:to_string()] = true
      if neighbour.x >= 0 and neighbour.x <= SIZE and neighbour.y >= 0 and neighbour.y <= SIZE then
        q:push(neighbour)
      end
    end
  end
  if next_node:equals(goal) then
   M.backtrack(path)
  else
    M.print_map(path, mapp, goal)
    return M.DFS_(goal, is_walkable, mapp, q, path, seen)
  end
end

M.backtrack = function(path)
  print("GG")
--   for key, value in pairs(path) do
--     print(key, " ", value)
--   end
end

M.print_map = function(m, terrain, goal)
  os.execute("sleep 0.05")
  os.execute("clear")
  for y = 0, SIZE, 1 do
    for x = 0, SIZE, 1 do
      local v = x .. " " .. y
      if x == goal.x and y == goal.y then
        io.write(" G ")
      elseif m[v] ~= nil then
        io.write(" * ")
      elseif terrain[v] then
        io.write(" # ")
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
  if map[vec:to_string()] == true then
    return false
  end
  return true
end

local map = {}

map["8 0"] = true
map["8 1"] = true
map["8 2"] = true
map["8 3"] = true
map["8 4"] = true
map["8 5"] = true
map["8 6"] = true
map["8 7"] = true

map["8 8"] = true
map["7 8"] = true
map["6 7"] = true
map["3 10"] = true
map["4 10"] = true
map["5 10"] = true
map["6 10"] = true
map["7 10"] = true
map["8 10"] = true


map["10 7"] = true
map["10 8"] = true
map["10 9"] = true
map["10 10"] = true
map["10 11"] = true
map["11 11"] = true
map["12 11"] = true
map["13 11"] = true


-- M.BFS(Vec2D(3, 3), Vec2D(12, 10), walkable, map)
M.DFS(Vec2D(3, 3), Vec2D(12, 10), walkable, map)



return M
