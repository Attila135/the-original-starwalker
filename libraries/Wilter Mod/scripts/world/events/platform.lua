---@class Event.platform : Event
local Platform, super = Class(Event)

function Platform:init(data)
    super.init(self, data.x, data.y, data.width, data.height, data)

    self.solid = true
    self.collider = ColliderGroup(self, {
        Hitbox(self, -160, -80, 40, 160),
        Hitbox(self, 120, -80, 40, 160),
        Hitbox(self, -120, -120, 240, 40),
        Hitbox(self, -120, 80, 80, 40),
        Hitbox(self, 40, 80, 80, 40),
        Hitbox(self, -40, -120, 80, 40)
    })
    self.stand_collider = Hitbox(self, -120,-80,120+120, 80+80)

    self.activated = false
end

function Platform:postLoad()
    self.platform = Game.world.map:getTileLayer("platform")
    self.platform_border = Game.world.map:getTileLayer("battleborder_platform")
    self.bridge = Game.world.map:getTileLayer("platform_bridge")
    self.eyespawner = Game.world.map:getEvent("eyespawner3")
end

function Platform:onFinishMove1()
    self.activated = false
end

function Platform:onFinishMove2()
    Assets.playSound("impact")
    self.activated = false
    self.collider.colliders[6].y = -120
    Game.world.camera.target = Game.world.player
end

function Platform:beginMove()
    Game.world.camera.target = self
    self.bridge.alpha = 0
    self.collider.colliders[6].y=80
    Assets.playSound("impact")
    self.activated = true
    self:slideTo(640, self.y, 2, "linear", function ()
        self:onFinishMove1()
    end)
    Game.world.timer:after(2, function ()
        Game.world.in_battle = true
    end)
    Game.world.timer:after(17, function ()
        self.eyespawner.activated = false
    end)
    Game.world.timer:after(18, function ()
        Game.world.in_battle = false
    end)
    Game.world.timer:after(20, function ()
        self.activated = true
        self:slideTo(1080, self.y, 2, "linear", function ()
            self:onFinishMove2()
        end)
        self.physics.move_target.move_func = self.move
    end)
    self.physics.move_target.move_func = self.move
end

function Platform:update()
    super.update(self)
    --[[if self.activated then
        self.platform.x = self.x - 160
        self.platform_border.x = self.x - 160
        Game.world.player.x = Game.world.player.x + 2480/(300*DTMULT)
        print((2640-self.player_startx)/(10*FPS), FPS)
    end]]
end

function Platform:move(x,y,speed)
    if self.stand_collider:collidesWith(self.world.player) then
        self.world.player.x = self.world.player.x + (x * (speed or 1))
        self.world.player.y = self.world.player.y + (y * (speed or 1))
    end
    self.platform:move(x,y,speed)
    self.platform_border:move(x,y,speed)
    super.move(self,x,y,speed)
end

function Platform:draw()
    super.draw(self)
    if DEBUG_RENDER then
        self.stand_collider:drawFor(self, 1,0,0)
    end
end

return Platform