local Aiming, super = Class(Wave)

function Aiming:init()
    super.init(self)

end

function Aiming:onStart()
    Game.battle:swapSoul(BlueSoul())
    self.move = 2

    self.time = 25

    for k,enemy in ipairs(self:getAttackers()) do
        --enemy.sprite:setAnimation("battle/act_ready", nil, true)
        self.ralsei = Sprite("bullets/ralsei/idle", 588, 159)
        self.ralsei:setAnimation({"bullets/ralsei/idle", 0.2, true})
        self.ralsei:setOrigin(0.5, 0.5)
        self.ralsei.scale_y = 2
        self.ralsei.scale_x = 2
        self.ralsei.alpha = 0
        self.ralsei.layer=BATTLE_LAYERS["top"]+15
        Game.battle:addChild(self.ralsei)
    end
    
    self.timer:after(23, function()
        self.ralsei:fadeOutAndRemove(1)
    end)

    -- Every 0.5 seconds...
    for k,enemy in ipairs(self:getAttackers()) do
        --enemy.sprite:setSprite("battle/attackready_1")
    end
    Assets.playSound("noise")
self.timer:every(2, function()

self.timer:script(function(wait)

    for k,enemy in ipairs(self:getAttackers()) do

        self.timer:after(1, function()
        local attackers = self:getAttackers()
        --enemy.sprite:setAnimation("battle/attack", nil, false)
    -- Loop through all attackers
    for _, attacker in ipairs(attackers) do

        -- Get the attacker's center position
        local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2)

        -- Get the angle between the bullet position and the soul's position
        local angle = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
        -- Spawn smallbullet angled towards the player with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("slash", x, y, angle, 13)
        bullet.rotation = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
        bullet:setScale(0.5)
    end
    end)
    self.timer:after(1.5, function()
        --enemy.sprite:setSprite("battle/attackready_1")
    end)
    end
end)
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
    -- Code here gets called every frame

    super.update(self)
end

function Aiming:onEnd()
	for k,enemy in ipairs(self:getAttackers()) do
		--enemy.sprite:setAnimation("battle/idle", nil, true)
        enemy.y = 277
	end
end

return Aiming