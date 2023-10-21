local H = {}

local metatable = {
  __call = function(self)
    self.heap = {}
    return self
  end,
}

setmetatable(H, metatable)

function H:peek()
  --  for key, value in pairs(self.heap) do
  --     print("hep",key,value)
  --   end
  return self.heap[1]
end

function H:push(value)
  table.insert(self.heap, value)
  self:upheap()
end

function H:pop()
  local heap = self.heap
  if #heap == 0 then return nil end
  if #heap == 1 then return table.remove(heap) end

  local top = heap[1]
  heap[1] = table.remove(heap)
  self:downheap()
  return top
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

function H:downheap()
  local heap = self.heap
  local parent = 1
  local heapSize = #heap
  while true do
    local left = parent * 2
    local right = parent * 2 + 1
    local smallest = parent

    if left <= heapSize and heap[left] < heap[smallest] then smallest = left end
    if right <= heapSize and heap[right] < heap[smallest] then smallest = right end

    if smallest ~= parent then
      heap[parent], heap[smallest] = heap[smallest], heap[parent]
      parent = smallest
    else
      break
    end
  end
end

function H:print()
  for key, value in pairs(self.heap) do
    print(key)
  end
end

function H.from_keys(list)
  local heap = H()
  for key, _ in pairs(list) do
    heap:push(key)
  end
  return heap
end

function H.from_values(list)
  local heap = H()
  for _, value in pairs(list) do
    heap:push(value)
  end
  return heap
end

return H
