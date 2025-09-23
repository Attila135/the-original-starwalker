local Eye, super = Class(WorldBullet)

function Eye:init(x, y, flip)
    super.init(self, x, y, "bullets/eyeball")
    self.sprite:setAnimation({"bullets/eyeball", 1/10, true})

    self.physics.direction = math.pi/2

    self.damage = 60

    self.physics.speed = 12

    self.rotation = math.rad(270)

    self.start_y = y
end

function Eye:update()

    super.update(self)
end

function Eye:onCollide(soul)
    if self.world then
        if not self.world:inBattle() then return end

        local kris = Game:getPartyMember("kris")

        if soul.inv_timer == 0 then
            if kris:getHealth() > 60 and kris:getHealth() ~= 1 then
                self:onDamage(soul)
            elseif kris:getHealth() <= 60 and kris:getHealth() ~= 1 then
                self.damage = kris:getHealth() - 1
                self:onDamage(soul)
            elseif kris:getHealth() == 1 then
                self:remove()
                Game.world:startCutscene("chase.death")
            end
        end
    end
end

return Eye