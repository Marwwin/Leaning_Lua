local Set = {}
local metatable

metatable = {
  __call = function(self, list)
    list = list or {}
    local set = {}
    for key, _ in pairs(list) do
      set[key] = true
    end
    return setmetatable(set, { __index = self })
  end,
}

setmetatable(Set, metatable)

function Set:add(value)
  self[value] = true
end

function Set:remove(value)
  self[value] = nil
end

function Set:has(value)
  for _, v in pairs(self) do
    if v == value then return true end
  end
  return false
end

function Set:diff(s)
  local diff = Set({})
  for key, _ in pairs(s) do
    if not self[key] then
      diff[key] = true
    end
  end
  return diff
end

function Set:print()
  for key, _ in pairs(self) do
    print(key)
  end
end

return Set
