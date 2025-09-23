local VineTest, super = Class(Event)

function VineTest:init(data)
    super.init(self, data.x, data.y, data.width, data.height, data)
    self:setSprite("world/events/treasure_chest_1")
    self:setOrigin(0.5)
    self.mirror_stage = 1
    self.mirrors = {

    }
    self.mirror_scale = math.pi
    self.self_scale = math.pi
    for i=1, 5 do
        local mirror = Sprite("objects/minigame_mirror", self.x-240+80*i, self.y-20)
        mirror:setOrigin(0.5)
        mirror:setScale(2)
        local mirrorob = Game.world:spawnObject(mirror, self.layer-0.01)
        table.insert(self.mirrors, mirrorob)
    end

    self.destination = Utils.pick({self.x-160, self.x-80, self.x, self.x+80, self.x+160})
    self.possible_destinations = {
        self.x-160,
        self.x-80,
        self.x,
        self.x+80,
        self.x+160
    }
    self.mirror_destinations = {

    }
    self.correct_mirror = nil
    for i=1, 5 do
        local rand = love.math.random(1, #self.possible_destinations)
        table.insert(self.mirror_destinations, self.possible_destinations[rand])
        if self.possible_destinations[rand] == self.destination then
            self.correct_mirror = i
        end
        self.possible_destinations[rand] = nil
    end
end

function VineTest:update()
    super.update(self)
    for _,mirror in ipairs(self.mirrors) do
        mirror:setScale(2*math.cos(self.mirror_scale), 2)
    end
    self:setScale(math.cos(self.self_scale), 1)
end

function VineTest:onInteract(player, dir)
    if self.mirror_stage == 1 then
        Game.lock_movement = true
        Game.world.map.timer:tween(0.5, self, {mirror_scale=self.mirror_scale+math.pi/2})
        Game.world.map.timer:tween(0.5, self, {self_scale=self.self_scale+math.pi/2})
        Game.world.map.timer:after(0.5, function ()
            self:setSprite(nil)
            Game.world.map.timer:tween(0.5, self, {mirror_scale=self.mirror_scale+math.pi/2})
        end)
        self.mirror_stage = 2
    else
        print("yo")
    end
    return true
end

return VineTest