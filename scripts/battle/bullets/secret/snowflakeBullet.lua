local snowflakeBullet_shadow, super = Class("snowflakeBullet")

function snowflakeBullet_shadow:init(x, y, dir, speed)
	super:init(self, x, y, 0, 0, false, 0)

	self.dir = dir
	self.speed = speed

	self.timer = 0
	self.start = false

	self.remove_offscreen = false

	self:setScaleOrigin(0.5, 0.5)

	self.shadow = Sprite("bullets/snowflakeBullet-shadow"..(dir=="left" and "L" or "R"))
	self.shadow:setScale(1)
	self.shadow:setLayer(self.layer+1)
	self.shadow.alpha = 0
	self:addChild(self.shadow)

	self:setScale(0)
end

function snowflakeBullet_shadow:onWaveSpawn(wave)
	self.af_timer = wave.timer:everyInstant(1/16, function()
        Game.battle:addChild(AfterImage(self.sprite, 0.5))
    end)
	wave.timer:script(function(wait)
		wave.timer:tween(0.25, self, {scale_x=1, scale_y=1})
		wait(0.5)
		Assets.playSound("bell")
		self.shadow.alpha = 1
		wave.timer:tween(0.5, self.shadow, {alpha=0})
		wait(0.5)
		Assets.playSound("snd_spearrise")
		self.start=true
	end)
end

function snowflakeBullet_shadow:onRemoveFromStage()
    self.wave.timer:cancel(self.af_timer)
end

function snowflakeBullet_shadow:update()
	super:update(self)

	if self.start then
		if self.y>-20 and self.timer==0 then
			self.y = self.y - 20*DTMULT
			self.rotation = math.rad(math.deg(self.rotation) - 5*DTMULT)
			if self.y<-20 then
				self.timer = 1
				self.rotation = 0
				self.remove_offscreen = true
				if self.dir == "left" then
					self.x = Game.battle.arena.left+self.sprite.width/2
				else
					self.x = Game.battle.arena.right-self.sprite.width/2
				end
			end
		else
			self.timer = self.timer+DTMULT
			print(self.timer)

			if self.timer>6 then
				self.y = self.y + 20*DTMULT
			end
		end
	end
end

return snowflakeBullet_shadow