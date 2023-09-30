SF = {}

function SF:inc(tape) tape.pointer = tape.pointer + 1 end

function SF:dec(tape) tape.pointer = tape.pointer - 1 end

function SF:get(tape)
	local data, pointer = tape.data, tape.pointer
	return data:sub(pointer, pointer)
end

function SF:set(tape, v)
	local data, pointer = tape.data, tape.pointer
	tape.data = data:sub(1, pointer - 1) .. v .. data:sub(pointer + 1)
end

function SF:flipBit(tape)
	local n = SF:get(tape) == "0" and "1" or "0"
	SF:set(tape, n)
end

function SF:findMatchingBracket(tape, open, close, fn)
	local brackets = 1
	while brackets > 0 do
		fn(nil,tape)
		if SF:get(tape) == open then brackets = brackets + 1 end
		if SF:get(tape) == close then brackets = brackets - 1 end
	end
end

function interpreter(codeStr, tapeStr)
	local code = { data = codeStr, pointer = 1 }
	local tape = { data = tapeStr, pointer = 1 }

	while (true) do
		local command = SF:get(code)
		local value = SF:get(tape)
		if command == "" or value == "" then
			break
		end
		if command == ">" then SF:inc(tape) end
		if command == "<" then SF:dec(tape) end
		if command == "*" then SF:flipBit(tape) end
		if command == "[" and value == "0" then
			SF:findMatchingBracket(code, "[", "]", SF.inc)
		end
		if command == "]" and value == "1" then
			SF:findMatchingBracket(code, "]", "[", SF.dec)
		end
		SF:inc(code)
	end
	return tape.data
end

return interpreter
