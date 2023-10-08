local AOC = require("AOC")
local day = {}

local function get_letters(word)
	local letters = {}
	for j = 1, #word do
		local char = word:sub(j, j)
		local l = letters[char]
		if l then
			letters[char] = l + 1
		else
			letters[char] = 1
		end
	end
	return letters
end

function day:part1(input_data)
	local threes = 0
	local twos = 0
	for i, str in ipairs(input_data) do
		local letters = get_letters(str)
		local two_found = false
		local three_found = false
		for j, v in pairs(letters) do
			if two_found and three_found then break end
			if v == 2 and not two_found then
				twos = twos + 1
				two_found = true
			end
			if v == 3 and not three_found then
				threes = threes + 1
				three_found = true
			end
		end
	end
	return threes * twos
end

local Word = {}

function Word.create(word)
	local mt = {
		__sub = function(a, b)
			local dif = {}
			for i = 1, #a.word do
				local a_char, b_char = a.word:sub(i, i), b.word:sub(i, i)
				if not (a_char == b_char) then
					table.insert(dif, a_char)
					table.insert(dif, b_char)
				end
			end
			if AOC.count_table_keys(dif) == 2 then
				return dif[1]:sub(1, 1):byte() - dif[2]:sub(1, 1):byte()
			end
			return 0
		end
	}
	local o = {}
	o.word = word
	setmetatable(o, mt)
	return o
end

function day:part2(input_data)
	local words = AOC.map(input_data, Word.create)
	for i, word in ipairs(words) do
		for j = i + 1, AOC.count_table_keys(words) do
			if math.abs(word - words[j]) == 1 then
				return AOC.string_intersection(word.word, words[j].word)
			end
		end
	end
end

return day
