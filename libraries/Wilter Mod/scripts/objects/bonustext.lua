local ThrownVine, super = Class(Object)

function ThrownVine:init(x, y)
    -- Last argument = sprite path
    super.init(self)
    self:setOrigin(0.5)

    self.sprite = Sprite("ui/battle/msg/bonus", 0, 0)
    self.sprite:setOrigin(0.5)
    self.sprite:setScale(2)
    self:addChild(self.sprite)

	--[[self.damage = 0
    self.sprite:setAnimation({"bullets/vinespike_warning", 1/10, true})
    Game.stage.timer:after(0.7, function()]]
    self.sprite.scale_y = 0.1
    self.sprite.alpha = 0
	Game.stage.timer:tween(1, self.sprite, {scale_y = 3, alpha = 1}, "out-quad")
    Game.stage.timer:after(1, function ()
        Game.stage.timer:tween(0.5, self.sprite, {scale_y = 6, alpha = 0, scale_x = 1}, "in-quad")
    end)
	-- end)

    --Game.stage.timer:after(1.45, function()
	    --Game.stage.timer:tween(1, self.sprite, {scale_y = 0}, "in-quint")
	    --Game.stage.timer:tween(1, self.sprite, {alpha = 0}, "in-quint")
	--end)
end

function ThrownVine:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
end



return ThrownVine