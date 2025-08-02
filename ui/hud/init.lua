hud = {}

hud.hotbar = require('ui.hud.hotbar')

function hud:draw(scale)
    for _, hudElements in pairs(self) do
        if type(hudElements) == "table" and hudElements.draw then
            hudElements:draw(scale)
        end
    end
end

return hud