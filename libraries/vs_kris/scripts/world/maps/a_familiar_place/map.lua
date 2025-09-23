local a_familiar_place, super = Class(Map)

function a_familiar_place:load()
    super:load(self)
end

function a_familiar_place:onFootstep(chara, num)
    if num == 1 then
        Assets.playSound("step1")
    elseif num == 2 then
        Assets.playSound("step2")
    end
end

return a_familiar_place