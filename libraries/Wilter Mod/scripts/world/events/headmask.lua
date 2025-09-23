local HeadMask, super = Class(Event)

function HeadMask:drawMask()
    love.graphics.rectangle("fill",0,0,self.width,self.height)
end

return HeadMask