local Switch, super = Class(Event)

-- TO USE THIS EVENT, MAKE SURE THE EVENT HAS THE PROPERTY "amount" (integer) AND THE PROPERTY "puzzle" (string)
-- the property "amount" must be equal to the amount of required buttons to complete the puzzle
-- the property "puzzle" must be the name of the puzzle
function Switch:init(data)
    super.init(self, data)
    Game:addFlag("RequiredButtonsPressed", 0)
    Game:setFlag("RequiredButtonsPressed", 0)
    local properties = data.properties or {}
    self.amount = properties["amount"]
    self.puzzle = properties["puzzle"]
    Game:setFlag("PuzzleState", false)
    if Game:getFlag(self.puzzle+"Puzzle") ~= true then
        Game:setFlag(self.puzzle+"Puzzle", false)
    end
    local flag = Game:getFlag("RequiredButtonsPressed")
    if Game:getFlag(self.puzzle+"Puzzle") == false then
        self:setSprite("world/events/switch_1")
        elseif Game:getFlag(self.puzzle+"Puzzle") == true then
        self:setSprite("world/events/switch_2")
        end
end


function Switch:onInteract(player, dir)
    if Game:getFlag(self.puzzle+"Puzzle") == false then
        Game:setFlag("spike1", true)
    local flag = Game:getFlag("RequiredButtonsPressed")
    local puzzle = Game:getFlag("PuzzleState")
    if puzzle == false then
    if flag == self.amount then
        self:setSprite("world/events/switch_2")
        Game:setFlag("PuzzleState", true)
        Game:setFlag(self.puzzle+"Puzzle", true)
        Game:setFlag("spike1", false)
        Kristal.Console:log("puzzle complete")
        Game.world:startCutscene("generic.puzzle_correct")
    end
    if flag ~= self.amount then
        self:setSprite("world/events/switch_2")
        Assets.playSound("noise")
        Game:setFlag("RequiredButtonsPressed", 0)
        Game:setFlag("PuzzleState", "reset")
        Kristal.Console:log("puzzle reset")
        Game.stage.timer:after(0.5, function ()
            Game:setFlag("PuzzleState", false)
            Assets.playSound("noise")
            self:setSprite("world/events/switch_1")
        end)
    end
end
elseif Game:getFlag(self.puzzle+"Puzzle") == true then
    Game:setFlag("spike1", false)
    self:setSprite("world/events/switch_2")
end
end

return Switch