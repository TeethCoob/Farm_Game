-- MODULES
local controller = require('controller')
local gameManager = require('gameManager')

function love.load()
   gameManager:load()
end

function love.update(deltaTime)
    gameManager:update(deltaTime)
end

function love.mousepressed(x, y, button)
    controller:mouse_mapping(x, y, button)
end

function love.keypressed(pressed_key)
    controller:key_mapping(pressed_key)
end

function love.draw()
    gameManager:draw()
end

print("aing moto teu")
