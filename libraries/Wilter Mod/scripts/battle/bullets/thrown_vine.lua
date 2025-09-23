local ThrownVine, super = Class(Bullet)

function ThrownVine:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/vinespike_warning")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.destroy_on_hit = false
    self:setOrigin(0.5, 1)
	--[[self.damage = 0
    self.sprite:setAnimation({"bullets/vinespike_warning", 1/10, true})
    Game.stage.timer:after(0.7, function()]]
    self:setSprite("bullets/vinespike")
	self.scale_y = 0.1
	self:setHitbox(8, 0, 3, 160)
	Game.stage.timer:tween(0.4/Game:getFlag("bul_speed"), self, {scale_y = 2.5}, "out-back")
	-- end)

    --Game.stage.timer:after(1.45, function()
	    Game.stage.timer:tween(1/Game:getFlag("bul_speed"), self, {scale_y = 0}, "in-quint")
	    Game.stage.timer:tween(1/Game:getFlag("bul_speed"), self, {alpha = 0}, "in-quint")
	--end)
    Game.stage.timer:after(1.45/Game:getFlag("bul_speed"), function()
	    self:remove()
	end)
    Game.stage.timer:after(.7/Game:getFlag("bul_speed"), function()
	    self.collidable = false
        self.collider.x = -700
	end)
end

function ThrownVine:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
end

return ThrownVine