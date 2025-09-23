local Basic, super = Class(Wave)
function Basic:init()
    super:init(self)

    -- Initialize timer
    self.time = 12

    self.layer = BATTLE_LAYERS["above_arena"]
end

function Basic:onStart()
    Game.battle:swapSoul(PurpleSoulSkerch())

    self.strings = {
        Game.battle.arena.height / 2
    }
    Game.battle.soul.string_count = 1
    Game.battle.soul.current_string = 1

    
	-- battle stuff start
    self.timer:after(1, function()
        -- Our X position is offscreen, to the right


        local flowerBase = self:spawnBullet("smallbullet", SCREEN_WIDTH / 2, 60)
		Assets.playSound("bluh")
		flowerBase:setSprite("bullets/bigeye")
		flowerBase.layer = flowerBase.layer + 10
		flowerBase.scale_x = 0
		flowerBase.scale_y = 0
		self.timer:tween(1, flowerBase, {scale_x = 2}, "out-elastic")
		self.timer:tween(1, flowerBase, {scale_y = 2}, "out-elastic")
		
		local counterr = 1

		local splode = 0

		self.timer:after(1/1, function()
			self.timer:everyInstant(1/5, function()
				local flowerPetal = self:spawnBullet("smallbullet", SCREEN_WIDTH / 2, 110)
				Assets.playSound("wing")
				flowerPetal.destroy_on_hit = false
				flowerPetal:setSprite("bullets/bigpetal")
					flowerPetal:setRotationOrigin(0.5, -1.5)
				flowerPetal.rotation = math.rad(92 * (counterr - 1))
				flowerPetal:setHitbox(5, 5, flowerPetal.width-10, flowerPetal.height-10)
				flowerPetal.scale_x = 0
				flowerPetal.scale_y = 0
				self.timer:tween(0.2, flowerPetal, {scale_x = 2}, "out-sine")
				self.timer:tween(0.2, flowerPetal, {scale_y = 2}, "out-sine")
				local release = 0

				local once = true

				counterr = counterr + 1
				self.timer:after((1/1 * counterr) - 1/2, function()
					flowerPetal:shake(3, 0, 0.5, 1/30 * DTMULT)
					Assets.playSound("break1")
				end)
				self.timer:after(1/1 * counterr, function()
					Assets.playSound("break2")
					release = 1

					self.timer:tween(1/Game:getFlag("bul_speed"), flowerPetal, {y = flowerPetal.y + 520}, "in-sine")
				end)
				self.timer:everyInstant(1/100, function()
					if release == 0 then
						flowerPetal.rotation = flowerPetal.rotation + math.rad(1)
					end
					if once and flowerPetal.y >= 540 then
						local rand = love.math.random(1, math.pi, 0.1)
						once = false
						if splode%2 == 0 then
							Assets.playSound("bomb")
							for i=1, 19 do
								local rot = math.pi*2/19
								if i%2 == 0 then
									local bul = self:spawnBullet("pellet", flowerPetal.x, flowerPetal.y, rand+rot*i, 7*Game:getFlag("bul_speed"))
									bul.remove_offscreen = false
								else
									local bul = self:spawnBullet("pellet", flowerPetal.x, flowerPetal.y, rand+rot*i, 8*Game:getFlag("bul_speed"))
									bul.remove_offscreen = false
								end
							end
							self.timer:after(0.1, function ()
								rand = rand + math.pi*2/38
								for i=1, 19 do
									local rot = math.pi*2/19
									if i%2 == 1 then
										local bul = self:spawnBullet("pellet", flowerPetal.x, flowerPetal.y, rand+rot*i, 7*Game:getFlag("bul_speed"))
										bul.remove_offscreen = false
									else
										local bul = self:spawnBullet("pellet", flowerPetal.x, flowerPetal.y, rand+rot*i, 8*Game:getFlag("bul_speed"))
										bul.remove_offscreen = false
									end
								end
							end)
						else
							Assets.playSound("chomping", 1, 0.7)
							local bul1 = self:spawnBullet("smallbullet", flowerPetal.x, flowerPetal.y-40, math.pi+math.pi*(1/4), 10)
							local bul2 = self:spawnBullet("smallbullet", flowerPetal.x, flowerPetal.y-40, math.pi+math.pi*(3/4), 10)
							local bul3 = self:spawnBullet("smallbullet", flowerPetal.x, flowerPetal.y-40, math.pi+math.pi*(0.5/4), 10)
							local bul4 = self:spawnBullet("smallbullet", flowerPetal.x, flowerPetal.y-40, math.pi+math.pi*(3.5/4), 10)
							bul1.remove_offscreen = false
							bul2.remove_offscreen = false
							bul3.remove_offscreen = false
							bul4.remove_offscreen = false
							bul1.sprite.alpha = 0
							bul2.sprite.alpha = 0
							bul3.sprite.alpha = 0
							bul4.sprite.alpha = 0
							self.timer:tween(0.5, bul1.sprite, {alpha = 1})
							self.timer:tween(0.5, bul2.sprite, {alpha = 1})
							self.timer:tween(0.5, bul3.sprite, {alpha = 1})
							self.timer:tween(0.5, bul4.sprite, {alpha = 1})
							bul1:setSprite("bullets/chomper_closed")
							bul2:setSprite("bullets/chomper_closed")
							bul3:setSprite("bullets/chomper_closed")
							bul4:setSprite("bullets/chomper_closed")
							bul1.flip_x = false
							bul3.flip_x = false
							bul1.physics.friction = 0.3
							bul2.physics.friction = 0.3
							bul3.physics.friction = 0.3
							bul4.physics.friction = 0.3
							self.timer:after(0.6, function()
								bul1.sprite:setAnimation({"bullets/chomper", 1/10, false})
								bul2.sprite:setAnimation({"bullets/chomper", 1/10, false})
								bul3.sprite:setAnimation({"bullets/chomper", 1/10, false})
								bul4.sprite:setAnimation({"bullets/chomper", 1/10, false})
								bul1.physics.direction = Utils.angle(bul1.x, bul1.y, Game.battle.soul.x, Game.battle.soul.y)
								bul2.physics.direction = Utils.angle(bul2.x, bul2.y, Game.battle.soul.x, Game.battle.soul.y)
								bul3.physics.direction = Utils.angle(bul3.x, bul3.y, Game.battle.soul.x, Game.battle.soul.y)
								bul4.physics.direction = Utils.angle(bul4.x, bul4.y, Game.battle.soul.x, Game.battle.soul.y)
								if bul1.x > Game.battle.soul.x then
									bul1.flip_x = false
								else
									bul1.flip_x = true
								end
								if bul2.x > Game.battle.soul.x then
									bul2.flip_x = false
								else
									bul2.flip_x = true
								end
								if bul3.x > Game.battle.soul.x then
									bul3.flip_x = false
								else
									bul3.flip_x = true
								end
								if bul4.x > Game.battle.soul.x then
									bul4.flip_x = false
								else
									bul4.flip_x = true
								end
								bul1.physics.friction = -0.5*Game:getFlag("bul_speed")
								bul2.physics.friction = -0.5*Game:getFlag("bul_speed")
								bul3.physics.friction = -0.5*Game:getFlag("bul_speed")
								bul4.physics.friction = -0.5*Game:getFlag("bul_speed")
								bul1.physics.speed = 2*Game:getFlag("bul_speed")
								bul2.physics.speed = 2*Game:getFlag("bul_speed")
								bul3.physics.speed = 2*Game:getFlag("bul_speed")
								bul4.physics.speed = 2*Game:getFlag("bul_speed")
								--[[self.timer:everyInstant(1/10, function ()
									local spr1 = Sprite(bul1.sprite:getTexture(), bul1.x+bul1.sprite.width/2, bul1.y+bul1.sprite.height/2)
									local spr2 = Sprite(bul2.sprite:getTexture(), bul2.x+bul2.sprite.width/2, bul2.y+bul2.sprite.height/2)
									local spr3 = Sprite(bul3.sprite:getTexture(), bul3.x+bul3.sprite.width/2, bul3.y+bul3.sprite.height/2)
									local spr4 = Sprite(bul4.sprite:getTexture(), bul4.x+bul4.sprite.width/2, bul4.y+bul4.sprite.height/2)
									spr1:setScale(2)
									spr2:setScale(2)
									spr3:setScale(2)
									spr4:setScale(2)
									spr1.layer = BATTLE_LAYERS["below_bullets"]
									spr2.layer = BATTLE_LAYERS["below_bullets"]
									spr3.layer = BATTLE_LAYERS["below_bullets"]
									spr4.layer = BATTLE_LAYERS["below_bullets"]
									local after1 = Game.world:spawnObject(AfterImage(spr1, 1, 0.05))
									local after2 = Game.world:spawnObject(AfterImage(spr2, 1, 0.05))
									local after3 = Game.world:spawnObject(AfterImage(spr3, 1, 0.05))
									local after4 = Game.world:spawnObject(AfterImage(spr4, 1, 0.05))
									after1.flip_x = bul1.flip_x
									after2.flip_x = bul2.flip_x
									after3.flip_x = bul3.flip_x
									after4.flip_x = bul4.flip_x
								end, 100)]]
							end)
						end
						splode = splode + 1
					end
				end)
			end, 5)
		end)
    end)
end

function Basic:update()
    super.update(self)
end


return Basic
