local controller = require('controller')
local gameManager = require('gameManager')

function love.load()
   gameManager:load()
end

function love.update(deltaTime)
    gameManager:update(deltaTime)
end

function love.mousepressed(x, y, button)
    controller:mouseMapping(x, y, button)
end

function love.keypressed(pressedKey)
    controller:keyMapping(pressedKey)
end

function love.draw()
    gameManager:draw()
end