local ui = {}

ui.hud = require('ui.hud')
ui.menu = require('ui.menu')

function ui:draw()
    self.hud:draw()
    self.menu:draw()
end

return ui