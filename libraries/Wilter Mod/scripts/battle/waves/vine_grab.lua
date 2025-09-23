local Basic, super = Class(Wave)
function Basic:init()
    super:init(self)

    -- Initialize timer
    self.time = 12
end

function Basic:onStart()
    Game.battle:swapSoul(PurpleSoulSkerch())

    self.strings = {
        Game.battle.arena.height / 2
    }
    Game.battle.soul.string_count = 1
    Game.battle.soul.current_string = 1

    self.drawLines = true
	self.timer:after(1/5, function()
    local vinetop = self:spawnBullet("smallbullet", 200, 130, math.rad(0), 0)
    vinetop.layer = self.layer + 0.01
	vinetop.sprite:setAnimation({"bullets/vine_hand", 1/10, false, frames={1,2,3,4}})
	vinetop.sprite:setOrigin(0, 0.42)
	vinetop.sprite.flip_x = true
	self.timer:after(1, function()
	vinetop.sprite:setSprite("bullets/vine_hand_5")
	self.timer:after(1/10, function()
	vinetop.sprite:setAnimation({"bullets/vine_hand", 1/10, false, frames={6,7}})
            Assets.playSound("impact")
	Game.battle:shakeCamera(2)
	end)
	end)

	self.timer:after(1/5, function()
	local vinebottom = self:spawnBullet("smallbullet", 437, 220, math.rad(180), 0)
    vinebottom.layer = self.layer + 0.01
	vinebottom.sprite:setAnimation({"bullets/vine_hand", 1/10, false, frames={1,2,3,4}})
	vinebottom.sprite:setOrigin(0.9, 0.42)
	self.timer:after(1, function()
	vinebottom.sprite:setSprite("bullets/vine_hand_5")
	self.timer:after(1/10, function()
	vinebottom.sprite:setAnimation({"bullets/vine_hand", 1/10, false, frames={6,7}})
            Assets.playSound("impact")
	Game.battle:shakeCamera(2)
	end)
	end)
	end)
	end)

    -- Every 0.33 seconds...
	self.timer:after(2/1, function()
		    self.timer:every(1, function()
      		  -- Our X position is offscreen, to the right

      		local left_or_right = Utils.random(0, 1, 1)
	
	
		if left_or_right == 0 then
     	   		local x, y = SCREEN_WIDTH + 20, (Game.battle.arena:getTop() + Game.battle.arena.bottom) / 2
     		   	local bullet2 = self:spawnBullet("smallbullet", x, y, math.rad(180), 7*Game:getFlag("bul_speed"))
       			bullet2.remove_offscreen = false
			bullet2.sprite:setAnimation({"bullets/eyeball", 0.1, true})
			bullet2.sprite:setOrigin(0, 0.2)
			bullet2:setLayer(1234)
		else
			local x, y = -20, (Game.battle.arena:getTop() + Game.battle.arena.bottom) / 2
     	  		local bullet2 = self:spawnBullet("smallbullet", x, y, math.rad(0), 7*Game:getFlag("bul_speed"))
       			bullet2.remove_offscreen = false
			bullet2.sprite:setAnimation({"bullets/eyeball", 0.1, true})
			bullet2.sprite.flip_x = true
			bullet2.sprite:setOrigin(-0.6, 0.2)
			bullet2:setLayer(1234)
		end
	
	
 	   end)
	end)
end

function Basic:draw()
    super.draw(self)
    if self.drawLines then
        Draw.setColor(Game.battle.soul.colors["soul"][1], Game.battle.soul.colors["soul"][2], Game.battle.soul.colors["soul"][3], 0.5)
        love.graphics.line(Game.battle.arena:getLeft()+15, Game.battle.arena:getTop()+30, Game.battle.arena:getRight()-15, Game.battle.arena:getTop()+30)
        love.graphics.line(Game.battle.arena:getLeft()+15, Game.battle.arena:getTop()+Game.battle.arena.height-30, Game.battle.arena:getRight()-15, Game.battle.arena:getTop()+Game.battle.arena.height-30)
    end
end

return Basic
