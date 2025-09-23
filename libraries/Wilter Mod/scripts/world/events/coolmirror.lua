local CoolMirror, super = Class(Event)

function CoolMirror:init(data)
    super.init(self, data.x, data.y, data.width, data.height, data)

    local properties = data.properties or {}

    self.flipped = properties["flipped"] or false

    if self.flipped then
        self.mirrorSprite = Sprite(Game.world.player.sprite.texture_path, self.width/2, 0)
        self.mirrorSprite:setOrigin(0.5, 1)
        self.mirrorSprite.scale_y = -self.height/40
    else
        self.mirrorSprite = Sprite(Game.world.player.sprite.texture_path, self.width/2, 0)
        self.mirrorSprite:setOrigin(0.5, 0)
        self.mirrorSprite.scale_y = self.height/40
    end

    self:addChild(self.mirrorSprite)

    self.mirrorSprite.scale_x = Utils.clampMap(math.abs(self.mirrorSprite.scale_y), 1, 4, 4, 1)
end

function CoolMirror:update()
    super.update(self)

    self.mirrorSpritePath = Game.world.player.sprite.texture_path

    if Utils.startsWith(self.mirrorSpritePath, "party/kris/dark/walk/down") and not self.flipped then
        self.mirrorSpritePath = "party/kris/dark/walk/up_" .. self.mirrorSpritePath:sub(-1, -1)
    elseif Utils.startsWith(self.mirrorSpritePath, "party/kris/dark/walk/up") and not self.flipped then
        self.mirrorSpritePath = "party/kris/dark/walk/down_" .. self.mirrorSpritePath:sub(-1, -1)
    end

    self.mirrorSprite:setSprite(self.mirrorSpritePath)

    local player = Game.world.player
    local distance = 0
    if not self.flipped then
        distance = Utils.dist(player.x, player.y, self.width/2+self.x, self.height+self.y)
    else
        distance = Utils.dist(player.x, player.y, self.width/2+self.x, self.y)
    end

    self.mirrorSprite.alpha = Utils.clampMap(distance, 20, 160, 1, 0)
end

return CoolMirror