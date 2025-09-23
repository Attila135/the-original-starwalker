local VineTest, super = Class(Event)

function VineTest:init(data)
    super.init(self, data.x, data.y, data.width, data.height, data)
    self:setOrigin(0.5)

    self.dir = data.properties["direction"] or "down"
    self.segments = data.properties["segments"] or 1
    self.mirror = data.properties["mirror"] or "a"
    self.layer = 0.69

    self.breakSprite = Game.world:spawnObject(Sprite("objects/mirror_broken" .. self.mirror, 0, 0), 0.6)
    self.breakSprite:setOrigin(0.5, 1)
    self.breakSprite:setScale(2)
    self.breakSprite.alpha = 0

    if self.dir == "down" then
        self:setHitbox(-16, 0, 62, 52+72*self.segments)
        self.breakSprite.rotation = 0
        if self.mirror == "e" then
            self.breakSprite:setPosition(self.x, self.y+40)
        else
            self.breakSprite:setPosition(self.x, self.y+60)
        end
    elseif self.dir == "up" then
        self:setHitbox(-16, 42, 62, -52-72*self.segments)
        self.breakSprite.rotation = math.pi
        if self.mirror == "d" then
            
        end
        if self.mirror == "e" then
            self.breakSprite:setPosition(self.x, self.y-40)
        else
            self.breakSprite:setPosition(self.x, self.y-60)
        end
    elseif self.dir == "left" then
        self:setHitbox(0, -16, -180*self.segments, 62)
        self.breakSprite.rotation = math.pi/2
        self.breakSprite:setPosition(self.x, self.y)
    elseif self.dir == "right" then
        self:setHitbox(0, -16, 180*self.segments, 62)
        self.breakSprite.rotation = math.pi+math.pi/2
        self.breakSprite:setPosition(self.x, self.y)
    end

    self.segment = {

    }
    if self.dir == "up" then
        for i=1, math.floor(self.segments) do
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
    else
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
    self.breakSprite.alpha = 1
    self.breakSprite:play(0.1, false)
    for i=1, 4 do
        local shard = Sprite("objects/mirror_shard"..Utils.pick({"a","b"}), self.x + love.math.random(-20, 20), self.y + 26 + love.math.random(-20, 20))
        shard:setFrame(love.math.random(1,4))
        shard:setOrigin(0.5)
        shard:setScale(2)
        shard.layer = Game.world.player.layer-0.01
        shard:play(0.5, true)
        Game.world:addChild(shard)
        shard.physics.speed_y = -10
        shard.physics.speed_x = Utils.pick({love.math.random(5,7,0.5), love.math.random(-5,-7,-0.5)})
        shard.physics.gravity = 1
        Game.world.map.timer:after(4, function ()
            shard:remove()
        end)
    end
    Assets.playSound("glass_crash")
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