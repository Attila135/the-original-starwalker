local Door, super = Class(Event)

function Door:init(data)
    super.init(self, data.x, data.y, data.width, data.height, data)

end

function Door:draw()
    Draw.setLineWidth(2)
    Draw.setColor()
    love.graphics.line()
end

return Door