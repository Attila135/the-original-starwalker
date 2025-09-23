local actor, super = Class(Actor, "omeg_wilter")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Dummy"

    -- Width and height for this actor, used to determine its center
    self.width = 111
    self.height = 104

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 0, 102, 106}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {0, 0, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "enemies/dummy"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk/down"

    -- Sound to play when this actor speaks (optional)
    self.voice = "omeg_wilt"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}

    -- Table of sprite animations
    self.animations = {
        -- Looping animation with 0.25 seconds between each frame
        -- (even though there's only 1 idle frame)
        ["battle"] = {"idle", 0.1, true},
        ["laugh"] = {"laugh", 0.05, true},
        ["hurt"] = {"hurt", 0.01, false},
        ["chuck"] = {"chuck", 0.1, false, next = "battle"}
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- Since the width and height is the idle sprite size, the offset is 0,0
        ["idle"] = {0, 0},
        ["laugh"] = {0, -4},
        ["chuck"] = {1, -8}
    }
end

return actor