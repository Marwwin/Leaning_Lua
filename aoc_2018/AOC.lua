local AOC = {}

function AOC.get_input(fileName, use_test_data)
	local file
	if use_test_data then
		file = io.open(fileName .. "/test", "r")
	else
		file = io.open(fileName .. "/input", "r")
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

function AOC.count_table_keys(t)
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
end

function AOC.at(str, i)
	return str:sub(i, i)
end

function AOC.reduce(t, fn, initalValue)
	for _, v in pairs(t) do
		initalValue = fn(initalValue, v)
	end
	return initalValue
end

-- CLI Commands

local args = { ... }



function AOC.parse_arg()
	local config = {}
	for _, arg in ipairs(args) do
		if arg == "--input" or arg == "-i" then config["show_input_data"] = true end
		if arg == "--test" or arg == "-t" then config["test_data"] = true end
	end

	for i, arg in ipairs(args) do
		if arg == "run" then AOC.run_day(args[i + 1], config) end
		if arg == "create" then AOC.create(args[i + 1], config) end
	end
end

function AOC.create(day_number, config)
	os.execute("mkdir " .. day_number)
	os.execute("touch " .. day_number .. "/input")
	os.execute("touch " .. day_number .. "/test")
	local init_solution = [[
local AOC = require("AOC")
local day = {}

function day:part1(input_data)
end

function day:part2(input_data)
end

return day
	]]
	os.execute("echo '" .. init_solution .. "' >> " .. day_number .. "/solution.lua")
end

function AOC.run_day(day_number, config)
	local data = AOC.get_input(day_number, config.test_data)
	if config.show_input_data then
		AOC.print_input(data)
	end
	local day = require(day_number .. "/solution")
	print("part1: ", day:part1(data))
	print("part2: ", day:part2(data))
end


AOC.parse_arg()
return AOC
