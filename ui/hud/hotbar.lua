hotbarUI = {}
hotbarUI.hotbar_sprite = love.graphics.newImage('assets/textures/ui/hud/hotbar.png')
hotbarUI.hotbar_selection_sprite = love.graphics.newImage('assets/textures/ui/hud/hotbar_selection.png')

local inventory = require('inventory') -- INVENTORY REQUIRED TO SHOW ITEMS INSIDE

function hotbarUI:draw(scale)
    local position = {x = love.graphics.getWidth()/2, y = love.graphics.getHeight() - 15}      -- *POSITION OF HOTBAR
    local offset = {x = self.hotbar_sprite:getWidth()/2, y = self.hotbar_sprite:getHeight()/2} -- *OFFSET OF HOTBAR

    position.y = position.y - (offset.y - 20)

    local item_scale = scale * 2.75

    love.graphics.draw(self.hotbar_sprite, position.x, position.y, nil, scale, scale, offset.x, offset.y)

    local grid_position = love.graphics.getWidth()/2.93

    for slotIndex, item in ipairs(inventory.hotbar) do
        if item and item.texture then
            item.texture:setFilter('nearest', 'nearest')
            love.graphics.draw(item.texture, position.x - offset.x, position.y, nil, item_scale, item_scale, item.texture:getWidth()/2, item.texture:getHeight()/2.2)
        end
    end
end

return hotbarUI