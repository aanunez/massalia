local WeaponClass = require "Weapon"
local pew = love.audio.newSource("pew.ogg", "static")
love.audio.setVolume(0.1)

local Player = {}
Player.__index = Player
Player.x = 0
Player.y = 0
Player.step = 5
Player.angle_step = math.pi/45
Player.width = 25
Player.height = 25
Player.fireCoolDown = 0
Player.angle = 0

Player.bullets = {}
Player.weapon = WeaponClass.Create()

function Player:Create()
  local self = setmetatable({},Player)
  self.x = window.width/2  - self.width/2
  self.y = window.height/2 - self.height/2
  return self
end



function Player:fire()
  if self.fireCoolDown <= 0 then
    bullet = {radius = 4, step = 9, angle = 0}
    bullet.width = bullet.radius*2
    bullet.height = bullet.radius*2
    bullet.angle = player.angle
    bullet.x = player.x --We will center the bullet via a translate
    bullet.y = player.y - (player.height/4) --Put bullet in front of player a bit
    bullet.currentY = 0
    self.fireCoolDown = self.weapon.cdtime
    table.insert(self.bullets,bullet)
    love.audio.play(pew)
  end
end



function Player:coolDown()
  if self.fireCoolDown > 0 then
    self.fireCoolDown = self.fireCoolDown - 1 end
end



return Player
