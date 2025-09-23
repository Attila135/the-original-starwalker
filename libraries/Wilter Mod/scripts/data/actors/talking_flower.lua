local actor, super = Class(Actor, "talking_flower")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Talking Flower"

    -- Width and height for this actor, used to determine its center
    self.width = 35
    self.height = 41

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {13, 30, 10, 5}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {0, 0, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "npcs"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "silent"

    -- Sound to play when this actor speaks (optional)
    self.voice = nil
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {
        ["idle_talk"] = {"talking_flower", 0.1, true},
    }

    -- Table of sprite animations
    self.animations = {
        ["silent"] = {"talking_flower_1", 0.15, true},
        ["talk"] = {"talking_flower", 0.15, true},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {}
end
function actor:onTalkStart(text, sprite)
    sprite:setAnimation("talk")
end

function actor:onTalkEnd(text, sprite)
    sprite:setAnimation("silent")
end


return actor