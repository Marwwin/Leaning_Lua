local AOC = {}
function AOC.GetInput()
	local file = io.open("input", "r")
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

function AOC.PrintInput(input, config)
	for _, v in pairs(input) do
		io.write(v, " ")
		if config.newLines then io.write("\n") end
	end
	io.write("\n")
end

return AOC
