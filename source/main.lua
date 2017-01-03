local PlayerClass = require "Player" --PlayerClass, we may have more than 1 some day
local batonClass = require "baton"   --Input library, only need the 1

function love.load()
  ship = {0, -12.5, 12.5, 12.5, 0, 0, -12.5, 12.5}

  local controls = {
    strafe_left   = {'key:a', 'axis:leftx-', 'button:dpleft'},
    strafe_right  = {'key:d', 'axis:leftx+' ,'button:dpright'},
    rotate_left   = {'key:left', 'axis:rightx-'},
    rotate_right  = {'key:right', 'axis:rightx+'},
    forward       = {'key:w', 'axis:lefty-', 'button:dpup'},
    backward      = {'key:s', 'axis:lefty+', 'button:dpdown'},
    shoot         = {'key:space', 'button:a','axis:triggerright+'},
    debug_upgrade = {'key:=', 'button:b'}
  }
  input = batonClass.new(controls, love.joystick.getJoysticks()[1])

  window = {width = love.graphics.getWidth(), height = love.graphics.getHeight()}

  player = PlayerClass.Create(window)
end



function love.update(dt)
  input:update()
  inputCheck()
  borderCheck(player)
  player:coolDown()
  for i,b in ipairs(player.bullets) do
    if offScreenCheck(b) then table.remove(player.bullets, i) end
    b.currentY = b.currentY - b.step
  end
end



function love.draw()

  love.graphics.circle("line", 100, 100, 50, 12)
  love.graphics.print(player.weapon.name)

  for _,b in pairs(player.bullets) do
    love.graphics.translate(b.x, b.y)
    love.graphics.rotate(b.angle)
    love.graphics.circle("fill", 0, b.currentY, b.radius)
    love.graphics.rotate(-b.angle)
    love.graphics.translate(-b.x, -b.y)
  end

  love.graphics.translate(player.x, player.y)
  love.graphics.rotate(player.angle)
  love.graphics.polygon("line", ship)
  --love.graphics.rectangle("line",-player.width/2, -player.height/2, player.width, player.height) --Hitbox
end



function inputCheck()
  if input:pressed('debug_upgrade') then player.weapon:upgrade() end
  if input:down('shoot') then player:fire() end
  if input:down("rotate_left")  then player.angle = player.angle - player.angle_step end
  if input:down("rotate_right") then player.angle = player.angle + player.angle_step end
  if input:down("strafe_left")  then player.x = player.x - player.step end
  if input:down("strafe_right") then player.x = player.x + player.step end
  if input:down("forward")  then player.y = player.y - player.step end
  if input:down("backward") then player.y = player.y + player.step end
end



function borderCheck(obj)
  if obj.x < (obj.width/2) then
    obj.x = (obj.width/2)  end
  if obj.x > window.width - (obj.width/2) then
    obj.x = window.width - (obj.width/2)  end
  if obj.y < (obj.height/2) then
    obj.y = (obj.height/2)  end
  if obj.y > window.height - (obj.height/2) then
    obj.y = window.height - (obj.height/2)  end
end



function offScreenCheck(obj)
  if obj.x < 0 - obj.width              then return true end
  if obj.x > window.width + obj.width   then return true end
  if obj.y < 0 - obj.height             then return true end
  if obj.y > window.height + obj.height then return true end
  return false
end



