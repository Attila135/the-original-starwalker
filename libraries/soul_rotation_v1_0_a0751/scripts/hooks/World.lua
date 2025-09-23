---@class World : World
---@overload fun(map?: string) : World
local World, super = Class(World)

function World:spawnPlayer(...)
    local args = {...}

    local x, y = 0, 0
    local chara = self.player and self.player.actor
    local party
    if #args > 0 then
        if type(args[1]) == "number" then
            x, y = args[1], args[2]
            chara = args[3] or chara
            party = args[4]
        elseif type(args[1]) == "string" then
            x, y = self.map:getMarker(args[1])
            chara = args[2] or chara
            party = args[3]
        end
    end

    if type(chara) == "string" then
        chara = Registry.createActor(chara)
    end

    local facing = "down"

    if self.player then
        facing = self.player.facing
        self:removeChild(self.player)
    end
    if self.soul then
        self:removeChild(self.soul)
    end

    self.player = Player(chara, x, y)
    self.player.layer = self.map.object_layer
    self.player:setFacing(facing)
    self:addChild(self.player)

    if party then
        self.player.party = party
    end

    self.soul = OverworldSoul(self.player:getRelativePos(self.player.actor:getSoulOffset()))
    self.soul:setColor(Game:getSoulColor())
    self.soul:setRotationOrigin(1, 1)
	self.soul.rotation = Game:getSoulRotation()
    self.soul.layer = WORLD_LAYERS["soul"]
    self:addChild(self.soul)

    if self.camera.attached_x then
        self.camera:setPosition(self.player.x, self.camera.y)
    end
    if self.camera.attached_y then
        self.camera:setPosition(self.camera.x, self.player.y - (self.player.height * 2)/2)
    end
end

return World