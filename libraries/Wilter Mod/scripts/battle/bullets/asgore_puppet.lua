local Puppet, super = Class(Bullet)

function Puppet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/asgore")
    self:setScale(0)

    self.old_x = self.x
    self.old_y = self.y

    self.siner = 0

    Game.battle.waves[1].timer:tween(1, self, {scale_x = 2, scale_y = 2}, "out-quad")
end

function Puppet:update()
    -- For more complicated bullet behaviours, code here gets called every update
    self.x = self.old_x + math.sin(self.siner/2)*7
    self.y = self.old_y + math.sin(self.siner)*10
    print(math.sin(self.siner)*20)
    self.siner = self.siner + DT
    super.update(self)
end

function Puppet:draw()
    Draw.setColor(1, 1, 1)
    love.graphics.setLineWidth(self.scale_x/2)
    love.graphics.line(math.sin(self.siner/2)*10+self.width/2, -350+self.height/2, math.sin(self.siner/2)*12+self.width/2, self.height/2)
    love.graphics.line(math.cos(self.siner/2)*10+self.width/2, -350+self.height/2, math.cos(self.siner/2)*7+self.width/2, self.height/2)
    love.graphics.line(math.sin(self.siner+math.pi/2)*10+self.width/2, -350+self.height/2, math.sin(self.siner+math.pi/2)*10+self.width/2, self.height/2)
    love.graphics.line(math.cos(self.siner+math.pi/2)*5+self.width/2-10, -350+self.height/2, math.cos(self.siner+math.pi/2)*5+self.width/2-10, self.height/2)
    super.draw(self)
end

return Puppet