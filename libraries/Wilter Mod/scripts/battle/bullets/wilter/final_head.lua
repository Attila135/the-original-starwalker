---@class Bullet.wilter.final_head : Bullet
---@field wave Wave.wilter.final
local bullet, super = Class(Bullet, "wilter.final_head")

function bullet:init(x,y)
    super.init(self,x,y,"bullets/wilt_head")
    self.destroy_on_hit = false
    self.vulnerable = false
    self.health = 5
    self.my_inv_timer = 0
    self:setDamaged(false)
    self:setHitbox(5,5,self.width-10, self.height-10)
    self.timer = self:addChild(Timer())
    self.timer:script(function (wait)
        wait()
        self:script(Utils.override(wait, function (orig, sec)
            if type(sec) == "function" then
                repeat orig(0) until sec()
            else
                orig(sec or 0)
            end
        end))
    end)
    self.alpha = 0
    self.collidable = false
    self:fadeTo(1,1,function ()
        self.collidable = true
    end)
    self.y = self.y - 70
    self:slideTo(self.init_x, self.init_y, 1)
end

function bullet:script(wait)
    while true do
        wait(self.wave:getFistCount())
        Assets.playSound("alarm")
        local out1 = self.sprite:addFX(OutlineFX()):setColor(Utils.unpackColor(Utils.hexToRgb("#ff0000")))
        wait(0.2)
        Assets.playSound("alarm")
        local out2 = self.sprite:addFX(OutlineFX()):setColor(Utils.unpackColor(Utils.hexToRgb("#ff0000")))
        wait(0.2)
        Assets.playSound("alarm")
        local out3 = self.sprite:addFX(OutlineFX()):setColor(Utils.unpackColor(Utils.hexToRgb("#ff0000")))
        wait(0.2)
        self.sprite:removeFX(out1)
        self.sprite:removeFX(out2)
        self.sprite:removeFX(out3)
        wait(function () return self.sprite.frame == 1 and not string.find(self.sprite.texture_path, "hurt") end)
        self.sprite.active = false
        self.sprite:setFrame(1)
        for i=0, love.math.random(7,10-(self.wave:getFistCount()*4)), 1 do
            local pellet = self.wave:spawnBullet("pellet", self.x, self.y + (self.height/2), math.rad(Utils.random(-90, 90))+Utils.angle(self, Game.battle.soul), 11 - (2*self.wave:getFistCount())*Game:getFlag("bul_speed"))
            if i % 3 == 0 then
                Assets.stopAndPlaySound("noise")
                wait(1/15)
            end
            pellet.physics.gravity = .5
        end
        self.sprite.active = true
        wait(1)
    end
end

function bullet:takeDamage(soul)
    if self.vulnerable then
        Assets.playSound("fistdamage")
        self:shake(10)
        self.health = self.health - 1
        self:setDamaged(true)
        if self.health <= 0 then
            self:explode()
        end
    else
        Assets.playSound("bump",4)
    end
end

function bullet:setDamaged(damaged)
    local suffix = damaged and "_damage" or ""
    if self.health <= 2 then
        self.sprite:setAnimation{"bullets/wilt_head_eyeless" .. suffix, 0.2, true}
    elseif self.health <= 3 then
        self.sprite:setAnimation{"bullets/wilt_head_one_eye" .. suffix, 0.2, true}
    else
        self.sprite:setAnimation{"bullets/wilt_head" .. suffix, 0.2, true}
    end
end

function bullet:update()
    super.update(self)
    local prev_timer = self.my_inv_timer
    self.my_inv_timer = self.my_inv_timer - DT
    if prev_timer > 0 and self.my_inv_timer <= 0 then
        self:setDamaged(false)
    end
    self:checkSoulCollision()
    if self.vulnerable then
    end
end

function bullet:checkSoulCollision()
    if not Game.battle.soul.dashing then return end
    if self.my_inv_timer > 0 then return end
    local o_collidable = Game.battle.soul.collidable
    Game.battle.soul.collidable = true
    if self:collidesWith(Game.battle.soul.collider) then
        self.my_inv_timer = 0.5
        if Game.battle.soul.goal_x > Game.battle.soul.x then
            Game.battle.soul.goal_x = Game.battle.soul.x - 30
        else
            Game.battle.soul.goal_x = Game.battle.soul.x + 30
        end
        self:takeDamage(Game.battle.soul)
    end
    Game.battle.soul.collidable = o_collidable
end

return bullet