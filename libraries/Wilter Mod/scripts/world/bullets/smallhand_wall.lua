local Eye, super = Class(WorldBullet)

function Eye:init(x, y, flip)
    super.init(self, x, y)

    self.physics.direction = 0

    self.rand = love.math.random(0, math.pi, 0.1)

    self.siner = 0

    self.rect = self:addChild(Rectangle(-SCREEN_WIDTH-10, 0, SCREEN_WIDTH, SCREEN_HEIGHT), 100)
    self.rect:setColor(0, 0, 0)
    self.rect:setLayer(2)

    self.rect2 = self:addChild(Rectangle(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT), 100)
    self.rect2:setColor(0, 0, 0)
    self.rect2.alpha = 0.5
    self.rect2:setLayer(2)

    self.rect3 = self:addChild(Rectangle(-SCREEN_WIDTH+5, 0, SCREEN_WIDTH, SCREEN_HEIGHT), 100)
    self.rect3:setColor(0, 0, 0)
    self.rect3.alpha = 0.2
    self.rect3:setLayer(2)
    self:setHitbox(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
end

function Eye:draw()
    super.draw(self)
    if DEBUG_RENDER then
        self.collider:draw(COLORS.white)
    end
end

function Eye:update()
    super.update(self)
    self.x = self.x + (4*DTMULT)

    --self.speed = Utils.clampMap(Utils.dist(self.x, self.y, Game.world.player.x, Game.world.player.y), 50, 400, 4, 8)

end

function Eye:onCollide(soul)
    if self.world then
        if not self.world:inBattle() then return end

        if not Game:getFlag("died_to_Chase") then
            self:remove()
            Game.world:startCutscene("chase.death")
        end
    end
end

return Eye