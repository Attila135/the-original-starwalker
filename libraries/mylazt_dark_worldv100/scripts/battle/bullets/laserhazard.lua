local laserhazard, super = Class(Bullet)

function laserhazard:onCollide(soul)
super.onCollide(self, soul)
if (self.damage > 0)
    then
            -- Kristal.Console:log("fakecollidee!")
            local targets = Game.battle:getPartyFromTarget(self:getTarget())
            for _, target in ipairs(targets) do
            -- target.x = target.x + 5
            target.isCursed = true
        
            end
    end
end

function laserhazard:init(x, y, rotation)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/laserhazard")
    self.isDark = true;
    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self:setOrigin(0.5, 0.5);
    self:setRotationOrigin(0.5, 0.5);
    -- self:setHitbox(0, 0, 500, 3)
    --self.width = 900;
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.rotation = rotation;
    --self.collider.rotation = rotation;
    self.alpha = 3;
    self.damage = 80;
    self.destroy_on_hit = false;
    self.sprite.wrap_texture_x = true;
    self:shake(6);
    --Assets.playSound("darkstrike")
    --self.sprite.width = 99999;
    --self.sprite:setScale(40, 1);
    Game.battle.willSoundStrike = true;
    self:setScale(2, 1);
    self.sprite:setScaleOrigin(0.5, 0.5);
    self.sprite:setScale(1, 2);
    self.sprite.wrap_texture_x = true;

end

function laserhazard:update()
    -- For more complicated bullet behaviours, code here gets called every update
    self.alpha = self.alpha - 0.2 * DTMULT;
    if (self.alpha <= 0.5) then self.damage = 0; end
    if (self.alpha <= 0) then self:remove(); end
    super.update(self)
end

return laserhazard