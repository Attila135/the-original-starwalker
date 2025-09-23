local Aiming, super = Class(Wave)

function Aiming:onStart()
    self.time = 20

    for k,enemy in ipairs(self:getAttackers()) do
        self.ralsei = Sprite("bullets/ralsei/idle", 588, 159)
        self.ralsei:setAnimation({"bullets/ralsei/idle", 0.2, true})
        self.ralsei:setOrigin(0.5, 0.5)
        self.ralsei.scale_y = 2
        self.ralsei.scale_x = 2
        self.ralsei.alpha = 0
        self.ralsei.layer=BATTLE_LAYERS["top"]+15
        Game.battle:addChild(self.ralsei)
    end
    
    self.timer:after(18, function()
        self.ralsei:fadeOutAndRemove(1)
    end)
    
    self.aim2 = 0
    self.arena = Game.battle.arena
    Game.battle:swapSoul(BlueSoul())
        
        self.timer:every(2, function()
    for k,enemy in ipairs(self:getAttackers()) do
        --enemy.sprite:setSprite("battle/alt_attack_ready_1")
        warn = self:spawnBullet("warning", 320, Game.battle.soul.y, 0, 0)
        self.aim = true
        self.timer:after(0.5, function()
            self.aim = false
        end)
        self.timer:after(1, function()
        --enemy.sprite:setAnimation("battle/alt_attack", nil, false)
        slice = self:spawnBullet("slice", 320, warn.y, 0, 0)
        slice:fadeOutAndRemove(0.5)
        warn:remove()
        end)
    end
        end)
    
    self.timer:every(1/7, function()
    self.speed = 2
    r = math.random(3)
    if r == 1 then
    local x = SCREEN_WIDTH + 20
    local y = Utils.random(Game.battle.arena.top, Game.battle.arena.bottom)
    local bullet = self:spawnBullet("fire_1", x, y, math.rad(180), 4)
    bullet:setScale(0.7)
    bullet.remove_offscreen = false
    elseif r == 2 then
    local x = SCREEN_WIDTH/2 - 250
    local y = Utils.random(Game.battle.arena.top, Game.battle.arena.bottom)
    local bullet = self:spawnBullet("fire_1", x, y, math.rad(0), 4)
    bullet:setScale(0.7)
    bullet.remove_offscreen = false
    elseif r == 3 then
    local x = Utils.random(Game.battle.arena.left, Game.battle.arena.right)
    local y = Game.battle.arena.top - 100
    local bullet = self:spawnBullet("fire_1", x, y, math.rad(90), 4)
    bullet:setScale(0.7)
    bullet.remove_offscreen = false
    elseif r == 4 then
    local x = Utils.random(Game.battle.arena.left, Game.battle.arena.right)
    local y = Game.battle.arena.bottom + 100
    local bullet = self:spawnBullet("fire_1", x, y, math.rad(-90), 4)
    bullet:setScale(0.8)
    bullet.remove_offscreen = false
    end
end)

    
end

function Aiming:update()
    if self.ralsei.alpha < 0.5 and time ~= 1 then
        self.ralsei.alpha = self.ralsei.alpha + 0.01
    end
    if self.aim == true then
        warn.y = Game.battle.soul.y
    end
    super.update(self)
end

function Aiming:onEnd()
	for k,enemy in ipairs(self:getAttackers()) do
		--enemy.sprite:setAnimation("battle/idle", nil, true)
	end
end

return Aiming