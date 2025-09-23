local masktutorial, super = Class(Encounter)

--function masktutorial:getSoulColor()
--    return {0.1, 1.0, 0.1, 1.0}
--end

function masktutorial:onDialogueEnd()
super.onDialogueEnd(self)
-- self:shake(20)

end
function masktutorial:onWavesDone()

super.onWavesDone(self)
end

function masktutorial:update()

super.update(self)
end

function masktutorial:onStateChange(old,new)
  if old == "INTRO" and new == "ACTIONSELECT" then
    Game.battle.current_selecting = 0
    Game.battle:setState("ENEMYDIALOGUE")
  end
end

function masktutorial:init()
    super.init(self)
    self.didThing = false
    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* test";
    --self.text = "* It is overdue for some walking."

    -- Battle music ("battle" is rude buster)
    self.music = nil; -- "soloparade" "unveiled"
    -- Enables the purple grid battle background
    self.background = false
    self.hide_world = false;
    self.default_xactions = false

    -- Add the dummy enemy to the encounter
    self:addEnemy("nullenemy")

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
end

return masktutorial