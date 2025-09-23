---@class Bullet.wilter.final_fist : Bullet
local bullet, super = Class(Bullet, "wilter.final_fist")

function bullet:init(x,y, left)
    super.init(self,x,y, "bullets/wilter/fist")
    if self.width == 128 then
        self:setScale(1)
    end
    self.remove_offscreen = false
    self.destroy_on_hit = false
    self.left = not not left
    self.origin_x = (not self.left) and 1 or 0
    self.sprite.flip_x = self.left
    self:slideTo(self.left and Game.battle.arena:getLeft() or Game.battle.arena:getRight(), self.y, 1, nil, function ()
        self.init_x = self.x
        self.init_y = self.y
        self.collidable = true
    end)
    self.collidable = false
    self.alpha = 0
    self:fadeTo(1,1)
    self.my_inv_timer = 0
    self:setHitbox(10,10,self.width-10-10, self.height-10-10)
    self.health = 5
    self.afterimage_timer = -math.huge
end

function bullet:update()
    super.update(self)
    self.my_inv_timer = self.my_inv_timer - DT
    self.afterimage_timer = self.afterimage_timer + (DT*2)
    if self.afterimage_timer > 0.1 then
        self.afterimage_timer = 0
        self.parent:addChild(AfterImage(self, 0.5, 0.03))
    end
    self:checkSoulCollision()
end

function bullet:checkSoulCollision()
    if not Game.battle.soul.dashing then return end
    if self.my_inv_timer > 0 then return end
    local o_collidable = Game.battle.soul.collidable
    Game.battle.soul.collidable = true
    if self:collidesWith(Game.battle.soul.collider) then
        self.my_inv_timer = 0.5
        self:shake(10)
        Assets.playSound("fistdamage")
        if Game.battle.soul.goal_x > Game.battle.soul.x then
            Game.battle.soul.goal_x = Game.battle.soul.x - 30
        else
            Game.battle.soul.goal_x = Game.battle.soul.x + 30
        end
        self.health = self.health - 1
        if self.health <= 0 then
            self:explode()
        end
    end
    Game.battle.soul.collidable = o_collidable
end

function bullet:onDamage(soul)
    local damage = self:getDamage()

    local battlers = Game.battle:hurt(damage, false, self:getTarget())
    soul.inv_timer = self.inv_timer
    soul:onDamage(self, damage)
    return battlers
end

return bullet