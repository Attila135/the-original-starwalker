local actor, super = Class(Actor, "watercooler")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "watercooler"

    -- Width and height for this actor, used to determine its center
    self.width = 27
    self.height = 43

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {1, 25, 25, 17}

    -- A table that defines where the Soul should be placed on this actor if they are a player.
    -- First value is x, second value is y.
    self.soul_offset = {36, 42}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {0, 170/255, 1}

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/watercooler/dark"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = nil
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of sprite animations
    self.animations = {

        -- Battle animations
        ["battle/idle"]         = {"battle/idle", 0.1, true},

        ["battle/attack"]       = {"battle/attack", 0, false},
        ["battle/act"]          = {"battle/act", 0.1, true},
        ["battle/spell"]        = {"battle/spell", 0.05, false},
        ["battle/item"]         = {"battle/item", 0.1, false, next="battle/idle"},
        ["battle/spare"]        = {"battle/act", 0.1, false, next="battle/idle"},

        ["battle/attack_ready"] = {"battle/attackready", 0.1, true},
        ["battle/act_ready"]    = {"battle/actready", 0.1, true},
        ["battle/spell_ready"]  = {"battle/spellready", 0, true},
        ["battle/item_ready"]   = {"battle/itemready", 0.1, true},
        ["battle/defend_ready"] = {"battle/defend", 0.05, false},

        ["battle/act_end"]      = {"battle/act", 0.1, false, next="battle/idle"},

        ["battle/hurt"]         = {"battle/hurt", 0.1, false, temp=true, duration=0.5},
        ["battle/defeat"]       = {"battle/defeat", 0.1, true},

        ["battle/transition"]   = {"battle/victory", 0.1, true},
        ["battle/intro"]        = {"battle/intro", 0.1, true},
        ["battle/victory"]      = {"battle/victory", 0.1, true},
    }

    -- Tables of sprites to change into in mirrors
    self.mirror_sprites = {
        ["walk/down"] = "walk/up",
        ["walk/up"] = "walk/down",
        ["walk/left"] = "walk/left",
        ["walk/right"] = "walk/right",
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {}
end

return actor