local VineTest, super = Class(Event, "wilthand")

function VineTest:init(data)
    super.init(self, data.x, data.y, data.width, data.height, data)
    self:setOrigin(0.5)

    self.dir = data.properties["direction"]
    self.segments = data.properties["segments"]
    self.layer = 0.69

    if self.dir == "down" then
        self:setHitbox(-16, 0, 62, 124*self.segments)
    elseif self.dir == "up" then
        self:setHitbox(-16, 42, 62, -124*self.segments)
    elseif self.dir == "left" then
        self:setHitbox(0, -16, -180*self.segments, 62)
    elseif self.dir == "right" then
        self:setHitbox(0, -16, 180*self.segments, 62)
    end

    self.segment = {

    }
    for i=1, math.ceil(self.segments) do
        if self.dir == "down" then
            local sprite = Game.world:spawnObject(Sprite("bullets/world/arm_vertical", self.x-8, self.y-72*i), self.layer + 0.01)
            sprite.layer = self.layer + 0.01
            sprite:setScale(2)
            sprite:addFX(MaskFX(self))
            sprite:setOrigin(0.5, 0)
            sprite.alpha = 0
            table.insert(self.segment, sprite)
        elseif self.dir == "up" then
            local sprite = Game.world:spawnObject(Sprite("bullets/world/arm_vertical", self.x-8, self.y+29*i), self.layer + 0.01)
            sprite.layer = self.layer + 0.01
            sprite:setScale(2)
            sprite:addFX(MaskFX(self))
            sprite:setOrigin(0.5, 0)
            sprite.alpha = 0
            table.insert(self.segment, sprite)
        elseif self.dir == "left" then
            local sprite = Game.world:spawnObject(Sprite("bullets/world/arm_horizontal", self.x+56*i, self.y-10), self.layer + 0.01)
            sprite.layer = self.layer + 0.01
            sprite:setScale(2)
            sprite:addFX(MaskFX(self))
            sprite:setOrigin(0.5, 0)
            sprite.alpha = 0
            table.insert(self.segment, sprite)
        elseif self.dir == "right" then
            local sprite = Game.world:spawnObject(Sprite("bullets/world/arm_horizontal", self.x-56*i, self.y-10), self.layer + 0.01)
            sprite.layer = self.layer + 0.01
            sprite:setScale(2)
            sprite:addFX(MaskFX(self))
            sprite:setOrigin(0.5, 0)
            sprite.alpha = 0
            table.insert(self.segment, sprite)
        else
            error("Arm " .. self.object_id .. " - Invalid direction: " .. self.dir)
        end
    end
    if self.dir == "up" or self.dir == "down" then
        self:setSprite("bullets/world/arm_end_" .. self.dir)
        self.sprite.alpha = 0
        self.sprite.x, self.sprite.y = self.sprite.x - 7, self.sprite.y - 1
    end

    if self.dir == "down" then
        self.hand = Game.world:spawnObject(Sprite("bullets/world/hand_" .. self.dir, self.x-4, self.y), self.layer + 0.01)
    elseif self.dir == "up" then
        self.hand = Game.world:spawnObject(Sprite("bullets/world/hand_" .. self.dir, self.x-9, self.y), self.layer - 0.01)
    elseif self.dir == "left" then
        self.hand = Game.world:spawnObject(Sprite("bullets/world/hand_" .. self.dir, self.x-11, self.y-3), self.layer + 0.01)
    elseif self.dir == "right" then
        self.hand = Game.world:spawnObject(Sprite("bullets/world/hand_" .. self.dir, self.x+11, self.y-3), self.layer + 0.01)
    end
    self.hand:setScale(2)
    self.hand:setOrigin(0.5)
    self.hand.alpha = 0
end

function VineTest:extend()
    self.extended = true
    self.solid = true

    local shard = Sprite("objects/mirror_shard"..Utils.pick({"a","b"}), self.x + love.math.random(-20, 20), self.y + 26 + love.math.random(-20, 20))
    shard:setFrame(love.math.random(1,4))
    shard:setOrigin(0.5)
    shard:setScale(2)
    shard.layer = Game.world.player.layer-0.01
    shard:play(0.5, true)
    Game.world:addChild(shard)
    shard.physics.speed_y = -10
    if self.dir == "left" then
        shard.physics.speed_x = love.math.random(-5,-7,-0.5)
    elseif self.dir == "right" then
        shard.physics.speed_x = love.math.random(5,7,0.5)
    else
        shard.physics.speed_x = Utils.pick({love.math.random(5,7,0.5), love.math.random(-5,-7,-0.5)})
    end
    shard.physics.gravity = 1
    Game.world.map.timer:after(4, function ()
        shard:remove()
    end)
    if self.dir == "down" then
        for _, segment in ipairs(self.segment) do
            Game.world.map.timer:tween(0.25, segment, {alpha=2, y=segment.y+72*self.segments})
        end
        self.sprite:fadeTo(1, 0.25)
        Game.world.map.timer:tween(0.25, self.hand, {alpha=2, y=self.hand.y+72*self.segments})
    elseif self.dir == "up" then
        for _, segment in ipairs(self.segment) do
            Game.world.map.timer:tween(0.25, segment, {alpha=2, y=segment.y-72*self.segments})
        end
        self.sprite:fadeTo(1, 0.25)
        Game.world.map.timer:tween(0.25, self.hand, {alpha=2, y=self.hand.y-72*self.segments})
    elseif self.dir == "left" then
        for _, segment in ipairs(self.segment) do
            Game.world.map.timer:tween(0.25, segment, {alpha=2, x=segment.x-72*self.segments})
        end
        Game.world.map.timer:tween(0.25, self.hand, {alpha=2, x=self.hand.x-72*self.segments})
    elseif self.dir == "right" then
        for _, segment in ipairs(self.segment) do
            Game.world.map.timer:tween(0.25, segment, {alpha=2, x=segment.x+72*self.segments})
        end
        Game.world.map.timer:tween(0.25, self.hand, {alpha=2, x=self.hand.x+72*self.segments})
    end
end

function VineTest:drawMask()
    if self.dir == "down" then
        love.graphics.rectangle("fill",-20,20,self.width+40,200)
    elseif self.dir == "up" then
        love.graphics.rectangle("fill",-20,20,self.width+40,-200)
    elseif self.dir == "left" then
        love.graphics.rectangle("fill",0,-40,-200,80)
    elseif self.dir == "right" then
        love.graphics.rectangle("fill",0,-40,200,80)
    else
        error("Arm " .. self.object_id .. " - Invalid direction: " .. self.dir)
    end
end

return VineTest