---@class Wave.wilter.feast : Wave
local wave, super = Class(Wave)
function wave:init()
    super.init(self)
    -- Initialize timer
    self.time = -1

    ------ Customizeability stuff, all besides the arena size is the default so if you want the default you don't need to include these(they're already set in the soul this just overrides the default)
    -- Sets the strings' direction, "horizontal", "vertical", there is no diagonal
    self.direction = "horizontal"

    -- Sets the arena's size
    self:setArenaSize(200, 142)
    self.phase1_siner = 0
    self.arena_moving = 0
    self.string_move = 0
end

function wave:onStart()
    -- Swap the soul into the purple soul
    Game.battle:swapSoul(PurpleSoulSkerch())
    -- Set the height of all the strings(from the top of the arena), string order goes from top to bottom
    self.strings = {
        30,
        Game.battle.arena.height / 2,
        Game.battle.arena.height - 30
    }
    -- Set the amount of strings
    Game.battle.soul.string_count = 3
    -- Set the string the soul starts on
    Game.battle.soul.current_string = 2
    ------ Customization ends here

    --[[-- Every 2 seconds...
    self.timer:every(2, function ()
        -- Spawn 3 eyeballs
        for i=1, 3 do
            -- Spawn them at the string heights depending on the index
            self:spawnBullet("eyeball", 650, Game.battle.arena:getTop()+self.strings[i], math.pi, 8)
        end
    end)]]

    self.arena_background = Arena(320, 170, {{0,0},{800,0},{800,600},{0,600}})
    self.arena_background:setLayer(BATTLE_LAYERS["above_battlers"])
    Game.world:addChild(self.arena_background)
end

function wave:moveArenaTo(x,y)
    self:moveArena(x - Game.battle.arena.x, y - Game.battle.arena.y, 1)
end

function wave:moveArena(x, y, speed)
    speed = speed or 1
    x = x * speed
    y = y * speed
    Game.battle.arena:move(x,y)
    if not Game.battle.soul.moving_string then
        Game.battle.soul.y = Game.battle.arena:getTop() + self.strings[Game.battle.soul.current_string]
    else
        Game.battle.soul.goal_y = Game.battle.arena:getTop() + self.strings[Game.battle.soul.goal_string]
        Game.battle.soul.start_y = Game.battle.arena:getTop() + self.strings[Game.battle.soul.current_string]
        -- local soul_timescale = Game.battle.soul.timescale
        -- Game.battle.soul:fullUpdate()
        -- Game.battle.soul.timescale = soul_timescale
    end
end

function wave:update()
    super.update(self)

    if self.arena_moving == 0 then
        if Game.battle.arena.x > 100 then
            self:moveArenaTo(Game.battle.arena.x - 6*DTMULT,  Game.battle.arena.y)
            Game.battle.soul.x = Game.battle.soul.x - 6*DTMULT

        else
            self.arena_moving = 1
        end
    end

    if self.arena_moving == 1 then
        self.phase1_siner = self.phase1_siner + DT

        local ax = Game.battle.arena.x
        local ay = 170 + math.sin(self.phase1_siner*3)*15

        self.strings = {
            30,
            Game.battle.arena.height / 2,
            Game.battle.arena.height - 30
        }


        if ax < 360 then
            ax = ax + 1*DTMULT
            Game.battle.soul.x = Game.battle.soul.x + 1*DTMULT
        else
            self.arena_moving = 2
            ay = 170
            self.strings = {
                30,
                Game.battle.arena.height / 2,
                Game.battle.arena.height - 30
            }
        end
        self:moveArenaTo(ax, ay)
    end

    if self.arena_moving == 2 then
        self.timer:tween(1, Game.battle.arena, {top=70, y=141, height=262})
        for i=0, 39 do
            Game.battle.soul.strings[i+1] = 30+40*i
        end
        for i=0, 39 do
            self.strings[i+1] = 30+40*i
        end
        Game.battle.soul.string_count = 40
        Game.battle.soul.current_string = 2
        self.arena_moving = 3
    end

    if self.arena_moving == 3 then
        self.timer:after(1, function ()
            if self.arena_moving == 3 then
                self.arena_moving = 4
            end
        end)
    end

    if self.arena_moving == 4 then
        self.string_move = self.string_move + 2*DTMULT
        for i=0, 39 do
            Game.battle.soul.strings[i+1] = 30+40*i-self.string_move
        end
        for i=0, 39 do
            self.strings[i+1] = 30+40*i-self.string_move
        end
        self:moveArena(0,0)
    end
end

return wave
