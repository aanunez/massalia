local Weapon = {}
Weapon.__index = Weapon
Weapon.level = 1
Weapon.name = "Pea Shooter I"
Weapon.cdtime = 20

function Weapon:Create()
  local self = setmetatable({},Weapon)
  return self
end



function Weapon:upgrade()
  if Weapon.level < 3 then
    self.cdtime = self.cdtime - 5
    Weapon.level = Weapon.level + 1
    Weapon.name = Weapon.name .. "I"
  end
end



return Weapon
