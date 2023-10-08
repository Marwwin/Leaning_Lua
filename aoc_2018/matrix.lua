local M = {}

function M.create(size)
	local matrix = {}
	for _ = 1, size do
		local row = {}
		for _ = 1, size do
			table.insert(row, 0)
		end
		table.insert(matrix, {})
	end
	matrix.size = size
	setmetatable(matrix, { __index = M })
	return matrix
end

function M:print()
	print(self)
	for x = 1, self.size do
		for y = 1, self.size do
			local value = self[x][y]
			if value then
				io.write(value)
			else
				io.write(".")
			end
		end
		io.write("\n")
	end
end

return M
