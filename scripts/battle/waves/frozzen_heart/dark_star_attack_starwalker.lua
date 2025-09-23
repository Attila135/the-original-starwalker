local dark_star_attack, super = Class(Wave)

function dark_star_attack:init()
    super:init(self)
    self.time = -1
    --self:setArenaSize(17, 17)
    self.hearts = {}
    self.can_jump = false
    self.is_jumping = {false, false, false}
    self.soul_jump_timer = nil    
end

function dark_star_attack:onStart()
    self.input = {
        kris = Input.usingGamepad() and Input.getText("confirm") or "[X]",
        susie = Input.usingGamepad() and Input.getText("cancel") or "[C]",
        ralsei = Input.usingGamepad() and Input.getText("menu") or "[V]"
    }
    self.timer:script(function(wait)
        Game.battle.soul.can_move = false
        wait(0.25)
        for i=1,15 do
            Game.battle.soul.x=Game.battle.soul.x+2*(i*(i%2==0 and 1 or -1))
            Assets.playSound("break1")
            wait(0.1)
        end
        Game.battle.soul.visible = false
        local offsets = {
            {5, 17},
            {15, 22},
            {20, 30}
        }
        Assets.playSound("break2")
        for i=1,3 do
            self.hearts[i] = self:spawnSprite("player/heart", Game.battle.soul.x, Game.battle.soul.y)
            self.hearts[i].color = {Game.battle.party[i].chara:getColor()}
            self.hearts[i].layer = BATTLE_LAYERS["top"]
            self.hearts[i]:setScale(0.5)
            local x, y = Game.battle.party[i].sprite:getScreenPos()
            self.timer:tween(0.5, self.hearts[i], {x=(x+Game.battle.party[i].sprite.width/2)+offsets[i][1], y=(y+Game.battle.party[i].sprite.height/2)+offsets[i][2]}, "out-quad", function()
                self.hearts[i].layer = BATTLE_LAYERS["above_battlers"]
            end)
        end
        Game.battle.soul.y = 0
        wait(0.75)
        self.can_jump = true
        Game.battle.arena:remove()
        wait(0.5)
        Game.battle:infoText("* ([color:"..Utils.rgbToHex({Game.battle.party[1].chara:getColor()}).."]"..Input.getText("up").."+"..self.input["kris"].."->Kris jumps![color:reset]\n[color:"..Utils.rgbToHex({Game.battle.party[2].chara:getColor()}).."]"..Input.getText("up").."+"..self.input["susie"].."->Susie jumps![color:reset]\n[color:"..Utils.rgbToHex({Game.battle.party[3].chara:getColor()}).."]"..Input.getText("up").."+"..self.input["ralsei"].."->Ralsei jumps![color:reset])")
        for i=1,5 do
            local bullet = self:spawnBullet("snowflakeBullet", ((SCREEN_WIDTH/2)-42)+(50*i-5), ((SCREEN_HEIGHT/2)-50)+(5*i-1), 0, 0)
            bullet:setScale(0)
            bullet:setScaleOrigin(0.5, 0.5)
            bullet.target = love.math.random(1,3)
            bullet:setColor(Game.battle.party[bullet.target].chara:getColor())
            self.timer:tween(0.5, bullet, {scale_x=1, scale_y=1}, "out-back")
        end
        wait(1)
        for i,bullet in ipairs(self.bullets) do
            self.timer:tween(2, bullet, {x=(bullet.x-30)-(50*i), y=(bullet.y+60)-(40*i), rotation=math.rad(360)}, "in-out-quad", function()
                self.timer:after(0.5, function()
                    self.timer:tween(1.5, bullet, {x=450+(20*i), y=70+(35*i), rotation=math.rad(0)}, "in-out-quad")
                end)
            end)
        end
        wait(Game.battle.encounter:getFlag("dark_star_first", false) and 4.5 or 5.5)
        Game.battle.encounter:setFlag("dark_star_first", true)
        for i=5,1,-1 do
            local bullet = self.bullets[i]
            local x, y = Game.battle.party[bullet.target].sprite:getScreenPos()
            Game.battle.soul.target = bullet.target
            if self.soul_jump_timer then
                self.timer:cancel(self.soul_jump_timer)
            end
            Game.battle.soul:setPosition(x, y+Game.battle.party[bullet.target].sprite.height)
            local angle = Utils.angle(bullet.x, bullet.y, Game.battle.soul.x, Game.battle.soul.y)
            bullet.physics = {
                direction = angle,
                speed = 30
            }
            wait(1.75)
        end
        wait(1)
        self.finished = true
    end)
