local actor, super = Class(Actor, "maskaughtcombat")

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
function actor:init()
    super.init(self)
    
    -- local fx = AlphaFX(1)
    
    -- Display name (optional)
    self.name = "MaskaughtCombat"
    
    -- Width and height for this actor, used to determine its center
    self.width = 37
    self.height = 20;
    -- self.origin_x = 1
    -- self.origin_y = 1;

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {2, 26, 27, 10}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 1, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = "right"

    -- Path to this actor's sprites (defaults to "")
    self.path = "Wolf";
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "Soul"

    -- Sound to play when this actor speaks (optional)
    self.voice = "lupine"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {
        ["talk"] = 0.05
    }

    -- Table of sprite animations
    self.animations = {
        -- Looping animation with 0.25 seconds between each frame
        -- (even though there's only 1 idle frame)
        -- ["idle"] = {"idle", 0.25, true},
        -- ["downleft"] = {"downleft", 0.25, true},
        -- ["downright"] = {"downright", 0.25, true},
        -- ["upleft"] = {"upleft", 0.25, true},
        -- ["upright"] = {"upright", 0.25, true},
        -- ["hurt"] = {"hurt", 0.15, false},
        -- ["unveilstay"] = {"unveilstay", 0.15, false, frames = {1} },
        -- ["unveilfinish"] = {"unveilfinish", 0.15, false, frames = {1} },
        -- --["spared"] = {"spared", 0, false}, 
        -- ["swirl"] = {"swirl", 0.10, false},
        -- ["raise"] = {"raise", 0.05, false, frames = {1, 1, 1, 2, 3} },
        -- ["unswirl"] = {"unswirl", 0.10, false, next = "swirled"},
        -- ["swirled"] = {"swirled", 0.25, true, frames = {4, 5, 6, 7, 1, 2, 3}},
        -- ["unswirlquick"] = {"swirl", 0.02, false, next = "idle", frames = {1, 2, 2, 3, 2, 4, 1, 4, 4, 4, 2, 1}},
        -- ["unswirlattempt"] = {"swirl", 0.02, false, next = "swirled", frames = {1, 2, 2, 3, 2, 4, 1, 4, 4, 4, 2, 1}},
        -- ["throw"] = {"throw", 0.15, false, frames = {1, 2}, next = "throwed" },
        -- ["throwed"] = {"throwed", 0.20, true, frames = {1, 1, 2, 3, 3, 2}},
        -- ["unveiled_idle"] = {"unveiled_idle", 0.20, true, frames = {1, 1, 2, 3, 3, 4}},
        -- ["unveiled_thinkaway"] = {"unveiled_thinkaway", 0.20, false, frames = {1}}
    }

    

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {}
end

function actor:onSetAnimation(sprite, anim, ...)
    local args = {...}
    -- if anim == "idle" then
    --     sprite:resetParts()
    -- elseif anim == "down" then
    --     sprite:resetParts()
    --     sprite:setHeadFrame(1)
    --     sprite:setSwingSpeed(0.5)
    -- elseif anim == "shaking" then
    --     sprite:setHeadFrame(3)
    --     sprite:setAllPartsShaking(true)
    --     for _,part in ipairs(sprite.parts) do
    --         sprite:setSwingSpeed(0)
    --     end
    -- elseif anim == "walk" then
    --     sprite:setPartSine("arm_l", 0)
    --     sprite:setPartSine("leg_l", 0)
    --     sprite:setPartSine("arm_r", math.pi*27)
    --     sprite:setPartSine("leg_r", math.pi*27)
    --     for _,part in ipairs{"arm_l", "leg_l", "arm_r", "leg_r"} do
    --         sprite:setPartSwingSpeed(part, 3)
    --         sprite:setPartSwingRange(part, math.rad(50))
    --     end
    -- 
    --     sprite:setHeadFrame(2)
    --     sprite:tweenPartRotation("head", math.rad(-10), 0.1, "out-quad")
    -- elseif anim == "aim" then
    --     sprite:resetParts()
    --     sprite:setHeadFrame(1)
    --     sprite:setPartSprite("arm_l", "npcs/spamton/arm_cannon")
    --     sprite:setPartSwingSpeed("arm_l", 0)
    --     local angle = args[1] or math.rad(170)
    --     sprite:tweenPartRotation("arm_l", angle, 0.3, "out-cubic")
    -- elseif anim == "death" then
    --     sprite:resetParts(true)
    --     sprite:setSwingSpeed(0)
    --     sprite:setPartSprite("head", "npcs/spamton/head_death")
    -- end
end

function actor:createSprite()
    --super.createSprite(self);
    return MaskaughtCombatActor(self)
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