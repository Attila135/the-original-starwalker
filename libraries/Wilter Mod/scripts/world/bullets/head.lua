local Head, super = Class(WorldBullet)

function Head:init(x, y, flip)
    super.init(self, x, y, "objects/wilthead")

    self.physics.direction = math.pi/2

    self.damage = 0

    self.physics.speed = 0.7

    self:setScale(0)

    self.alpha = 0

    self.layer = Game.world.player.layer-0.01

    self.physics.friction = -0.57

    Game.world.timer:tween(0.5, self, {scale_x = 2, scale_y = 2, alpha = 1})
    Game.world.timer:after(0.5, function ()
        self.physics.friction = 0
    end)

    self.start_y = y

    self.disappeared = false
end

--[[function Head:onAdd()
    self:addFX(MaskFX(Game.world.map:getEvent("headmask")))
end]]

function Head:update()
    if not self.disappeared and math.abs(self.y - self.start_y) >= self.world.map.tile_height * 50 then
        self.physics.friction = 0.57
        Game.world.timer:tween(0.5, self, {scale_x = 0, scale_y = 0, alpha = 0})
        self.disappeared = true
        Game.world.timer:after(0.5, function ()
            self:remove()
        end)
    end

    super.update(self)
end

function Head:onCollide(soul)
    if not soul:includes(OverworldSoul) then return end
    if self.world then
        soul:remove()
        if not self.world:inBattle() then return end

        if not Game:getFlag("died_to_Chase") then
            Assets.stopAndPlaySound("alert")
            self:remove()
            Game.world:startCutscene("chase.death")
        end
    end
end

return Head