return {
    delta = function(cutscene, event)
        local kris = cutscene:getCharacter("kris")
        local susie = cutscene:getCharacter("susie")
        local ralsei = cutscene:getCharacter("ralsei")

        if kris and susie and ralsei then
            Game:addPartyMember("vessel")
            Game:addPartyMember("noelle")
            Game:addPartyMember("watercooler")
            Game:removePartyMember("kris")
            Game:removePartyMember("susie")
            Game:removePartyMember("ralsei")
        end
    end,

    nabla = function(cutscene, event)
        local vessel = cutscene:getCharacter("vessel")
        local noelle = cutscene:getCharacter("noelle")
        local watercooler = cutscene:getCharacter("watercooler")

        if vessel and noelle and watercooler then
            Game:addPartyMember("kris")
            Game:addPartyMember("susie")
            Game:addPartyMember("ralsei")
            Game:removePartyMember("vessel")
            Game:removePartyMember("noelle")
            Game:removePartyMember("watercooler")
        end
    end
}
