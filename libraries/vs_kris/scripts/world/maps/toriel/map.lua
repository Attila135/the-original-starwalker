local toriel, super = Class(Map)

function toriel:load()
  super:load(self)
  print("room "..self.name.." loaded!")
end

return toriel