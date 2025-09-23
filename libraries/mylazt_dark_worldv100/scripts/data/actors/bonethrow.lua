local actor, super = Class(Actor, "bonethrow")

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
    self.name = "bonethrow"

    self.battlerOwner = nil;
    
    -- Width and height for this actor, used to determine its center
    self.width = 13
    self.height = 13; -- originally 36, now 20 to fit with alt
    -- self.origin_x = 1
    -- self.origin_y = 1;

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 0, 13, 13}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 1, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil;

    -- Path to this actor's sprites (defaults to "")
    self.path = "npcs"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "bonethrow_idle"

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

        ["jump_ball"]           = {"ball", 1/15, true},

    }

    

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        ["ball"] = {1, -2},
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