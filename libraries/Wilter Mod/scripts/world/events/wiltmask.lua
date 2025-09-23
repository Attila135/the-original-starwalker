local WiltMask, super = Class(Event)

function WiltMask:drawMask()
    love.graphics.rectangle("fill",0,0,self.width,self.height)
end

return WiltMask