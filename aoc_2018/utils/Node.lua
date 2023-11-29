local Node = {}

local metatable = {
  __call = function(self, node, parent)
    local o = { node = node, parent = parent or {} }
    setmetatable(o, { __index = self })
    return o
  end
}

setmetatable(Node, metatable)


return Node
