---@class Wave.wilter.final : Wave
local wave, super = Class(Wave)

function wave:init()
    super.init(self)
    self.arena_width = 640 * (2/3)
    self.time = 1
    self.left_fist = Game.world
    self.right_fist = self.left_fist
    self.head = self.left_fist
    self.ending_done = false
    self.ending_started = false
    self.pan_duration = 2
    self.actually_started = false

    self.duration = 0

    self.indicated = false

    self.doOnce = true
end

function wave:onStart()
    local soul = PurpleSoulSkerch()
    Game.battle:swapSoul(soul)
    soul.string_count = 9
    for i=1,soul.string_count do
        soul.strings[i] = Utils.clampMap(i, 1, soul.string_count, 20, Game.battle.arena.height - 20)
    end
    soul.current_string = math.ceil(soul.string_count / 2)
    self.timer:after(1, function ()
        local fade_time = 0.5
        Game.battle.arena:fadeTo(0,fade_time)
        Game.battle.arena.bg_color[4] = 1
        self.timer:tween(fade_time, Game.battle.arena, {bg_color = {0,0,0,0}})
        local height = Game.battle.arena.height
        Assets.playSound("spearrise")
        self.timer:during(math.huge, function ()
            height = Utils.approach(height, 325, DTMULT*12)
            Game.battle.arena:setSize(Game.battle.arena.width, height)
            for i=1,soul.string_count do
                soul.strings[i] = Utils.clampMap(i, 1, soul.string_count, 20, Game.battle.arena.height - 20)
            end
            if soul.goal_y == nil or soul.goal_y == soul.y then
                soul.old_y = soul.y
                soul.goal_y = Game.battle.arena:getTop() + soul.strings[soul.current_string]
                soul.y = soul.goal_y
            end
            soul:handleStringMovement()
            if height == 325 then
                Assets.playSound("noise")
                local y_relative = SCREEN_HEIGHT*-(3/4)
                -- self.timer:tween(self.pan_duration, Game.battle.camera, {y = {y = Game.battle.camera.y + y_relative}})
                Game.world.camera:setAttached(false)
                Game.world.camera.keep_in_bounds = false
                Game.battle.battle_ui.shown = false
                Game.battle.battle_ui:slideTo(0, 480, 0.25, "out-quad")
                self.orig_cam_y = Game.world.camera.y
                self.timer:tween(self.pan_duration, Game.world.camera, {y = Game.world.camera.y + y_relative})
                for i=1,(#Game.battle.party + #Game.battle.enemies) do
                    local battler = Game.battle.party[i] or Game.battle.enemies[i - #Game.battle.party]
                    battler["_start_y"] = battler.y
                    self.timer:tween(self.pan_duration, battler, {y = battler.y - y_relative})
                end
                self.timer:after(self.pan_duration, function ()
                    self:onActuallyStart()
                end)
                return false
            end
        end)
    end)
end

function wave:isWon()
    return self.left_fist:isRemoved() and self.right_fist:isRemoved() and self.head:isRemoved()
end

function wave:canEnd()
    return super.canEnd(self) and self:isWon() and self.ending_done
end

---@return fun(sec: (number|fun():boolean)?)
local function mkAdvWait(wait)
    return Utils.override(wait, function (orig, sec)
        if type(sec) == "function" then
            repeat orig(0) until sec()
        else
            orig(sec or 0)
        end
    end)
end

local function slideTo(obj, x, y, time, ease)
    local slided = false
    if obj:slideTo(x, y, time, ease, function() slided = true end) then
        return function() return slided end
    else
        return function () return true end
    end
end

local function slideToSpeed(obj, x, y, speed)
    local slided = false
    if obj:slideToSpeed(x, y, speed, function() slided = true end) then
        return function() return slided or obj:isRemoved() end
    else
        return function () return true end
    end
end

function wave:onActuallyStart()
    Assets.playSound("spearappear")
    self.left_fist = self:spawnBullet("wilter.final_fist", -100, Game.battle.arena:getBottom(), true)
    self.right_fist = self:spawnBullet("wilter.final_fist", SCREEN_WIDTH+100, Game.battle.arena:getBottom())
    self.actually_started = true
    local b = self.parent
    ---@cast b Battle
    self.timer:script(function (wait)
        wait = mkAdvWait(wait)
        wait(function () return not self.left_fist.physics.move_target end)
        while not (self.left_fist:isRemoved() and self.right_fist:isRemoved()) do
            for _, fist in pairs({self.left_fist, self.right_fist}) do
                ---@cast fist Bullet.wilter.final_fist
                local left = (_ == 1)
                if not fist:isRemoved() then
                    Assets.playSound("wing")
                    fist:shake(0,4)
                    wait(0.2)
                    wait(slideToSpeed(fist, fist.x,b.soul.y-90, 10))
                    local tx = b.soul.x
                    if not (self.left_fist:isRemoved() or self.right_fist:isRemoved()) then
                        if left then
                            tx = math.min(b.arena:getCenter() - 40, tx)
                        else
                            tx = math.max(b.arena:getCenter() + 40, tx)
                        end
                    end
                    wait(slideToSpeed(fist, tx,fist.y, 10))
                    Assets.playSound("wing")
                    fist:shake(0,4)
                    wait(.3)
                    Assets.playSound("scytheburst")
                    fist.afterimage_timer = 0.1
                    wait(slideToSpeed(fist, fist.x,SCREEN_HEIGHT, 30))
                    fist.afterimage_timer = -math.huge
                    if fist:isRemoved() then goto continue end
                    Assets.playSound("impact")
                    wait(.2)
                    wait(slideToSpeed(fist, fist.init_x, fist.init_y, 10))
                    wait(.4)
                end
                wait(.1)
                ::continue::
            end
        end
    end)
    self.head = self:spawnBullet("wilter.final_head", SCREEN_WIDTH/2, Game.battle.arena:getTop()+60)
end

function wave:update()
    super.update(self)
    if self.actually_started then
       self.duration = self.duration + DT

        if self.duration >= 5 and not self.indicated then
            self.indicated = true
            self.ind1 = self.left_fist:addChild(Text("HIT THIS\n    V", self.left_fist.width/2-5, -30, 1000, 1000, {font_size=8, color={0.7, 0.7, 0.7}}))
            self.ind2 = self.right_fist:addChild(Text("HIT THIS\n    V", self.right_fist.width/2-5, -30, 1000, 1000, {font_size=8, color={0.7, 0.7, 0.7}}))
        end

        if self.left_fist.health < 5 or self.right_fist.health < 5 and self.doOnce then
            self.doOnce = false
            self.indicated = true
            if self.ind2 then
                self.ind1:remove()
                self.ind2:remove()
            end
        end 
    end

    for _, battler in ipairs(Game.battle.party) do
        if battler.is_down and not Kristal.Config["challenge"] then
            battler.chara:setHealth(1)
            battler:checkHealth()
        end
    end

    if not self.head.vulnerable and (self.left_fist:isRemoved() and self.right_fist:isRemoved()) then
        self.head.vulnerable = true
    end
    if not self.ending_started and self:isWon() then
        self.ending_started = true
        self:doEnding()
    end
end

function wave:doEnding()
    self.timer:script(function (wait)
        wait(1)
        self.timer:tween(self.pan_duration, Game.world.camera, {y = self.orig_cam_y})
        for i=1,(#Game.battle.party + #Game.battle.enemies) do
            local battler = Game.battle.party[i] or Game.battle.enemies[i - #Game.battle.party]
            self.timer:tween(self.pan_duration, battler, {y = battler["_start_y"]})
            battler["_start_y"] = nil
        end
        wait(self.pan_duration + 1)
        self.ending_done = true
        Game.battle.battle_ui:slideTo(0, 325, 0.25, "out-quad")
        Game.battle.battle_ui.shown = true
        Game.world.camera:setAttached(true)
        Game.world.camera.keep_in_bounds = true
    end)
end

function wave:beforeEnd()
    if self.ending_started then return end
    Game.world.camera.y = self.orig_cam_y
    for i=1,(#Game.battle.party + #Game.battle.enemies) do
        local battler = Game.battle.party[i] or Game.battle.enemies[i - #Game.battle.party]
        battler.y = battler["_start_y"]
        battler["_start_y"] = nil
    end
end

function wave:getFistCount()
    local count = 0
    if not self.left_fist:isRemoved() then count = count + 1 end
    if not self.right_fist:isRemoved() then count = count + 1 end
    return count
end

return wave