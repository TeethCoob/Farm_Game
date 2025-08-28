menu = {}

menu.inventory = require('ui.menu.inventory')
menu.settings = require('ui.menu.settings')

function menu:toggle(element_str)
    element_str = string.lower(element_str)

    self[element_str].visible = not self[element_str].visible

    -- print(element_str)
end

function menu:draw(scale)
    for _, menuElements in pairs(self) do
        if type(menuElements) == "table" and menuElements.draw then
            menuElements:draw(scale)
        end
    end
end

return menu