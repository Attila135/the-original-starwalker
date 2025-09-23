local actor, super = Class(Actor, "spikegate")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Spikegate"

    -- Width and height for this actor, used to determine its center
    self.width = 20
    self.height = 60

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {1, 60, 18, 8}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 1, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "npcs"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "spikegate_open"

    -- Sound to play when this actor speaks (optional)
    self.voice = nil
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}

    -- Table of sprite animations
    self.animations = 
    {
        --
    ["close"] = {"spikegate_close", 0.02, false, frames = {1, 2, 3, 4}, callback = function(cback) Assets.playSound("locker")  end },
        --
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = 
    {
        ["spikegate_open"] = {0, 10},
        ["spikegate_close"] = {0, 10},
    }
end

return actor