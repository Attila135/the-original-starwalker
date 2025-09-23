local DustClaw, super = Class(Bullet)
local targetRotation = 0
local timeVar2 = 0
local desX2 = 0
local desY2 = 0
local activeAim = false
local isDying = false


function DustClaw:onCollide(soul)
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

-- function DustClaw:onDamage()
-- super.onDamage(self)
-- Kristal.Console:log("Cursed real!")
-- if Game:getConfig("targetSystem") then
-- 			local target = self:getTarget()
-- 
-- 			Kristal.Console:log("Cursed real!")
-- 		end
-- end

function DustClaw:init(x, y, dir, speed, desX, desY)
    -- Last argument = sprite path
    self.isDark = true;
    self.desX2 = desX
    self.desY2 = desY
    self.activeAim = true
    self.timeVar2 = 0
    self.isDying = false
    super.init(self, x, y, "bullets/dustclaw")
    self.targetRotation = Utils.angle(self.x, self.y, self.desX2, self.desY2)
    self.layer = self.layer + 1
    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.rotation = dir
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    -- self.damage = 0
    -- self.tp = 0
    self.damage = 80;
    self.alpha = 0
    --self:setScale(2, 1);
    self.destroy_on_hit = false
    --self.sprite:setScaleOrigin(0.5, 0.5)
    --self.sprite:setScale(1, 2)self.destroy_on_hit = false;
    self.collider = Hitbox(self, self.sprite.width / 2 + 20, self.sprite.height / 2 - 1, 20, 2);

    self.maxSpeed = 14;
    self.originMaskaught = nil;

    --self.tp = 0;
    self.spawnedGraze = true;
    -- self:shake(8);
end

function DustClaw:update()
    -- For more complicated bullet behaviours, code here gets called every update
    if (self.spawnedGraze == false) then self.wave:spawnBullet("grazerbullet", self, 5); self.spawnedGraze = true; else end

    if (self.isDying == false)
        then
        if self.alpha < 1
            then
            self.alpha = self.alpha + 0.06 * DTMULT;
            else
            self.isDying = true;
            if (self.originMaskaught ~= nil)
                then
                self.originMaskaught.willSoundSlice = true;
                end
            end
        else
        self.alpha = self.alpha - 0.04 * DTMULT
        if (self.alpha <= 0.3) 
            then 
            self.damage = 0
            self.tp = 0;
            self.destroyGraze = 1;
            else
            
            end
        end
    if (self.isDying == true)
        then
        if (self.physics.speed < self.maxSpeed) then self.physics.speed = self.physics.speed * 1.255; end
        end
    

    super.update(self)
    self.timeVar2 = self.timeVar2 + 1
    if (self.rotation ~= self.targetRotation)
    then
    --self.targetRotation = Utils.angle(self.x, self.y, self.desX2, self.desY2)
    self.rotation = Utils.approachAngle(self.rotation, self.targetRotation, Utils.ease(0, 10, self.timeVar2 / 60, "in-out-quad"))
    self.physics.direction = self.rotation
    end

end

return DustClaw