local Set = {}
Set.__index = Set

local metatable = {
  __call= function (self, list)
    local set = {}
    for key, value in pairs(list) do
      set[key] = true
    end
    self = set
  end
}

setmetatable(Set,metatable)

function Set:has(value)
  for _, v in pairs(self) do
    if v == value then return true end 
  end
  return false
end

return Set
