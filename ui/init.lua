local ui = {}

ui.hud = require('ui.hud')
ui.menu = require('ui.menu')

function ui:draw()
    local screen_width, screen_height = love.graphics.getWidth(), love.graphics.getHeight()
    local scale = math.min(screen_width / 1920, screen_height / 1080)

    self.hud:draw(scale)
    self.menu:draw(scale)
end

return ui