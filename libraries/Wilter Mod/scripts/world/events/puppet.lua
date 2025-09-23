---@class Event.puppet : Event
local event, super = Class(Event, "puppet")

---@param data table
function event:init(data)
    super.init(self,data)
    self.character = data.properties and data.properties.chara
    self:setSprite("objects/"..self.character.."puppet")
    if self.character == "asr" then
        self.solid = false
    else
        self:setHitbox(6,self.height-5,self.width-6-6,5)
        self.solid = true
    end
    self:setOrigin(0,1)
    self.siner = love.math.random(32767)
    self.string_count = 3
end

function event:update()
    super.update(self)
    --self.x = self.old_x + Utils.round(Utils.wave(self.siner, -1, 1), 1) + 1
    self.sprite.y = (Utils.round(Utils.wave(self.siner-math.pi/2, -3, 3), 1) + 1)
    self.siner = self.siner +DT
end

function event:draw()
    if self.character == "kr" then
        Draw.setColor(COLORS.red)
    else
        Draw.setColor{0.706, 0.627, 0.918}
    end
    --[[for i = 1, self.string_count do
        -- TODO: Find formula that more or less eliminates the clumping
        local tsiner = ((i*2*math.pi/self.string_count) + (self.siner))
        if i == 3 then tsiner = tsiner * 2 end
        local x = Utils.round(Utils.wave(tsiner, 6, 18), 1) + 1
        love.graphics.setLineWidth(2)
        love.graphics.line(x, 10, x, -200)
    end]]
    love.graphics.setLineWidth(2)
    love.graphics.line(math.sin(self.siner/2)*3+10, -350+self.height/2, math.sin(self.siner/2)*2+10, 10+(Utils.round(Utils.wave(self.siner-math.pi/2, -3, 3), 1) + 1))
    love.graphics.line(math.cos(self.siner/2)*3+14, -350+self.height/2, math.cos(self.siner/2)*3+14, 10+(Utils.round(Utils.wave(self.siner-math.pi/2, -3, 3), 1) + 1))
    love.graphics.line(math.sin(self.siner+math.pi/2)*3+20, -350+self.height/2, math.cos(self.siner+math.pi/2)*1+20, 10+(Utils.round(Utils.wave(self.siner-math.pi/2, -3, 3), 1) + 1))
    super.draw(self)
end

return event