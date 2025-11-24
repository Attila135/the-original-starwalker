local fancy_ralsei, super = Class(Bullet)

function fancy_ralsei:onDamage(soul)
if (self.damage ~= 0)
    then
    super.onDamage(self, soul) 
    --self.damage = 0;
    self.tp = 0;
    end

end

function fancy_ralsei:onCollide(soul)
super.onCollide(self, soul)
if (self.damage ~= 0)
    then
    --self.damage = 0;
    self.tp = 0;
    end

end

function fancy_ralsei:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/fancy_lineward")

    self.ravenAnim = {"bullets/fancy_lineward", 0.06, true, frames = {1, 1, 2, 3, 3, 2}};
    self.sprite:setAnimation(self.ravenAnim);

    --self.threadSprite = Sprite("ralseithreads"); 
    --self:addChild(self.threadSprite);
    --Kristal.Console:log("T");

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed

    self.destroy_on_hit = false;
    self.remove_offscreen = false;
    self.alwaysBreak = true;
    self.damage = 10;
    self.tp = 0;

    self.alpha = 0;
    self.timer = Timer();
    self:addChild(self.timer);
    --self.timer:tween(1.0, self, {collider.radius = 100}, 'out-quad');
    self.timer:tween(0.3, self, {alpha = 1}, 'in-quad');
    --self.inv_timer = 0.2;

    self.isBreak = true;
    self.breakType = "lineward"

end

function fancy_ralsei:remove()
    --local ralsei = Game.world:getCharacter("ralsei");
    --ralsei:shake(5);
    self.wave.threadAmount = self.wave.threadAmount + 1;
    super.remove(self)
end

function fancy_ralsei:update()
    -- For more complicated bullet behaviours, code here gets called every update
    --local lineX, lineY = self:getScreenPos();
    --if (lineX < Game.battle.arena.x - Game.battle.arena.width / 2)
    --    then
    --    self.wave:spawnBullet("breakexplosion", lineX, lineY);
    --    self:remove();
    --    end
    if (self.alpha < 1)
        then
        self.alpha = self.alpha + 0.01 * DTMULT;
        end

    super.update(self)
end

return fancy_ralsei