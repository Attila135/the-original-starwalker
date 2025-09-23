local Wilter, super = Class(WorldBullet)

function Wilter:init(x, y, flip)
    super.init(self, x, y, "enemies/dummy/run/down")
    self.sprite:setAnimation({"enemies/dummy/run/down", 1/10, true})

    self:setScale(2)
    self:setHitbox(0, 0, self.width, self.height)
end

function Wilter:postLoad()
    
end

function Wilter:update()
    super.update(self)
    self:setLayer(Game.world.player.layer)
end

function Wilter:onCollide(soul)
    if self.world then
        if not self.world:inBattle() then return end

        if not Game:getFlag("died_to_Chase") then
            self:remove()
            Game.world:startCutscene("chase.death")
        end
    end
end

return Wilter