end

function dark_star_attack:update()
    -- Code here gets called every frame

    if self.can_jump then
        if not self.is_jumping[1] and Input.down("up") and Input.down(Input.usingGamepad() and "confirm" or "x") then
            print("Kris jumped!")
            self.is_jumping[1] = true
            local kris = Game.battle.party[1]
            kris.sprite:setAnimation({"ball", 1/16, true})
            Assets.playSound("jump")
            Game.battle.timer:tween(0.5, kris, {y=kris.y-70}, "out-quad", function()
                Game.battle.timer:tween(0.5, kris, {y=kris.y+70}, "in-quad", function()
                    Assets.playSound("noise")
                    kris:setSprite("landed")
                    Game.battle.timer:after(0.5, function()
                        kris:resetSprite()
                        if self.is_jumping then
                            self.is_jumping[1] = false
                        end
                    end)
                end)
            end)
            self.timer:tween(0.5, self.hearts[1], {y=self.hearts[1].y-70}, "out-quad", function()
                self.timer:tween(0.5, self.hearts[1], {y=self.hearts[1].y+70}, "in-quad")
            end)
            if Game.battle.soul.target==1 then
                self.soul_jump_timer = self.timer:tween(0.5, Game.battle.soul, {y=Game.battle.soul.y-70}, "out-quad", function()
                    self.soul_jump_timer = self.timer:tween(0.5, Game.battle.soul, {y=Game.battle.soul.y+70}, "in-quad")
                end)
            end
        elseif not self.is_jumping[2] and Input.down("up") and Input.down(Input.usingGamepad() and "cancel" or "c") then
            print("Susie jumped!")
            self.is_jumping[2] = true
            local susie = Game.battle.party[2]
            susie.sprite:setAnimation({"ball", 1/16, true})
            Assets.playSound("jump")
            Game.battle.timer:tween(0.5, susie, {y=susie.y-70}, "out-quad", function()
                Game.battle.timer:tween(0.5, susie, {y=susie.y+70}, "in-quad", function()
                    Assets.playSound("noise")
                    susie:setSprite("landed")
                    Game.battle.timer:after(0.5, function()
                        susie:resetSprite()
                        if self.is_jumping then
                            self.is_jumping[2] = false
                        end
                    end)
                end)
            end)
            self.timer:tween(0.5, self.hearts[2], {y=self.hearts[2].y-70}, "out-quad", function()
                self.timer:tween(0.5, self.hearts[2], {y=self.hearts[2].y+70}, "in-quad")
            end)
            if Game.battle.soul.target==2 then
                self.soul_jump_timer = self.timer:tween(0.5, Game.battle.soul, {y=Game.battle.soul.y-70}, "out-quad", function()
                    self.soul_jump_timer = self.timer:tween(0.5, Game.battle.soul, {y=Game.battle.soul.y+70}, "in-quad")
                end)
            end
        elseif not self.is_jumping[3] and Input.down("up") and Input.down(Input.usingGamepad() and "menu" or "v") then
            print("Ralsei jumped!")
            self.is_jumping[3] = true
            local ralsei = Game.battle.party[3]
            ralsei.sprite:setAnimation({"ball", 1/16, true})
            Assets.playSound("jump")
            Game.battle.timer:tween(0.5, ralsei, {y=ralsei.y-70}, "out-quad", function()
                Game.battle.timer:tween(0.5, ralsei, {y=ralsei.y+70}, "in-quad", function()
                    Assets.playSound("noise")
                    ralsei:setSprite("landed")
                    Game.battle.timer:after(0.5, function()
                        ralsei:resetSprite()
                        if self.is_jumping then
                            self.is_jumping[3] = false
                        end
                    end)
                end)
            end)
            self.timer:tween(0.5, self.hearts[3], {y=self.hearts[3].y-70}, "out-quad", function()
                self.timer:tween(0.5, self.hearts[3], {y=self.hearts[3].y+70}, "in-quad")
            end)
            if Game.battle.soul.target==3 then
                self.soul_jump_timer = self.timer:tween(0.5, Game.battle.soul, {y=Game.battle.soul.y-70}, "out-quad", function()
                    self.soul_jump_timer = self.timer:tween(0.5, Game.battle.soul, {y=Game.battle.soul.y+70}, "in-quad")
                end)
            end
        end
    end

    super:update(self)
end

return dark_star_attack