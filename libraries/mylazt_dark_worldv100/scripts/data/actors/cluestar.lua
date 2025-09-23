local actor, super = Class(Actor, "cluestar")

function actor:init()
    super.init(self)

    self.name = "Cluestar"

    self.width = 100
    self.height = 100

    self.path = "shopkeepers/cluestar"
    self.default = "idle"

    self.animations = {
        ["idle"] = {"idle", function(sprite, wait)
            while true do
                sprite:setFrame(1)
                wait(2)
                for i = 2, 4 do
                    sprite:setFrame(i)
                    wait(5/30)
                end
            end
        end}
    }

    self.talk_sprites = {
        --["talk"] = 0.25,
        ["sider"] = 0.25
    }
    --self.offsets["idle"] = {-10, 0}
end

function actor:onTalkStart(text, sprite)
    if sprite.sprite ~= "idle" then
        --sprite:setSprite("idle")
    end
end

function actor:onTalkEnd(text, sprite)
    if sprite.sprite == "talk" then
        --sprite:setAnimation("idle")
    end
end


return actor