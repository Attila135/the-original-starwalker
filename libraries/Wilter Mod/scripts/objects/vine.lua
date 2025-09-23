local Vine, super = Class(Object)

function Vine:init(x, y)
    super.init(self)
    self.x = Utils.ceil(Game.world.player.x, 40)
    self.y = Utils.ceil(Game.world.player.y, 40)
    self.x = self.x + (-200 + math.floor(love.math.random(10)) * 40)
    self.y = self.y + (-200 + math.floor(love.math.random(10)) * 40)
    self.x = Utils.ceil(self.x, 40)
    self.y = Utils.ceil(self.y, 40)

    self:setScale(2)
    self:setOrigin(0, 1)

    self.sprite = Sprite("bullets/world/vine_grow", 0, 0)
    self.sprite.alpha = 0
    self:addChild(self.sprite)
    self.sprite:setOrigin(0, 1)

    self:setHitbox(2, -15, 18, 15)

    self.zPresses = 10
    self.caught = false
    self.spawning = true
    self.doOnce = true

    self.vineCollided = false
    self.noVine = {
        {},
        {},
        {},
        {},
        {},
        {},
        {},
        {},
        {},
        {},
        {},
        {},
        {},
        {},
        {},
        {}
    }

    --self.sprite:fadeTo(1, 0.5)
    --Assets.stopAndPlaySound("spearappear")

    --[[Game.world.map.timer:after(1.5, function ()
        self.sprite:play(0.1, false)
        self.layer = 0.4
        Assets.stopAndPlaySound("spearrise")
        Game.world.map.timer:after(0.3, function ()
            self.activated = true
        end)
        Game.world.map.timer:after(2, function ()
            if not self.caught then
                self.sprite:setAnimation({"bullets/world/vine_shrink", 0.1, false})
                self.sprite:fadeOutAndRemove(0.5)
                Game.world.map.timer:after(0.5, function ()
                    self:remove()
                end)
            end
        end)
    end)]]
end

function Vine:update()
    super.update(self)
    if self.spawning then
        if self.doOnce then
            self.doOnce = false
            local novine = Game.world.map:getShapes("objects_novine")
            for i=1, #novine do
                for _, point in ipairs(novine[i]["polygon"]) do
                    table.insert(self.noVine[i], {novine[i]["x"]+point["x"], novine[i]["y"]+point["y"]})
                end
            end

            for _, polygon in ipairs(self.noVine) do
                if polygon then
                    if CollisionUtil.rectPolygon(self.x+4, self.y-10, 12, 20, polygon) then
                        self.vineCollided = true
                    end
                end
            end
    
            if Game.world.player.facing == "up" then
                for i=1, 3 do
                    if self.vineCollided then
                        self.y = self.y - 40
                        self.vineCollided = false
                    end
                    for _, polygon in ipairs(self.noVine) do
                        if CollisionUtil.rectPolygon(self.x+4, self.y-10, 12, 20, polygon) then
                            self.vineCollided = true
                        end
                    end
                end
            elseif Game.world.player.facing == "down" then
                for i=1, 3 do
                    if self.vineCollided then
                        self.y = self.y + 40
                        self.vineCollided = false
                    end
                    for _, polygon in ipairs(self.noVine) do
                        if CollisionUtil.rectPolygon(self.x+4, self.y-10, 12, 20, polygon) then
                            self.vineCollided = true
                        end
                    end
                end
            elseif Game.world.player.facing == "left" then
                for i=1, 3 do
                    if self.vineCollided then
                        self.x = self.x - 40
                        self.vineCollided = false
                    end 
                    for _, polygon in ipairs(self.noVine) do
                        if CollisionUtil.rectPolygon(self.x+4, self.y-10, 12, 20, polygon) then
                            self.vineCollided = true
                        end
                    end
                end
            elseif Game.world.player.facing == "right" then
                for i=1, 3 do
                    if self.vineCollided then
                        self.x = self.x + 40
                        self.vineCollided = false
                    end
                    for _, polygon in ipairs(self.noVine) do
                        if CollisionUtil.rectPolygon(self.x+4, self.y-10, 12, 20, polygon) then
                            self.vineCollided = true
                        end
                    end
                end
            end

            if self.collider:collidesWith(Game.world.player.collider) and Game:getFlag("vine_trapped") then
                self.vineCollided = true
            end

            if self.vineCollided then
                self:remove()
            else
                self.spawning = false
                self.doOnce = true
            end
        end
    end

    if not self.spawning then
        if self.doOnce then
            self.doOnce = false
            self.sprite:fadeTo(1, 0.5)
            Assets.stopAndPlaySound("spearappear")

            Game.world.map.timer:after(0.5, function ()
                self.sprite:play(0.1, false)
                Assets.stopAndPlaySound("spearrise")
                Game.world.map.timer:after(0.3, function ()
                    self.layer = Game.world.player.layer
                    self.activated = true
                end)
                Game.world.map.timer:after(1, function ()
                    if not self.caught then
                        self.activated = false
                        self.sprite:setAnimation({"bullets/world/vine_shrink", 0.1, false})
                        self.sprite:fadeOutAndRemove(0.5)
                        Game.world.map.timer:after(0.5, function ()
                            self:remove()
                        end)
                    end
                end)
            end)
        end

        if self.collider:collidesWith(Game.world.player.collider) and not Game:getFlag("vine_trapped") and self.activated then
            Game.lock_movement = true
            self.caught = true
            Game:setFlag("vine_trapped", true)
            self.zmash = Sprite("objects/z_mash", 20, -60)
            self.zmash:setOrigin(0.5)
            self.zmash:play(0.05, true)
            self.zmash.layer = 20
            self:addChild(self.zmash)
            Game.world.player:setSprite("vine_grabbed")
            Game.world.player:setPosition(self.x+20, self.y-24)
            Game.world.player.layer = self.layer + 0.01
            Assets.playSound("grab")
            Game.world.player:shake()
        end

        if Game:getFlag("vine_trapped") and self.zPresses > 0 and Input.pressed("confirm") and self.caught then
            Game.world.player:shake()
            Assets.stopAndPlaySound("bump")
            self.zPresses = self.zPresses - 1
        end

        if Game:getFlag("vine_trapped") and self.zPresses == 0 and self.caught then
            self.zPresses = -1
            self.zmash:remove()
            Assets.playSound("jump")
            Game.world.player:setAnimation({"sword_jump_up", 0.2, true})
            Game.world.map.timer:tween(0.4, Game.world.player, {y=Game.world.player.y-80}, "out-quad")
            self.sprite:setAnimation({"bullets/world/vine_shrink", 0.1, false})
            self.sprite:fadeOutAndRemove(0.5)
            Game.world.map.timer:after(1, function ()
                self:remove()
            end)
            Game.world.map.timer:after(0.4,
            function()
                Game.world.player:setAnimation({"sword_jump_down", 0.2, true})
                Game.world.map.timer:tween(0.4, Game.world.player, {y=Game.world.player.y+90}, "in-quad")
                Game.world.map.timer:after(0.4, function ()
                    Game.world.player:setSprite("landed")
                    Assets.playSound("impact")
                    Game.world.player.layer = self.layer
                    Game.world.player.sprite:play(0.2, false)
                    Game.world.map.timer:after(0.4, function ()
                        Game.lock_movement = false
                        Game.world.player:setFacing("down")
                        Game.world.player:resetSprite()
                        Game:setFlag("vine_trapped", false)
                        Game.world.map.timer:after(0.5, function ()
                            Game:setFlag("vine_trapped", false)
                        end)
                    end)
                end)
            end)
        end
    end
end

return Vine