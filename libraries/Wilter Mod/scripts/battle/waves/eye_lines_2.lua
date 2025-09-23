local Basic, super = Class(Wave, "eye_lines_2")
function Basic:init()
    super:init(self)

    -- Initialize timer
    self.time = 10


    self.layer = BATTLE_LAYERS["above_arena"]
end

function Basic:onStart()
    Game.battle:swapSoul(PurpleSoulSkerch())

    -- Every 0.33 seconds...
    self.timer:every(1/2, function()
        local mamadog = Utils.pick({"line1", "line2", "line3", "line1_2", "line2_2", "line3_2"})
        local spd = math.random(7,13)*Game:getFlag("bul_speed")
        
        if mamadog == "line1" then
            local x = SCREEN_WIDTH + 20
            local y = 120

            local bullet = self:spawnBullet("eyeball", x, y, math.rad(180), spd)

            bullet.remove_offscreen = false
        elseif mamadog == "line2" then
            local x = SCREEN_WIDTH + 20
            local y = 170

            local bullet = self:spawnBullet("eyeball", x, y, math.rad(180), spd)

            bullet.remove_offscreen = false
        elseif mamadog == "line3" then
            local x = SCREEN_WIDTH + 20
            local y = 220
            local bullet = self:spawnBullet("eyeball", x, y, math.rad(180), spd)

            bullet.remove_offscreen = false
        elseif mamadog == "line1_2" then
            local x = -20
            local y = 120

            local bullet = self:spawnBullet("eyeball_flipped", x, y, math.rad(0), spd)

            bullet.remove_offscreen = false
        elseif mamadog == "line2_2" then
            local x = -20
            local y = 170

            local bullet = self:spawnBullet("eyeball_flipped", x, y, math.rad(0), spd)

            bullet.remove_offscreen = false
        elseif mamadog == "line3_2" then
            local x = -20
            local y = 220
            local bullet = self:spawnBullet("eyeball_flipped", x, y, math.rad(0), spd)

            bullet.remove_offscreen = false
        end
    end)

    local y = Utils.round(love.math.random(0, 1))

    self.timer:every(3, function ()
        Assets.playSound("chomping", 1, 0.7)
            local bul1 = self:spawnBullet("smallbullet", 320, 480*y, math.pi+math.pi*(1/4)-math.pi*Utils.clampMap(y, 0, 1, 1, 0), 10)
            local bul2 = self:spawnBullet("smallbullet", 320, 480*y, math.pi+math.pi*(3/4)-math.pi*Utils.clampMap(y, 0, 1, 1, 0), 10)
            local bul3 = self:spawnBullet("smallbullet", 320, 480*y, math.pi+math.pi*(0.5/4)-math.pi*Utils.clampMap(y, 0, 1, 1, 0), 10)
            local bul4 = self:spawnBullet("smallbullet", 320, 480*y, math.pi+math.pi*(3.5/4)-math.pi*Utils.clampMap(y, 0, 1, 1, 0), 10)
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
                bul1.physics.speed = 2
                bul2.physics.speed = 2
                bul3.physics.speed = 2
                bul4.physics.speed = 2
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
    end)
end

return Basic
