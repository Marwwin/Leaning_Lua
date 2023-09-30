TapeObj = {}

function TapeObj:new(tape, isData)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.pointer = 1
	o.tape = tape
	o.isData = isData or false
	return o
end

function TapeObj:inc()
	if (self.isData) then
		if self.pointer == #self.tape then
			return
		end
	end
	self.pointer = self.pointer + 1
end

function TapeObj:dec() self.pointer = self.pointer - 1 end

function TapeObj:get() return self.tape:sub(self.pointer, self.pointer) end

function TapeObj:set(v)
	local tape = self.tape
	self.tape = tape:sub(1, self.pointer - 1) .. v .. tape:sub(self.pointer + 1)
end

function TapeObj:flipBit()
	local n = self:get() == "0" and "1" or "0"
	self:set(n)
end

function interpreter(codeStr, tapeStr)
	local code = TapeObj:new(codeStr)
	local tape = TapeObj:new(tapeStr, true)
	while (true) do
		if code.pointer > #code.tape or code.pointer < 1 then
			break
		end
		if code:get() == ">" then tape:inc() end
		if code:get() == "<" then tape:dec() end
		if code:get() == "*" then tape:flipBit() end
		if code:get() == "[" and tape:get() == "0" then
			local brackets = 1
			while brackets > 0 do
				code:inc()
				if code:get() == "[" then brackets = brackets + 1 end
				if code:get() == "]" then brackets = brackets - 1 end
			end
		end
		if code:get() == "]" and tape:get() == "1" then
			print("ghp", code:get() == "]", tape:get() == "1", tape:get())
			print("]")
			local brackets = 1
			while brackets > 0 do
				code:dec()
				if code:get() == "]" then brackets = brackets + 1 end
				if code:get() == "[" then brackets = brackets - 1 end
			end
		end
		code:inc()
	end
	return tape.tape
end

print(interpreter("[[]*>*>*>]", "000"))

return interpreter
