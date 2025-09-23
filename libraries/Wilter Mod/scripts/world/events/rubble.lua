---@class Event.rubble : Event
local event, super = Class(Event, "rubble")

function event:init(data)
    super.init(self,data)
    self.solid = true
end

function event:applyTileObject(data, map)
    self.tile = map:createTileObject(data, 0, 0, self.width, self.height)

    local ox, oy = self.tile:getOrigin()
    self:setOrigin(ox, oy)

    self.tile:setPosition(ox * self.width, oy * self.height)
    self.tile.debug_select = false

    self:addChild(self.tile)
end

function event:explode(x,y, dont_remove, options)
    options = options or {}
    local play_sound = options.play_sound ~= false
    options.play_sound = false
    if play_sound then
        Assets.playSound("explosion")
    end
    return super.explode(self,x,y,dont_remove, options)
end

return event