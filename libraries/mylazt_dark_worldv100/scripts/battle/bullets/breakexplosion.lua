local breakexplosion, super = Class(Bullet)

function breakexplosion:onDamage(soul)
if (self.damage ~= 0)
    then
    super.onDamage(self, soul) 
    self.damage = 0;
    self.tp = 0;
    end

end

function breakexplosion:onCollide(soul)
super.onCollide(self, soul)
if (self.damage ~= 0)
    then
    self.damage = 0;
    self.tp = 0;
    end

end

function breakexplosion:init(x, y)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/smallbullet")
    self.collider = CircleCollider(self, 0, 0, 0);
    self.alpha = 0.8;

    self.destroy_on_hit = false;
    self.damage = 80;

    self.inv_timer = 0.0;
    self.bRadius = 0;

    self.timer = Timer();
    self:addChild(self.timer);
    --self.timer:tween(1.0, self, {collider.radius = 100}, 'out-quad');
    self.timer:tween(1.0, self, {bRadius = 150, alpha = 0}, 'out-quad');

    Assets.playSound("darkthorn")

end

function breakexplosion:draw()
    love.graphics.circle("fill", 0, 0, self.collider.radius)
    --love.graphics.circle("line", 0, 0, self.collider.radius)
    --super.draw(self);
end

function breakexplosion:update()
    self.collider.radius = self.bRadius;
    if (self.alpha <= 0) then self:remove(); end
    -- For more complicated bullet behaviours, code here gets called every update
    super.update(self)
end

return breakexplosion