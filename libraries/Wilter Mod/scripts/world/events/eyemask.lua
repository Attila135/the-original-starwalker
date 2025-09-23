local EyeMask, super = Class(Event)

function EyeMask:drawMask()
    love.graphics.rectangle("fill",0,0,self.width,self.height)
end

return EyeMask