local AOC = {}

function AOC.get_input(fileName, use_test_data)
  local file
  if use_test_data then
    file = io.open(fileName .. "/test.data", "r")
  else
    file = io.open(fileName .. "/input.data", "r")
  end

  if not file then
    print("File Open error")
  else
    local input = {}
    local index = 1
    for line in file:lines() do
      input[index] = line
      index = index + 1
    end
    file:close()
    return input
  end
end

function AOC.print_input(input, config)
  for _, v in pairs(input) do
    io.write(v, " ")
    if config then
      if config.newLines then io.write("\n") end
    end
  end
  io.write("\n")
end

-- UTIL Functions

function AOC.size(t)
  local count = 0
  for _, _ in pairs(t) do
    count = count + 1
  end
  return count
end

function AOC.string_intersection(str_a, str_b)
  local result = ""
  for i = 1, #str_a do
    if str_a:sub(i, i) == str_b:sub(i, i) then
      result = result .. str_a:sub(i, i)
    end
  end
  return result
end

function AOC.map(t, fn)
  local result = {}
  for _, v in pairs(t) do
    table.insert(result, fn(v))
  end
  return result
end

function AOC.filter(t, fn)
  local result = {}
  for _, v in pairs(t) do
    if fn(v) then table.insert(result, v) end
  end
  return result
end

function AOC.at(str, i)
  return str:sub(i, i)
end

function AOC.reduce(t, fn, initalValue)
  if initalValue == nil then
    if type(t[1]) == "number" then
      initalValue = 0
    elseif type(t[1]) == "string" then
      initalValue = ""
    else
      initalValue = {}
    end
  end

  for _, v in pairs(t) do
    initalValue = fn(initalValue, v)
  end
  return initalValue
end

local acc = {}
AOC.acc = acc
function acc.sum(accumulator, current)
  return accumulator + current
end

local sort = {}
AOC.sort = sort
function sort.by_year(date1, date2)
  if date1.year == date2.year then
    if date1.month == date2.month then
      if date1.day == date2.day then
        if date1.hour == date2.hour then
          return date1.minute < date2.minute
        end
        return date1.hour < date2.hour
      end
      return date1.day < date2.day
    end
    return date1.month < date2.month
  end
  return date1.year < date2.year
end

function AOC.split(str, char)
  if char == "" then return AOC.split_each_char(str) end
  local result = {}
  for v in str:gmatch("[^" .. char .. "]+") do
    table.insert(result, v)
  end
  return result
end

function AOC.split_each_char(str)
  local result = {}
  for i = 1, #str do
    table.insert(result, str:sub(i, i))
  end
  return result
end

function AOC.print_t(t)
  for i, v in pairs(t) do print(i, v) end
end

-- CLI Commands

local args = { ... }

function AOC.parse_arg()
  local config = AOC.parse_config()

  for i, arg in ipairs(args) do
    print(arg)
    if arg == "run" then AOC.run_day(args[i + 1], config) end
    if arg == "test" then AOC.run_test(args[i + 1], config) end
    if arg == "create" then AOC.create(args[i + 1], config) end
  end
end

function AOC.parse_config()
  local config = {}
  for _, arg in ipairs(args) do
    if arg == "--input" or arg == "-i" then config["show_input_data"] = true end
    if arg == "--test" or arg == "-t" then config["test_data"] = true end
  end
  return config
end

function AOC.create(day_number, config)
  os.execute("mkdir " .. day_number)
  os.execute("touch " .. day_number .. "/input.data")
  os.execute("touch " .. day_number .. "/test.data")
  os.execute("cat .config/test.lua " .. day_number .. "/test.lua")
  os.execute("cat .config/init_day.lua >> " .. day_number .. "/solution.lua")
end

function AOC.run_day(day_number, config)
  print(day_number)
  local data = AOC.get_input(day_number, config.test_data)
  if config.show_input_data then
    AOC.print_input(data)
  end
  local day = require(day_number .. "/solution")
  print("part1: ", day:part1(data))
  print("part2: ", day:part2(data))
end

function AOC.run_test(day_number, config)
  os.execute("busted " .. day_number .. "/test.lua")
end

AOC.parse_arg()
return AOC
