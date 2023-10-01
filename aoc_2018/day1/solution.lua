local AOC = require "AOC"
local function solution(input)
	local part2Solution
	local part1Solution
	local result = 0
	local numbers = { [0] = true }
	while (not part2Solution) do
		for _, v in pairs(input) do
			local command, n = v:sub(1, 1), v:sub(2)
			if command == "+" then result = result + n end
			if command == "-" then result = result - n end

			if not part2Solution and numbers[result] then
				part2Solution = result
			else
				numbers[result] = true
			end
		end
		if not part1Solution then part1Solution = result end
	end
	print("Solution to part1:", part1Solution, "Solution to part2: ", part2Solution)
end

solution(AOC.GetInput())
-- solution({ "+1", "-1" })
-- solution({ "+3", "+3", "+4", "-2", "-4" })
-- solution({ "-6", "+3", "+8", "+5", "-6" })
