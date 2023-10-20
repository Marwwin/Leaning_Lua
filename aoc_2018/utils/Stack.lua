local H = {}

local metatable = {
  __call = function ()
    local self = setmetatable({}, {__index = self})
    self.heap = {}
    return self
  end,
}

function H:push(value)
  table.insert(self.heap, value)
  self:upheap()
end

function H:upheap()
  local heap = self.heap
  local child = #heap
  while child > 1 do
    local parent = math.floor(child / 2)
    if heap[child] < heap[parent] then
      heap[parent], heap[child] = heap[child], heap[parent]
      child = parent
    else
      break
    end
  end
end

return H
