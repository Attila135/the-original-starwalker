---@class Map_override : Map
---@overload fun(...) : Map
local Map, super = Class(Map)

function Map:init(world, data)
    super.init(self, world, data)

    -- this is a bool property that you can add in any map.
    self.use_footstep_sounds = data and data.properties and data.properties["footsteps"] or false
end

return Map