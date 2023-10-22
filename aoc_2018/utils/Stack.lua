local Stack = {}

local metatable = {
  __call = function(self)
    local o = {}
    setmetatable(o, { __index = Stack })
    return o
  end,
}

setmetatable(Stack, metatable)

function Stack:push(value)
  table.insert(self, 1, value)
end

function Stack:pop()
  if self:size() == 0 then return nil end
  return table.remove(self, 1)
end

function Stack:top()
  return self[1]
end

function Stack:size()
  local size = 0
  for _, _ in pairs(self) do size = size + 1 end
  return size
end

return Stack
