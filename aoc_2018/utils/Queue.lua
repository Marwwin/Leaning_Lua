local Queue = {}

local metatable = {
  __call = function(self)
    local o = {}
    setmetatable(o, { __index = Queue })
    return o
  end
}

setmetatable(Queue, metatable)

function Queue:push(value)
  table.insert(self, value)
end

function Queue:pop()
  return table.remove(self, 1)
end

function Queue:top()
  return self[1]
end

function Queue:size()
  local size = 0
  for _, _ in pairs(self) do
    size = size + 1
  end
  return size
end

return Queue
