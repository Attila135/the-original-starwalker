local ThrownVine, super = Class(Solid)

function ThrownVine:init(filled, x, y, width, height)
    -- Last argument = sprite path
    super.init(self, filled, x, y, width, height)

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = 0
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = 0
    self.destroy_on_hit = false
    self:setOrigin(0)

    self.sprite = self:addChild(Sprite("bullets/vinespike", 0, self.height))
    self.sprite:setOrigin(0, 1)
    self.sprite:setScale(2)
    self.sprite.alpha = 0
    self.sprite.layer = 0
    self.sprite:setColor(0, 50/255, 1)

    self.squish_damage = 100

    self.hurted = false

	--[[self.damage = 0
    self.sprite:setAnimation({"bullets/vinespike_warning", 1/10, true})
    Game.stage.timer:after(0.7, function()]]
    self.sprite.scale_y = 0.1
	Game.stage.timer:tween(0.5, self.sprite, {scale_y = 2.5, alpha = 1}, "out-back")
	-- end)

    --Game.stage.timer:after(1.45, function()
	    --Game.stage.timer:tween(1, self.sprite, {scale_y = 0}, "in-quint")
	    --Game.stage.timer:tween(1, self.sprite, {alpha = 0}, "in-quint")
	--end)
end

function ThrownVine:update()
    -- For more complicated bullet behaviours, code here gets called every update

    --self.sprite.x = self.x
    --self.sprite.y = self.y
    super.update(self)
end

function ThrownVine:onSquished(soul)
    local battler = Utils.pick(Game.battle:getActiveParty())
    if not self.hurted then
        if battler then
            battler:hurt(self.squish_damage)
        end
        self.hurted = true
    end
end



return ThrownVine