local actor, super = Class(Actor, "maskaught")

-- function actor:drawMask()
--     love.graphics.setColor(1, 1, 1)
--     love.graphics.rectangle("fill", 0, 0, self.width, self.height)
-- end
--function actor:onSpriteInit(sprite)
--ocal mask = Sprite("fine")
--    sprite:addChild(mask)
--    sprite.malsk = mask
--    sprite.mask.layer = -10
--    sprite.mask.visible = false
--    mask.origin_x = 0
--    mask.origin_y = 0
--    sprite.mask.x = 0
--    sprite.mask.y = 0
--
--local bg = Sprite("draw")
--    sprite:addChild(bg)
--    sprite.bg = bg
--    sprite.bg.layer = -1
--    bg.origin_x = 0.5
--    bg.origin_y = 0.5
--    sprite.bg.x = 0
--    sprite.bg.y = 0
--    bg.wrap_texture_x = true
--    bg.wrap_texture_y = true
--    sprite.bg.mask_fx = bg:addFX(MaskFX(mask))
    
    
-- end
-- function actor:onBattleUpdate(battler)
--     --super.onBattleUpdate(self)
--     self.battlerOwner = battler;
-- end
function actor:init()
    super.init(self)
    
    -- local fx = AlphaFX(1)
    
    -- Display name (optional)
    self.name = "Maskaught"

    self.battlerOwner = nil;
    
    -- Width and height for this actor, used to determine its center
    self.width = 37
    self.height = 36; -- originally 36, now 20 to fit with alt
    -- self.origin_x = 1
    -- self.origin_y = 1;

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    local offmaskx = 9;
    local offmasky = -1;
    self.hitbox = {0 + offmaskx, 25 + offmasky, 19, 14}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 1, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil;

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/maskaught/dark"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = "lupine"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    --self.walk_speed = 100;
    

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {
        ["talk"] = 0.05
    }

    -- Table of sprite animations
    self.animations = {
        -- Looping animation with 0.25 seconds between each frame
        -- (even though there's only 1 idle frame)
        ["idle"] = {"idle", 0.25, true},
        ["sitting_stare"] = {"sitting_stare", 0.25, true},
        ["sitting_alert"] = {"sitting_alert", 0.25, true},
        ["sitting_darkness"] = {"sitting_stare", 0.55, true},
        
        ["sitting_wag"] = {"sitting_wag", 0.10, true},

        ["boneleft"] = {"boneleft", 0.25, false},
        ["boneNO"] = {"boneNO", 0.25, false},
        ["bonewow"] = {"boneNO", 0.25, false},
        --["walk"] = {"walk", 0.1, false},

        ["stay/right"] = {"walk/right", 2.0, false, frames = {1} },
        ["stay/left"] = {"walk/left", 2.0, false, frames = {1} },

        ["walk/right"] = {"walk/right", 2.0, false, frames = {1, 2, 3} },
        ["face/right"] = {"walk/right", 2.0, false, frames = {1} },
        ["face/left"] = {"walk/left", 2.0, false, frames = {1} },
        ["jump_ball"]           = {"ball", 1/15, true},

        ["unveiled"] = {"unveiled", 0.15, false},
        ["unveiled_empty"] = {"unveiled_empty", 0.15, false},
        ["unveiled_full"] = {"unveiled_full", 0.15, false},
        ["unveiled_notail"] = {"unveiled_notail", 0.15, false},
        ["laugh"] = {"laugh", 0.15, true},
        ["downleft"] = {"downleft", 0.25, true},
        ["downright"] = {"downright", 0.25, true},
        ["upleft"] = {"upleft", 0.25, true},
        ["upright"] = {"upright", 0.25, true},
        ["hurt"] = {"hurt", 0.15, false},
        ["unveilstay"] = {"unveilstay", 0.15, false, frames = {1} },
        ["unveilfinish"] = {"unveilfinish", 0.15, false, frames = {1} },
        --["spared"] = {"spared", 0, false}, 
        ["swirl"] = {"swirl", 0.10, false},
        ["raise"] = {"raise", 0.05, false, frames = {1, 1, 1, 2, 3} },
        ["unswirl"] = {"unswirl", 0.10, false, next = "swirled"},
        ["swirled"] = {"swirled", 0.25, true, frames = {4, 5, 6, 7, 1, 2, 3}},
        ["unswirlquick"] = {"swirl", 0.02, false, frames = {1, 2, 2, 3, 2, 4, 1, 4, 4, 4, 2, 1}, callback = function(cback) Game.battle.shouldUnswirl = true; end }, -- ["unswirlquick"] = {"swirl", 0.02, false, next = "idle", frames = {1, 2, 2, 3, 2, 4, 1, 4, 4, 4, 2, 1}, callback = function(cback) Game.battle.shouldUnswirl = true; end },
        ["unswirlattempt"] = {"swirl", 0.02, false, next = "swirled", frames = {1, 2, 2, 3, 2, 4, 1, 4, 4, 4, 2, 1}},
        ["throw"] = {"throw", 0.15, false, frames = {1, 2}, next = "throwed" },
        ["throwed"] = {"throwed", 0.20, true, frames = {1, 1, 2, 3, 3, 2}},
        ["unveiled_idle"] = {"unveiled_idle", 0.20, true, frames = {1, 1, 2, 3, 3, 4}},
        ["unveiled_thinkaway"] = {"unveiled_thinkaway", 0.20, false, frames = {1}}
    }

    

    -- Table of sprite offsets (indexed by sprite name)
    local moveOffY = -17;
    local moveOffX = -6;
    self.offsets = {
        ["ball"] = {1, -2},
        ["sitting_intense"] = {0, -1},
        ["sitting_darkness"] = {0, -1},
        --["sitting_duck"] = {1, 7},

        ["boneleft"] = {moveOffX, moveOffY},
        ["boneNO"] = {moveOffX, moveOffY},
        ["bonewow"] = {moveOffX, moveOffY},

        -- Movement offsets
        ["walk/down"] = {moveOffX, moveOffY},
        ["walk/left"] = {moveOffX, moveOffY},
        ["walk/right"] = {moveOffX, moveOffY},
        ["walk/up"] = {moveOffX, moveOffY},

        ["walk_bangs/down"] = {0, -2},
        ["walk_bangs/left"] = {0, -2},
        ["walk_bangs/right"] = {0, -2},
        ["walk_bangs/up"] = {0, -2},
    }
end

-- voicermask -- function actor:onSpriteInit(sprite)
-- voicermask -- super.onSpriteInit(self)
-- voicermask -- 
-- voicermask -- local child = VoicerMask(0, 0, 0, 0)
-- voicermask --     child.focusActor = sprite
-- voicermask --     Game.stage:addChild(child)
-- voicermask -- --
-- voicermask --     self.floatSprite2OffsetX = 0
-- voicermask --     self.floatSprite2Alpha = 1
-- voicermask --     self.maskaughtFlightLifetime = 0
-- voicermask --     self.maskaughtGroundLifetime = 0
-- voicermask --    
-- voicermask -- 
-- voicermask --     -- sprite = Sprite("float2")
-- voicermask --     -- sprite.layer = -100
-- voicermask --     -- Game.battle:addChild(sprite)
-- voicermask --     
-- voicermask --     local mask = Sprite("maskk")
-- voicermask --     -- Kristal.Console:log("the " .. sprite:getTexture())
-- voicermask --     -- mask:setSprite(tostring(sprite:getTexture()))
-- voicermask --     -- mask.sprite = Assets.getTexture("fence")
-- voicermask --     sprite:addChild(mask)
-- voicermask --     sprite.mask = mask
-- voicermask --     sprite.mask.layer = -10
-- voicermask --     sprite.mask.visible = false
-- voicermask --     sprite.mask.origin_x = 0
-- voicermask --     sprite.mask.origin_y = 0
-- voicermask --     sprite.mask.x = 0
-- voicermask --     sprite.mask.y = 0
-- voicermask -- 
-- voicermask --     local bg = Sprite("draw2")
-- voicermask --     sprite:addChild(bg)
-- voicermask --     sprite.bg = bg
-- voicermask --     sprite.bg.layer = -1
-- voicermask --     sprite.bg.scale_x = 0.1
-- voicermask --     sprite.bg.scale_y = 1
-- voicermask --     sprite.bg.origin_x = 0.5
-- voicermask --     sprite.bg.origin_y = 0.5
-- voicermask --     sprite.bg.x = 0
-- voicermask --     sprite.bg.y = 0
-- voicermask --     sprite.bg.alpha = 0
-- voicermask --     sprite.bg.wrap_texture_x = true
-- voicermask --     sprite.bg.wrap_texture_y = true
-- voicermask --     sprite.bg.mask_fx = bg:addFX(MaskFX(mask))
-- voicermask -- 
-- voicermask --     --
-- voicermask -- end
-- function actor:getDefaultAnim() return self.default end
-- function actor:getDefault()
--     self.voice = "wallspeak"
-- end
-- 

return actor