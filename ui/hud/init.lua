hud = {}

hud.hotbar = require('ui.hud.hotbar')
--hud.compass = require('ui.hud.compass')

function hud:draw(scale)
    for _, hudElements in pairs(self) do
        if type(hudElements) == "table" and hudElements.draw then
            hudElements:draw(scale)
        end
    end
end

return hud