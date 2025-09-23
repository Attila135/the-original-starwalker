local actor, super = Class(Actor, "wilter6")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Wilter"

    -- Width and height for this actor, used to determine its center
    self.width = 35
    self.height = 45
    self.hitbox = {0, 20, 35, 20}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 1, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "npcs/wilter"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = "wilt6"
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
        ["walk/down"] = {"walk/down", 0.1, true},
        ["walk/right"] = {"walk/right", 0.1, true},
        ["walk/up"] = {"walk/up", 0.1, true},
        ["walk/left"] = {"walk/left", 0.1, true},
        ["emotions/laugh"] = {"emotions/laugh", 0.075, true},
        ["emotions/sad"] = {"emotions/sad", 0.1, true},
        ["emotions/verysad"] = {"emotions/verysad", 0.1, true},
        ["emotions/stare"] = {"emotions/stare", 0.1, true},
        ["death/dead"] = {"death/dead", 0.1, true},
        ["death/slmn"] = {"death/slmn", 0.1, true},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        ["walk/down"] = {0, 0},
        ["walk/right"] = {0, 0},
        ["walk/up"] = {0, 0},
        ["walk/left"] = {0, 0},
        ["emotions/sad"] = {0, 0},
        ["emotions/verysad"] = {0, 0},
        ["emotions/stare"] = {0, 0},
        ["emotions/laugh"] = {-1, -2},
        ["death/slmn1"] = {-2,0},
        ["death/slmn2"] = {-2,0},
        ["death/slmn3"] = {-2,0},
        ["death/slmn4"] = {-2,0},
        ["death/slmn5"] = {-2,0},
        ["death/dead"] = {-10, 0},



    }
end

return actor